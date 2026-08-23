#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "usage: $0 --config FILE --case FILE --result FILE --trace FILE [--iob-trace FILE] --work-dir DIR --chipyard-root DIR [--adora-root DIR] [--python FILE] [--sbt FILE] [--sbt-cache-root DIR]" >&2
}

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
config=
case_file=
result=
trace=
iob_trace=
work_dir=
chipyard_root=
adora_root=/home/jyhu/adora-compiler-scheduletasks-h
python=/home/jyhu/.conda/envs/cocotb/bin/python
sbt=/home/jhlou/chipyard/.conda-env/bin/sbt
sbt_cache_root=

while (($#)); do
  case "$1" in
    --config) config=$2; shift 2 ;;
    --case) case_file=$2; shift 2 ;;
    --result) result=$2; shift 2 ;;
    --trace) trace=$2; shift 2 ;;
    --iob-trace) iob_trace=$2; shift 2 ;;
    --work-dir) work_dir=$2; shift 2 ;;
    --chipyard-root) chipyard_root=$2; shift 2 ;;
    --adora-root) adora_root=$2; shift 2 ;;
    --python) python=$2; shift 2 ;;
    --sbt) sbt=$2; shift 2 ;;
    --sbt-cache-root) sbt_cache_root=$2; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "error: unknown argument: $1" >&2; usage; exit 2 ;;
  esac
done

for value in config case_file result trace work_dir chipyard_root; do
  if [[ -z ${!value} ]]; then
    echo "error: --${value//_/-} is required" >&2
    usage
    exit 2
  fi
done
for file in "$config" "$case_file" "$python" "$sbt"; do
  [[ -f $file ]] || { echo "error: required file does not exist: $file" >&2; exit 2; }
done
[[ -e $adora_root/.git ]] || { echo "error: ADORA checkout is missing: $adora_root" >&2; exit 2; }

config=$(realpath "$config")
case_file=$(realpath "$case_file")
result=$(realpath -m "$result")
trace=$(realpath -m "$trace")
iob_trace=${iob_trace:-${trace%.json}-iob.json}
iob_trace=$(realpath -m "$iob_trace")
work_dir=$(realpath -m "$work_dir")
chipyard_root=$(realpath "$chipyard_root")
adora_root=$(realpath "$adora_root")
python=$(realpath "$python")
sbt=$(realpath "$sbt")
if [[ -n $sbt_cache_root ]]; then
  sbt_cache_root=$(realpath -m "$sbt_cache_root")
fi

fdra_root=$chipyard_root/generators/fdra
[[ -d $fdra_root/cgra-mg/src/main ]] || {
  echo "error: --chipyard-root must be an isolated Chipyard tree containing generators/fdra" >&2
  exit 2
}
if ! diff -qr "$repo_root/cgra-mg/src/main" "$fdra_root/cgra-mg/src/main" >/dev/null; then
  echo "error: isolated Chipyard FDRA source does not match this VITRA checkout" >&2
  exit 2
fi

vitra_commit=$(git -C "$repo_root" rev-parse HEAD)
adora_commit=$(git -C "$adora_root" rev-parse HEAD)
[[ $vitra_commit =~ ^[0-9a-f]{40}$ ]] || { echo "error: VITRA commit is not a full SHA" >&2; exit 2; }
[[ $adora_commit =~ ^[0-9a-f]{40}$ ]] || { echo "error: ADORA commit is not a full SHA" >&2; exit 2; }

mkdir -p "$work_dir" "$(dirname "$result")" "$(dirname "$trace")" "$(dirname "$iob_trace")"
bundle=$work_dir/fresh-bundle
runtime_work=$work_dir/runtime
rm -rf "$bundle" "$runtime_work"
mkdir -p "$bundle" "$runtime_work"

sbt_cache_root=${sbt_cache_root:-$work_dir/sbt-cache}
mkdir -p "$sbt_cache_root"/{boot,coursier,global,ivy,runtime}
(
  cd "$chipyard_root"
  env \
    XDG_RUNTIME_DIR="$sbt_cache_root/runtime" \
    TMPDIR="$sbt_cache_root/runtime" \
    COURSIER_CACHE="$sbt_cache_root/coursier" \
    JAVA_TOOL_OPTIONS="-Djava.io.tmpdir=$sbt_cache_root/runtime -Dsbt.global.base=$sbt_cache_root/global -Dsbt.boot.directory=$sbt_cache_root/boot -Dsbt.ivy.home=$sbt_cache_root/ivy -Dsbt.coursier.home=$sbt_cache_root/coursier -Dsbt.server.autostart=false -Dsbt.server.forcestart=true" \
    "$sbt" -java-home /usr/lib/jvm/java-11-openjdk-amd64 -batch \
      "project fdra" \
      "runMain tram.vitra.CStoreVerilogGen -td $bundle"
)

runtime=$repo_root/cgra-mg/e2e/cstore/runtime.py
"$python" "$runtime" manifest \
  --bundle "$bundle" \
  --vitra-commit "$vitra_commit" \
  --adora-commit "$adora_commit"
"$python" "$runtime" prepare \
  --bundle "$bundle" \
  --config "$config" \
  --case "$case_file" \
  --output "$runtime_work"

python_bin=$(dirname "$python")
rm -f "$result" "$trace" "$iob_trace"
env \
  PATH="$python_bin:$PATH" \
  PYTHONPATH="$repo_root/cgra-mg/e2e/cstore${PYTHONPATH:+:$PYTHONPATH}" \
  E2E_BUNDLE="$bundle" \
  E2E_WORK="$runtime_work" \
  E2E_CASE="$case_file" \
  E2E_TRACE="$trace" \
  E2E_IOB_TRACE="$iob_trace" \
  E2E_RESULT="$result" \
  make -C "$repo_root/cgra-mg/e2e/cstore" \
    E2E_BUNDLE="$bundle" \
    E2E_WORK="$runtime_work" \
    SIM_BUILD="$work_dir/sim-build"

[[ -s $result ]] || { echo "error: simulator did not produce result JSON" >&2; exit 1; }
[[ -s $trace ]] || { echo "error: simulator did not produce trace JSON" >&2; exit 1; }
[[ -s $iob_trace ]] || { echo "error: simulator did not produce target IOB trace JSON" >&2; exit 1; }
"$python" -c 'import json,sys; sys.exit(0 if json.load(open(sys.argv[1]))["status"] == "pass" else 1)' "$result"

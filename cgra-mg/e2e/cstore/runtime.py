#!/usr/bin/env python3
"""Auditable adapter and runtime helpers for VITRA full-CGRA CSTORE E2E.

This module never derives placement or routing bits.  It validates and packs the
two-column hexadecimal packets emitted by the ADORA mapper, checks that every
hardware artifact belongs to one generation, and wraps the unmodified generated
core only to expose its real SRAM-side signals to the simulator.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import re
import sys
from pathlib import Path
from typing import Any, Iterable


SCHEMA_VERSION = 1
REQUIRED_ARTIFACTS = (
    "CGRAWithAXI.v",
    "spec/vitra_spec.json",
    "spec/operations.json",
    "spec/vitra_cgra_adg.json",
    "spec/axilite_spec.json",
    "spec/loop_index_contract.json",
)
REFERENCE_RUNTIME_REPOSITORY = "https://github.com/theElysia/CGRA-Cocotb-Sim"
REFERENCE_RUNTIME_COMMIT = "e9560326ee307f2a456c65ea3a7a71e91846d019"


class ContractError(RuntimeError):
    """An input violates the machine-readable handoff contract."""


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def parse_config_text(text: str) -> list[tuple[int, int]]:
    """Parse the exact ADORA mapper `config.bit` address/data text format."""
    packets: list[tuple[int, int]] = []
    addresses: set[int] = set()
    for line_number, raw_line in enumerate(text.splitlines(), start=1):
        line = raw_line.partition("#")[0].strip()
        if not line:
            continue
        fields = line.split()
        if len(fields) != 2:
            raise ContractError(f"config line {line_number}: expected address and data")
        try:
            address, data = (int(field, 16) for field in fields)
        except ValueError as error:
            raise ContractError(f"config line {line_number}: fields must be hexadecimal") from error
        if not 0 <= address <= 0xFFFF:
            raise ContractError(f"config line {line_number}: address exceeds 16-bit packet field")
        if not 0 <= data <= 0xFFFFFFFF:
            raise ContractError(f"config line {line_number}: data exceeds 32-bit packet field")
        if address in addresses:
            raise ContractError(f"config line {line_number}: duplicate address 0x{address:04x}")
        addresses.add(address)
        packets.append((address, data))
    if not packets:
        raise ContractError("configuration contains no packets")
    return packets


def parse_config_file(path: Path) -> list[tuple[int, int]]:
    return parse_config_text(path.read_text(encoding="utf-8"))


def pack_config_packets(packets: Iterable[tuple[int, int]]) -> bytes:
    """Pack data-low, data-high, address as three little-endian 16-bit words."""
    output = bytearray()
    for address, data in packets:
        output.extend((data & 0xFFFF).to_bytes(2, "little"))
        output.extend(((data >> 16) & 0xFFFF).to_bytes(2, "little"))
        output.extend(address.to_bytes(2, "little"))
    return bytes(output)


def build_manifest(root: Path, vitra_commit: str, adora_commit: str) -> dict[str, Any]:
    for commit, label in ((vitra_commit, "VITRA"), (adora_commit, "ADORA")):
        if not re.fullmatch(r"[0-9a-f]{40}", commit):
            raise ContractError(f"{label} commit must be a lowercase 40-character SHA")
    artifacts: dict[str, dict[str, Any]] = {}
    for relative in REQUIRED_ARTIFACTS:
        path = root / relative
        if not path.is_file():
            raise ContractError(f"required artifact is missing: {relative}")
        artifacts[relative] = {"sha256": sha256_file(path), "size_bytes": path.stat().st_size}
    return {
        "schema_version": SCHEMA_VERSION,
        "generator": "tram.vitra.CStoreVerilogGen",
        "vitra_commit": vitra_commit,
        "adora_commit": adora_commit,
        "artifacts": artifacts,
    }


def _all_named_operations(value: Any) -> set[str]:
    result: set[str] = set()
    if isinstance(value, dict):
        for key, item in value.items():
            if key.lower() in {"name", "operation", "operations"}:
                if isinstance(item, str):
                    result.add(item)
                elif isinstance(item, list):
                    result.update(entry for entry in item if isinstance(entry, str))
            result.update(_all_named_operations(item))
    elif isinstance(value, list):
        for item in value:
            result.update(_all_named_operations(item))
    return result


def validate_bundle(root: Path) -> dict[str, Any]:
    manifest_path = root / "manifest.json"
    if not manifest_path.is_file():
        raise ContractError("bundle manifest.json is missing")
    manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
    if manifest.get("schema_version") != SCHEMA_VERSION:
        raise ContractError("unsupported bundle manifest schema")
    listed = manifest.get("artifacts", {})
    if set(listed) != set(REQUIRED_ARTIFACTS):
        raise ContractError("bundle manifest must list exactly the required same-generation artifacts")
    for relative in REQUIRED_ARTIFACTS:
        path = root / relative
        if not path.is_file():
            raise ContractError(f"required artifact is missing: {relative}")
        if sha256_file(path) != listed[relative].get("sha256"):
            raise ContractError(f"artifact hash mismatch: {relative}")

    spec = json.loads((root / "spec/vitra_spec.json").read_text(encoding="utf-8"))
    if spec.get("cgra_iob_mode") != 2 or spec.get("cgra_iob_sram_has_mask") is not True:
        raise ContractError("production bundle must use conditional mode-2 masked IOB SRAM")
    if spec.get("cgra_data_width") != 16:
        raise ContractError("production bundle data width must be 16 bits")
    if spec.get("cgra_cfg_data_width") != 32 or spec.get("cgra_cfg_addr_width_align") != 16:
        raise ContractError("configuration packet widths do not match the runtime adapter")

    operations = json.loads((root / "spec/operations.json").read_text(encoding="utf-8"))
    adg = json.loads((root / "spec/vitra_cgra_adg.json").read_text(encoding="utf-8"))
    names = _all_named_operations(operations) | _all_named_operations(adg)
    if "FOR" in names:
        raise ContractError("FOR is compiler-level only and must not be a physical operation")
    if "CLOAD" in names:
        raise ContractError("CLOAD is outside this hardware handoff and is not implemented")
    if not {"ACC", "CSTORE"}.issubset(names):
        raise ContractError("bundle must expose physical ACC and CSTORE operations")

    loop_contract = json.loads(
        (root / "spec/loop_index_contract.json").read_text(encoding="utf-8")
    )
    if loop_contract.get("physical_operation") != "ACC":
        raise ContractError("loop-index contract must name ACC as the physical operation")
    if loop_contract.get("for_is_physical_operation") is not False:
        raise ContractError("loop-index contract must reject physical FOR")
    if loop_contract.get("byte_address_scaling") != "external-explicit-arithmetic":
        raise ContractError("byte scaling must remain explicit external arithmetic")

    axil = json.loads((root / "spec/axilite_spec.json").read_text(encoding="utf-8"))
    for field in ("cfgmem_baseaddr", "tile_num", "tile_iob_bank_num"):
        if field not in axil:
            raise ContractError(f"AXI-Lite spec is missing {field}")
    if axil["tile_num"] * axil["tile_iob_bank_num"] != 48:
        raise ContractError("runtime trace wrapper expects exactly 48 physical SRAM banks")

    return {
        "vitra_commit": manifest.get("vitra_commit"),
        "adora_commit": manifest.get("adora_commit"),
        "artifact_count": len(REQUIRED_ARTIFACTS),
        "artifact_sha256": {name: listed[name]["sha256"] for name in REQUIRED_ARTIFACTS},
    }


_PORT_RE = re.compile(
    r"^\s*(input|output)\s+(?:(?:wire|reg)\s+)?(?:(\[[^]]+\])\s+)?([A-Za-z_][A-Za-z0-9_]*)\s*[,)]\s*$"
)


def _friendly_port(name: str) -> str:
    if name == "clock":
        return "clk"
    if name == "reset":
        return "rst"
    for source, target in (("io_s_axilite_", "axil_"), ("io_s_axi_", "axi_")):
        if name.startswith(source):
            suffix = name[len(source) :].replace("_bits_", "_")
            return target + suffix.replace("_", "")
    raise ContractError(f"unsupported generated top-level port: {name}")


def _parse_core_ports(core_text: str) -> list[tuple[str, str | None, str, str]]:
    match = re.search(r"\bmodule\s+CGRAWithAXI\s*\((.*?)\);", core_text, re.DOTALL)
    if not match:
        raise ContractError("CGRAWithAXI module header was not found")
    ports: list[tuple[str, str | None, str, str]] = []
    for line in match.group(1).splitlines():
        parsed = _PORT_RE.match(line + ("," if not line.rstrip().endswith((",", ")")) else ""))
        if parsed:
            direction, width, original = parsed.groups()
            ports.append((direction, width, original, _friendly_port(original)))
    if not ports or not {"clock", "reset"}.issubset({port[2] for port in ports}):
        raise ContractError("generated core ports could not be parsed")
    friendly = [port[3] for port in ports]
    if len(friendly) != len(set(friendly)):
        raise ContractError("generated core port renaming is not unique")
    return ports


def render_trace_wrapper(core_text: str, bank_count: int = 48) -> str:
    ports = _parse_core_ports(core_text)
    declarations: list[str] = []
    for direction, width, _original, friendly in ports:
        declarations.append(f"  {direction} {width + ' ' if width else ''}{friendly}")
    declarations.extend(
        (
            f"  output [{bank_count - 1}:0] trace_request_enable",
            f"  output [{bank_count * 2 - 1}:0] trace_write_mask",
            f"  output [{bank_count * 12 - 1}:0] trace_word_address",
            f"  output [{bank_count * 16 - 1}:0] trace_write_data",
        )
    )
    connections = ",\n".join(
        f"    .{original}({friendly})" for _direction, _width, original, friendly in ports
    )
    assignments: list[str] = []
    for bank in range(bank_count):
        prefix = f"core.cgra_io_srams_iob_{bank}"
        assignments.extend(
            (
                f"  assign trace_request_enable[{bank}] = {prefix}_en;",
                f"  assign trace_write_mask[{bank * 2} +: 2] = {prefix}_we;",
                f"  assign trace_word_address[{bank * 12} +: 12] = {prefix}_addr;",
                f"  assign trace_write_data[{bank * 16} +: 16] = {prefix}_din;",
            )
        )
    return (
        "// Generated deterministically by cgra-mg/e2e/cstore/runtime.py.\n"
        "// The wrapper only renames bus ports and observes the unmodified core.\n"
        "module CStoreTraceWrapper(\n"
        + ",\n".join(declarations)
        + "\n);\n"
        + "  CGRAWithAXI core (\n"
        + connections
        + "\n  );\n"
        + "\n".join(assignments)
        + "\nendmodule\n"
    )


def interface_contract() -> dict[str, Any]:
    return {
        "schema_version": SCHEMA_VERSION,
        "top_module": "CStoreTraceWrapper",
        "wrapped_core": "CGRAWithAXI",
        "clock": {"signal": "clk", "period_ns": 2},
        "reset": {
            "signal": "rst",
            "polarity": "active-high",
            "sequence": "assert for four rising edges; deassert; wait two rising edges",
        },
        "axi": {"prefix": "axi", "address_width_bits": 19, "data_width_bits": 128, "id_width_bits": 6},
        "axi_lite": {"prefix": "axil", "address_width_bits": 10, "data_width_bits": 32},
        "configuration": {
            "external_format": "ADORA config.bit: hexadecimal address data per line",
            "address_unit": "configuration-register address",
            "address_width_bits": 16,
            "data_width_bits": 32,
            "packet_word_width_bits": 16,
            "packet_word_order": ["data[15:0]", "data[31:16]", "address[15:0]"],
            "packet_byte_order": "little-endian within each 16-bit word",
            "transaction_order": "file order, loaded contiguously at cfgmem_baseaddr",
            "tile_enable_register": "reg_cfg_en_tile_0",
            "configuration_start_register": "reg_cfg_en",
        },
        "execution": {
            "iob_enable_registers": ["reg_exe_iob_ens_0", "reg_exe_iob_ens_1"],
            "tile_enable_register": "reg_exe_tile_ens_0",
            "start_register": "reg_exe_start",
            "done_register": "reg_exe_done_0",
        },
        "sram": {
            "input_loading": "AXI writes to the physical scratchpad bank address map",
            "output_readback": "AXI reads from the physical scratchpad bank address map",
            "element_width_bits": 16,
            "write_mask_width_bits": 2,
        },
        "sram_write_trace": {
            "bank_count": 48,
            "request_path": "core.cgra_io_srams_iob_<bank>_en",
            "write_mask_path": "core.cgra_io_srams_iob_<bank>_we",
            "word_address_path": "core.cgra_io_srams_iob_<bank>_addr",
            "write_data_path": "core.cgra_io_srams_iob_<bank>_din",
            "address_units": {"word_address": "16-bit elements", "byte_address": "word_address * 2"},
        },
        "runtime": {
            "model": "vendored-minimum",
            "source": "cgra-mg/e2e/cstore",
            "reference_repository": REFERENCE_RUNTIME_REPOSITORY,
            "reference_commit": REFERENCE_RUNTIME_COMMIT,
            "python": "3.12.13",
            "cocotb": "1.9.2",
            "cocotbext_axi": "0.1.28",
            "verilator": "5.044",
        },
    }


def _write_json(path: Path, value: Any) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(value, indent=2, sort_keys=True) + "\n", encoding="utf-8")


def prepare(bundle: Path, config: Path, output: Path) -> dict[str, Any]:
    validation = validate_bundle(bundle)
    packets = parse_config_file(config)
    output.mkdir(parents=True, exist_ok=True)
    wrapper = render_trace_wrapper((bundle / "CGRAWithAXI.v").read_text(encoding="utf-8"))
    (output / "CStoreTraceWrapper.v").write_text(wrapper, encoding="utf-8")
    (output / "config.bin").write_bytes(pack_config_packets(packets))
    _write_json(output / "interface.json", interface_contract())
    result = {
        **validation,
        "config_input": str(config.resolve()),
        "config_sha256": sha256_file(config),
        "config_packet_count": len(packets),
        "packed_config_sha256": sha256_file(output / "config.bin"),
        "wrapper_sha256": sha256_file(output / "CStoreTraceWrapper.v"),
    }
    _write_json(output / "adapter_result.json", result)
    return result


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    subparsers = parser.add_subparsers(dest="command", required=True)
    prepare_parser = subparsers.add_parser("prepare", help="validate and adapt a generated bundle")
    prepare_parser.add_argument("--bundle", type=Path, required=True)
    prepare_parser.add_argument("--config", type=Path, required=True)
    prepare_parser.add_argument("--output", type=Path, required=True)
    manifest_parser = subparsers.add_parser("manifest", help="hash one fresh generated bundle")
    manifest_parser.add_argument("--bundle", type=Path, required=True)
    manifest_parser.add_argument("--vitra-commit", required=True)
    manifest_parser.add_argument("--adora-commit", required=True)
    args = parser.parse_args(argv)
    try:
        if args.command == "prepare":
            print(json.dumps(prepare(args.bundle, args.config, args.output), sort_keys=True))
            return 0
        if args.command == "manifest":
            manifest = build_manifest(args.bundle, args.vitra_commit, args.adora_commit)
            _write_json(args.bundle / "manifest.json", manifest)
            print(json.dumps(manifest, sort_keys=True))
            return 0
    except (ContractError, OSError, json.JSONDecodeError) as error:
        print(f"error: {error}", file=sys.stderr)
        return 2
    return 2


if __name__ == "__main__":
    raise SystemExit(main())

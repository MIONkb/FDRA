# VITRA-CGRA Generator

This repository contains the Chipyard-based CGRA hardware generation flow used by VITRA-CGRA.

It is derived from the original [FDRA](https://github.com/yhqiu16/FDRA) project. The current tree keeps the FDRA RISC-V + CGRA foundation, but the active development focus is different: this version is maintained as the CGRA RTL / hardware generation side of the ADORA/CGRVOPT and AXI-CGRA workflow.

Related projects:

| Project | Role |
|--------|------|
| [VITRA-CGRA](https://github.com/MIONkb/VITRA-CGRA) | CGRA RTL / hardware generation, based on Chipyard. |
| [CGRA-Cocotb-Sim](https://github.com/theElysia/CGRA-Cocotb-Sim) | Cocotb-based simulation environment for AXI-CGRA. |
| [ADORA-Compiler](https://github.com/MIONkb/adora-compiler) | MLIR-based compiler flow used with this CGRA hardware. |

## Directory Layout

- `cgra-mg`: Chisel/Scala CGRA generator and VITRA architecture specification.
- `cgra-mg/src/main/scala/vitra/spec`: VITRA spec entry point and reference spec files.
- `scripts`: Helper scripts for setup and legacy build flows.
- `fpgaz7p-prototype`: FPGA prototype-related files.
- `legacy`: Historical or inherited FDRA materials kept for reference.

## How To Install

Place this repository under the Chipyard generator directory:

```text
<chipyard-root>/generators/fdra
```

Register the generator project in `<chipyard-root>/build.sbt`:

```scala
lazy val chipyard = (project in file("generators/chipyard"))
  .dependsOn(
    // other generator projects...
    fdra
  )

lazy val fdra = (project in file("generators/fdra/cgra-mg"))
  .dependsOn(testchipip, rocketchip)
  .settings(libraryDependencies ++= rocketLibDeps.value)
  .settings(chiselTestSettings)
  .settings(commonSettings)
```

Then run the setup helper from this repository:

```sh
cd <chipyard-root>/generators/fdra
./scripts/setup-paths.sh
```

After that, return to the Chipyard root before running sbt commands.

## Generate VITRA Verilog

Run the generator from the Chipyard root. The recommended entry point for VITRA RTL generation is `tram.vitra.VerilogGen`.

```sh
cd <chipyard-root>
sbt "project fdra; runMain tram.vitra.VerilogGen -td /path/to/output" -mem 4096
```

For example, to generate into this repository:

```sh
cd <chipyard-root>
sbt "project fdra; runMain tram.vitra.VerilogGen -td generators/fdra/cgra-mg/vitrartl" -mem 4096
```

You can also use an interactive sbt session:

```sh
cd <chipyard-root>
sbt
project fdra
runMain tram.vitra.VerilogGen -td /path/to/output
```

The `-td` option selects the target directory for generated files. The VITRA metadata files (`vitra_spec.json`, `operations.json`, `vitra_cgra_adg.json`, and `axilite_spec.json`) are written under `<target-dir>/spec`. Use a fresh output directory when testing a new architecture spec so older generated RTL is not overwritten by accident.

### Generate the CSTORE target

`tram.vitra.CStoreVerilogGen` is the explicit production target for conditional stores. It builds an isolated `COND_LS_MODE` spec without changing the default `tram.vitra.VerilogGen` SRAM configuration, then audits the emitted RTL and metadata before returning success.

```sh
cd <chipyard-root>
sbt -java-home /usr/lib/jvm/java-11-openjdk-amd64 -batch \
  "project fdra" \
  "runMain tram.vitra.CStoreVerilogGen -td /path/to/fresh-output"
```

The generated bundle contains `CGRAWithAXI.v` and the four metadata files under `<target-dir>/spec`. Reproducible reference metadata and its provenance manifest are checked in under:

```text
cgra-mg/src/main/vitra_spec/cstore
```

The RTL is deliberately not checked in; its SHA-256 is recorded in `manifest.json`. The CSTORE contract is `data=operand 0`, `byte address=operand 1`, and `enable=operand 2 bit 0`. The operation catalog and IOB capability include `INPUT`, `OUTPUT`, `LOAD`, `STORE`, and `CSTORE`; they intentionally do not claim the unimplemented `CLOAD` operation.

The current ADORA Mapper can parse these files, but its `COND_LS_MODE` reader independently injects both `CLOAD` and `CSTORE` instead of trusting the artifact's capability list. Therefore parse compatibility is verified, while trusted end-to-end ADORA capability consumption remains blocked until that external reader is fixed. See `cgra-mg/validation/task4-cstore-artifacts.adoc` for exact commits, hashes, commands, and test evidence.

## Modify The VITRA Spec

The main architecture configuration is:

```text
cgra-mg/src/main/scala/vitra/spec/VitraSpec.scala
```

Different CGRA sizes, operation sets, and memory/interconnect settings are selected by editing `object VitraSpec`, especially the `attrs` map.

Reference specs are stored in:

```text
cgra-mg/src/main/scala/vitra/spec/references
```

Use these files as examples when building a new configuration:

- `VitraSpec_smallscale.scala.bck` and `VitraSpec_largescale.scala.bck`: smaller or larger architecture examples.
- `VitraSpec_6M.scala.bck`, `VitraSpec_9M.scala.bck`, `VitraSpec_11M.scala.bck`: capacity/scale-oriented examples.
- `VitraSpec_BF16.scala.bck` and `VitraSpec_FP32.scala.bck`: operation set examples for BF16 and FP32 designs.
- `VitraSpec_Int4x4.scala.bck` and `VitraSpec_Int6x6.scala.bck`: integer design examples.
- `VitraSpec_tensor.scala.bck`: tensor-oriented configuration example.

A typical workflow is:

1. Choose the closest file from `references`.
2. Compare or copy the relevant settings into `VitraSpec.scala`.
3. Re-run `tram.vitra.VerilogGen` with a new `-td` output directory.
4. Check the generated RTL and metadata, especially the operation set and ADG outputs.

## Relationship To FDRA

This repository should not be read as a drop-in copy of the original FDRA documentation. The original FDRA flow included CGRA-MG, an LLVM/Polly-based App-Compiler, a CGRA-Compiler, benchmarks, and SoC application simulation scripts.

In this tree, the actively documented flow is the VITRA CGRA hardware generator under Chipyard. Some FDRA-derived directories and scripts remain for compatibility, experiments, or historical reference, but new users should start from `VitraSpec.scala` and `tram.vitra.VerilogGen`.

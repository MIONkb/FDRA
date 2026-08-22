"""Cocotb driver for the unmodified fresh-generated VITRA full CGRA."""

from __future__ import annotations

import json
import os
from pathlib import Path

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge
from cocotbext.axi import AxiBus, AxiLiteBus, AxiLiteMaster, AxiMaster


def _load_json(environment_name: str) -> dict:
    return json.loads(Path(os.environ[environment_name]).read_text(encoding="utf-8"))


def _register(spec: dict, name: str) -> int:
    return int(spec[name], 16)


async def _write_reg(axil: AxiLiteMaster, address: int, value: int) -> None:
    await axil.write(address, value.to_bytes(4, "little"))


async def _read_reg(axil: AxiLiteMaster, address: int) -> int:
    response = await axil.read(address, 4)
    return int.from_bytes(response.data, "little")


async def _wait_selected_done(
    axil: AxiLiteMaster,
    clock,
    done_address: int,
    selected_tiles: int,
    timeout_cycles: int,
    require_busy_transition: bool,
) -> int:
    busy_seen = not require_busy_transition
    poll_period_cycles = 8
    for poll in range(max(1, timeout_cycles // poll_period_cycles)):
        value = await _read_reg(axil, done_address)
        selected_done = value & selected_tiles
        if selected_done != selected_tiles:
            busy_seen = True
        elif busy_seen:
            return poll
        for _ in range(poll_period_cycles):
            await RisingEdge(clock)
    raise TimeoutError(
        f"selected tiles 0x{selected_tiles:x} did not reach done after a busy transition"
    )


async def _capture_trace(dut, running: list[bool], trace: list[dict]) -> None:
    cycle = 0
    while running[0]:
        await RisingEdge(dut.clk)
        cycle += 1
        try:
            request_bus = int(dut.trace_request_enable.value)
            mask_bus = int(dut.trace_write_mask.value)
            address_bus = int(dut.trace_word_address.value)
            data_bus = int(dut.trace_write_data.value)
        except ValueError as error:
            raise AssertionError("SRAM trace interface contains an unobservable value") from error
        for bank in range(48):
            request = (request_bus >> bank) & 1
            mask = (mask_bus >> (bank * 2)) & 0x3
            if request or mask:
                word_address = (address_bus >> (bank * 12)) & 0xFFF
                data = (data_bus >> (bank * 16)) & 0xFFFF
                trace.append(
                    {
                        "cycle": cycle,
                        "bank": bank,
                        "request_enable": request,
                        "write_enable": int(mask != 0),
                        "write_mask": mask,
                        "byte_address": word_address * 2,
                        "word_address": word_address,
                        "data": data,
                    }
                )


@cocotb.test()
async def full_cgra_external_config(dut):
    bundle = Path(os.environ["E2E_BUNDLE"])
    work = Path(os.environ["E2E_WORK"])
    trace_path = Path(os.environ["E2E_TRACE"])
    result_path = Path(os.environ["E2E_RESULT"])
    case = _load_json("E2E_CASE")
    adapter = json.loads((work / "adapter_result.json").read_text(encoding="utf-8"))
    axil_spec = json.loads((bundle / "spec/axilite_spec.json").read_text(encoding="utf-8"))
    timeout_cycles = int(os.environ.get("E2E_TIMEOUT_CYCLES", "20000"))

    if len(dut.trace_request_enable) != 48 or len(dut.trace_write_mask) != 96:
        raise AssertionError("SRAM interface is not observable through the 48-bank wrapper")

    cocotb.start_soon(Clock(dut.clk, 2, units="ns").start())
    axi = AxiMaster(AxiBus.from_prefix(dut, "axi"), dut.clk, dut.rst)
    axil = AxiLiteMaster(AxiLiteBus.from_prefix(dut, "axil"), dut.clk, dut.rst)

    dut.rst.value = 1
    for _ in range(4):
        await RisingEdge(dut.clk)
    dut.rst.value = 0
    for _ in range(2):
        await RisingEdge(dut.clk)

    packed_config = (work / "config.bin").read_bytes()
    packet_count = adapter["config_packet_count"]
    if len(packed_config) != packet_count * 6:
        raise AssertionError("packed external configuration length is inconsistent")

    config_memory_address = int(axil_spec["cfgmem_baseaddr"])
    await axi.write(config_memory_address, packed_config)
    tile_mask = int(case["tile_mask"])
    iob_mask = int(case["iob_mask"])
    if tile_mask <= 0 or tile_mask >= (1 << int(axil_spec["tile_num"])):
        raise AssertionError("case tile mask must select a nonempty in-range tile subset")
    if iob_mask < 0 or iob_mask >= (1 << 48):
        raise AssertionError("case IOB mask exceeds the physical 48-bank interface")

    await _write_reg(axil, _register(axil_spec, "reg_cfg_base_addr_0"), 0)
    await _write_reg(axil, _register(axil_spec, "reg_cfg_num_0"), packet_count)
    await _write_reg(axil, _register(axil_spec, "reg_cfg_en_tile_0"), tile_mask)
    await _write_reg(axil, _register(axil_spec, "reg_cfg_en"), 1)
    config_wait_cycles = packet_count * 4 + 32
    if config_wait_cycles > timeout_cycles:
        raise TimeoutError("external configuration exceeds the bounded runtime timeout")
    for _ in range(config_wait_cycles):
        await RisingEdge(dut.clk)
    configured_done = await _read_reg(axil, _register(axil_spec, "reg_exe_done_0"))
    if configured_done & tile_mask != tile_mask:
        raise TimeoutError("selected tiles did not return to idle after configuration")

    for load in case.get("memory_loads", []):
        await axi.write(int(load["byte_address"]), bytes.fromhex(load["data_hex"]))

    await _write_reg(axil, _register(axil_spec, "reg_exe_iob_ens_0"), iob_mask & 0xFFFFFFFF)
    await _write_reg(axil, _register(axil_spec, "reg_exe_iob_ens_1"), (iob_mask >> 32) & 0xFFFF)
    await _write_reg(axil, _register(axil_spec, "reg_exe_tile_ens_0"), tile_mask)

    trace: list[dict] = []
    running = [True]
    trace_task = cocotb.start_soon(_capture_trace(dut, running, trace))
    await _write_reg(axil, _register(axil_spec, "reg_exe_start"), 1)
    done_poll = await _wait_selected_done(
        axil,
        dut.clk,
        _register(axil_spec, "reg_exe_done_0"),
        tile_mask,
        timeout_cycles,
        require_busy_transition=True,
    )
    running[0] = False
    await RisingEdge(dut.clk)
    await trace_task

    readbacks = []
    for readback in case.get("memory_readbacks", []):
        response = await axi.read(int(readback["byte_address"]), int(readback["size_bytes"]))
        actual_hex = bytes(response.data).hex()
        expected_hex = readback.get("expected_hex")
        passed = expected_hex is None or actual_hex == expected_hex.lower()
        readbacks.append({**readback, "actual_hex": actual_hex, "passed": passed})
        if not passed:
            raise AssertionError(
                f"readback at 0x{int(readback['byte_address']):x}: "
                f"expected {expected_hex}, got {actual_hex}"
            )

    target = case.get("target")
    target_writes = []
    if target:
        target_writes = [
            entry
            for entry in trace
            if entry["bank"] == int(target["bank"])
            and entry["byte_address"] == int(target["byte_address_within_bank"])
            and entry["write_enable"] == 1
        ]
        expected_write_count = target.get("expected_write_count")
        if expected_write_count is not None and len(target_writes) != int(expected_write_count):
            raise AssertionError(
                f"target write count: expected {expected_write_count}, got {len(target_writes)}"
            )
        for entry in target_writes:
            if "expected_data" in target and entry["data"] != int(target["expected_data"]):
                raise AssertionError("target trace write data does not match the case contract")
            if "expected_mask" in target and entry["write_mask"] != int(target["expected_mask"]):
                raise AssertionError("target trace write mask does not match the case contract")

    trace_path.parent.mkdir(parents=True, exist_ok=True)
    trace_path.write_text(json.dumps(trace, indent=2) + "\n", encoding="utf-8")
    result = {
        "schema_version": 1,
        "case": case["case"],
        "status": "pass",
        "config_sha256": adapter["config_sha256"],
        "rtl_sha256": adapter["artifact_sha256"]["CGRAWithAXI.v"],
        "operations_sha256": adapter["artifact_sha256"]["spec/operations.json"],
        "adg_sha256": adapter["artifact_sha256"]["spec/vitra_cgra_adg.json"],
        "config_packet_count": packet_count,
        "config_wait_cycles": config_wait_cycles,
        "done_cycle": done_poll,
        "trace_event_count": len(trace),
        "target_write_count": len(target_writes),
        "target_write_addresses": [entry["byte_address"] for entry in target_writes],
        "target_write_data": [entry["data"] for entry in target_writes],
        "readbacks": readbacks,
        "predicate_input": case.get("predicate_input"),
        "initial_value": case.get("initial_value"),
        "final_value": case.get("final_value"),
        "simulation_exit_code": 0,
    }
    result_path.parent.mkdir(parents=True, exist_ok=True)
    result_path.write_text(json.dumps(result, indent=2, sort_keys=True) + "\n", encoding="utf-8")

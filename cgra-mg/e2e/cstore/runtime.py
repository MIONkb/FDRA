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
SRAM_BANK_COUNT = 48
SRAM_BANK_STRIDE_BYTES = 8192


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


def parse_mapped_dfgio_text(text: str) -> list[dict[str, Any]]:
    """Parse ADORA's existing Mapper I/O assignment report.

    This metadata identifies runtime SRAM banks only.  It is deliberately not
    used to derive placement, routing, or configuration-register values.
    """
    mappings: list[dict[str, Any]] = []
    tags: set[str] = set()
    names: set[str] = set()
    banks: set[int] = set()
    for line_number, raw_line in enumerate(text.splitlines(), start=1):
        line = raw_line.strip()
        if not line or line.startswith("#"):
            continue
        fields = [field.strip() for field in line.split(",")]
        if len(fields) != 5 or not fields[0] or not fields[1]:
            raise ContractError(f"mapped_dfgio line {line_number}: expected five comma-separated fields")
        tag, name = fields[:2]
        try:
            adg_iob_id, bank, latency = (int(field, 10) for field in fields[2:])
        except ValueError as error:
            raise ContractError(f"mapped_dfgio line {line_number}: numeric fields must be decimal") from error
        if not 0 <= bank < SRAM_BANK_COUNT:
            raise ContractError(f"mapped_dfgio line {line_number}: bank index is outside 0..47")
        if adg_iob_id < 0 or latency < 0:
            raise ContractError(f"mapped_dfgio line {line_number}: id and latency must be nonnegative")
        if tag in tags or name in names or bank in banks:
            raise ContractError(f"mapped_dfgio line {line_number}: duplicate tag, name, or bank")
        tags.add(tag)
        names.add(name)
        banks.add(bank)
        mappings.append(
            {"tag": tag, "name": name, "adg_iob_id": adg_iob_id, "bank": bank, "latency": latency}
        )
    if not mappings:
        raise ContractError("mapped_dfgio contains no assignments")
    return mappings


def _iob_module_attributes(adg: dict[str, Any]) -> dict[str, Any]:
    modules = [entry for entry in adg.get("sub_modules", []) if entry.get("type") == "IOB"]
    if len(modules) != 1 or not isinstance(modules[0].get("attributes"), dict):
        raise ContractError("ADG must describe exactly one IOB module type")
    return modules[0]["attributes"]


def resolve_target_iob(
    adg: dict[str, Any], mappings: list[dict[str, Any]]
) -> dict[str, int]:
    outputs = [entry for entry in mappings if entry["tag"].startswith(("STORE_", "CSTORE_"))]
    if len(outputs) != 1:
        raise ContractError("diagnostic case requires exactly one STORE/CSTORE output")
    output = outputs[0]
    matches = [
        entry
        for entry in adg.get("instances", [])
        if entry.get("type") == "IOB" and entry.get("id") == output["adg_iob_id"]
    ]
    if len(matches) != 1:
        raise ContractError(f"ADG does not contain unique target IOB {output['adg_iob_id']}")
    instance = matches[0]
    if instance.get("iob_index") != output["bank"]:
        raise ContractError("Mapper IOB index disagrees with the authoritative ADG instance")
    required = ("id", "iob_index", "tile", "cfg_blk_index")
    if any(not isinstance(instance.get(field), int) for field in required):
        raise ContractError("target IOB instance is missing integer identity fields")
    return {
        "adg_iob_id": instance["id"],
        "iob_index": instance["iob_index"],
        "tile": instance["tile"],
        "cfg_blk_index": instance["cfg_blk_index"],
    }


def decode_iob_lane_map(adg: dict[str, Any]) -> list[dict[str, int]]:
    attributes = _iob_module_attributes(adg)
    connections = attributes.get("connections")
    if not isinstance(connections, dict):
        raise ContractError("IOB ADG module is missing connections")
    mux_to_lane: dict[int, int] = {}
    raw_inputs: list[dict[str, int]] = []
    for connection in connections.values():
        if not isinstance(connection, list) or len(connection) != 6:
            raise ContractError("IOB connection does not match the six-field ADG format")
        src_id, src_type, src_port, dst_id, dst_type, dst_port = connection
        if src_type == "Muxn" and dst_type == "DelayPipe":
            if src_id in mux_to_lane or not all(isinstance(value, int) for value in (src_id, dst_port)):
                raise ContractError("IOB mux-to-lane mapping is ambiguous")
            mux_to_lane[src_id] = dst_port
        if src_type == "This" and dst_type == "Muxn":
            if not all(isinstance(value, int) for value in (src_port, dst_id, dst_port)):
                raise ContractError("IOB raw-input mapping contains non-integer ports")
            raw_inputs.append(
                {"raw_input": src_port, "mux_id": dst_id, "mux_select": dst_port}
            )
    result: list[dict[str, int]] = []
    for entry in raw_inputs:
        lane = mux_to_lane.get(entry["mux_id"])
        if lane is None:
            raise ContractError(f"IOB mux {entry['mux_id']} does not feed a DelayPipe lane")
        result.append({**entry, "lane": lane})
    result.sort(key=lambda entry: entry["raw_input"])
    expected_count = int(attributes.get("num_operands", 0)) * 2
    if expected_count <= 0 or [entry["raw_input"] for entry in result] != list(range(expected_count)):
        raise ContractError("IOB raw inputs are not a complete consecutive operand mapping")
    return result


def _iob_instance(adg: dict[str, Any], target_iob_id: int) -> dict[str, Any]:
    matches = [
        entry
        for entry in adg.get("instances", [])
        if entry.get("type") == "IOB" and entry.get("id") == target_iob_id
    ]
    if len(matches) != 1:
        raise ContractError(f"ADG does not contain unique target IOB {target_iob_id}")
    return matches[0]


def _configuration_range(attributes: dict[str, Any], config_id: int) -> tuple[int, int]:
    configuration = attributes.get("configuration", {})
    entry = configuration.get(str(config_id), configuration.get(config_id))
    if not isinstance(entry, list) or len(entry) != 3:
        raise ContractError(f"IOB configuration id {config_id} has no authoritative range")
    _name, high, low = entry
    if not isinstance(high, int) or not isinstance(low, int) or high < low:
        raise ContractError(f"IOB configuration id {config_id} has an invalid range")
    return high, low


def decode_iob_config(
    packets: Iterable[tuple[int, int]], adg: dict[str, Any], target_iob_id: int
) -> dict[str, Any]:
    attributes = _iob_module_attributes(adg)
    instance = _iob_instance(adg, target_iob_id)
    cfg_blk_offset = adg.get("cfg_blk_offset")
    cfg_blk_index = instance.get("cfg_blk_index")
    if not isinstance(cfg_blk_offset, int) or not isinstance(cfg_blk_index, int):
        raise ContractError("ADG is missing IOB configuration addressing fields")
    aggregate = attributes.get("configuration", {}).get("0")
    if not isinstance(aggregate, list) or len(aggregate) != 3 or aggregate[0] != "This":
        raise ContractError("IOB aggregate configuration range is missing")
    aggregate_high = aggregate[1]
    if not isinstance(aggregate_high, int) or aggregate_high < 0:
        raise ContractError("IOB aggregate configuration range is invalid")
    word_count = (aggregate_high + 32) // 32
    packet_base = cfg_blk_index << cfg_blk_offset
    packet_map = dict(packets)
    words: list[int] = []
    for word in range(word_count):
        address = packet_base + word
        if address not in packet_map:
            raise ContractError(f"configuration is missing target IOB packet 0x{address:04x}")
        words.append(packet_map[address])
    config_value = sum(value << (32 * index) for index, value in enumerate(words))

    def field(config_id: int) -> int:
        high, low = _configuration_range(attributes, config_id)
        return (config_value >> low) & ((1 << (high - low + 1)) - 1)

    controller_ids = attributes.get("io_controller_cfg_id")
    if not isinstance(controller_ids, dict):
        raise ContractError("IOB module is missing controller configuration IDs")
    controller = {}
    for name in ("IsStore", "UseAddr", "UseEn"):
        config_id = controller_ids.get(name)
        if not isinstance(config_id, int):
            raise ContractError(f"IOB module is missing controller field {name}")
        controller[name] = field(config_id)

    configuration = attributes["configuration"]
    delay_entries = [
        (int(config_id), entry)
        for config_id, entry in configuration.items()
        if isinstance(entry, list) and entry and entry[0] == "DelayPipe"
    ]
    if len(delay_entries) != 1:
        raise ContractError("IOB must contain exactly one DelayPipe configuration")
    delay_id, delay_entry = delay_entries[0]
    delay_value = field(delay_id)
    delay_width = delay_entry[1] - delay_entry[2] + 1
    num_operands = attributes.get("num_operands")
    if not isinstance(num_operands, int) or num_operands <= 0 or delay_width % num_operands:
        raise ContractError("IOB DelayPipe range is incompatible with operand count")
    lane_width = delay_width // num_operands
    lane_mask = (1 << lane_width) - 1
    delay_by_lane = [(delay_value >> (lane * lane_width)) & lane_mask for lane in range(num_operands)]

    lane_map = decode_iob_lane_map(adg)
    mux_select_by_lane: list[int] = []
    selected_raw_input_by_lane: list[int] = []
    for lane in range(num_operands):
        entries = [entry for entry in lane_map if entry["lane"] == lane]
        mux_ids = {entry["mux_id"] for entry in entries}
        if len(entries) != 2 or len(mux_ids) != 1:
            raise ContractError(f"IOB lane {lane} does not have exactly two mux candidates")
        mux_select = field(mux_ids.pop())
        selected = [entry["raw_input"] for entry in entries if entry["mux_select"] == mux_select]
        if len(selected) != 1:
            raise ContractError(f"IOB lane {lane} mux select is outside its candidates")
        mux_select_by_lane.append(mux_select)
        selected_raw_input_by_lane.append(selected[0])

    return {
        "target_iob_id": target_iob_id,
        "iob_index": instance.get("iob_index"),
        "tile": instance.get("tile"),
        "packet_base_address": packet_base,
        "packet_addresses": [packet_base + word for word in range(word_count)],
        "aggregate_config_hex": f"0x{config_value:0{word_count * 8}x}",
        "controller": controller,
        "delay_by_lane": delay_by_lane,
        "mux_select_by_lane": mux_select_by_lane,
        "selected_raw_input_by_lane": selected_raw_input_by_lane,
        "raw_input_lane_map": lane_map,
    }


def derive_test_only_normal_store_config(
    packets: Iterable[tuple[int, int]], adg: dict[str, Any], target_iob_id: int
) -> tuple[list[tuple[int, int]], dict[str, Any]]:
    original = list(packets)
    before = decode_iob_config(original, adg, target_iob_id)
    if before["controller"] != {"IsStore": 1, "UseAddr": 1, "UseEn": 1}:
        raise ContractError("control source must be a configured conditional store")
    attributes = _iob_module_attributes(adg)
    use_en_id = attributes["io_controller_cfg_id"]["UseEn"]
    high, low = _configuration_range(attributes, use_en_id)
    if high != low:
        raise ContractError("UseEn must be a single-bit configuration field")
    packet_address = before["packet_base_address"] + low // 32
    packet_bit = low % 32
    derived = [
        (address, data & ~(1 << packet_bit) if address == packet_address else data)
        for address, data in original
    ]
    after = decode_iob_config(derived, adg, target_iob_id)
    expected_after = {"IsStore": 1, "UseAddr": 1, "UseEn": 0}
    if after["controller"] != expected_after:
        raise ContractError("derived control did not produce normal STORE controller fields")
    changed = [
        (address, before_data ^ after_data)
        for (address, before_data), (after_address, after_data) in zip(original, derived)
        if address != after_address or before_data != after_data
    ]
    if changed != [(packet_address, 1 << packet_bit)]:
        raise ContractError("TEST-ONLY control config changed more than the UseEn bit")
    manifest = {
        "schema_version": SCHEMA_VERSION,
        "test_only": True,
        "adora_generated": False,
        "derivation": "clear authoritative VITRA ADG UseEn field in passing CSTORE config",
        "target_iob_id": target_iob_id,
        "before_controller": before["controller"],
        "after_controller": after["controller"],
        "unchanged_mux_select_by_lane": after["mux_select_by_lane"],
        "unchanged_delay_by_lane": after["delay_by_lane"],
        "changed_bits": [
            {
                "field": "UseEn",
                "aggregate_bit": low,
                "packet_address": packet_address,
                "packet_bit": packet_bit,
                "before": 1,
                "after": 0,
            }
        ],
    }
    return derived, manifest


def format_config_packets(packets: Iterable[tuple[int, int]]) -> str:
    return "".join(f"{address:04x} {data:08x}\n" for address, data in packets)


def build_memory_case(
    mappings: list[dict[str, Any]],
    iob_to_spad_banks: dict[str, list[int]],
    case_name: str,
    input_values: dict[str, int],
    target_byte_address: int,
    initial_value: int,
    expected_final_value: int,
    expected_write_count: int,
    predicate_input: int | None = None,
    tile_mask: int = 0xFF,
) -> dict[str, Any]:
    """Build runtime SRAM transactions from Mapper I/O assignments."""
    outputs = [entry for entry in mappings if entry["tag"].startswith(("CSTORE_", "STORE_"))]
    inputs = [entry for entry in mappings if entry["tag"].startswith("INPUT_")]
    if len(outputs) != 1:
        raise ContractError("runtime case requires exactly one output assignment")
    expected_names = {entry["name"] for entry in inputs}
    if set(input_values) != expected_names:
        raise ContractError(
            f"input values must match mapped inputs exactly: expected {sorted(expected_names)}"
        )
    if not case_name:
        raise ContractError("case name must not be empty")
    if target_byte_address < 0 or target_byte_address >= SRAM_BANK_STRIDE_BYTES:
        raise ContractError("target byte address is outside one SRAM bank")
    if target_byte_address % 2:
        raise ContractError("target byte address must be aligned to a 16-bit SRAM element")
    for value, label in (
        (initial_value, "initial value"),
        (expected_final_value, "expected final value"),
        *[(value, f"input {name}") for name, value in input_values.items()],
    ):
        if not isinstance(value, int) or not 0 <= value <= 0xFFFF:
            raise ContractError(f"{label} must fit an unsigned 16-bit SRAM element")
    if expected_write_count < 0:
        raise ContractError("expected write count must be nonnegative")

    def physical_bank(entry: dict[str, Any]) -> int:
        controller = entry["bank"]
        group = iob_to_spad_banks.get(str(controller), iob_to_spad_banks.get(controller))
        if not isinstance(group, list) or controller not in group or not group:
            raise ContractError(f"ADG has no valid SRAM coalescing group for IOB {controller}")
        if any(not isinstance(bank, int) or not 0 <= bank < SRAM_BANK_COUNT for bank in group):
            raise ContractError(f"ADG SRAM coalescing group for IOB {controller} is invalid")
        return group[0]

    output = outputs[0]
    output_physical_bank = physical_bank(output)
    global_target = output_physical_bank * SRAM_BANK_STRIDE_BYTES + target_byte_address
    load_by_address: dict[int, dict[str, Any]] = {}
    for entry in inputs:
        address = physical_bank(entry) * SRAM_BANK_STRIDE_BYTES
        value = input_values[entry["name"]]
        if address in load_by_address:
            previous = load_by_address[address]
            if previous["value"] != value:
                raise ContractError(
                    f"mapped inputs require conflicting values at physical byte address {address}"
                )
            previous["sources"].append(entry["name"])
        else:
            load_by_address[address] = {"value": value, "sources": [entry["name"]]}
    loads = [
        {
            "byte_address": address,
            "data_hex": entry["value"].to_bytes(2, "little").hex(),
            "source": ",".join(entry["sources"]),
        }
        for address, entry in load_by_address.items()
    ]
    loads.append({
        "byte_address": global_target,
        "data_hex": initial_value.to_bytes(2, "little").hex(),
        "source": "initial-target",
    })
    target = {
        "iob_controller_bank": output["bank"],
        "bank": output_physical_bank,
        "byte_address_within_bank": target_byte_address,
        "global_byte_address": global_target,
        "expected_write_count": expected_write_count,
        "expected_data": expected_final_value,
        "expected_mask": 3,
    }
    return {
        "schema_version": SCHEMA_VERSION,
        "case": case_name,
        "configuration_tile_mask": 0xFF,
        "tile_mask": tile_mask,
        "iob_mask": sum(1 << entry["bank"] for entry in mappings),
        "memory_loads": loads,
        "memory_readbacks": [
            {
                "byte_address": global_target,
                "size_bytes": 2,
                "expected_hex": expected_final_value.to_bytes(2, "little").hex(),
                "source": "target",
            }
        ],
        "target": target,
        "predicate_input": predicate_input,
        "initial_value": initial_value,
        "expected_final_value": expected_final_value,
        "mapper_io": mappings,
        "iob_to_spad_banks": {
            str(entry["bank"]): iob_to_spad_banks[str(entry["bank"])]
            for entry in mappings
        },
        "controller_base_word_address": 0,
    }


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


def render_trace_wrapper(
    core_text: str, bank_count: int = 48, target_iob_id: int | None = None
) -> str:
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
    if target_iob_id is not None:
        if target_iob_id < 0:
            raise ContractError("target IOB id must be nonnegative")
        declarations.extend(
            (
                "  output [95:0] trace_target_raw_inputs",
                "  output [47:0] trace_target_mux_outputs",
                "  output [47:0] trace_target_delay_outputs",
                "  output [47:0] trace_target_controller_inputs",
                "  output [127:0] trace_target_controller_config",
                "  output [11:0] trace_target_delay_config",
                "  output [2:0] trace_target_mux_config",
                "  output trace_target_is_store",
                "  output trace_target_use_addr",
                "  output trace_target_use_en",
                "  output trace_target_w_valid",
                "  output trace_target_write_request",
                "  output trace_target_write_allowed",
                "  output trace_target_write_issue",
                "  output trace_target_iob_enable",
                "  output trace_target_iob_start",
                "  output trace_target_iob_done",
                "  output trace_target_delay_enable",
                "  output [15:0] trace_target_wdata_reg",
                "  output [14:0] trace_target_effective_address",
                "  output [14:0] trace_target_addr_reg",
                "  output [1:0] trace_target_state",
                "  output trace_target_sram_enable",
                "  output [1:0] trace_target_sram_write_mask",
                "  output [14:0] trace_target_sram_word_address",
                "  output [15:0] trace_target_sram_write_data",
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
    if target_iob_id is not None:
        prefix = f"core.cgra.cgra.iob_{target_iob_id}"
        for raw_input in range(6):
            assignments.append(
                f"  assign trace_target_raw_inputs[{raw_input * 16} +: 16] = "
                f"{prefix}.io_in_{raw_input};"
            )
        for lane, mux_name in enumerate(("Muxn", "Muxn_1", "Muxn_2")):
            assignments.append(
                f"  assign trace_target_mux_outputs[{lane * 16} +: 16] = "
                f"{prefix}.{mux_name}_io_out;"
            )
            assignments.append(
                f"  assign trace_target_mux_config[{lane}] = {prefix}.{mux_name}_io_config;"
            )
        for lane in range(3):
            assignments.append(
                f"  assign trace_target_delay_outputs[{lane * 16} +: 16] = "
                f"{prefix}.delay_pipe_io_out_{lane};"
            )
            assignments.append(
                f"  assign trace_target_controller_inputs[{lane * 16} +: 16] = "
                f"{prefix}.ioCtrl_io_in_{lane};"
            )
        assignments.extend(
            (
                f"  assign trace_target_controller_config = {prefix}.ioCtrl_io_config;",
                f"  assign trace_target_delay_config = {prefix}.delay_pipe_io_config;",
                f"  assign trace_target_is_store = {prefix}.ioCtrl.isStore;",
                f"  assign trace_target_use_addr = {prefix}.ioCtrl.useAddr;",
                f"  assign trace_target_use_en = {prefix}.ioCtrl.useEn;",
                f"  assign trace_target_w_valid = {prefix}.ioCtrl.wValid;",
                f"  assign trace_target_write_request = {prefix}.ioCtrl.writeRequest;",
                f"  assign trace_target_write_allowed = {prefix}.ioCtrl.writeAllowed;",
                f"  assign trace_target_write_issue = {prefix}.ioCtrl.writeEnable;",
                f"  assign trace_target_iob_enable = {prefix}.io_en;",
                f"  assign trace_target_iob_start = {prefix}.io_start;",
                f"  assign trace_target_iob_done = {prefix}.io_done;",
                f"  assign trace_target_delay_enable = {prefix}.delay_pipe_io_en;",
                f"  assign trace_target_wdata_reg = {prefix}.ioCtrl.wDataReg;",
                f"  assign trace_target_effective_address = {prefix}.ioCtrl.addr;",
                f"  assign trace_target_addr_reg = {prefix}.ioCtrl.addrReg;",
                f"  assign trace_target_state = {prefix}.ioCtrl.state;",
                f"  assign trace_target_sram_enable = {prefix}.ioCtrl_io_sram_en;",
                f"  assign trace_target_sram_write_mask = {prefix}.ioCtrl_io_sram_we;",
                f"  assign trace_target_sram_word_address = {prefix}.ioCtrl_io_sram_addr;",
                f"  assign trace_target_sram_write_data = {prefix}.ioCtrl_io_sram_din;",
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
            "iob_to_spad_banks_source": "vitra_cgra_adg.json:iob_to_spad_banks; BaseAddr selects within the listed coalesced group",
            "element_width_bits": 16,
            "write_mask_width_bits": 2,
            "post_done_drain_cycles": 2,
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


def _write_text_if_changed(path: Path, value: str) -> None:
    if path.is_file() and path.read_text(encoding="utf-8") == value:
        return
    path.write_text(value, encoding="utf-8")


def prepare(
    bundle: Path, config: Path, output: Path, case_path: Path | None = None
) -> dict[str, Any]:
    validation = validate_bundle(bundle)
    packets = parse_config_file(config)
    diagnostic_target = None
    config_decode = None
    if case_path is not None:
        case = json.loads(case_path.read_text(encoding="utf-8"))
        mappings = case.get("mapper_io")
        if not isinstance(mappings, list):
            raise ContractError("diagnostic case is missing Mapper I/O assignments")
        adg = json.loads((bundle / "spec/vitra_cgra_adg.json").read_text(encoding="utf-8"))
        diagnostic_target = resolve_target_iob(adg, mappings)
        config_decode = decode_iob_config(packets, adg, diagnostic_target["adg_iob_id"])
    output.mkdir(parents=True, exist_ok=True)
    wrapper = render_trace_wrapper(
        (bundle / "CGRAWithAXI.v").read_text(encoding="utf-8"),
        target_iob_id=(diagnostic_target or {}).get("adg_iob_id"),
    )
    _write_text_if_changed(output / "CStoreTraceWrapper.v", wrapper)
    (output / "config.bin").write_bytes(pack_config_packets(packets))
    _write_json(output / "interface.json", interface_contract())
    if config_decode is not None:
        _write_json(output / "config_decode.json", config_decode)
    result = {
        **validation,
        "config_input": str(config.resolve()),
        "config_sha256": sha256_file(config),
        "config_packet_count": len(packets),
        "packed_config_sha256": sha256_file(output / "config.bin"),
        "wrapper_sha256": sha256_file(output / "CStoreTraceWrapper.v"),
        "diagnostic_target": diagnostic_target,
        "config_decode": config_decode,
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
    prepare_parser.add_argument("--case", type=Path)
    manifest_parser = subparsers.add_parser("manifest", help="hash one fresh generated bundle")
    manifest_parser.add_argument("--bundle", type=Path, required=True)
    manifest_parser.add_argument("--vitra-commit", required=True)
    manifest_parser.add_argument("--adora-commit", required=True)
    case_parser = subparsers.add_parser(
        "case", help="adapt Mapper I/O assignments and runtime values into a simulation case"
    )
    case_parser.add_argument("--mapped-dfgio", type=Path, required=True)
    case_parser.add_argument("--adg", type=Path, required=True)
    case_parser.add_argument("--input-values", type=Path, required=True)
    case_parser.add_argument("--case-name", required=True)
    case_parser.add_argument("--target-byte-address", type=lambda value: int(value, 0), required=True)
    case_parser.add_argument("--initial-value", type=lambda value: int(value, 0), required=True)
    case_parser.add_argument("--expected-final-value", type=lambda value: int(value, 0), required=True)
    case_parser.add_argument("--expected-write-count", type=int, required=True)
    case_parser.add_argument("--predicate-input", type=lambda value: int(value, 0))
    case_parser.add_argument("--tile-mask", type=lambda value: int(value, 0), default=0xFF)
    case_parser.add_argument("--output", type=Path, required=True)
    control_parser = subparsers.add_parser(
        "control-config",
        help="derive a labeled TEST-ONLY normal STORE control from a passing CSTORE config",
    )
    control_parser.add_argument("--source-config", type=Path, required=True)
    control_parser.add_argument("--adg", type=Path, required=True)
    control_parser.add_argument("--target-iob-id", type=int, required=True)
    control_parser.add_argument("--output", type=Path, required=True)
    control_parser.add_argument("--manifest", type=Path, required=True)
    args = parser.parse_args(argv)
    try:
        if args.command == "prepare":
            print(json.dumps(prepare(args.bundle, args.config, args.output, args.case), sort_keys=True))
            return 0
        if args.command == "manifest":
            manifest = build_manifest(args.bundle, args.vitra_commit, args.adora_commit)
            _write_json(args.bundle / "manifest.json", manifest)
            print(json.dumps(manifest, sort_keys=True))
            return 0
        if args.command == "case":
            input_values = json.loads(args.input_values.read_text(encoding="utf-8"))
            if not isinstance(input_values, dict):
                raise ContractError("input-values JSON must be an object keyed by Mapper DFG name")
            mapping_text = args.mapped_dfgio.read_text(encoding="utf-8")
            adg = json.loads(args.adg.read_text(encoding="utf-8"))
            spad_groups = adg.get("iob_to_spad_banks")
            if not isinstance(spad_groups, dict):
                raise ContractError("ADG is missing iob_to_spad_banks")
            case = build_memory_case(
                parse_mapped_dfgio_text(mapping_text),
                spad_groups,
                args.case_name,
                input_values,
                args.target_byte_address,
                args.initial_value,
                args.expected_final_value,
                args.expected_write_count,
                predicate_input=args.predicate_input,
                tile_mask=args.tile_mask,
            )
            case["mapped_dfgio_input"] = str(args.mapped_dfgio.resolve())
            case["mapped_dfgio_sha256"] = sha256_file(args.mapped_dfgio)
            case["adg_input"] = str(args.adg.resolve())
            case["adg_sha256"] = sha256_file(args.adg)
            case["input_values_sha256"] = sha256_file(args.input_values)
            _write_json(args.output, case)
            print(json.dumps(case, sort_keys=True))
            return 0
        if args.command == "control-config":
            source_packets = parse_config_file(args.source_config)
            adg = json.loads(args.adg.read_text(encoding="utf-8"))
            derived, control_manifest = derive_test_only_normal_store_config(
                source_packets, adg, args.target_iob_id
            )
            args.output.parent.mkdir(parents=True, exist_ok=True)
            args.output.write_text(format_config_packets(derived), encoding="utf-8")
            control_manifest.update(
                {
                    "source_config": str(args.source_config.resolve()),
                    "source_config_sha256": sha256_file(args.source_config),
                    "output_config": str(args.output.resolve()),
                    "output_config_sha256": sha256_file(args.output),
                    "adg": str(args.adg.resolve()),
                    "adg_sha256": sha256_file(args.adg),
                    "decoded_output": decode_iob_config(derived, adg, args.target_iob_id),
                }
            )
            _write_json(args.manifest, control_manifest)
            print(json.dumps(control_manifest, sort_keys=True))
            return 0
    except (ContractError, OSError, json.JSONDecodeError) as error:
        print(f"error: {error}", file=sys.stderr)
        return 2
    return 2


if __name__ == "__main__":
    raise SystemExit(main())

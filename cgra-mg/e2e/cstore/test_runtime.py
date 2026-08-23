import json
import tempfile
import unittest
from pathlib import Path

import runtime


class ConfigBitTest(unittest.TestCase):
    def test_parses_and_packs_adora_packets(self):
        packets = runtime.parse_config_text("01d9 12345678\n01e1 00000040\n")
        self.assertEqual(packets, [(0x01D9, 0x12345678), (0x01E1, 0x40)])
        self.assertEqual(
            runtime.pack_config_packets(packets),
            bytes.fromhex("78 56 34 12 d9 01 40 00 00 00 e1 01"),
        )

    def test_rejects_malformed_duplicate_and_out_of_range_packets(self):
        invalid = (
            "01d9\n",
            "01d9 0 1\n",
            "not-hex 00000000\n",
            "01d9 00000000\n01d9 00000001\n",
            "10000 00000000\n",
            "0001 100000000\n",
            "\n# comment only\n",
        )
        for text in invalid:
            with self.subTest(text=text), self.assertRaises(runtime.ContractError):
                runtime.parse_config_text(text)


class MapperIoCaseTest(unittest.TestCase):
    MAPPING = """\
# format: DFG-IO-Tag, DFG-IO-Name, ADG-IOB-Id, ADG-IOB-Index, DFG-IO-Latency
CSTORE_0, CSTORE7, 413, 34, 20
INPUT_1, Input8, 552, 47, 1
INPUT_2, Input9, 414, 35, 3
"""

    def test_builds_runtime_inputs_from_mapper_io_without_config_derivation(self):
        mapping = runtime.parse_mapped_dfgio_text(self.MAPPING)
        case = runtime.build_memory_case(
            mapping,
            {"34": [33, 34, 35], "35": [33, 34, 35], "47": [45, 46, 47]},
            case_name="cstore-true",
            input_values={"Input8": 0x1234, "Input9": 2},
            target_byte_address=12,
            initial_value=0xBEEF,
            expected_final_value=0x1236,
            expected_write_count=1,
            predicate_input=1,
            tile_mask=0xEF,
        )
        self.assertEqual(case["configuration_tile_mask"], 0xFF)
        self.assertEqual(case["tile_mask"], 0xEF)
        self.assertEqual(case["iob_mask"], (1 << 34) | (1 << 35) | (1 << 47))
        self.assertEqual(case["target"], {
            "iob_controller_bank": 34,
            "bank": 33,
            "byte_address_within_bank": 12,
            "global_byte_address": 33 * 8192 + 12,
            "expected_write_count": 1,
            "expected_data": 0x1236,
            "expected_mask": 3,
        })
        self.assertEqual(case["memory_loads"], [
            {"byte_address": 45 * 8192, "data_hex": "3412", "source": "Input8"},
            {"byte_address": 33 * 8192, "data_hex": "0200", "source": "Input9"},
            {"byte_address": 33 * 8192 + 12, "data_hex": "efbe", "source": "initial-target"},
        ])
        self.assertEqual(case["memory_readbacks"][0]["expected_hex"], "3612")

    def test_rejects_ambiguous_or_incomplete_mapper_io(self):
        invalid = (
            "INPUT_1, Input1, 1, 48, 0\nSTORE_0, store, 2, 0, 1\n",
            "INPUT_1, Input1, 1, 0, 0\nINPUT_1, Input2, 2, 1, 0\n",
            "INPUT_1, Input1, not-an-id, 0, 0\n",
        )
        for text in invalid:
            with self.subTest(text=text), self.assertRaises(runtime.ContractError):
                runtime.parse_mapped_dfgio_text(text)

        mapping = runtime.parse_mapped_dfgio_text(self.MAPPING)
        with self.assertRaisesRegex(runtime.ContractError, "exactly one output"):
            runtime.build_memory_case(mapping[:1] + [mapping[0]], {}, "bad", {}, 0, 0, 0, 0)
        with self.assertRaisesRegex(runtime.ContractError, "input values"):
            runtime.build_memory_case(mapping, {}, "bad", {"Input8": 1}, 0, 0, 0, 0)

        with self.assertRaisesRegex(runtime.ContractError, "conflicting values"):
            runtime.build_memory_case(
                mapping,
                {"34": [33, 34, 35], "35": [33, 34, 35], "47": [33, 35, 47]},
                "conflict",
                {"Input8": 1, "Input9": 2},
                0,
                0,
                0,
                0,
            )


class IobDiagnosticTest(unittest.TestCase):
    ADG = {
        "cfg_blk_offset": 3,
        "instances": [
            {
                "id": 413,
                "type": "IOB",
                "module_id": 1,
                "cfg_blk_index": 413,
                "iob_index": 34,
                "tile": 5,
            }
        ],
        "sub_modules": [
            {
                "id": 1,
                "type": "IOB",
                "attributes": {
                    "num_operands": 3,
                    "configuration": {
                        "0": ["This", 142, 0],
                        "2": ["DelayPipe", 139, 128],
                        "3": ["Muxn", 140, 140],
                        "4": ["Muxn", 141, 141],
                        "5": ["Muxn", 142, 142],
                        "17": ["IsStore", 125, 125],
                        "18": ["UseAddr", 126, 126],
                        "19": ["UseEn", 127, 127],
                    },
                    "io_controller_cfg_id": {
                        "IsStore": 17,
                        "UseAddr": 18,
                        "UseEn": 19,
                    },
                    "connections": {
                        "1": [0, "This", 0, 3, "Muxn", 0],
                        "2": [0, "This", 1, 3, "Muxn", 1],
                        "3": [3, "Muxn", 0, 2, "DelayPipe", 0],
                        "5": [0, "This", 2, 4, "Muxn", 0],
                        "6": [0, "This", 3, 4, "Muxn", 1],
                        "7": [4, "Muxn", 0, 2, "DelayPipe", 1],
                        "9": [0, "This", 4, 5, "Muxn", 0],
                        "10": [0, "This", 5, 5, "Muxn", 1],
                        "11": [5, "Muxn", 0, 2, "DelayPipe", 2],
                    },
                },
            }
        ],
    }
    MAPPINGS = [
        {
            "tag": "CSTORE_0",
            "name": "CSTORE7",
            "adg_iob_id": 413,
            "bank": 34,
            "latency": 20,
        }
    ]
    CSTORE_PACKETS = [
        (0x0CE8, 0x10000000),
        (0x0CE9, 0x00000000),
        (0x0CEA, 0x00000000),
        (0x0CEB, 0xE9880000),
        (0x0CEC, 0x00005055),
    ]

    def test_resolves_raw_iob_inputs_through_muxes_to_operand_lanes(self):
        target = runtime.resolve_target_iob(self.ADG, self.MAPPINGS)
        self.assertEqual(target, {
            "adg_iob_id": 413,
            "iob_index": 34,
            "tile": 5,
            "cfg_blk_index": 413,
        })
        self.assertEqual(runtime.decode_iob_lane_map(self.ADG), [
            {"raw_input": 0, "mux_id": 3, "mux_select": 0, "lane": 0},
            {"raw_input": 1, "mux_id": 3, "mux_select": 1, "lane": 0},
            {"raw_input": 2, "mux_id": 4, "mux_select": 0, "lane": 1},
            {"raw_input": 3, "mux_id": 4, "mux_select": 1, "lane": 1},
            {"raw_input": 4, "mux_id": 5, "mux_select": 0, "lane": 2},
            {"raw_input": 5, "mux_id": 5, "mux_select": 1, "lane": 2},
        ])

    def test_decodes_controller_mux_and_delay_fields_from_authoritative_adg_ranges(self):
        decoded = runtime.decode_iob_config(self.CSTORE_PACKETS, self.ADG, 413)
        self.assertEqual(decoded["controller"], {
            "IsStore": 1,
            "UseAddr": 1,
            "UseEn": 1,
        })
        self.assertEqual(decoded["delay_by_lane"], [5, 5, 0])
        self.assertEqual(decoded["mux_select_by_lane"], [1, 0, 1])
        self.assertEqual(decoded["selected_raw_input_by_lane"], [1, 2, 5])
        self.assertEqual(decoded["packet_base_address"], 0x0CE8)

    def test_derives_test_only_normal_store_by_clearing_only_use_en(self):
        derived, manifest = runtime.derive_test_only_normal_store_config(
            self.CSTORE_PACKETS, self.ADG, 413
        )
        self.assertEqual(derived[:-2], self.CSTORE_PACKETS[:-2])
        self.assertEqual(derived[-2], (0x0CEB, 0x69880000))
        self.assertEqual(derived[-1], self.CSTORE_PACKETS[-1])
        self.assertEqual(manifest["changed_bits"], [{
            "field": "UseEn",
            "aggregate_bit": 127,
            "packet_address": 0x0CEB,
            "packet_bit": 31,
            "before": 1,
            "after": 0,
        }])
        self.assertEqual(manifest["before_controller"], {
            "IsStore": 1,
            "UseAddr": 1,
            "UseEn": 1,
        })
        self.assertEqual(manifest["after_controller"], {
            "IsStore": 1,
            "UseAddr": 1,
            "UseEn": 0,
        })
        self.assertTrue(manifest["test_only"])
        self.assertFalse(manifest["adora_generated"])


class BundleValidationTest(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.root = Path(self.tmp.name)
        (self.root / "spec").mkdir()
        (self.root / "CGRAWithAXI.v").write_text(
            "module CGRAWithAXI(input clock, input reset); endmodule\n"
        )
        (self.root / "spec" / "vitra_spec.json").write_text(
            json.dumps(
                {
                    "cgra_iob_mode": 2,
                    "cgra_iob_sram_has_mask": True,
                    "cgra_data_width": 16,
                    "cgra_cfg_data_width": 32,
                    "cgra_cfg_addr_width_align": 16,
                }
            )
        )
        (self.root / "spec" / "operations.json").write_text(
            json.dumps({"operations": [{"name": "CSTORE"}, {"name": "ACC"}]})
        )
        (self.root / "spec" / "vitra_cgra_adg.json").write_text(
            json.dumps({"nodes": [{"operations": ["CSTORE", "ACC"]}]})
        )
        (self.root / "spec" / "axilite_spec.json").write_text(
            json.dumps({"cfgmem_baseaddr": 393216, "tile_num": 8, "tile_iob_bank_num": 6})
        )
        (self.root / "spec" / "loop_index_contract.json").write_text(
            json.dumps(
                {
                    "physical_operation": "ACC",
                    "for_is_physical_operation": False,
                    "byte_address_scaling": "external-explicit-arithmetic",
                }
            )
        )
        self.manifest = runtime.build_manifest(self.root, "a" * 40, "b" * 40)
        (self.root / "manifest.json").write_text(json.dumps(self.manifest))

    def tearDown(self):
        self.tmp.cleanup()

    def test_consumes_one_generation_and_rejects_for_cload_or_hash_mismatch(self):
        validated = runtime.validate_bundle(self.root)
        self.assertEqual(validated["vitra_commit"], "a" * 40)
        self.assertEqual(validated["artifact_count"], 6)

        operations = self.root / "spec" / "operations.json"
        original = operations.read_text()
        operations.write_text(original + " ")
        with self.assertRaisesRegex(runtime.ContractError, "hash mismatch"):
            runtime.validate_bundle(self.root)

        operations.write_text(json.dumps({"operations": [{"name": "FOR"}]}))
        self.manifest = runtime.build_manifest(self.root, "a" * 40, "b" * 40)
        (self.root / "manifest.json").write_text(json.dumps(self.manifest))
        with self.assertRaisesRegex(runtime.ContractError, "FOR"):
            runtime.validate_bundle(self.root)

        operations.write_text(json.dumps({"operations": [{"name": "CLOAD"}]}))
        self.manifest = runtime.build_manifest(self.root, "a" * 40, "b" * 40)
        (self.root / "manifest.json").write_text(json.dumps(self.manifest))
        with self.assertRaisesRegex(runtime.ContractError, "CLOAD"):
            runtime.validate_bundle(self.root)


class WrapperTest(unittest.TestCase):
    def test_wraps_unmodified_core_and_exposes_all_sram_banks(self):
        core = """module CGRAWithAXI(
  input clock,
  input reset,
  output io_s_axi_aw_ready,
  input io_s_axi_aw_valid,
  input [18:0] io_s_axi_aw_bits_addr,
  output io_s_axilite_aw_ready,
  input io_s_axilite_aw_valid,
  input [9:0] io_s_axilite_aw_bits_addr
);\nendmodule\n"""
        wrapper = runtime.render_trace_wrapper(core, bank_count=48)
        self.assertIn("module CStoreTraceWrapper(", wrapper)
        self.assertIn("CGRAWithAXI core (", wrapper)
        self.assertIn(".clock(clk)", wrapper)
        self.assertIn(".io_s_axi_aw_bits_addr(axi_awaddr)", wrapper)
        self.assertIn(".io_s_axilite_aw_bits_addr(axil_awaddr)", wrapper)
        self.assertIn("core.cgra_io_srams_iob_0_en", wrapper)
        self.assertIn("core.cgra_io_srams_iob_47_din", wrapper)
        self.assertEqual(wrapper.count("trace_request_enable["), 48)
        self.assertEqual(wrapper.count("trace_write_mask["), 48)
        self.assertEqual(wrapper.count("trace_word_address["), 48)
        self.assertEqual(wrapper.count("trace_write_data["), 48)

    def test_exposes_cycle_aligned_target_iob_pipeline_without_modifying_core(self):
        core = """module CGRAWithAXI(
  input clock,
  input reset
);\nendmodule
// Fresh generated hierarchy contains: IOB_42 iob_484 (...)
"""
        wrapper = runtime.render_trace_wrapper(core, bank_count=48, target_iob_id=484)
        self.assertIn("output [95:0] trace_target_raw_inputs", wrapper)
        self.assertIn("output [47:0] trace_target_mux_outputs", wrapper)
        self.assertIn("output [47:0] trace_target_delay_outputs", wrapper)
        self.assertIn("output [47:0] trace_target_controller_inputs", wrapper)
        self.assertIn("output [127:0] trace_target_controller_config", wrapper)
        self.assertIn("output trace_target_write_issue", wrapper)
        self.assertIn("output trace_target_iob_enable", wrapper)
        self.assertIn("output trace_target_iob_start", wrapper)
        self.assertIn("output trace_target_iob_done", wrapper)
        self.assertIn("output trace_target_delay_enable", wrapper)
        self.assertIn(
            "assign trace_target_raw_inputs[0 +: 16] = core.cgra.cgra.iob_484.io_in_0;",
            wrapper,
        )
        self.assertIn(
            "assign trace_target_mux_outputs[32 +: 16] = core.cgra.cgra.iob_484.Muxn_2_io_out;",
            wrapper,
        )
        self.assertIn(
            "assign trace_target_delay_outputs[16 +: 16] = core.cgra.cgra.iob_484.delay_pipe_io_out_1;",
            wrapper,
        )
        self.assertIn(
            "assign trace_target_controller_inputs[32 +: 16] = core.cgra.cgra.iob_484.ioCtrl_io_in_2;",
            wrapper,
        )
        self.assertIn(
            "assign trace_target_wdata_reg = core.cgra.cgra.iob_484.ioCtrl.wDataReg;",
            wrapper,
        )
        self.assertIn(
            "assign trace_target_write_issue = core.cgra.cgra.iob_484.ioCtrl.writeEnable;",
            wrapper,
        )
        self.assertIn(
            "assign trace_target_delay_enable = core.cgra.cgra.iob_484.delay_pipe_io_en;",
            wrapper,
        )


class InterfaceTest(unittest.TestCase):
    def test_interface_is_machine_readable_and_complete(self):
        interface = runtime.interface_contract()
        self.assertEqual(interface["top_module"], "CStoreTraceWrapper")
        self.assertEqual(interface["wrapped_core"], "CGRAWithAXI")
        self.assertEqual(interface["reset"]["polarity"], "active-high")
        self.assertEqual(interface["axi"]["data_width_bits"], 128)
        self.assertEqual(interface["axi_lite"]["data_width_bits"], 32)
        self.assertEqual(interface["configuration"]["packet_word_order"], [
            "data[15:0]",
            "data[31:16]",
            "address[15:0]",
        ])
        self.assertEqual(interface["sram_write_trace"]["bank_count"], 48)
        self.assertEqual(interface["sram"]["post_done_drain_cycles"], 2)
        self.assertEqual(interface["sram_write_trace"]["address_units"], {
            "word_address": "16-bit elements",
            "byte_address": "word_address * 2",
        })
        self.assertEqual(interface["runtime"]["model"], "vendored-minimum")
        self.assertEqual(len(interface["runtime"]["reference_commit"]), 40)


if __name__ == "__main__":
    unittest.main()

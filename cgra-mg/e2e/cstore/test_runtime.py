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
        self.assertEqual(interface["sram_write_trace"]["address_units"], {
            "word_address": "16-bit elements",
            "byte_address": "word_address * 2",
        })
        self.assertEqual(interface["runtime"]["model"], "vendored-minimum")
        self.assertEqual(len(interface["runtime"]["reference_commit"]), 40)


if __name__ == "__main__":
    unittest.main()

TOPLEVEL_LANG := verilog
SIM ?= verilator
TOPLEVEL := CStoreTraceWrapper
MODULE := cocotb_full_cgra
export MAKEFLAGS += -j4

ifndef E2E_BUNDLE
$(error E2E_BUNDLE is required)
endif
ifndef E2E_WORK
$(error E2E_WORK is required)
endif

VERILOG_SOURCES := $(E2E_BUNDLE)/CGRAWithAXI.v $(E2E_WORK)/CStoreTraceWrapper.v
COMPILE_ARGS += -Wno-fatal -Wno-SELRANGE -Wno-WIDTH -Wno-CASEINCOMPLETE
COMPILE_ARGS += --threads 4 --build-jobs 4
COMPILE_ARGS += --output-split 5000 --output-split-cfuncs 500

COCOTB_HDL_TIMEUNIT := 1ns
COCOTB_HDL_TIMEPRECISION := 1ns
COCOTB_RESOLVE_X := ZEROS
COCOTB_LOG_LEVEL ?= WARNING
export COCOTB_LOG_LEVEL

include $(shell cocotb-config --makefiles)/Makefile.sim

# All signals consumed by the test are explicit wrapper ports.  Avoid exporting
# every internal signal in the 615-module core through VPI.
COMPILE_ARGS := $(filter-out --public-flat-rw,$(COMPILE_ARGS))
COMPILE_ARGS += --public-depth 1

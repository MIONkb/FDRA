# to the chipyard directory
cd ../../..
# generate verilog file
sbt "project fdra; runMain tram.axi.VerilogGen -td ./verilog" -mem 4096

#or

sbt
project fdra
runMain tram.axi.VerilogGen -td /home/jhlou/projects/cocotb/verilog
runMain tram.axi.VerilogGenWithoutSRAM -td /home/jhlou/chipyard/generators/fdra/cgra-mg/rtl
runMain tram.axi.VerilogGen -td /home/jhlou/projects/cocotb/IntVecAddNew
runMain tram.vitra.VerilogGen -td /home/jhlou/chipyard/generators/fdra/cgra-mg/vitrartl
runMain tram.vitra.VerilogGen -td /home/jhlou/CGRVOPT/AXIFPGA/CGRAWithAXI6X6X2
runMain tram.vitra.VerilogGen -td /home/jhlou/CGRVOPT/MatrixMeld/vitrartl
runMain tram.vitra.VerilogGenWithoutSRAM -td /home/jhlou/chipyard/generators/fdra/cgra-mg/rtl
runMain tram.vitra.FirGen -td /home/jhlou/CGRVOPT/AXIFPGA/CGRAWithAXI8x16/src 

# firtool /home/jhlou/CGRVOPT/MatrixMeld/rtl/CGRAwithAXI.fir \
#   --split-verilog \
#   --output-dir=verilog_out 
# # generate verilog file
# sbt "runMain dsa.VerilogGen -td ./test_run_dir"
# # generate CGRA top module, no-check-comb-loops
# sbt "runMain dsa.VerilogGen -td ./test_run_dir --no-check-comb-loops"
# # increase JVM heap size, -mem
# sbt "runMain dsa.VerilogGen -td ./test_run_dir --no-check-comb-loops" -mem 4096
# # test
# sbt "test:runMain dsa.CGRATester  -td ./test_run_dir"
# sbt "test:runMain dsa.CGRATester  -td ./test_run_dir -tbn verilator"


# jhlou
# run VerilogGen in generators/fdra/cgra-mg/src/main/scala/axi/TramWithAxi.scala
cd ../../.. #chipyard
sbt
project fdra
runMain tram.axi.VerilogGen


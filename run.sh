# to the chipyard directory
cd ../../..
# generate verilog file
sbt "project fdra; runMain tram.axi.VerilogGen -td ./verilog" -mem 4096

#or

sbt
project fdra
runMain tram.axi.VerilogGen -td /home/jhlou/projects/cocotb/verilog
runMain tram.axi.VerilogGen -td /home/jhlou/chipyard/generators/fdra 
runMain tram.axi.VerilogGen -td /home/jhlou/projects/cocotb/IntVecAddNew
runMain tram.vitra.VerilogGen -td /home/jhlou/projects/cocotb/IntVecAddNew
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


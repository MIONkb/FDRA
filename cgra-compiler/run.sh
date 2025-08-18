# SPDLOG_LEVEL=trace, debug, info, warn, err, critical, off
/home/jhlou/chipyard/generators/fdra/cgra-compiler/build/cgra-compiler SPDLOG_LEVEL=off \
	-c true -m true -o true -t 3600000 -i 2000 \
	-p "/home/jhlou/chipyard/generators/fdra/cgra-mg/src/main/resources/operations.json" \
	-a "/home/jhlou/chipyard/generators/fdra/cgra-mg/src/main/resources/cgra_adg.json" \
	-d "/home/jhlou/CGRVOPT/cgra-opt/experiment/Cbenchmarks/Polybench/medley/deriche/2_dfgs/kernel_deriche_kernel_0_CDFG.json"
	# "../benchmarks/test4/conv2d_3x3/affine.json"
  #-d "/home/tianyi/MLIRCGRA/CGRA-Flow/mlir-cgra/experiments/LJHtest/gemm_new/kernels/gemm_kernel_0.json"
	# -d "../benchmarks/test4/conv2d_3x3/affine.json"
#	-d "../benchmarks/test/arf/arf.json ../benchmarks/test/centro-fir/centro-fir.json ../benchmarks/test/ewf/ewf.json ../benchmarks/test/fft/fft.json ../benchmarks/test/fir1/fir1.json ../benchmarks/test/resnet1/resnet1.json"
#	-d "../benchmarks/test/arf/arf.json ../benchmarks/test/centro-fir/centro-fir.json ../benchmarks/test/cosine1/cosine1.json ../benchmarks/test/ewf/ewf.json ../benchmarks/test/fir1/fir1.json ../benchmarks/test/resnet1/resnet1.json"
	# -d "../benchmarks/test/fft/fft.json"
  #	-d "../benchmarks/test2/matrixmul/matrixmul.json"
	# -d "../benchmarks/test/cosine2/cosine2.json ../benchmarks/test/fir/fir.json ../benchmarks/test/md/md.json ../benchmarks/test/resnet2/resnet2.json ../benchmarks/test/stencil3d/stencil3d.json"	
	# -d "../benchmarks/test2/conv3/conv3.json ../benchmarks/test2/matrixmul/matrixmul.json ../benchmarks/test2/simple/simple.json"
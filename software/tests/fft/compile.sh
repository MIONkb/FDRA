clang -D CGRA_COMPILER -target riscv64-unknown-elf -c -emit-llvm \
  -fno-builtin-printf -nostdlib \
   -I/home/tianyi/chipyard/generators/fdra/software/tests/riscv-tests \
  -I/home/tianyi/chipyard/generators/fdra/software/tests/riscv-tests/env \
  -I/home/tianyi/chipyard/generators/fdra/software/tests/ \
  -I/home/tianyi/chipyard/generators/fdra/software/tests/riscv-tests/benchmarks/common \
  -I/home/tianyi/chipyard/.conda-env/riscv-tools/riscv64-unknown-elf/include \
  -I/home/tianyi/chipyard/.conda-env/riscv-tools/sysroot/usr/include \
  -O2 -fno-tree-vectorize -fno-unroll-loops fft2.c -S -o fft2.ll

llc -O3 fft2.ll \
  -march=riscv64 -mtriple=riscv64-unknown-elf-gnu -mcpu=rocket-rv64 \
  -mattr=+c,+d,+relax  -float-abi=hard \
  -o fft2.s

riscv64-unknown-elf-gcc \
 -DPREALLOCATE=1 -DMULTITHREAD=1 -mcmodel=medany \
 -std=gnu99 -O2 -ffast-math -fno-common -fno-builtin-printf \
 -fno-tree-loop-distribute-patterns -march=rv64gc -Wa,-march=rv64gc12 \
 -lm -lgcc \
 -I/home/tianyi/chipyard/generators/fdra/software/tests/riscv-tests \
 -I/home/tianyi/chipyard/generators/fdra/software/tests/riscv-tests/env \
 -I/home/tianyi/chipyard/generators/fdra/software/tests/ \
 -I/home/tianyi/chipyard/generators/fdra/software/tests/riscv-tests/benchmarks/common \
 -DID_STRING=  -nostdlib -nostartfiles -static \
 -T /home/tianyi/chipyard/generators/fdra/software/tests/riscv-tests/benchmarks/common/test.ld \
 -DBAREMETAL=1 \
 /home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/cgra_execute.c \
 -o /home/tianyi/chipyard/generators/fdra/software/tests/build/bareMetalC/gemm-baremetal \
 /home/tianyi/chipyard/generators/fdra/software/tests/riscv-tests/benchmarks/common/syscalls.c \
 /home/tianyi/chipyard/generators/fdra/software/tests/riscv-tests/benchmarks/common/crt.S 


riscv64-unknown-elf-gcc \
 -DPREALLOCATE=1 -DMULTITHREAD=1 -mcmodel=medany \
 -std=gnu99 -O2 -ffast-math -fno-common -fno-builtin-printf \
 -fno-tree-loop-distribute-patterns -march=rv64gc -Wa,-march=rv64gc12 \
 -lm -lgcc \
 -I/home/tianyi/chipyard/generators/fdra/software/tests//riscv-tests \
 -I/home/tianyi/chipyard/generators/fdra/software/tests//riscv-tests/env \
 -I/home/tianyi/chipyard/generators/fdra/software/tests/ \
 -I/home/tianyi/chipyard/generators/fdra/software/tests//riscv-tests/benchmarks/common \
 -DID_STRING=  -nostdlib -nostartfiles -static \
 -T /home/tianyi/chipyard/generators/fdra/software/tests//riscv-tests/benchmarks/common/test.ld \
 -DBAREMETAL=1 \
 -S -o /home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/syscalls.s \
 /home/tianyi/chipyard/generators/fdra/software/tests//riscv-tests/benchmarks/common/syscalls.c

riscv64-unknown-elf-as -march=rv64gc \
 /home/tianyi/chipyard/generators/fdra/software/tests/fft/fft2.s \
 -o /home/tianyi/chipyard/generators/fdra/software/tests/fft/fft2.o 

riscv64-unknown-elf-as -march=rv64gc \
 /home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/crt.S \
 -o /home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/crt.o 

riscv64-unknown-elf-as -march=rv64gc \
 /home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/syscalls.s \
 -o /home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/syscalls.o

riscv64-unknown-elf-ld -melf64lriscv \
 -T/home/tianyi/chipyard/generators/fdra/software/tests/riscv-tests/benchmarks/common/test.ld \
 -e _start \
 -o /home/tianyi/chipyard/generators/fdra/software/tests/build/bareMetalC/fft2-baremetal \
  /home/tianyi/chipyard/generators/fdra/software/tests/fft/fft2.o \
 /home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/crt.o \
 /home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/syscalls.o \
#  /home/tianyi/chipyard/generators/fdra/software/tests/fft/fft2.o 



################
# simple compute
################
riscv64-unknown-elf-gcc \
 -DPREALLOCATE=1 -DMULTITHREAD=1 -mcmodel=medany \
 -std=gnu99 -O2 -ffast-math -fno-common -fno-builtin-printf \
 -fno-tree-loop-distribute-patterns -march=rv64gc -Wa,-march=rv64gc12 \
 -lm -lgcc \
 -I/home/tianyi/chipyard/generators/fdra/software/tests/riscv-tests \
 -I/home/tianyi/chipyard/generators/fdra/software/tests/riscv-tests/env \
 -I/home/tianyi/chipyard/generators/fdra/software/tests/ \
 -I/home/tianyi/chipyard/generators/fdra/software/tests/riscv-tests/benchmarks/common \
 -DID_STRING=  -nostdlib -nostartfiles -static \
 -T /home/tianyi/chipyard/generators/fdra/software/tests/riscv-tests/benchmarks/common/test.ld \
 -DBAREMETAL=1 \
 /home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/simplecompute.c -S\
 -o /home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/simplecompute.s 

riscv64-unknown-elf-gcc \
 -DPREALLOCATE=1 -DMULTITHREAD=1 -mcmodel=medany \
 -std=gnu99 -O2 -ffast-math -fno-common -fno-builtin-printf \
 -fno-tree-loop-distribute-patterns -march=rv64gc -Wa,-march=rv64gc12 \
 -lm -lgcc \
 -DID_STRING=  -nostdlib -nostartfiles -static \
 -T /home/tianyi/chipyard/generators/fdra/software/tests/riscv-tests/benchmarks/common/test.ld \
 -I/home/tianyi/chipyard/generators/fdra/software/tests \
 -DBAREMETAL=1 \
 /home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/cgra_execute.c -S \
 -o /home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/cgra_execute.s 


riscv64-unknown-elf-gcc \
 -std=gnu99 -O2 -ffast-math -fno-common -fno-builtin-printf \
 -fno-tree-loop-distribute-patterns -march=rv64gc -Wa,-march=rv64gc12 \
 -I/home/tianyi/chipyard/generators/fdra/software/tests/include \
 -I/home/tianyi/chipyard/generators/fdra/software/tests \
 -DBAREMETAL=1 \
 /home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/ISA.c -S\
 -o /home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/extISA.s

riscv64-unknown-elf-as -march=rv64gc \
 /home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/simplecompute.s \
 -o /home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/simplecompute.o 

riscv64-unknown-elf-as -march=rv64gc \
 /home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/cgra_execute.s \
 -o /home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/cgra_execute.o
 

riscv64-unknown-elf-ld -melf64lriscv \
 -T/home/tianyi/chipyard/generators/fdra/software/tests/riscv-tests/benchmarks/common/test.ld \
 -e _start \
 -o /home/tianyi/chipyard/generators/fdra/software/tests/build/bareMetalC/simplecompute-baremetal \
 /home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/crt.o \
 /home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/syscalls.o \
 /home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/cgra_execute.o \
 /home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/simplecompute.o 
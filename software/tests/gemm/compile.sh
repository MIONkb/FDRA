clang -D CGRA_COMPILER -target riscv64-unknown-elf -c -emit-llvm \
  -fno-builtin-printf -nostdlib \
   -I/home/tianyi/chipyard/generators/fdra/software/tests/riscv-tests \
  -I/home/tianyi/chipyard/generators/fdra/software/tests/riscv-tests/env \
  -I/home/tianyi/chipyard/generators/fdra/software/tests/ \
  -I/home/tianyi/chipyard/generators/fdra/software/tests/riscv-tests/benchmarks/common \
  -I/home/tianyi/chipyard/.conda-env/riscv-tools/riscv64-unknown-elf/include \
  -I/home/tianyi/chipyard/.conda-env/riscv-tools/sysroot/usr/include \
  -O2 -fno-tree-vectorize -fno-unroll-loops fft2.c -S -o fft2.ll

clang -D CGRA_COMPILER -target i386-unknown-linux-gnu \
 -c -emit-llvm -O2 -fno-tree-vectorize -fno-unroll-loops -S fft2.c

opt -O2 -memprof main.ll > main.bc

llvm-as main.ll -o main.bc

llc -O2 main.bc \
  -march=riscv64 -mtriple=riscv64-unknown-elf-gnu -mcpu=rocket-rv64 \
  --relocation-model=pic \
  -mattr=+c,+d,+relax  \
  -float-abi=hard \
  -o main.s

sed -i -E 's/^(\s*)(\.file|\.loc)/\1#&/' "main.s"

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
 -DBAREMETAL=1 \
 /home/tianyi/chipyard/generators/fdra/software/tests/gemm/cgra_gemm.c \
 -S -o /home/tianyi/chipyard/generators/fdra/software/tests/gemm/cgra_gemm.s 




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
 /home/tianyi/chipyard/generators/fdra/software/tests/gemm/cgra_gemm.s \
 -o /home/tianyi/chipyard/generators/fdra/software/tests/gemm/cgra_gemm.o 

riscv64-unknown-elf-as -march=rv64gc \
 /home/tianyi/chipyard/generators/fdra/software/tests/gemm/main.s \
 -o /home/tianyi/chipyard/generators/fdra/software/tests/gemm/main.o 

riscv64-unknown-elf-as -march=rv64gc \
 /home/tianyi/chipyard/generators/fdra/software/tests/gemm/crt.S \
 -o /home/tianyi/chipyard/generators/fdra/software/tests/gemm/crt.o 

riscv64-unknown-elf-as -march=rv64gc \
 /home/tianyi/chipyard/generators/fdra/software/tests/gemm/syscalls.s \
 -o /home/tianyi/chipyard/generators/fdra/software/tests/gemm/syscalls.o

riscv64-unknown-elf-ld -melf64lriscv \
 -T/home/tianyi/chipyard/generators/fdra/software/tests/riscv-tests/benchmarks/common/test.ld \
 -e _start \
 -o /home/tianyi/chipyard/generators/fdra/software/tests/build/bareMetalC/gemm-baremetal \
 /home/tianyi/chipyard/generators/fdra/software/tests/gemm/crt.o \
 /home/tianyi/chipyard/generators/fdra/software/tests/gemm/syscalls.o \
 /home/tianyi/chipyard/generators/fdra/software/tests/gemm/main.o \
 /home/tianyi/chipyard/generators/fdra/software/tests/gemm/cgra_gemm.o


/home/tianyi/chipyard/sims/verilator/simulator-chipyard-TramSoCConfig\
  /home/tianyi/chipyard/generators/fdra//software/tests/build/bareMetalC/gemm-baremetal\
  --debug


 /home/tianyi/chipyard/generators/fdra/software/tests/gemm/cgra_gemm.o \

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
 /home/tianyi/chipyard/generators/fdra/software/tests/gemm/cgra_execute.c \
 -o /home/tianyi/chipyard/generators/fdra/software/tests/build/bareMetalC/gemm-baremetal \
 /home/tianyi/chipyard/generators/fdra/software/tests/riscv-tests/benchmarks/common/syscalls.c \
 /home/tianyi/chipyard/generators/fdra/software/tests/riscv-tests/benchmarks/common/crt.S 

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
 /home/tianyi/chipyard/generators/fdra/software/tests/gemm/cgra_execute.c \
 -o /home/tianyi/chipyard/generators/fdra/software/tests/build/bareMetalC/gemm-baremetal \
 /home/tianyi/chipyard/generators/fdra/software/tests/riscv-tests/benchmarks/common/syscalls.c \
 /home/tianyi/chipyard/generators/fdra/software/tests/riscv-tests/benchmarks/common/crt.S 
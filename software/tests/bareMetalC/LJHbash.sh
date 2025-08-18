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
 /home/tianyi/chipyard/generators/fdra/software/tests//bareMetalC/Nokernel.c \
 -o /home/tianyi/chipyard/generators/fdra/software/tests/build/bareMetalC/Nokernel-baremetal \
 /home/tianyi/chipyard/generators/fdra/software/tests//riscv-tests/benchmarks/common/syscalls.c \
 /home/tianyi/chipyard/generators/fdra/software/tests//riscv-tests/benchmarks/common/crt.S 

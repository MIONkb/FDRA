#include <stdint.h>
#include <stddef.h>
#include <assert.h>
#include <stdlib.h>
#include <stdio.h>
#ifndef BAREMETAL
#include <sys/mman.h>
#endif

//Define compute data type
#define TYPE unsigned int

//Specify row/column sizes
#define row_size 32
#define col_size 32
#define N (row_size*col_size)

TYPE m1[N] __attribute__((aligned(8)));
TYPE m2[N] __attribute__((aligned(8)));
TYPE prod0[N] __attribute__((aligned(8)));
TYPE prod[N] __attribute__((aligned(8)));

__attribute__((noinline))
void gemm(){
    int i, j, k;
    int k_col, i_col;
    TYPE mult;

    outer:for(i=0;i<row_size;i++) {
        middle:for(j=0;j<col_size;j++) {
            i_col = i * col_size;
            TYPE sum = 0;
            inner:for(k=0;k<row_size;k++) {
                k_col = k * col_size;
                mult = m1[i_col + k] * m2[k_col + j];
                sum += mult;
            }
            prod0[i_col + j]  = sum;
        }
    }
}

#include "include/ISA.h"
#include "include/encoding.h"

void cgra_execute(void** din_addr, void** dout_addr)
{
	volatile unsigned short cin[62][3] __attribute__((aligned(8))) = {
		{0x8002, 0x2000, 0x0018},
		{0xf900, 0x0107, 0x0019},
		{0x0002, 0x0102, 0x001a},
		{0x0000, 0x0000, 0x001b},
		{0x1040, 0x2010, 0x0028},
		{0x2040, 0x8107, 0x0029},
		{0x0e30, 0x0102, 0x002a},
		{0x0000, 0x0000, 0x002b},
		{0x0820, 0x2010, 0x0030},
		{0x2040, 0x8107, 0x0031},
		{0x0e30, 0x0102, 0x0032},
		{0x0000, 0x0000, 0x0033},
		{0x8001, 0x2000, 0x0038},
		{0xf900, 0x0107, 0x0039},
		{0x0002, 0x0102, 0x003a},
		{0x0000, 0x0000, 0x003b},
		{0x1860, 0x2010, 0x0040},
		{0x2040, 0x8107, 0x0041},
		{0x0e30, 0x0102, 0x0042},
		{0x0000, 0x0000, 0x0043},
		{0x2000, 0x0000, 0x0068},
		{0x0000, 0x0002, 0x0070},
		{0x1100, 0x0002, 0x0078},
		{0x0000, 0x0002, 0x0080},
		{0x0000, 0x0000, 0x0088},
		{0xd103, 0x0000, 0x00a9},
		{0x5003, 0x0000, 0x00b1},
		{0x1061, 0x0001, 0x00b9},
		{0x8803, 0x0000, 0x00c1},
		{0x00c0, 0x0000, 0x00f0},
		{0x0100, 0x0000, 0x00f8},
		{0x0800, 0x0000, 0x0100},
		{0x0004, 0x0000, 0x0108},
		{0x8881, 0x0000, 0x0141},
		{0x6041, 0x0000, 0x0149},
		{0x0000, 0x0020, 0x0180},
		{0x0500, 0x0000, 0x0188},
		{0x0003, 0x0000, 0x0198},
		{0x4801, 0x0000, 0x01d1},
		{0x0000, 0x0020, 0x0210},
		{0x0000, 0x0200, 0x0218},
		{0x0000, 0x0000, 0x0228},
		{0x2003, 0x0001, 0x0271},
		{0x0000, 0x0004, 0x02a0},
		{0x0300, 0x0000, 0x02a8},
		{0x0001, 0x0000, 0x02c0},
		{0x8003, 0x2000, 0x02e0},
		{0xf900, 0x0107, 0x02e1},
		{0x0002, 0x0102, 0x02e2},
		{0x0000, 0x0000, 0x02e3},
		{0x0800, 0x2000, 0x02f0},
		{0x0040, 0x8100, 0x02f1},
		{0x0000, 0x9502, 0x02f2},
		{0x0000, 0x0000, 0x02f3},
		{0x0800, 0x2010, 0x0300},
		{0x2040, 0x8107, 0x0301},
		{0x0e30, 0x0102, 0x0302},
		{0x0000, 0x0000, 0x0303},
		{0x8000, 0x2000, 0x0308},
		{0xf900, 0x0107, 0x0309},
		{0x0002, 0x0102, 0x030a},
		{0x0000, 0x0000, 0x030b},
	};

	load_cfg((void*)cin, 0x20000, 372, 0, 0);
	load_data(din_addr[0], 0x18000, 4096, 1, 0, 0);
	load_data(din_addr[1], 0x8000, 4096, 1, 0, 0);
	load_data(din_addr[2], 0x0, 4096, 1, 0, 0);
	load_data(din_addr[3], 0x10000, 4096, 0, 0, 0);
	load_data(din_addr[4], 0x1a000, 4096, 1, 0, 0);
	load_data(din_addr[5], 0xa000, 4096, 1, 0, 0);
	load_data(din_addr[6], 0xc000, 4096, 1, 0, 0);
	load_data(din_addr[7], 0xe000, 4096, 0, 0, 0);
	config(0x0, 62, 0, 0);
	execute(0x6af4, 0, 0);
	store(dout_addr[0], 0x12000, 4096, 0, 0);
}



int main(){
//#ifndef BAREMETAL
//    if (mlockall(MCL_CURRENT | MCL_FUTURE) != 0) {
//      perror("mlockall failed");
//      exit(1);
//    }
//#endif
    long long unsigned start;
    long long unsigned end;

    for (int i=0; i<N; i++){
      m1[i] = i;
      m2[i] = i+1;
    }

    start = rdcycle();
    gemm();
    end = rdcycle();
    printf("It takes %d cycles for CPU to finish the task.\n", end - start);

//    void* cgra_din_addr[2] = {m1, m2};
    void* cgra_din_addr[8] = {m1, m1, m1, m1, m2, m2, m2, m2};
    void* cgra_dout_addr[1] = {prod};
    start = rdcycle();
    cgra_execute(cgra_din_addr, cgra_dout_addr);
    volatile int result = fence(1);
    end = rdcycle();
    printf("It takes %d cycles for CGRA to finish the task(%d).\n", end - start, result);

//    printf("%x, %x, %x, %x\n", m1, m2, prod0, prod);
//    printf("Execution time (CPU, CGRA): %ul, %ul\n", time0, time1);
    printf("Compare the result:\n");
    for (int i=0; i<N; i++){
        if(prod[i] != prod0[i]){
            printf("%x, %x\n", prod0[i], prod[i]);
        }
    }
    printf("Succeed!(%d)\n", result);

    return 0;
}
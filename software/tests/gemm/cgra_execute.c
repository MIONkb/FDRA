// void cgra_execute(void** din_addr, void** dout_addr)
// {
// 	volatile unsigned short cin[22][3] __attribute__((aligned(8))) = {
// 		{0x2800, 0x8000, 0x0004},
// 		{0xf840, 0x8107, 0x0005},
// 		{0x0000, 0x0102, 0x0006},
// 		{0x0000, 0x0000, 0x0007},
// 		{0x0000, 0x8000, 0x0008},
// 		{0x0040, 0x8100, 0x0009},
// 		{0x0000, 0x8d02, 0x000a},
// 		{0x0000, 0x0000, 0x000b},
// 		{0x0030, 0x0000, 0x002c},
// 		{0x8413, 0x0000, 0x0051},
// 		{0x0000, 0x0008, 0x0074},
// 		{0x000c, 0x0000, 0x0078},
// 		{0x080d, 0x0000, 0x0095},
// 		{0x0000, 0x5001, 0x0096},
// 		{0x0080, 0x0500, 0x0097},
// 		{0x0000, 0x0020, 0x00c0},
// 		{0x0000, 0x0020, 0x0108},
// 		{0x0000, 0x0000, 0x0150},
// 		{0x0000, 0x8004, 0x0174},
// 		{0x0840, 0x8107, 0x0175},
// 		{0x0e00, 0x0102, 0x0176},
// 		{0x0000, 0x0000, 0x0177},
// 	};

// 	load_cfg((void*)cin, 0x20000, 132, 0, 0);
// 	load_data(din_addr[0], 0x2000, 4096, 1, 0, 0);
// 	load_data(din_addr[1], 0x10000, 4096, 0, 0, 0);
// 	config(0x0, 22, 0, 0);
// 	execute(0x403, 0, 0);
// 	store(dout_addr[0], 0x0, 4096, 0, 0);
// }
#define NTAPS 32

#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <math.h>
#include "include/encoding.h"
#include "include/ISA.h"
// #include <stdio.h>

void cgra_execute(void *a, void *b, void*c)
{
	printf("In cgra_excute!\n");
	volatile unsigned short cin[20][3] __attribute__((aligned(8))) = {
		{0x100d, 0x0000, 0x00e5},
		{0x0000, 0x4001, 0x00e6},
		{0x0080, 0x0500, 0x00e7},
		{0x0000, 0x0200, 0x0108},
		{0x0001, 0x0000, 0x010c},
		{0x9003, 0x0000, 0x012d},
		{0x2000, 0x0000, 0x0150},
		{0x0004, 0x0000, 0x0154},
		{0x0000, 0x8000, 0x0170},
		{0x0040, 0x8100, 0x0171},
		{0x0000, 0x8d02, 0x0172},
		{0x0080, 0x0000, 0x0173},
		{0x1000, 0x8004, 0x0174},
		{0x0840, 0x8107, 0x0175},
		{0x0e00, 0x0102, 0x0176},
		{0x0000, 0x0000, 0x0177},
		{0x2800, 0x8000, 0x0178},
		{0xf840, 0x8107, 0x0179},
		{0x0000, 0x0102, 0x017a},
		{0x0000, 0x0000, 0x017b},
	};

	load_cfg((void*)cin, 0x20000, 120, 0, 0);
	load_data(a, 0x12000, 4096, 1, 0, 0);
	load_data(b, 0x14000, 4096, 0, 0, 0);
	config(0x0, 20, 0, 0);
	execute(0xe00, 0, 0);
	store(c, 0x10000, 4096, 0, 0);
	printf("out cgra_excute!\n");
}

int main(int argc, char** argv)
{
  printf("IT is stupid!\n");
  long long unsigned start;
  long long unsigned end;
	int a [4096], b[4096], c[4096];
	int cnt = 0;
	for(; cnt < 4096; cnt++){
		a[cnt]=cnt+1;
		b[cnt]=cnt * 2;
		c[cnt]=0;
	}
  printf("Initialization finished!\n");

  start = rdcycle();
  /* Run kernel. */

  end = rdcycle();
  printf("It takes %d cycles for CPU to finish the task.\n", end - start);
  start = rdcycle();
  cgra_execute(a, b, c);
  volatile int result = fence(1);
  end = rdcycle();
  printf("It takes %d cycles for CGRA to finish the task(%d).\n", end - start, result);

  // result_check();
  printf("Done!\n");

  return 0;
}
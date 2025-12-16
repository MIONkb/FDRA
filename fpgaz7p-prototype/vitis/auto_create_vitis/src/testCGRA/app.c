

//===----------------------------------------------------------------------===//
//
// Copyright (c) 2025 ADORA
// All rights reserved.
//
// Automatically generated file for Vitis SDK based CGRA call function from ADORA.
// Generated on: 2025-12-08 00:54:34
//
//===----------------------------------------------------------------------===//

#include "cgra_cdma.h"
#include "cgra_axil.h"
static uint8_t _task_id = 0;
#define CGRA_BASE_ADDR 0x90000000
#define CGRA_LITE_ADDR 0x90040000

static void HostToDeviceTransfer(
  XScuGic* IntcController, XAxiCdma* AxiCdmaInstance,
  void* src_h, void* dst_d, int64_t bytelen){
  int Status;
  xil_printf("%d\r\n",bytelen);
  Status = XAxiCdma_DataTransfer(IntcController, AxiCdmaInstance, (UINTPTR)src_h, (UINTPTR)dst_d, bytelen);
  if (Status != XST_SUCCESS) {
    xil_printf("XAxiCdma Data Transfer Failed. Status: %d\r\n", Status);
    abort();
  }
}

static void DeviceToHostTransfer(
  XScuGic* IntcController, XAxiCdma* AxiCdmaInstance,
  void* src_d, void* dst_h, int64_t bytelen){
  int Status;
  Status = XAxiCdma_DataTransfer(IntcController, AxiCdmaInstance, (UINTPTR)src_d, (UINTPTR)dst_h, bytelen);
  if (Status != XST_SUCCESS) {
    xil_printf("XAxiCdma Data Transfer Failed. Status: %d\r\n", Status);
    abort();
  }
}


//===----------------------------------------------------------------------===//
// Configuration Data
//===----------------------------------------------------------------------===//
/// BF16VecAddMul
volatile unsigned short cin_BF16VecAddMul[37][3] __attribute__((aligned(16))) = {
		{0x9000, 0x4000, 0x0008},
		{0x0001, 0x0000, 0x0009},
		{0x0000, 0x0000, 0x000a},
		{0x0000, 0x2488, 0x000b},
		{0x0080, 0x0000, 0x000c},
		{0x8000, 0x4000, 0x0010},
		{0x0001, 0x0000, 0x0011},
		{0x0000, 0x0000, 0x0012},
		{0x0000, 0x0008, 0x0013},
		{0x0001, 0x0000, 0x0020},
		{0x0000, 0x0308, 0x0028},
		{0x2200, 0x0000, 0x0029},
		{0x0008, 0x0000, 0x0040},
		{0x0800, 0x0000, 0x0041},
		{0x0818, 0x0000, 0x0061},
		{0x0200, 0x0000, 0x0078},
		{0x0000, 0x0000, 0x0080},
		{0x0819, 0x0000, 0x0081},
		{0x0000, 0x0000, 0x0098},
		{0x0000, 0x0080, 0x00a0},
		{0x0018, 0x0000, 0x00a1},
		{0x0000, 0x100a, 0x00a8},
		{0x2200, 0x0000, 0x00a9},
		{0x0000, 0x0000, 0x00b8},
		{0x0008, 0x0000, 0x00c0},
		{0x0018, 0x0000, 0x00c1},
		{0x0001, 0x0000, 0x00d8},
		{0x0000, 0x0000, 0x00e0},
		{0x9000, 0x4000, 0x00e8},
		{0x0001, 0x0000, 0x00e9},
		{0x0000, 0x0000, 0x00ea},
		{0x0000, 0x2488, 0x00eb},
		{0x0000, 0x0000, 0x00ec},
		{0x8000, 0x4000, 0x00f0},
		{0x0001, 0x0000, 0x00f1},
		{0x0000, 0x0000, 0x00f2},
		{0x0000, 0x0008, 0x00f3},
	};


void BF16VecAddMul(XAxiCdma* AxiCdmaInstance, XScuGic* IntcController, void* arg_0, void* arg_1, void* arg_2, void* arg_3){
  int Status;
  int16_t *SrcPtr, *DesPtr;

  {
  /// %0 = ADORA.BlockLoad %arg0 [0] : memref<?xbf16> -> memref<20xbf16>  {Id = "0", KernelName = "BF16VecAddMul"}
  uint64_t dramoffset_0 = 0;
  uint64_t spadoffset_0 = 0;
  uint64_t roffset_0 = 0;
  HostToDeviceTransfer(IntcController, AxiCdmaInstance, arg_0 + dramoffset_0 + roffset_0, 0x0 + spadoffset_0 + 0x90000000, 40);
  spadoffset_0 = spadoffset_0 + 40;

  }
  {
  /// %1 = ADORA.BlockLoad %arg1 [0] : memref<?xbf16> -> memref<20xbf16>  {Id = "1", KernelName = "BF16VecAddMul"}
  uint64_t dramoffset_1 = 0;
  uint64_t spadoffset_1 = 0;
  uint64_t roffset_1 = 0;
  HostToDeviceTransfer(IntcController, AxiCdmaInstance, arg_1 + dramoffset_1 + roffset_1, 0x4000 + spadoffset_1 + 0x90000000, 40);
  spadoffset_1 = spadoffset_1 + 40;

  }
  {
  /// BF16VecAddMul
  HostToDeviceTransfer(IntcController, AxiCdmaInstance, (void*)cin_BF16VecAddMul, 0x30000 + 0x90000000, 222);
  cgra_config(0x0, 37, 0x00000001);
  cgra_exe(0x0000000f, 0x00000001);
  wait_cgra_all_finish();

  }
  {
  /// ADORA.BlockStore %2, %arg2 [0] : memref<20xbf16> -> memref<?xbf16>  {Id = "2", KernelName = "BF16VecAddMul"}
  uint64_t dramoffset_2 = 0;
  uint64_t spadoffset_2 = 0;
  uint64_t roffset_2 = 0;
  DeviceToHostTransfer(IntcController, AxiCdmaInstance, 0x6000 + spadoffset_2 + 0x90000000, arg_2 + dramoffset_2 + roffset_2, 40);
  spadoffset_2 = spadoffset_2 + 40;

  }
  {
  /// ADORA.BlockStore %3, %arg3 [0] : memref<20xbf16> -> memref<?xbf16>  {Id = "3", KernelName = "BF16VecAddMul"}
  uint64_t dramoffset_3 = 0;
  uint64_t spadoffset_3 = 0;
  uint64_t roffset_3 = 0;
  DeviceToHostTransfer(IntcController, AxiCdmaInstance, 0x2000 + spadoffset_3 + 0x90000000, arg_3 + dramoffset_3 + roffset_3, 40);
  spadoffset_3 = spadoffset_3 + 40;

  }
  _task_id++;
  return ;
}





















static XAxiCdma AxiCdmaInstance;	/* Instance of the XAxiCdma */
static XScuGic IntcController;	/* Instance of the Interrupt Controller */

typedef uint16_t bf16;
bf16 float_to_bf16_rne(float x) {
    uint32_t u = *(uint32_t *)&x;
    uint32_t lsb = (u >> 16) & 1;
    uint32_t rounding_bias = 0x7FFF + lsb;
    return (bf16)((u + rounding_bias) >> 16);
}
float bf16_to_float(bf16 b) {
    uint32_t tmp = ((uint32_t)b) << 16;
    return *(float *)&tmp;
}
void fpPrint(float value){
	xil_printf("%d.%06d", (int)value, (int)(fabs(value) * 1000000) % 1000000);
}
int main(){
    float a[20], b[20], c[20], d[20], e[20], f[20], g[20], h[20];

    for(int i=0;i<20;i++){
        a[i] = 1 + i * 0.1;
        b[i] = 2 + i * 0.1;
    }

    for(int i=0;i<20;i++){
        c[i] = a[i] + b[i];
        d[i] = a[i] * b[i];
    }

    bf16 a_bf16[20] __attribute__ ((aligned (64)));
    bf16 b_bf16[20] __attribute__ ((aligned (64)));
    bf16 c_bf16[20], d_bf16[20];
    bf16 c_cgra[20] __attribute__ ((aligned (64)));
    bf16 d_cgra[20] __attribute__ ((aligned (64)));
    for(int i=0;i<20;i++){
        a_bf16[i] = float_to_bf16_rne(a[i]);
        b_bf16[i] = float_to_bf16_rne(b[i]);
    }
    // Simulate hardware BF16 vector add and multiply
    for(int i=0;i<20;i++){
        c_bf16[i] = float_to_bf16_rne(bf16_to_float(a_bf16[i]) + bf16_to_float(b_bf16[i]));
        d_bf16[i] = float_to_bf16_rne(bf16_to_float(a_bf16[i]) * bf16_to_float(b_bf16[i]));
    }
    // Convert back to float for verification
    for(int i=0;i<20;i++){
        e[i] = bf16_to_float(c_bf16[i]);
        f[i] = bf16_to_float(d_bf16[i]);
    }

    int Status;
	Status = XAxiCdma_Prepare(&IntcController, &AxiCdmaInstance);
	if (Status != XST_SUCCESS) {
		xil_printf("XAxiCdma Prepare Failed\r\n");
		return XST_FAILURE;
	}


    BF16VecAddMul(&AxiCdmaInstance, &IntcController, a_bf16, b_bf16, c_cgra, d_cgra);

    for(int i=0;i<20;i++){
        g[i] = bf16_to_float(c_cgra[i]);
        h[i] = bf16_to_float(d_cgra[i]);
    }


    for(int i=0;i<20;i++){
        // printf("a[%d]=%f, b[%d]=%f, c[%d]=%f, d[%d]=%f\n", i, a[i], i, b[i], i, c[i], i, d[i]);
        xil_printf("c[%d]=", i);
        fpPrint(c[i]);
        xil_printf(";\t d[%d]=", i);
        fpPrint(d[i]);
        xil_printf(";\t e[%d]=", i);
        fpPrint(e[i]);
        xil_printf(";\t f[%d]=", i);
        fpPrint(f[i]);
        xil_printf(";\t g[%d]=", i);
        fpPrint(g[i]);
        xil_printf(";\t h[%d]=", i);
        fpPrint(h[i]);
        xil_printf("\r\n");
    }


	// Close
	XAxiCdma_CloseAndClean(&IntcController);


    xil_printf("\r\n");

    return 0;
}




/*


void    init_array_int(int n,
		DATA_TYPE x1[N],
		DATA_TYPE x2[N],
		DATA_TYPE y_1[N],
		DATA_TYPE y_2[N],
		DATA_TYPE A[N][N])
{
  int i, j;

  for (i = 0; i < n; i++){
      x1[i] = (DATA_TYPE) (i % n) ;
      x2[i] = (DATA_TYPE) ((i + 1) % n);
      y_1[i] = (DATA_TYPE) ((i + 3) % n);
      y_2[i] = (DATA_TYPE) ((i + 4) % n) ;
      for (j = 0; j < n; j++)
    	  A[i][j] = (DATA_TYPE) (i*j % n);
    }
}


void kernel_mvt_cpu(
		DATA_TYPE x1[N],
		DATA_TYPE x2[N],
		DATA_TYPE y_1[N],
		DATA_TYPE y_2[N],
		DATA_TYPE A[N][N])
{
  int i, j;


  for (i = 0; i < N; i++)
    for (j = 0; j < N; j++)
      x1[i] = x1[i] + A[i][j] * y_1[j];
  for (i = 0; i < N; i++)
    for (j = 0; j < N; j++)
      x2[i] = x2[i] + A[j][i] * y_2[j];

}


//void print_float(float num) {
//int integer_part = (int)num;
//int fractional_part = (int)(fabs(num) * 1000000) % 1000000;
//xil_printf("%d.%06d\t", integer_part, fractional_part);
//}

int main()
{
	int Status;

	DATA_TYPE x1[N] __attribute__ ((aligned (64)));
	DATA_TYPE x2[N] __attribute__ ((aligned (64)));
	DATA_TYPE y_1[N] __attribute__ ((aligned (64)));
	DATA_TYPE y_2[N] __attribute__ ((aligned (64)));
	DATA_TYPE A[N][N] __attribute__ ((aligned (64)));
//	init_array(N, x1, x2, y_1, y_2, A);
	init_array_int(N, x1, x2, y_1, y_2, A);

	DATA_TYPE x1zero[N] __attribute__ ((aligned (64)));
	for(int i=0;i<N;i++){
		x1zero[i] = 0;
	}


	DATA_TYPE x1cpu[N] __attribute__ ((aligned (64)));
	DATA_TYPE x2cpu[N] __attribute__ ((aligned (64)));
	DATA_TYPE y_1cpu[N] __attribute__ ((aligned (64)));
	DATA_TYPE y_2cpu[N] __attribute__ ((aligned (64)));
	DATA_TYPE Acpu[N][N] __attribute__ ((aligned (64)));
//	init_array(N ,x1cpu, x2cpu, y_1cpu, y_2cpu, Acpu);
	init_array_int(N ,x1cpu, x2cpu, y_1cpu, y_2cpu, Acpu);


	xil_printf("\r\n--- Entering main() --- \r\n");


	// Prepare
	Status = XAxiCdma_Prepare(&IntcController, &AxiCdmaInstance);
	if (Status != XST_SUCCESS) {
		xil_printf("XAxiCdma Prepare Failed\r\n");
		return XST_FAILURE;
	}

//	kernel_mvt_cpu(x1cpu, x2cpu, y_1cpu, y_2cpu, Acpu);

	xil_printf("\r\n--- cpu() done --- \r\n");

	kernel_mvt(&AxiCdmaInstance, &IntcController, x1, x2, y_1, y_2, A);

	xil_printf("\r\n--- cgra() done --- \r\n");

	for(int i=0; i<N; i++){
//		print_float(x1[i]) ;
//		print_float(x1cpu[i]) ;
//		print_float(x2[i]) ;
//		print_float(x2cpu[i]);
//		xil_printf("x1: %f, %f;x2: %f , %f", x1[i], x1cpu[i], x2[i], x2cpu[i]);
		xil_printf("x1: %d, %d;x2: %d , %d", x1[i], x1cpu[i], x2[i], x2cpu[i]);
		if((x1[i]!=x1cpu[i])){
			xil_printf("\terror in x1[%d]\t", i);
		}
		if( (x2[i]!=x2cpu[i])){
			xil_printf("error in x2[%d]", i);
		}

		xil_printf("\r\n");
	}

	// Close
	XAxiCdma_CloseAndClean(&IntcController);


    xil_printf("\r\n");


	return XST_SUCCESS;

}


*/


//#include "xtime_l.h"
//XTime tEnd, tbegin;

//XTime_GetTime(&tbegin);

//XTime_GetTime(&tEnd);
//  tused = ((tEnd-tbegin)*1000000)/(COUNTS_PER_SECOND);
//  xil_printf("time elapsed is %d us\r\n",tused);
//xil_printf("COUNTS_PER_SECOND is %d us\r\n",COUNTS_PER_SECOND);
//xil_printf("duration %d cycle\r\n",(tEnd-tbegin));


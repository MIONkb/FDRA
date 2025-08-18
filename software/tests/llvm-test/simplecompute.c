#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <math.h>

/* Include benchmark-specific header. */
/* Default data type is double, default size is 4000. */
#include "include/encoding.h"
#include "include/ISA.h"
void cgra_execute(void** din_addr, void** dout_addr);
#define TYPE int
#define N 1024
TYPE XR0[N];
TYPE XR1[N];
TYPE XR2[N];
TYPE XR3[N];
TYPE XI0[N];
TYPE XI1[N];
TYPE XI2[N];
TYPE XI3[N];
TYPE YR0[N];
TYPE YR1[N];
TYPE YR2[N];
TYPE YR3[N];
TYPE YI0[N];
TYPE YI1[N];
TYPE YI2[N];
TYPE YI3[N];
TYPE ZR0[N];
TYPE ZR1[N];
TYPE ZR2[N];
TYPE ZR3[N];
TYPE ZI0[N];
TYPE ZI1[N];
TYPE ZI2[N];
TYPE ZI3[N];

#define cmplx_M_x(a_x, a_y, b_x, b_y) (a_x*b_x - a_y *b_y)
#define cmplx_M_y(a_x, a_y, b_x, b_y) (a_x*b_y + a_y *b_x)
#define cmplx_MUL_x(a_x, a_y, b_x, b_y ) (a_x*b_x - a_y*b_y)
#define cmplx_MUL_y(a_x, a_y, b_x, b_y ) (a_x*b_y + a_y*b_x)
#define cmplx_mul_x(a_x, a_y, b_x, b_y) (a_x*b_x - a_y*b_y)
#define cmplx_mul_y(a_x, a_y, b_x, b_y) (a_x*b_y + a_y*b_x)
#define cmplx_add_x(a_x, b_x) (a_x + b_x)
#define cmplx_add_y(a_y, b_y) (a_y + b_y)
#define cmplx_sub_x(a_x, b_x) (a_x - b_x)
#define cmplx_sub_y(a_y, b_y) (a_y - b_y)
#define cm_fl_mul_x(a_x, b) (b*a_x)
#define cm_fl_mul_y(a_y, b) (b*a_y)

#define FF2(a0_x, a0_y, a1_x, a1_y){			\
    TYPE c0_x = a0_x;		\
    TYPE c0_y = a0_y;		\
    a0_x = cmplx_add_x(c0_x, a1_x);	\
    a0_y = cmplx_add_y(c0_y, a1_y);	\
    a1_x = cmplx_sub_x(c0_x, a1_x);	\
    a1_y = cmplx_sub_y(c0_y, a1_y);	\
}

#define FFT4(a0_x, a0_y, a1_x, a1_y, a2_x, a2_y, a3_x, a3_y){           \
    TYPE exp_1_44_x;		\
    TYPE exp_1_44_y;		\
    TYPE tmp;			\
    exp_1_44_x =  0;		\
    exp_1_44_y =  -1;		\
    FF2( a0_x, a0_y, a2_x, a2_y);   \
    FF2( a1_x, a1_y, a3_x, a3_y);   \
    tmp = a3_x;			\
    a3_x = a3_x*exp_1_44_x-a3_y*exp_1_44_y;     	\
    a3_y = tmp*exp_1_44_y - a3_y*exp_1_44_x;    	\
    FF2( a0_x, a0_y, a1_x, a1_y );                  \
    FF2( a2_x, a2_y, a3_x, a3_y );                  \
}

/* Array initialization. */
static
void init_array()
{
    int i;
    for (i = 0; i < N; i++) {
        XR0[i] = i;
        XR1[i] = i+1;
        XR2[i] = i+2;
        XR3[i] = i+3;
        XI0[i] = i+4;
        XI1[i] = i+5;
        XI2[i] = i+6;
        XI3[i] = i+7;
    }    
}


/* Main computational kernel. The whole function will be timed,
   including the call and return. */


int main(int argc, char** argv)
{
  printf("IT is stupid!\n");
  long long unsigned start;
  long long unsigned end;
  init_array();
  printf("Initialization finished!\n");

  void* cgra_din_addr[8] = {XI0, XI1, XI2, XI3, XR0, XR1, XR2, XR3};
  void* cgra_dout_addr[8] = {YR0, YI0, YR1, YI1, YR2, YI2, YR3, YI3};
  start = rdcycle();
  cgra_execute(cgra_din_addr, cgra_dout_addr);
  volatile int result = fence(1);
  end = rdcycle();
  printf("It takes %d cycles for CGRA to finish the task(%d).\n", end - start, result);

  return 0;
}

#include <string.h>
#include <stdio.h>


#define SIZE  1024
int A[SIZE], B[SIZE], C[SIZE];

__attribute__((noinline))

void array_add(){
   for (int i=0;i<SIZE; i++){
      #ifdef CGRA_COMPILER
      please_map_me();
      #endif
      C[i] = A[i]+B[i];
   }
}

int main(){

int i,j;

for (i=0;i<SIZE; i++){
      A[i] = i * 2 + 5;
      B[i] = i * 3;
      C[i] = 0;
    }
    
array_add();

for (i=0;i<SIZE; i++) printf("%d\n", C[i]);
    

return 0;

}

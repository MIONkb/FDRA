    #define _PB_LENGTH 8
    int c[_PB_LENGTH+1][_PB_LENGTH+1];
    int sum_c[_PB_LENGTH+1][_PB_LENGTH+1][_PB_LENGTH+1];
   //kernel 23
void kernel() { 
    #ifdef CGRA_COMPILER
    	loop_begin();
    #endif 
     for (int i = 0; i <= _PB_LENGTH ; i++)
        {
          for (int j = 0; j <= _PB_LENGTH ; j++)
          {
            for (int k = 1; k <= _PB_LENGTH; k++)
              sum_c[i][j][k] = c[i][k] + c[k][j];
          }
        }
                       
    #ifdef CGRA_COMPILER
    	loop_end();
    #endif 
}

#include <stdio.h>
    unsigned int Input1[16] = {0x1111, 0x2222, 0x3333, 0x4444,
                               0x5555, 0x6666, 0x7777, 0x8888,
                               0x9999, 0xAAAA, 0xBBBB, 0xCCCC,
                               0xDDDD, 0xEEEE, 0xFFFF, 0x6666};
    unsigned int Input0[1] = {0b0001101100011011};
    unsigned int Output0[16] = {0};
    unsigned int Output1[16] = {0};
    unsigned int Output2[16] = {0};
    unsigned int Output3[16] = {0};
    // initialize variables
    //int Gran_selection[1]; // 0 represents 1 word per data; 1 represents 2 words per data
int kernel(int Gran_selection) {


    /*
    unsigned int Input1[16] = {0x1111, 0x2222, 0x3333, 0x4444,
                               0x5555, 0x6666, 0x7777, 0x8888,
                               0x9999, 0xAAAA, 0xBBBB, 0xCCCC,
                               0xDDDD, 0xEEEE, 0xFFFF, 0x6666};
    unsigned int Output0[16] = {0};
    unsigned int Output1[16] = {0};
    unsigned int Output2[16] = {0};
    unsigned int Output3[16] = {0};*/
    int type_mask = 0x3; // 2 bits for data type
    int type_shift = 0;
    int word_size = 16;
    int num_words = 16; // default to 16 for 1-word data
    //int output_index[4] = {0, 0, 0, 0};
    
    // // read inputs
    // scanf("%d", &Gran_selection);
    // scanf("%u", &Input0);
    // for (int i = 0; i < num_words; i++) {
    //     scanf("%u", &Input1[i]);
    // }

    // set word size and number of words based on Gran_selection
    /*
    if (Gran_selection == 1) {
        word_size = 32;
        num_words = 8;
    }*/
    
    // process input data
    
    int outidx0, outidx1, outidx2, outidx3;
    outidx0 = 0;
    outidx1 = 0;
    outidx2 = 0;
    outidx3 = 0;
    /*
    for (int i = 0; i < num_words; i++) {
    please_map_me();
        // extract data type from Input0
        int type = (Input0[0] >> type_shift) & type_mask;
        
        // if (type_shift >= 32) {
        //     type_shift = 0;
        // }
        
            if (type == 0){
                Output0[outidx0] = Input1[i];
                outidx0 += 1;
            }
            else if (type == 1){
                Output1[outidx1] = Input1[i];
                outidx1 += 1;
            }
            else if (type == 2){
                Output2[outidx2] = Input1[i];
                outidx2 += 1;
            }
            else {
                Output3[outidx3] = Input1[i];
                outidx3 += 1;
            }
            type_shift += 2;
    }
    */
    ///*
     for (int i = 0; i < num_words; i++) {
    please_map_me();
        // extract data type from Input0
        int type = (Input0[0] >> type_shift) & type_mask;
        type_shift += 2;
        // if (type_shift >= 32) {
        //     type_shift = 0;
        // }
        

            if (type == 0){
                Output0[outidx0] = Input1[i * 2];
                outidx0 += 1;
                Output0[outidx0] = Input1[i * 2 + 1];
                outidx0 += 1;
            }
            else if (type == 1){
                Output1[outidx1] = Input1[i * 2];
                outidx1 += 1;
                Output1[outidx1] = Input1[i * 2 + 1];
                outidx1 += 1;
            }
    //type_shift += 2;
    }
    //*/
    
    // output results
    for (int i = 0; i < 16; i++) {
        printf("%x ", Output0[i]);
    }
    printf("\n");
    for (int i = 0; i < 16; i++) {
        printf("%x ", Output1[i]);
    }
    printf("\n");
    for (int i = 0; i < 16; i++) {
        printf("%x ", Output2[i]);
    }
    printf("\n");
    for (int i = 0; i < 16; i++) {
        printf("%x ", Output3[i]);
    }
    printf("\n");
    
    return 0;
}

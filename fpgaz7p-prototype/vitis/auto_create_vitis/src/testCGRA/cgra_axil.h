// This file is auto-generated from axlite_spec.json

#ifndef CGRA_LITE_ADDR
#define CGRA_LITE_ADDR 0x90040000
#endif
#ifndef CGRA_TILE_NUM
#define CGRA_TILE_NUM 6
#endif

#include "xil_io.h"

void cgra_config (int64_t cfg_base_addr, int64_t cfg_num, int64_t cfg_tile){
	int32_t tmp;
	tmp = (int32_t)(cfg_base_addr>>(0*32));
	Xil_Out32((CGRA_LITE_ADDR+0x0),tmp);
	tmp = (int32_t)(cfg_num>>(0*32));
	Xil_Out32((CGRA_LITE_ADDR+0x4),tmp);
	tmp = (int32_t)(cfg_tile>>(0*32));
	Xil_Out32((CGRA_LITE_ADDR+0x8),tmp);
	Xil_Out32((CGRA_LITE_ADDR+0xC),0x01);
}

void cgra_exe (int64_t exe_iob_ens, int64_t exe_tile_ens){
	int32_t tmp;
	tmp = (int32_t)(exe_iob_ens>>(0*32));
	Xil_Out32((CGRA_LITE_ADDR+0x10),tmp);
	tmp = (int32_t)(exe_tile_ens>>(0*32));
	Xil_Out32((CGRA_LITE_ADDR+0x14),tmp);
	Xil_Out32((CGRA_LITE_ADDR+0x18),0x01);
}

int32_t is_tile_done(int32_t tiles){
	int32_t done=Xil_In32((CGRA_LITE_ADDR+0x1C));
	return (done & tiles) == tiles;
}

void wait_tile_done(int32_t tiles) {
	while(1){
		if(is_tile_done(tiles)) break;
	}
}

int32_t is_cgra_all_done (){
	int32_t done=Xil_In32((CGRA_LITE_ADDR+0x1C));
	int32_t tile_mask = (1 << CGRA_TILE_NUM) - 1;
	return (done & tile_mask) == tile_mask;
}

void wait_cgra_all_finish() {
	while(1){
		if(is_cgra_all_done()) break;
	}
}

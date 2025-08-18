	.file	"cgra_gemm.c"
	.option nopic
	.attribute arch, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC3:
	.string	"out cgra_excute!\n"
	.text
	.align	1
	.globl	cgra_execute
	.type	cgra_execute, @function
cgra_execute:
	addi	sp,sp,-144
	mv	a3,a2
	sd	ra,136(sp)
	mv	a6,a1
	lla	a5,.LANCHOR0
	addi	a4,sp,8
	lla	a2,.LANCHOR0+120
.L2:
	ld	a7,0(a5)
	ld	a1,8(a5)
	ld	t1,16(a5)
	sd	a7,0(a4)
	ld	a7,24(a5)
	sd	a1,8(a4)
	ld	a1,32(a5)
	sd	t1,16(a4)
	sd	a7,24(a4)
	sd	a1,32(a4)
	addi	a5,a5,40
	addi	a4,a4,40
	bne	a5,a2,.L2
	addi	a1,sp,8
	ld	a2,.LC1
 #APP
# 26 "/home/tianyi/chipyard/generators/fdra/software/tests/include/ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 1) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	ld	a2,.LC2
	mv	a1,a0
 #APP
# 34 "/home/tianyi/chipyard/generators/fdra/software/tests/include/ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 1) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	li	a2,1073741824
	addi	a2,a2,5
	mv	a1,a6
	slli	a2,a2,14
 #APP
# 34 "/home/tianyi/chipyard/generators/fdra/software/tests/include/ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 1) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	li	a2,5
	li	a1,0
	slli	a2,a2,34
 #APP
# 50 "/home/tianyi/chipyard/generators/fdra/software/tests/include/ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 3) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	li	a1,4096
	addi	a1,a1,-512
	li	a2,0
 #APP
# 58 "/home/tianyi/chipyard/generators/fdra/software/tests/include/ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 4) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	li	a5,268435456
	addi	a2,a5,1
	mv	a1,a3
	slli	a2,a2,16
 #APP
# 42 "/home/tianyi/chipyard/generators/fdra/software/tests/include/ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 2) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	lla	a0,.LC3
	call	printf
	ld	ra,136(sp)
	addi	sp,sp,144
	jr	ra
	.size	cgra_execute, .-cgra_execute
	.section	.srodata.cst8,"aM",@progbits,8
	.align	3
.LC1:
	.dword	36029312415170560
	.align	3
.LC2:
	.dword	4521191813488640
	.section	.rodata
	.align	3
	.set	.LANCHOR0,. + 0
.LC0:
	.half	4109
	.half	0
	.half	229
	.half	0
	.half	16385
	.half	230
	.half	128
	.half	1280
	.half	231
	.half	0
	.half	512
	.half	264
	.half	1
	.half	0
	.half	268
	.half	-28669
	.half	0
	.half	301
	.half	8192
	.half	0
	.half	336
	.half	4
	.half	0
	.half	340
	.half	0
	.half	-32768
	.half	368
	.half	64
	.half	-32512
	.half	369
	.half	0
	.half	-29438
	.half	370
	.half	128
	.half	0
	.half	371
	.half	4096
	.half	-32764
	.half	372
	.half	2112
	.half	-32505
	.half	373
	.half	3584
	.half	258
	.half	374
	.half	0
	.half	0
	.half	375
	.half	10240
	.half	-32768
	.half	376
	.half	-1984
	.half	-32505
	.half	377
	.half	0
	.half	258
	.half	378
	.half	0
	.half	0
	.half	379
	.ident	"GCC: (g2ee5e430018) 12.2.0"

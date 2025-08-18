	.file	"cgra_execute.c"
	.option nopic
	.attribute arch, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	cgra_execute
	.type	cgra_execute, @function
cgra_execute:
	addi	sp,sp,-656
	mv	a5,a1
	lla	a4,.LANCHOR0
	addi	a3,sp,8
	lla	a2,.LANCHOR0+640
.L2:
	ld	a1,0(a4)
	ld	a7,8(a4)
	ld	a6,16(a4)
	sd	a1,0(a3)
	ld	a1,24(a4)
	sd	a7,8(a3)
	sd	a6,16(a3)
	sd	a1,24(a3)
	addi	a4,a4,32
	addi	a3,a3,32
	bne	a4,a2,.L2
	ld	a4,0(a4)
	addi	a1,sp,8
	ld	a2,.LC1
	sd	a4,0(a3)
 #APP
# 26 "/home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/./ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 1) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	ld	a2,.LC2
	ld	a1,0(a0)
 #APP
# 34 "/home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/./ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 1) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	ld	a2,.LC3
	ld	a1,8(a0)
 #APP
# 34 "/home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/./ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 1) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	ld	a2,.LC4
	ld	a1,16(a0)
 #APP
# 34 "/home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/./ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 1) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	ld	a2,.LC5
	ld	a1,24(a0)
 #APP
# 34 "/home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/./ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 1) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	ld	a2,.LC6
	ld	a1,32(a0)
 #APP
# 34 "/home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/./ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 1) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	ld	a2,.LC7
	ld	a1,40(a0)
 #APP
# 34 "/home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/./ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 1) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	ld	a2,.LC8
	ld	a1,48(a0)
 #APP
# 34 "/home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/./ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 1) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	ld	a2,.LC9
	ld	a1,56(a0)
 #APP
# 34 "/home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/./ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 1) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	li	a2,20971520
	addi	a2,a2,27
	li	a1,0
	slli	a2,a2,34
 #APP
# 50 "/home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/./ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 3) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	li	a1,65536
	li	a2,37
	addi	a1,a1,-1
	slli	a2,a2,56
 #APP
# 58 "/home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/./ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 4) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	ld	a2,.LC10
	ld	a1,0(a5)
 #APP
# 42 "/home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/./ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 2) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	ld	a2,.LC11
	ld	a1,8(a5)
 #APP
# 42 "/home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/./ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 2) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	ld	a2,.LC12
	ld	a1,16(a5)
 #APP
# 42 "/home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/./ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 2) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	ld	a2,.LC13
	ld	a1,24(a5)
 #APP
# 42 "/home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/./ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 2) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	ld	a2,.LC14
	ld	a1,32(a5)
 #APP
# 42 "/home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/./ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 2) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	li	a2,83890176
	ld	a1,40(a5)
	slli	a2,a2,32
 #APP
# 42 "/home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/./ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 2) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	ld	a2,.LC15
	ld	a1,48(a5)
 #APP
# 42 "/home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/./ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 2) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	ld	a2,.LC16
	ld	a1,56(a5)
 #APP
# 42 "/home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/./ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 2) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	addi	sp,sp,656
	jr	ra
	.size	cgra_execute, .-cgra_execute
	.section	.srodata.cst8,"aM",@progbits,8
	.align	3
.LC1:
	.dword	5008005568774930432
	.align	3
.LC2:
	.dword	360305562375692288
	.align	3
.LC3:
	.dword	360305562375790592
	.align	3
.LC4:
	.dword	360305562375700480
	.align	3
.LC5:
	.dword	360305562375806976
	.align	3
.LC6:
	.dword	360305562375786496
	.align	3
.LC7:
	.dword	360305562375757824
	.align	3
.LC8:
	.dword	360305562375798784
	.align	3
.LC9:
	.dword	360305562375770112
	.align	3
.LC10:
	.dword	360305562375749632
	.align	3
.LC11:
	.dword	360305562375716864
	.align	3
.LC12:
	.dword	360305562375774208
	.align	3
.LC13:
	.dword	360305562375725056
	.align	3
.LC14:
	.dword	360305562375733248
	.align	3
.LC15:
	.dword	360305562375741440
	.align	3
.LC16:
	.dword	360305562375708672
	.section	.rodata
	.align	3
	.set	.LANCHOR0,. + 0
.LC0:
	.half	8192
	.half	0
	.half	4
	.half	16
	.half	0
	.half	5
	.half	0
	.half	-29440
	.half	6
	.half	128
	.half	0
	.half	7
	.half	14336
	.half	0
	.half	8
	.half	16
	.half	0
	.half	9
	.half	0
	.half	-29440
	.half	10
	.half	128
	.half	0
	.half	11
	.half	12288
	.half	0
	.half	12
	.half	16
	.half	0
	.half	13
	.half	0
	.half	256
	.half	14
	.half	0
	.half	0
	.half	15
	.half	10240
	.half	0
	.half	16
	.half	16
	.half	0
	.half	17
	.half	0
	.half	256
	.half	18
	.half	0
	.half	0
	.half	19
	.half	10240
	.half	0
	.half	20
	.half	16
	.half	0
	.half	21
	.half	0
	.half	-29440
	.half	22
	.half	128
	.half	0
	.half	23
	.half	8192
	.half	0
	.half	24
	.half	16
	.half	0
	.half	25
	.half	0
	.half	-28928
	.half	26
	.half	128
	.half	0
	.half	27
	.half	12288
	.half	0
	.half	28
	.half	16
	.half	0
	.half	29
	.half	0
	.half	-28928
	.half	30
	.half	0
	.half	0
	.half	31
	.half	14336
	.half	0
	.half	32
	.half	16
	.half	0
	.half	33
	.half	0
	.half	-29440
	.half	34
	.half	0
	.half	0
	.half	35
	.half	3
	.half	0
	.half	44
	.half	5121
	.half	0
	.half	48
	.half	1024
	.half	0
	.half	52
	.half	0
	.half	12
	.half	60
	.half	35
	.half	0
	.half	64
	.half	48
	.half	0
	.half	68
	.half	-30702
	.half	0
	.half	81
	.half	10242
	.half	0
	.half	85
	.half	9217
	.half	0
	.half	89
	.half	-29694
	.half	0
	.half	97
	.half	0
	.half	0
	.half	116
	.half	12
	.half	0
	.half	120
	.half	0
	.half	0
	.half	128
	.half	32
	.half	160
	.half	132
	.half	2056
	.half	256
	.half	136
	.half	0
	.half	20
	.half	140
	.half	20609
	.half	0
	.half	153
	.half	12305
	.half	0
	.half	173
	.half	0
	.half	0
	.half	192
	.half	0
	.half	0
	.half	204
	.half	0
	.half	0
	.half	208
	.half	3
	.half	32
	.half	212
	.half	-29678
	.half	0
	.half	229
	.half	28673
	.half	0
	.half	241
	.half	-29694
	.half	0
	.half	245
	.half	28720
	.half	0
	.half	264
	.half	12
	.half	3
	.half	268
	.half	-16384
	.half	3
	.half	272
	.half	64
	.half	65
	.half	276
	.half	32
	.half	0
	.half	280
	.half	4
	.half	0
	.half	284
	.half	18562
	.half	0
	.half	297
	.half	-29695
	.half	0
	.half	301
	.half	19457
	.half	0
	.half	305
	.half	-28670
	.half	0
	.half	309
	.half	-29695
	.half	0
	.half	313
	.half	-29694
	.half	0
	.half	317
	.half	28673
	.half	0
	.half	321
	.half	0
	.half	0
	.half	332
	.half	16
	.half	4
	.half	336
	.half	0
	.half	0
	.half	340
	.half	22
	.half	0
	.half	348
	.half	16
	.half	17
	.half	352
	.half	128
	.half	0
	.half	356
	.half	14336
	.half	0
	.half	364
	.half	16
	.half	0
	.half	365
	.half	0
	.half	-29440
	.half	366
	.half	128
	.half	0
	.half	367
	.half	13312
	.half	0
	.half	368
	.half	16
	.half	0
	.half	369
	.half	0
	.half	256
	.half	370
	.half	0
	.half	0
	.half	371
	.half	8192
	.half	0
	.half	372
	.half	16
	.half	0
	.half	373
	.half	0
	.half	-29952
	.half	374
	.half	128
	.half	0
	.half	375
	.half	10240
	.half	0
	.half	376
	.half	16
	.half	0
	.half	377
	.half	0
	.half	256
	.half	378
	.half	0
	.half	0
	.half	379
	.half	12288
	.half	0
	.half	380
	.half	16
	.half	0
	.half	381
	.half	0
	.half	256
	.half	382
	.half	0
	.half	0
	.half	383
	.half	10240
	.half	0
	.half	384
	.half	16
	.half	0
	.half	385
	.half	0
	.half	256
	.half	386
	.half	0
	.half	0
	.half	387
	.half	9216
	.half	0
	.half	388
	.half	16
	.half	0
	.half	389
	.half	0
	.half	256
	.half	390
	.half	0
	.half	0
	.half	391
	.half	14336
	.half	0
	.half	392
	.half	16
	.half	0
	.half	393
	.half	0
	.half	256
	.half	394
	.half	0
	.half	0
	.half	395
	.ident	"GCC: (g2ee5e430018) 12.2.0"

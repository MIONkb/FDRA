	.file	"fft.c"
	.option nopic
	.attribute arch, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	cgra_execute
	.type	cgra_execute, @function
cgra_execute:
	addi	sp,sp,-624
	mv	a5,a1
	lla	a4,.LANCHOR0
	mv	a3,sp
	lla	a2,.LANCHOR0+624
.L2:
	ld	a7,0(a4)
	ld	a6,8(a4)
	ld	a1,16(a4)
	sd	a7,0(a3)
	ld	a7,24(a4)
	sd	a6,8(a3)
	ld	a6,32(a4)
	sd	a1,16(a3)
	ld	a1,40(a4)
	sd	a7,24(a3)
	sd	a6,32(a3)
	sd	a1,40(a3)
	addi	a4,a4,48
	addi	a3,a3,48
	bne	a4,a2,.L2
	mv	a1,sp
	ld	a2,.LC3
 #APP
# 26 "/home/tianyi/chipyard/generators/fdra/software/tests/include/ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 1) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	li	a4,536870912
	addi	a2,a4,1
	ld	a1,0(a0)
	slli	a2,a2,15
 #APP
# 34 "/home/tianyi/chipyard/generators/fdra/software/tests/include/ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 1) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	li	a2,1
	ld	a1,8(a0)
	slli	a2,a2,44
 #APP
# 34 "/home/tianyi/chipyard/generators/fdra/software/tests/include/ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 1) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	ld	a2,.LC4
	ld	a1,16(a0)
 #APP
# 34 "/home/tianyi/chipyard/generators/fdra/software/tests/include/ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 1) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	ld	a2,.LC5
	ld	a1,24(a0)
 #APP
# 34 "/home/tianyi/chipyard/generators/fdra/software/tests/include/ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 1) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	li	a2,268435456
	addi	a2,a2,1
	ld	a1,32(a0)
	slli	a2,a2,16
 #APP
# 34 "/home/tianyi/chipyard/generators/fdra/software/tests/include/ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 1) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	addi	a2,a4,3
	ld	a1,40(a0)
	slli	a2,a2,15
 #APP
# 34 "/home/tianyi/chipyard/generators/fdra/software/tests/include/ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 1) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	ld	a2,.LC6
	ld	a1,48(a0)
 #APP
# 34 "/home/tianyi/chipyard/generators/fdra/software/tests/include/ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 1) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	ld	a2,.LC7
	ld	a1,56(a0)
 #APP
# 34 "/home/tianyi/chipyard/generators/fdra/software/tests/include/ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 1) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	li	a2,13
	li	a1,0
	slli	a2,a2,35
 #APP
# 50 "/home/tianyi/chipyard/generators/fdra/software/tests/include/ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 3) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	li	a1,65536
	addi	a1,a1,-1
	li	a2,0
 #APP
# 58 "/home/tianyi/chipyard/generators/fdra/software/tests/include/ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 4) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	li	a4,1073741824
	addi	a2,a4,5
	ld	a1,0(a5)
	slli	a2,a2,14
 #APP
# 42 "/home/tianyi/chipyard/generators/fdra/software/tests/include/ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 2) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	addi	a2,a4,1
	ld	a1,8(a5)
	slli	a2,a2,14
 #APP
# 42 "/home/tianyi/chipyard/generators/fdra/software/tests/include/ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 2) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	addi	a2,a4,7
	ld	a1,16(a5)
	slli	a2,a2,14
 #APP
# 42 "/home/tianyi/chipyard/generators/fdra/software/tests/include/ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 2) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	addi	a2,a4,3
	ld	a1,24(a5)
	slli	a2,a2,14
 #APP
# 42 "/home/tianyi/chipyard/generators/fdra/software/tests/include/ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 2) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	ld	a2,.LC8
	ld	a1,32(a5)
 #APP
# 42 "/home/tianyi/chipyard/generators/fdra/software/tests/include/ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 2) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	ld	a2,.LC9
	ld	a1,40(a5)
 #APP
# 42 "/home/tianyi/chipyard/generators/fdra/software/tests/include/ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 2) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	ld	a2,.LC10
	ld	a1,48(a5)
 #APP
# 42 "/home/tianyi/chipyard/generators/fdra/software/tests/include/ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 2) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	ld	a2,.LC11
	ld	a1,56(a5)
 #APP
# 42 "/home/tianyi/chipyard/generators/fdra/software/tests/include/ISA.h" 1
	.word 0b0001011 | (0 << (7)) | (1 << (7+5)) | (1 << (7+5+1)) | (0 << (7+5+2)) | (11 << (7+5+3)) | (12 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 2) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	addi	sp,sp,624
	jr	ra
	.size	cgra_execute, .-cgra_execute
	.align	1
	.globl	fft4
	.type	fft4, @function
fft4:
	addi	sp,sp,-96
	sd	s0,88(sp)
	sd	s1,80(sp)
	sd	s2,72(sp)
	sd	s3,64(sp)
	sd	s4,56(sp)
	sd	s5,48(sp)
	sd	s6,40(sp)
	sd	s11,0(sp)
	sd	s7,32(sp)
	sd	s8,24(sp)
	sd	s9,16(sp)
	sd	s10,8(sp)
	lla	a6,XR0
	lla	s6,XI0
	lla	s5,XR1
	lla	s4,XI1
	lla	s3,XR2
	lla	s2,XI2
	lla	s1,XR3
	lla	s0,XI3
	lla	t2,ZR0
	lla	t0,ZI0
	lla	t6,ZR1
	lla	t5,ZI1
	lla	t4,ZR2
	lla	t3,ZI2
	lla	t1,ZR3
	lla	a7,ZI3
	lla	s11,XR0+4096
.L7:
	lw	s9,0(s5)
	lw	s8,0(s3)
	lw	s7,0(s2)
	lw	s10,0(s0)
	lw	a4,0(a6)
	lw	a5,0(s6)
	lw	a2,0(s4)
	lw	a3,0(s1)
	addw	a0,a4,s8
	addw	a1,a5,s7
	subw	a4,a4,s8
	subw	a5,a5,s7
	addw	s8,s9,a3
	addw	s7,a2,s10
	subw	a3,a3,s9
	subw	a2,a2,s10
	addw	s9,a1,s7
	addw	s10,a0,s8
	subw	a1,a1,s7
	subw	a0,a0,s8
	addw	s7,a3,a5
	addw	s8,a4,a2
	subw	a5,a5,a3
	subw	a4,a4,a2
	sw	s10,0(t2)
	sw	s9,0(t0)
	sw	a0,0(t6)
	sw	a1,0(t5)
	sw	s8,0(t4)
	sw	s7,0(t3)
	sw	a4,0(t1)
	sw	a5,0(a7)
	addi	a6,a6,4
	addi	s6,s6,4
	addi	s5,s5,4
	addi	s4,s4,4
	addi	s3,s3,4
	addi	s2,s2,4
	addi	s1,s1,4
	addi	s0,s0,4
	addi	t2,t2,4
	addi	t0,t0,4
	addi	t6,t6,4
	addi	t5,t5,4
	addi	t4,t4,4
	addi	t3,t3,4
	addi	t1,t1,4
	addi	a7,a7,4
	bne	a6,s11,.L7
	ld	s0,88(sp)
	ld	s1,80(sp)
	ld	s2,72(sp)
	ld	s3,64(sp)
	ld	s4,56(sp)
	ld	s5,48(sp)
	ld	s6,40(sp)
	ld	s7,32(sp)
	ld	s8,24(sp)
	ld	s9,16(sp)
	ld	s10,8(sp)
	ld	s11,0(sp)
	addi	sp,sp,96
	jr	ra
	.size	fft4, .-fft4
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC12:
	.string	"IT is stupid!\n"
	.align	3
.LC13:
	.string	"Initialization finished!\n"
	.align	3
.LC14:
	.string	"It takes %d cycles for CPU to finish the task.\n"
	.align	3
.LC17:
	.string	"It takes %d cycles for CGRA to finish the task(%d).\n"
	.align	3
.LC18:
	.string	"There is an error in location (%d)[%d, %d]\n"
	.align	3
.LC19:
	.string	"Done!\n"
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-256
	lla	a0,.LC12
	sd	s1,232(sp)
	sd	ra,248(sp)
	sd	s0,240(sp)
	sd	s2,224(sp)
	sd	s3,216(sp)
	sd	s4,208(sp)
	sd	s5,200(sp)
	sd	s6,192(sp)
	sd	s7,184(sp)
	sd	s8,176(sp)
	sd	s9,168(sp)
	sd	s10,160(sp)
	sd	s11,152(sp)
	call	printf
	lla	t3,XR0
	lla	t1,XR1
	lla	a7,XR2
	lla	a6,XR3
	lla	a0,XI0
	lla	a1,XI1
	lla	a2,XI2
	lla	a3,XI3
	li	a4,0
	li	s1,1024
.L11:
	addiw	t4,a4,1
	addiw	s0,a4,2
	addiw	t2,a4,3
	addiw	t0,a4,4
	addiw	t6,a4,5
	addiw	t5,a4,6
	addiw	a5,a4,7
	sw	a4,0(t3)
	sw	t4,0(t1)
	sw	s0,0(a7)
	sw	t2,0(a6)
	sw	t0,0(a0)
	sw	t6,0(a1)
	sw	t5,0(a2)
	sw	a5,0(a3)
	sext.w	a4,t4
	addi	t3,t3,4
	addi	t1,t1,4
	addi	a7,a7,4
	addi	a6,a6,4
	addi	a0,a0,4
	addi	a1,a1,4
	addi	a2,a2,4
	addi	a3,a3,4
	bne	a4,s1,.L11
	lla	a0,.LC13
	call	printf
 #APP
# 281 "/home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/fft.c" 1
	csrr s0, cycle
# 0 "" 2
 #NO_APP
	call	fft4
 #APP
# 284 "/home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/fft.c" 1
	csrr a1, cycle
# 0 "" 2
 #NO_APP
	lla	a0,.LC14
	sub	a1,a1,s0
	call	printf
	lla	a5,.LANCHOR0
	ld	s0,624(a5)
	ld	t2,632(a5)
	ld	t0,640(a5)
	ld	t6,648(a5)
	ld	t5,656(a5)
	ld	t4,664(a5)
	ld	t3,672(a5)
	ld	t1,680(a5)
	ld	a7,688(a5)
	ld	a6,696(a5)
	ld	a0,704(a5)
	ld	a1,712(a5)
	ld	a2,720(a5)
	ld	a3,728(a5)
	ld	a4,736(a5)
	ld	a5,744(a5)
	sd	s0,16(sp)
	sd	t2,24(sp)
	sd	t0,32(sp)
	sd	t6,40(sp)
	sd	t5,48(sp)
	sd	t4,56(sp)
	sd	t3,64(sp)
	sd	t1,72(sp)
	sd	a7,80(sp)
	sd	a6,88(sp)
	sd	a0,96(sp)
	sd	a1,104(sp)
	sd	a2,112(sp)
	sd	a3,120(sp)
	sd	a4,128(sp)
	sd	a5,136(sp)
 #APP
# 289 "/home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/fft.c" 1
	csrr s0, cycle
# 0 "" 2
 #NO_APP
	addi	a1,sp,80
	addi	a0,sp,16
	call	cgra_execute
 #APP
# 82 "/home/tianyi/chipyard/generators/fdra/software/tests/include/ISA.h" 1
	.word 0b0001011 | (10 << (7)) | (0 << (7+5)) | (0 << (7+5+1)) | (1 << (7+5+2)) | (0 << (7+5+3)) | (0 << (7+5+3+5)) | ((((~(~0 << 7) << 0) & 0) >> 0) << (7+5+3+5+5))
	
# 0 "" 2
 #NO_APP
	addi	a5,a0,-1
	seqz	a5,a5
	sw	a5,12(sp)
 #APP
# 292 "/home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/fft.c" 1
	csrr a1, cycle
# 0 "" 2
 #NO_APP
	lw	a2,12(sp)
	sub	a1,a1,s0
	lla	a0,.LC17
	call	printf
	lla	s3,ZR0
	lla	s2,YR0
	lla	s6,ZI3
	lla	s9,YI3
	lla	s8,ZR3
	lla	s11,YR3
	lla	s10,ZI2
	li	s0,0
	li	s1,0
	lla	s5,ZI0
	lla	s4,YI0
	lla	s7,ZR1
	j	.L14
.L12:
	call	printf
.L13:
	li	a3,1024
	addi	s3,s3,4
	addi	s2,s2,4
	addi	s6,s6,4
	addi	s9,s9,4
	addi	s8,s8,4
	addi	s11,s11,4
	addi	s10,s10,4
	addi	s0,s0,4
	beq	s1,a3,.L18
.L14:
	lw	a2,0(s3)
	lw	a3,0(s2)
	mv	a1,s1
	add	t4,s0,s5
	add	t3,s0,s4
	addiw	s1,s1,1
	lla	a0,.LC18
	bne	a2,a3,.L12
	lw	t4,0(t4)
	lw	t3,0(t3)
	bne	t4,t3,.L12
	lla	a5,YR1
	add	t4,s0,s7
	add	t3,s0,a5
	lw	t4,0(t4)
	lw	t3,0(t3)
	bne	t4,t3,.L12
	lla	a5,ZI1
	add	t4,s0,a5
	lla	a5,YI1
	add	t3,s0,a5
	lw	t4,0(t4)
	lw	t3,0(t3)
	bne	t4,t3,.L12
	lla	a5,ZR2
	add	t4,s0,a5
	lla	a5,YR2
	add	t3,s0,a5
	lw	t4,0(t4)
	lw	t3,0(t3)
	bne	t4,t3,.L12
	lla	t3,YI2
	add	t3,s0,t3
	lw	t4,0(s10)
	lw	t3,0(t3)
	bne	t4,t3,.L12
	lw	t4,0(s8)
	lw	t3,0(s11)
	bne	t4,t3,.L12
	lw	t4,0(s6)
	lw	t3,0(s9)
	bne	t4,t3,.L12
	j	.L13
.L18:
	lla	a0,.LC19
	call	printf
	ld	ra,248(sp)
	ld	s0,240(sp)
	ld	s1,232(sp)
	ld	s2,224(sp)
	ld	s3,216(sp)
	ld	s4,208(sp)
	ld	s5,200(sp)
	ld	s6,192(sp)
	ld	s7,184(sp)
	ld	s8,176(sp)
	ld	s9,168(sp)
	ld	s10,160(sp)
	ld	s11,152(sp)
	li	a0,0
	addi	sp,sp,256
	jr	ra
	.size	main, .-main
	.globl	ZI3
	.globl	ZI2
	.globl	ZI1
	.globl	ZI0
	.globl	ZR3
	.globl	ZR2
	.globl	ZR1
	.globl	ZR0
	.globl	YI3
	.globl	YI2
	.globl	YI1
	.globl	YI0
	.globl	YR3
	.globl	YR2
	.globl	YR1
	.globl	YR0
	.globl	XI3
	.globl	XI2
	.globl	XI1
	.globl	XI0
	.globl	XR3
	.globl	XR2
	.globl	XR1
	.globl	XR0
	.section	.srodata.cst8,"aM",@progbits,8
	.align	3
.LC3:
	.dword	36031477078687744
	.align	3
.LC4:
	.dword	17592186085376
	.align	3
.LC5:
	.dword	17592186052608
	.align	3
.LC6:
	.dword	17592186118144
	.align	3
.LC7:
	.dword	17592186150912
	.align	3
.LC8:
	.dword	17592186134528
	.align	3
.LC9:
	.dword	17592186101760
	.align	3
.LC10:
	.dword	17592186068992
	.align	3
.LC11:
	.dword	17592186167296
	.section	.rodata
	.align	3
	.set	.LANCHOR0,. + 0
.LC0:
	.half	14336
	.half	0
	.half	4
	.half	16
	.half	0
	.half	5
	.half	0
	.half	-29440
	.half	6
	.half	0
	.half	0
	.half	7
	.half	10240
	.half	0
	.half	8
	.half	16
	.half	0
	.half	9
	.half	0
	.half	256
	.half	10
	.half	0
	.half	0
	.half	11
	.half	8192
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
	.half	12288
	.half	0
	.half	16
	.half	16
	.half	0
	.half	17
	.half	0
	.half	-29440
	.half	18
	.half	128
	.half	0
	.half	19
	.half	12288
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
	.half	10240
	.half	0
	.half	24
	.half	16
	.half	0
	.half	25
	.half	0
	.half	256
	.half	26
	.half	0
	.half	0
	.half	27
	.half	8192
	.half	0
	.half	28
	.half	16
	.half	0
	.half	29
	.half	0
	.half	256
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
	.half	1024
	.half	0
	.half	44
	.half	1024
	.half	0
	.half	48
	.half	0
	.half	4
	.half	52
	.half	512
	.half	8
	.half	56
	.half	-30720
	.half	0
	.half	60
	.half	5120
	.half	1
	.half	64
	.half	2096
	.half	0
	.half	68
	.half	10242
	.half	0
	.half	81
	.half	9217
	.half	0
	.half	85
	.half	17537
	.half	0
	.half	93
	.half	10258
	.half	0
	.half	97
	.half	9217
	.half	0
	.half	101
	.half	9218
	.half	0
	.half	105
	.half	0
	.half	0
	.half	112
	.half	0
	.half	512
	.half	116
	.half	1024
	.half	512
	.half	140
	.half	20482
	.half	0
	.half	149
	.half	11393
	.half	0
	.half	177
	.half	771
	.half	0
	.half	188
	.half	816
	.half	0
	.half	212
	.half	-31743
	.half	0
	.half	225
	.half	25618
	.half	0
	.half	249
	.half	0
	.half	64
	.half	260
	.half	4
	.half	128
	.half	264
	.half	2048
	.half	128
	.half	268
	.half	12800
	.half	0
	.half	272
	.half	16384
	.half	1
	.half	276
	.half	64
	.half	520
	.half	284
	.half	-28671
	.half	0
	.half	293
	.half	-29694
	.half	0
	.half	297
	.half	10257
	.half	0
	.half	305
	.half	17538
	.half	0
	.half	309
	.half	-29695
	.half	0
	.half	313
	.half	-29566
	.half	0
	.half	317
	.half	20
	.half	0
	.half	332
	.half	772
	.half	0
	.half	336
	.half	256
	.half	0
	.half	340
	.half	16
	.half	16
	.half	348
	.half	32
	.half	0
	.half	352
	.half	772
	.half	0
	.half	356
	.half	8192
	.half	0
	.half	364
	.half	16
	.half	0
	.half	365
	.half	0
	.half	256
	.half	366
	.half	0
	.half	0
	.half	367
	.half	10240
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
	.half	14336
	.half	0
	.half	372
	.half	16
	.half	0
	.half	373
	.half	0
	.half	-29440
	.half	374
	.half	0
	.half	0
	.half	375
	.half	12288
	.half	0
	.half	376
	.half	16
	.half	0
	.half	377
	.half	0
	.half	-29440
	.half	378
	.half	0
	.half	0
	.half	379
	.half	10240
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
	.half	12288
	.half	0
	.half	384
	.half	16
	.half	0
	.half	385
	.half	0
	.half	-29440
	.half	386
	.half	0
	.half	0
	.half	387
	.half	8192
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
	.half	-29440
	.half	394
	.half	0
	.half	0
	.half	395
.LC15:
	.dword	XI0
	.dword	XI1
	.dword	XI2
	.dword	XI3
	.dword	XR0
	.dword	XR1
	.dword	XR2
	.dword	XR3
.LC16:
	.dword	YR0
	.dword	YI0
	.dword	YR1
	.dword	YI1
	.dword	YR2
	.dword	YI2
	.dword	YR3
	.dword	YI3
	.bss
	.align	3
	.type	ZI3, @object
	.size	ZI3, 4096
ZI3:
	.zero	4096
	.type	ZI2, @object
	.size	ZI2, 4096
ZI2:
	.zero	4096
	.type	ZI1, @object
	.size	ZI1, 4096
ZI1:
	.zero	4096
	.type	ZI0, @object
	.size	ZI0, 4096
ZI0:
	.zero	4096
	.type	ZR3, @object
	.size	ZR3, 4096
ZR3:
	.zero	4096
	.type	ZR2, @object
	.size	ZR2, 4096
ZR2:
	.zero	4096
	.type	ZR1, @object
	.size	ZR1, 4096
ZR1:
	.zero	4096
	.type	ZR0, @object
	.size	ZR0, 4096
ZR0:
	.zero	4096
	.type	YI3, @object
	.size	YI3, 4096
YI3:
	.zero	4096
	.type	YI2, @object
	.size	YI2, 4096
YI2:
	.zero	4096
	.type	YI1, @object
	.size	YI1, 4096
YI1:
	.zero	4096
	.type	YI0, @object
	.size	YI0, 4096
YI0:
	.zero	4096
	.type	YR3, @object
	.size	YR3, 4096
YR3:
	.zero	4096
	.type	YR2, @object
	.size	YR2, 4096
YR2:
	.zero	4096
	.type	YR1, @object
	.size	YR1, 4096
YR1:
	.zero	4096
	.type	YR0, @object
	.size	YR0, 4096
YR0:
	.zero	4096
	.type	XI3, @object
	.size	XI3, 4096
XI3:
	.zero	4096
	.type	XI2, @object
	.size	XI2, 4096
XI2:
	.zero	4096
	.type	XI1, @object
	.size	XI1, 4096
XI1:
	.zero	4096
	.type	XI0, @object
	.size	XI0, 4096
XI0:
	.zero	4096
	.type	XR3, @object
	.size	XR3, 4096
XR3:
	.zero	4096
	.type	XR2, @object
	.size	XR2, 4096
XR2:
	.zero	4096
	.type	XR1, @object
	.size	XR1, 4096
XR1:
	.zero	4096
	.type	XR0, @object
	.size	XR0, 4096
XR0:
	.zero	4096
	.ident	"GCC: (g2ee5e430018) 12.2.0"

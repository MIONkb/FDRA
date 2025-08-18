	.file	"simplecompute.c"
	.option nopic
	.attribute arch, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC2:
	.string	"IT is stupid!\n"
	.align	3
.LC3:
	.string	"Initialization finished!\n"
	.align	3
.LC6:
	.string	"It takes %d cycles for CGRA to finish the task(%d).\n"
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-160
	lla	a0,.LC2
	sd	s0,144(sp)
	sd	ra,152(sp)
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
	li	s0,1024
.L2:
	addiw	t4,a4,1
	addiw	ra,a4,2
	addiw	t2,a4,3
	addiw	t0,a4,4
	addiw	t6,a4,5
	addiw	t5,a4,6
	addiw	a5,a4,7
	sw	a4,0(t3)
	sw	t4,0(t1)
	sw	ra,0(a7)
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
	bne	a4,s0,.L2
	lla	a0,.LC3
	call	printf
	lla	a5,.LANCHOR0
	ld	ra,0(a5)
	ld	t2,8(a5)
	ld	t0,16(a5)
	ld	t6,24(a5)
	ld	t5,32(a5)
	ld	t4,40(a5)
	ld	t3,48(a5)
	ld	t1,56(a5)
	ld	a7,64(a5)
	ld	a6,72(a5)
	ld	a0,80(a5)
	ld	a1,88(a5)
	ld	a2,96(a5)
	ld	a3,104(a5)
	ld	a4,112(a5)
	ld	a5,120(a5)
	sd	ra,16(sp)
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
# 107 "/home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/simplecompute.c" 1
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
# 110 "/home/tianyi/chipyard/generators/fdra/software/tests/llvm-test/simplecompute.c" 1
	csrr a1, cycle
# 0 "" 2
 #NO_APP
	lw	a2,12(sp)
	sub	a1,a1,s0
	lla	a0,.LC6
	call	printf
	ld	ra,152(sp)
	ld	s0,144(sp)
	li	a0,0
	addi	sp,sp,160
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
	.section	.rodata
	.align	3
	.set	.LANCHOR0,. + 0
.LC4:
	.dword	XI0
	.dword	XI1
	.dword	XI2
	.dword	XI3
	.dword	XR0
	.dword	XR1
	.dword	XR2
	.dword	XR3
.LC5:
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

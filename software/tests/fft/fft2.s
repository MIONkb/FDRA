	.text
	.attribute	4, 16
	.attribute	5, "rv64i2p0_f2p0_d2p0_c2p0"
	.file	"fft2.c"
	.section	.sdata,"aw",@progbits
	.p2align	3                               # -- Begin function cgra_execute
.LCPI0_0:
	.quad	36031477078687744               # 0x80027000020000
	.text
	.globl	cgra_execute
	.p2align	1
	.type	cgra_execute,@function
cgra_execute:                           # @cgra_execute
# %bb.0:                                # %entry
	addi	sp, sp, -656
	sd	ra, 648(sp)                     # 8-byte Folded Spill
	sd	s0, 640(sp)                     # 8-byte Folded Spill
	sd	s1, 632(sp)                     # 8-byte Folded Spill
	mv	s0, a1
	mv	s1, a0
	lui	a0, %hi(.L__const.cgra_execute.cin)
	addi	a1, a0, %lo(.L__const.cgra_execute.cin)
	addi	a0, sp, 8
	li	a2, 624
	call	memcpy@plt
	lui	a0, %hi(.LCPI0_0)
	ld	a2, %lo(.LCPI0_0)(a0)
	addi	a1, sp, 8
	#APP
	.word	46510091

	#NO_APP
	ld	a1, 0(s1)
	lui	a3, 131072
	addiw	a0, a3, 1
	slli	a2, a0, 15
	#APP
	.word	46510091

	#NO_APP
	ld	a1, 8(s1)
	li	a0, 1
	slli	a2, a0, 44
	#APP
	.word	46510091

	#NO_APP
	ld	a1, 16(s1)
	slli	a0, a0, 31
	addi	a2, a0, 5
	slli	a2, a2, 13
	#APP
	.word	46510091

	#NO_APP
	ld	a1, 24(s1)
	addi	a2, a0, 1
	slli	a2, a2, 13
	#APP
	.word	46510091

	#NO_APP
	ld	a1, 32(s1)
	lui	a2, 65536
	addiw	a2, a2, 1
	slli	a2, a2, 16
	#APP
	.word	46510091

	#NO_APP
	ld	a1, 40(s1)
	addiw	a2, a3, 3
	slli	a2, a2, 15
	#APP
	.word	46510091

	#NO_APP
	ld	a1, 48(s1)
	addi	a2, a0, 9
	slli	a2, a2, 13
	#APP
	.word	46510091

	#NO_APP
	ld	a1, 56(s1)
	addi	a2, a0, 13
	slli	a2, a2, 13
	#APP
	.word	46510091

	#NO_APP
	li	a1, 13
	slli	a2, a1, 35
	li	a1, 0
	#APP
	.word	113618955

	#NO_APP
	lui	a1, 16
	addiw	a1, a1, -1
	li	a2, 0
	#APP
	.word	147173387

	#NO_APP
	ld	a1, 0(s0)
	lui	a3, 262144
	addiw	a2, a3, 5
	slli	a2, a2, 14
	#APP
	.word	80064523

	#NO_APP
	ld	a1, 8(s0)
	addiw	a2, a3, 1
	slli	a2, a2, 14
	#APP
	.word	80064523

	#NO_APP
	ld	a1, 16(s0)
	addiw	a2, a3, 7
	slli	a2, a2, 14
	#APP
	.word	80064523

	#NO_APP
	ld	a1, 24(s0)
	addiw	a2, a3, 3
	slli	a2, a2, 14
	#APP
	.word	80064523

	#NO_APP
	ld	a1, 32(s0)
	addi	a2, a0, 11
	slli	a2, a2, 13
	#APP
	.word	80064523

	#NO_APP
	ld	a1, 40(s0)
	addi	a2, a0, 7
	slli	a2, a2, 13
	#APP
	.word	80064523

	#NO_APP
	ld	a1, 48(s0)
	addi	a2, a0, 3
	slli	a2, a2, 13
	#APP
	.word	80064523

	#NO_APP
	ld	a1, 56(s0)
	addi	a0, a0, 15
	slli	a2, a0, 13
	#APP
	.word	80064523

	#NO_APP
	ld	ra, 648(sp)                     # 8-byte Folded Reload
	ld	s0, 640(sp)                     # 8-byte Folded Reload
	ld	s1, 632(sp)                     # 8-byte Folded Reload
	addi	sp, sp, 656
	ret
.Lfunc_end0:
	.size	cgra_execute, .Lfunc_end0-cgra_execute
                                        # -- End function
	.globl	fft4                            # -- Begin function fft4
	.p2align	1
	.type	fft4,@function
fft4:                                   # @fft4
# %bb.0:                                # %entry
	addi	sp, sp, -112
	sd	ra, 104(sp)                     # 8-byte Folded Spill
	sd	s0, 96(sp)                      # 8-byte Folded Spill
	sd	s1, 88(sp)                      # 8-byte Folded Spill
	sd	s2, 80(sp)                      # 8-byte Folded Spill
	sd	s3, 72(sp)                      # 8-byte Folded Spill
	sd	s4, 64(sp)                      # 8-byte Folded Spill
	sd	s5, 56(sp)                      # 8-byte Folded Spill
	sd	s6, 48(sp)                      # 8-byte Folded Spill
	sd	s7, 40(sp)                      # 8-byte Folded Spill
	sd	s8, 32(sp)                      # 8-byte Folded Spill
	sd	s9, 24(sp)                      # 8-byte Folded Spill
	sd	s10, 16(sp)                     # 8-byte Folded Spill
	sd	s11, 8(sp)                      # 8-byte Folded Spill
	li	a0, 0
	li	s9, 1024
	lui	a2, %hi(XR0)
	addi	a6, a2, %lo(XR0)
	lui	a2, %hi(XI0)
	addi	a7, a2, %lo(XI0)
	lui	a2, %hi(XR1)
	addi	t0, a2, %lo(XR1)
	lui	a2, %hi(XI1)
	addi	t1, a2, %lo(XI1)
	lui	a2, %hi(XR2)
	addi	t2, a2, %lo(XR2)
	lui	a2, %hi(XI2)
	addi	t3, a2, %lo(XI2)
	lui	a2, %hi(XR3)
	addi	t4, a2, %lo(XR3)
	lui	a2, %hi(XI3)
	addi	t5, a2, %lo(XI3)
	lui	a2, %hi(ZR0)
	addi	t6, a2, %lo(ZR0)
	lui	a2, %hi(ZI0)
	addi	s2, a2, %lo(ZI0)
	lui	a2, %hi(ZR1)
	addi	s3, a2, %lo(ZR1)
	lui	a2, %hi(ZI1)
	addi	s4, a2, %lo(ZI1)
	lui	a2, %hi(ZR2)
	addi	s5, a2, %lo(ZR2)
	lui	a3, %hi(ZI2)
	addi	s6, a3, %lo(ZI2)
	lui	a3, %hi(ZR3)
	addi	s7, a3, %lo(ZR3)
	lui	a3, %hi(ZI3)
	addi	s8, a3, %lo(ZI3)
.LBB1_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	add	a4, a6, a0
	lw	s11, 0(a4)
	add	a5, a7, a0
	lw	ra, 0(a5)
	add	a2, t0, a0
	lw	s10, 0(a2)
	add	s0, t1, a0
	lw	s0, 0(s0)
	add	s1, t2, a0
	lw	s1, 0(s1)
	add	a3, t3, a0
	lw	a3, 0(a3)
	add	a1, t4, a0
	lw	a1, 0(a1)
	add	a2, t5, a0
	lw	a2, 0(a2)
	addw	a4, s1, s11
	addw	a5, a3, ra
	subw	s1, s11, s1
	subw	s11, ra, a3
	addw	a3, a1, s10
	addw	ra, a2, s0
	subw	a1, a1, s10
	subw	a2, s0, a2
	addw	s0, a3, a4
	addw	s10, ra, a5
	subw	a3, a4, a3
	subw	a4, a5, ra
	addw	a5, a2, s1
	addw	ra, a1, s11
	subw	a2, s1, a2
	subw	a1, s11, a1
	add	s1, t6, a0
	sw	s0, 0(s1)
	add	s0, s2, a0
	sw	s10, 0(s0)
	add	s0, s3, a0
	sw	a3, 0(s0)
	add	a3, s4, a0
	sw	a4, 0(a3)
	add	a3, s5, a0
	sw	a5, 0(a3)
	add	a3, s6, a0
	sw	ra, 0(a3)
	add	a3, s7, a0
	sw	a2, 0(a3)
	add	a2, s8, a0
	sw	a1, 0(a2)
	addi	s9, s9, -1
	addi	a0, a0, 4
	bnez	s9, .LBB1_1
# %bb.2:                                # %for.end
	ld	ra, 104(sp)                     # 8-byte Folded Reload
	ld	s0, 96(sp)                      # 8-byte Folded Reload
	ld	s1, 88(sp)                      # 8-byte Folded Reload
	ld	s2, 80(sp)                      # 8-byte Folded Reload
	ld	s3, 72(sp)                      # 8-byte Folded Reload
	ld	s4, 64(sp)                      # 8-byte Folded Reload
	ld	s5, 56(sp)                      # 8-byte Folded Reload
	ld	s6, 48(sp)                      # 8-byte Folded Reload
	ld	s7, 40(sp)                      # 8-byte Folded Reload
	ld	s8, 32(sp)                      # 8-byte Folded Reload
	ld	s9, 24(sp)                      # 8-byte Folded Reload
	ld	s10, 16(sp)                     # 8-byte Folded Reload
	ld	s11, 8(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 112
	ret
.Lfunc_end1:
	.size	fft4, .Lfunc_end1-fft4
                                        # -- End function
	.section	.sdata,"aw",@progbits
	.p2align	3                               # -- Begin function main
.LCPI2_0:
	.quad	36031477078687744               # 0x80027000020000
	.text
	.globl	main
	.p2align	1
	.type	main,@function
main:                                   # @main
# %bb.0:                                # %entry
	addi	sp, sp, -800
	sd	ra, 792(sp)                     # 8-byte Folded Spill
	sd	s0, 784(sp)                     # 8-byte Folded Spill
	sd	s1, 776(sp)                     # 8-byte Folded Spill
	sd	s2, 768(sp)                     # 8-byte Folded Spill
	sd	s3, 760(sp)                     # 8-byte Folded Spill
	sd	s4, 752(sp)                     # 8-byte Folded Spill
	sd	s5, 744(sp)                     # 8-byte Folded Spill
	sd	s6, 736(sp)                     # 8-byte Folded Spill
	sd	s7, 728(sp)                     # 8-byte Folded Spill
	sd	s8, 720(sp)                     # 8-byte Folded Spill
	sd	s9, 712(sp)                     # 8-byte Folded Spill
	sd	s10, 704(sp)                    # 8-byte Folded Spill
	sd	s11, 696(sp)                    # 8-byte Folded Spill
	li	a0, 0
	lui	a1, %hi(XI3)
	addi	a7, a1, %lo(XI3)
	lui	a1, %hi(XI2)
	addi	t1, a1, %lo(XI2)
	lui	a2, %hi(XI1)
	addi	a2, a2, %lo(XI1)
	lui	a3, %hi(XI0)
	addi	a3, a3, %lo(XI0)
	lui	a4, %hi(XR3)
	addi	a4, a4, %lo(XR3)
	lui	a5, %hi(XR2)
	addi	a5, a5, %lo(XR2)
	lui	s1, %hi(XR1)
	addi	s1, s1, %lo(XR1)
	lui	s0, %hi(XR0)
	addi	s0, s0, %lo(XR0)
	li	a6, 1024
.LBB2_1:                                # %for.body.i
                                        # =>This Inner Loop Header: Depth=1
	sw	a0, 0(s0)
	addi	t0, a0, 1
	sw	t0, 0(s1)
	addiw	a1, a0, 2
	sw	a1, 0(a5)
	addiw	a1, a0, 3
	sw	a1, 0(a4)
	addiw	a1, a0, 4
	sw	a1, 0(a3)
	addiw	a1, a0, 5
	sw	a1, 0(a2)
	addiw	a1, a0, 6
	sw	a1, 0(t1)
	addiw	a0, a0, 7
	sw	a0, 0(a7)
	addi	a7, a7, 4
	addi	t1, t1, 4
	addi	a2, a2, 4
	addi	a3, a3, 4
	addi	a4, a4, 4
	addi	a5, a5, 4
	addi	s1, s1, 4
	addi	s0, s0, 4
	mv	a0, t0
	bne	t0, a6, .LBB2_1
# %bb.2:                                # %init_array.exit
	#APP
	rdcycle	a0
	#NO_APP
	call	fft4
	#APP
	rdcycle	a0
	#NO_APP
	#APP
	rdcycle	a0
	#NO_APP
	lui	a0, %hi(.L__const.cgra_execute.cin)
	addi	a1, a0, %lo(.L__const.cgra_execute.cin)
	addi	a0, sp, 72
	li	a2, 624
	call	memcpy@plt
	li	s0, 0
	li	s1, 0
	lui	a0, %hi(.LCPI2_0)
	ld	a2, %lo(.LCPI2_0)(a0)
	addi	a1, sp, 72
	#APP
	.word	46510091

	#NO_APP
	lui	a0, %hi(XI0)
	addi	a1, a0, %lo(XI0)
	lui	a0, 131072
	addiw	a2, a0, 1
	slli	a2, a2, 15
	#APP
	.word	46510091

	#NO_APP
	lui	a1, %hi(XI1)
	addi	a1, a1, %lo(XI1)
	li	a3, 1
	slli	a2, a3, 44
	#APP
	.word	46510091

	#NO_APP
	lui	a1, %hi(XI2)
	addi	a1, a1, %lo(XI2)
	slli	a3, a3, 31
	addi	a2, a3, 5
	slli	a2, a2, 13
	#APP
	.word	46510091

	#NO_APP
	lui	a1, %hi(XI3)
	addi	a1, a1, %lo(XI3)
	addi	a2, a3, 1
	slli	a2, a2, 13
	#APP
	.word	46510091

	#NO_APP
	lui	a1, %hi(XR0)
	addi	a1, a1, %lo(XR0)
	lui	a2, 65536
	addiw	a2, a2, 1
	slli	a2, a2, 16
	#APP
	.word	46510091

	#NO_APP
	lui	a1, %hi(XR1)
	addi	a1, a1, %lo(XR1)
	addiw	a0, a0, 3
	slli	a2, a0, 15
	#APP
	.word	46510091

	#NO_APP
	lui	a0, %hi(XR2)
	addi	a1, a0, %lo(XR2)
	addi	a0, a3, 9
	slli	a2, a0, 13
	#APP
	.word	46510091

	#NO_APP
	lui	a0, %hi(XR3)
	addi	a1, a0, %lo(XR3)
	addi	a0, a3, 13
	slli	a2, a0, 13
	#APP
	.word	46510091

	#NO_APP
	li	a0, 13
	slli	a2, a0, 35
	li	a1, 0
	#APP
	.word	113618955

	#NO_APP
	lui	a0, 16
	addiw	a1, a0, -1
	li	a2, 0
	#APP
	.word	147173387

	#NO_APP
	lui	a0, %hi(YR0)
	addi	s9, a0, %lo(YR0)
	lui	a0, 262144
	addiw	a1, a0, 5
	slli	a2, a1, 14
	mv	a1, s9
	#APP
	.word	80064523

	#NO_APP
	lui	a1, %hi(YI0)
	addi	s8, a1, %lo(YI0)
	addiw	a1, a0, 1
	slli	a2, a1, 14
	mv	a1, s8
	#APP
	.word	80064523

	#NO_APP
	lui	a1, %hi(YR1)
	addi	s2, a1, %lo(YR1)
	addiw	a1, a0, 7
	slli	a2, a1, 14
	mv	a1, s2
	#APP
	.word	80064523

	#NO_APP
	lui	a1, %hi(YI1)
	addi	s3, a1, %lo(YI1)
	addiw	a0, a0, 3
	slli	a2, a0, 14
	mv	a1, s3
	#APP
	.word	80064523

	#NO_APP
	lui	a0, %hi(YR2)
	addi	a1, a0, %lo(YR2)
	addi	a0, a3, 11
	slli	a2, a0, 13
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	#APP
	.word	80064523

	#NO_APP
	lui	a0, %hi(YI2)
	addi	a1, a0, %lo(YI2)
	addi	a0, a3, 7
	slli	a2, a0, 13
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	#APP
	.word	80064523

	#NO_APP
	lui	a0, %hi(YR3)
	addi	a1, a0, %lo(YR3)
	addi	a0, a3, 3
	slli	a2, a0, 13
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	#APP
	.word	80064523

	#NO_APP
	lui	a0, %hi(YI3)
	addi	a1, a0, %lo(YI3)
	addi	a0, a3, 15
	slli	a2, a0, 13
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	#APP
	.word	80064523

	#NO_APP
	#APP
	.word	17675

	#NO_APP
	addi	a0, a0, -1
	seqz	a0, a0
	sw	a0, 72(sp)
	#APP
	rdcycle	a0
	#NO_APP
	lui	a0, %hi(ZR0)
	addi	s11, a0, %lo(ZR0)
	lui	a0, %hi(ZI0)
	addi	s7, a0, %lo(ZI0)
	lui	a0, %hi(ZR1)
	addi	s6, a0, %lo(ZR1)
	lui	a0, %hi(ZI1)
	addi	s5, a0, %lo(ZI1)
	lui	a0, %hi(ZR2)
	addi	a0, a0, %lo(ZR2)
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	lui	a0, %hi(ZI2)
	addi	a0, a0, %lo(ZI2)
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	lui	a0, %hi(ZR3)
	addi	a0, a0, %lo(ZR3)
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	lui	a0, %hi(ZI3)
	addi	a0, a0, %lo(ZI3)
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	li	s4, 1024
	lui	a0, %hi(.L.str)
	addi	s10, a0, %lo(.L.str)
.LBB2_3:                                # %for.body.i15
                                        # =>This Inner Loop Header: Depth=1
	add	a0, s11, s0
	lw	a2, 0(a0)
	add	a0, s9, s0
	lw	a3, 0(a0)
	bne	a2, a3, .LBB2_11
# %bb.4:                                # %lor.lhs.false.i
                                        #   in Loop: Header=BB2_3 Depth=1
	add	a0, s7, s0
	lw	a0, 0(a0)
	add	a1, s8, s0
	lw	a1, 0(a1)
	bne	a0, a1, .LBB2_11
# %bb.5:                                # %lor.lhs.false9.i
                                        #   in Loop: Header=BB2_3 Depth=1
	add	a0, s6, s0
	lw	a0, 0(a0)
	add	a1, s2, s0
	lw	a1, 0(a1)
	bne	a0, a1, .LBB2_11
# %bb.6:                                # %lor.lhs.false15.i
                                        #   in Loop: Header=BB2_3 Depth=1
	add	a0, s5, s0
	lw	a0, 0(a0)
	add	a1, s3, s0
	lw	a1, 0(a1)
	bne	a0, a1, .LBB2_11
# %bb.7:                                # %lor.lhs.false21.i
                                        #   in Loop: Header=BB2_3 Depth=1
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	add	a0, a0, s0
	lw	a0, 0(a0)
	ld	a1, 64(sp)                      # 8-byte Folded Reload
	add	a1, a1, s0
	lw	a1, 0(a1)
	bne	a0, a1, .LBB2_11
# %bb.8:                                # %lor.lhs.false27.i
                                        #   in Loop: Header=BB2_3 Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	add	a0, a0, s0
	lw	a0, 0(a0)
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	add	a1, a1, s0
	lw	a1, 0(a1)
	bne	a0, a1, .LBB2_11
# %bb.9:                                # %lor.lhs.false33.i
                                        #   in Loop: Header=BB2_3 Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	add	a0, a0, s0
	lw	a0, 0(a0)
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	add	a1, a1, s0
	lw	a1, 0(a1)
	bne	a0, a1, .LBB2_11
# %bb.10:                               # %lor.lhs.false39.i
                                        #   in Loop: Header=BB2_3 Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	add	a0, a0, s0
	lw	a0, 0(a0)
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	add	a1, a1, s0
	lw	a1, 0(a1)
	beq	a0, a1, .LBB2_12
.LBB2_11:                               # %if.then.i
                                        #   in Loop: Header=BB2_3 Depth=1
	sext.w	a1, s1
	mv	a0, s10
	call	printf
.LBB2_12:                               # %for.inc.i
                                        #   in Loop: Header=BB2_3 Depth=1
	addi	s1, s1, 1
	addi	s0, s0, 4
	bne	s1, s4, .LBB2_3
# %bb.13:                               # %result_check.exit
	li	a0, 0
	ld	ra, 792(sp)                     # 8-byte Folded Reload
	ld	s0, 784(sp)                     # 8-byte Folded Reload
	ld	s1, 776(sp)                     # 8-byte Folded Reload
	ld	s2, 768(sp)                     # 8-byte Folded Reload
	ld	s3, 760(sp)                     # 8-byte Folded Reload
	ld	s4, 752(sp)                     # 8-byte Folded Reload
	ld	s5, 744(sp)                     # 8-byte Folded Reload
	ld	s6, 736(sp)                     # 8-byte Folded Reload
	ld	s7, 728(sp)                     # 8-byte Folded Reload
	ld	s8, 720(sp)                     # 8-byte Folded Reload
	ld	s9, 712(sp)                     # 8-byte Folded Reload
	ld	s10, 704(sp)                    # 8-byte Folded Reload
	ld	s11, 696(sp)                    # 8-byte Folded Reload
	addi	sp, sp, 800
	ret
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
                                        # -- End function
	.type	.L__const.cgra_execute.cin,@object # @__const.cgra_execute.cin
	.section	.rodata,"a",@progbits
	.p2align	3
.L__const.cgra_execute.cin:
	.half	14336                           # 0x3800
	.half	0                               # 0x0
	.half	4                               # 0x4
	.half	16                              # 0x10
	.half	0                               # 0x0
	.half	5                               # 0x5
	.half	0                               # 0x0
	.half	36096                           # 0x8d00
	.half	6                               # 0x6
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	7                               # 0x7
	.half	10240                           # 0x2800
	.half	0                               # 0x0
	.half	8                               # 0x8
	.half	16                              # 0x10
	.half	0                               # 0x0
	.half	9                               # 0x9
	.half	0                               # 0x0
	.half	256                             # 0x100
	.half	10                              # 0xa
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	11                              # 0xb
	.half	8192                            # 0x2000
	.half	0                               # 0x0
	.half	12                              # 0xc
	.half	16                              # 0x10
	.half	0                               # 0x0
	.half	13                              # 0xd
	.half	0                               # 0x0
	.half	256                             # 0x100
	.half	14                              # 0xe
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	15                              # 0xf
	.half	12288                           # 0x3000
	.half	0                               # 0x0
	.half	16                              # 0x10
	.half	16                              # 0x10
	.half	0                               # 0x0
	.half	17                              # 0x11
	.half	0                               # 0x0
	.half	36096                           # 0x8d00
	.half	18                              # 0x12
	.half	128                             # 0x80
	.half	0                               # 0x0
	.half	19                              # 0x13
	.half	12288                           # 0x3000
	.half	0                               # 0x0
	.half	20                              # 0x14
	.half	16                              # 0x10
	.half	0                               # 0x0
	.half	21                              # 0x15
	.half	0                               # 0x0
	.half	36096                           # 0x8d00
	.half	22                              # 0x16
	.half	128                             # 0x80
	.half	0                               # 0x0
	.half	23                              # 0x17
	.half	10240                           # 0x2800
	.half	0                               # 0x0
	.half	24                              # 0x18
	.half	16                              # 0x10
	.half	0                               # 0x0
	.half	25                              # 0x19
	.half	0                               # 0x0
	.half	256                             # 0x100
	.half	26                              # 0x1a
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	27                              # 0x1b
	.half	8192                            # 0x2000
	.half	0                               # 0x0
	.half	28                              # 0x1c
	.half	16                              # 0x10
	.half	0                               # 0x0
	.half	29                              # 0x1d
	.half	0                               # 0x0
	.half	256                             # 0x100
	.half	30                              # 0x1e
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	31                              # 0x1f
	.half	14336                           # 0x3800
	.half	0                               # 0x0
	.half	32                              # 0x20
	.half	16                              # 0x10
	.half	0                               # 0x0
	.half	33                              # 0x21
	.half	0                               # 0x0
	.half	36096                           # 0x8d00
	.half	34                              # 0x22
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	35                              # 0x23
	.half	1024                            # 0x400
	.half	0                               # 0x0
	.half	44                              # 0x2c
	.half	1024                            # 0x400
	.half	0                               # 0x0
	.half	48                              # 0x30
	.half	0                               # 0x0
	.half	4                               # 0x4
	.half	52                              # 0x34
	.half	512                             # 0x200
	.half	8                               # 0x8
	.half	56                              # 0x38
	.half	34816                           # 0x8800
	.half	0                               # 0x0
	.half	60                              # 0x3c
	.half	5120                            # 0x1400
	.half	1                               # 0x1
	.half	64                              # 0x40
	.half	2096                            # 0x830
	.half	0                               # 0x0
	.half	68                              # 0x44
	.half	10242                           # 0x2802
	.half	0                               # 0x0
	.half	81                              # 0x51
	.half	9217                            # 0x2401
	.half	0                               # 0x0
	.half	85                              # 0x55
	.half	17537                           # 0x4481
	.half	0                               # 0x0
	.half	93                              # 0x5d
	.half	10258                           # 0x2812
	.half	0                               # 0x0
	.half	97                              # 0x61
	.half	9217                            # 0x2401
	.half	0                               # 0x0
	.half	101                             # 0x65
	.half	9218                            # 0x2402
	.half	0                               # 0x0
	.half	105                             # 0x69
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	112                             # 0x70
	.half	0                               # 0x0
	.half	512                             # 0x200
	.half	116                             # 0x74
	.half	1024                            # 0x400
	.half	512                             # 0x200
	.half	140                             # 0x8c
	.half	20482                           # 0x5002
	.half	0                               # 0x0
	.half	149                             # 0x95
	.half	11393                           # 0x2c81
	.half	0                               # 0x0
	.half	177                             # 0xb1
	.half	771                             # 0x303
	.half	0                               # 0x0
	.half	188                             # 0xbc
	.half	816                             # 0x330
	.half	0                               # 0x0
	.half	212                             # 0xd4
	.half	33793                           # 0x8401
	.half	0                               # 0x0
	.half	225                             # 0xe1
	.half	25618                           # 0x6412
	.half	0                               # 0x0
	.half	249                             # 0xf9
	.half	0                               # 0x0
	.half	64                              # 0x40
	.half	260                             # 0x104
	.half	4                               # 0x4
	.half	128                             # 0x80
	.half	264                             # 0x108
	.half	2048                            # 0x800
	.half	128                             # 0x80
	.half	268                             # 0x10c
	.half	12800                           # 0x3200
	.half	0                               # 0x0
	.half	272                             # 0x110
	.half	16384                           # 0x4000
	.half	1                               # 0x1
	.half	276                             # 0x114
	.half	64                              # 0x40
	.half	520                             # 0x208
	.half	284                             # 0x11c
	.half	36865                           # 0x9001
	.half	0                               # 0x0
	.half	293                             # 0x125
	.half	35842                           # 0x8c02
	.half	0                               # 0x0
	.half	297                             # 0x129
	.half	10257                           # 0x2811
	.half	0                               # 0x0
	.half	305                             # 0x131
	.half	17538                           # 0x4482
	.half	0                               # 0x0
	.half	309                             # 0x135
	.half	35841                           # 0x8c01
	.half	0                               # 0x0
	.half	313                             # 0x139
	.half	35970                           # 0x8c82
	.half	0                               # 0x0
	.half	317                             # 0x13d
	.half	20                              # 0x14
	.half	0                               # 0x0
	.half	332                             # 0x14c
	.half	772                             # 0x304
	.half	0                               # 0x0
	.half	336                             # 0x150
	.half	256                             # 0x100
	.half	0                               # 0x0
	.half	340                             # 0x154
	.half	16                              # 0x10
	.half	16                              # 0x10
	.half	348                             # 0x15c
	.half	32                              # 0x20
	.half	0                               # 0x0
	.half	352                             # 0x160
	.half	772                             # 0x304
	.half	0                               # 0x0
	.half	356                             # 0x164
	.half	8192                            # 0x2000
	.half	0                               # 0x0
	.half	364                             # 0x16c
	.half	16                              # 0x10
	.half	0                               # 0x0
	.half	365                             # 0x16d
	.half	0                               # 0x0
	.half	256                             # 0x100
	.half	366                             # 0x16e
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	367                             # 0x16f
	.half	10240                           # 0x2800
	.half	0                               # 0x0
	.half	368                             # 0x170
	.half	16                              # 0x10
	.half	0                               # 0x0
	.half	369                             # 0x171
	.half	0                               # 0x0
	.half	256                             # 0x100
	.half	370                             # 0x172
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	371                             # 0x173
	.half	14336                           # 0x3800
	.half	0                               # 0x0
	.half	372                             # 0x174
	.half	16                              # 0x10
	.half	0                               # 0x0
	.half	373                             # 0x175
	.half	0                               # 0x0
	.half	36096                           # 0x8d00
	.half	374                             # 0x176
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	375                             # 0x177
	.half	12288                           # 0x3000
	.half	0                               # 0x0
	.half	376                             # 0x178
	.half	16                              # 0x10
	.half	0                               # 0x0
	.half	377                             # 0x179
	.half	0                               # 0x0
	.half	36096                           # 0x8d00
	.half	378                             # 0x17a
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	379                             # 0x17b
	.half	10240                           # 0x2800
	.half	0                               # 0x0
	.half	380                             # 0x17c
	.half	16                              # 0x10
	.half	0                               # 0x0
	.half	381                             # 0x17d
	.half	0                               # 0x0
	.half	256                             # 0x100
	.half	382                             # 0x17e
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	383                             # 0x17f
	.half	12288                           # 0x3000
	.half	0                               # 0x0
	.half	384                             # 0x180
	.half	16                              # 0x10
	.half	0                               # 0x0
	.half	385                             # 0x181
	.half	0                               # 0x0
	.half	36096                           # 0x8d00
	.half	386                             # 0x182
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	387                             # 0x183
	.half	8192                            # 0x2000
	.half	0                               # 0x0
	.half	388                             # 0x184
	.half	16                              # 0x10
	.half	0                               # 0x0
	.half	389                             # 0x185
	.half	0                               # 0x0
	.half	256                             # 0x100
	.half	390                             # 0x186
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	391                             # 0x187
	.half	14336                           # 0x3800
	.half	0                               # 0x0
	.half	392                             # 0x188
	.half	16                              # 0x10
	.half	0                               # 0x0
	.half	393                             # 0x189
	.half	0                               # 0x0
	.half	36096                           # 0x8d00
	.half	394                             # 0x18a
	.half	0                               # 0x0
	.half	0                               # 0x0
	.half	395                             # 0x18b
	.size	.L__const.cgra_execute.cin, 624

	.type	XR0,@object                     # @XR0
	.bss
	.globl	XR0
	.p2align	2
XR0:
	.zero	4096
	.size	XR0, 4096

	.type	XI0,@object                     # @XI0
	.globl	XI0
	.p2align	2
XI0:
	.zero	4096
	.size	XI0, 4096

	.type	XR1,@object                     # @XR1
	.globl	XR1
	.p2align	2
XR1:
	.zero	4096
	.size	XR1, 4096

	.type	XI1,@object                     # @XI1
	.globl	XI1
	.p2align	2
XI1:
	.zero	4096
	.size	XI1, 4096

	.type	XR2,@object                     # @XR2
	.globl	XR2
	.p2align	2
XR2:
	.zero	4096
	.size	XR2, 4096

	.type	XI2,@object                     # @XI2
	.globl	XI2
	.p2align	2
XI2:
	.zero	4096
	.size	XI2, 4096

	.type	XR3,@object                     # @XR3
	.globl	XR3
	.p2align	2
XR3:
	.zero	4096
	.size	XR3, 4096

	.type	XI3,@object                     # @XI3
	.globl	XI3
	.p2align	2
XI3:
	.zero	4096
	.size	XI3, 4096

	.type	ZR0,@object                     # @ZR0
	.globl	ZR0
	.p2align	2
ZR0:
	.zero	4096
	.size	ZR0, 4096

	.type	ZI0,@object                     # @ZI0
	.globl	ZI0
	.p2align	2
ZI0:
	.zero	4096
	.size	ZI0, 4096

	.type	ZR1,@object                     # @ZR1
	.globl	ZR1
	.p2align	2
ZR1:
	.zero	4096
	.size	ZR1, 4096

	.type	ZI1,@object                     # @ZI1
	.globl	ZI1
	.p2align	2
ZI1:
	.zero	4096
	.size	ZI1, 4096

	.type	ZR2,@object                     # @ZR2
	.globl	ZR2
	.p2align	2
ZR2:
	.zero	4096
	.size	ZR2, 4096

	.type	ZI2,@object                     # @ZI2
	.globl	ZI2
	.p2align	2
ZI2:
	.zero	4096
	.size	ZI2, 4096

	.type	ZR3,@object                     # @ZR3
	.globl	ZR3
	.p2align	2
ZR3:
	.zero	4096
	.size	ZR3, 4096

	.type	ZI3,@object                     # @ZI3
	.globl	ZI3
	.p2align	2
ZI3:
	.zero	4096
	.size	ZI3, 4096

	.type	YR0,@object                     # @YR0
	.globl	YR0
	.p2align	2
YR0:
	.zero	4096
	.size	YR0, 4096

	.type	YI0,@object                     # @YI0
	.globl	YI0
	.p2align	2
YI0:
	.zero	4096
	.size	YI0, 4096

	.type	YR1,@object                     # @YR1
	.globl	YR1
	.p2align	2
YR1:
	.zero	4096
	.size	YR1, 4096

	.type	YI1,@object                     # @YI1
	.globl	YI1
	.p2align	2
YI1:
	.zero	4096
	.size	YI1, 4096

	.type	YR2,@object                     # @YR2
	.globl	YR2
	.p2align	2
YR2:
	.zero	4096
	.size	YR2, 4096

	.type	YI2,@object                     # @YI2
	.globl	YI2
	.p2align	2
YI2:
	.zero	4096
	.size	YI2, 4096

	.type	YR3,@object                     # @YR3
	.globl	YR3
	.p2align	2
YR3:
	.zero	4096
	.size	YR3, 4096

	.type	YI3,@object                     # @YI3
	.globl	YI3
	.p2align	2
YI3:
	.zero	4096
	.size	YI3, 4096

	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"There is an error in location (%d)[%d, %d]\n"
	.size	.L.str, 44

	.ident	"clang version 16.0.0"
	.section	".note.GNU-stack","",@progbits

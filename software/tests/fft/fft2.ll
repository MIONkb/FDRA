; ModuleID = 'fft2.c'
source_filename = "fft2.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n64-S128"
target triple = "riscv64-unknown-unknown-elf"

@__const.cgra_execute.cin = private unnamed_addr constant [104 x [3 x i16]] [[3 x i16] [i16 14336, i16 0, i16 4], [3 x i16] [i16 16, i16 0, i16 5], [3 x i16] [i16 0, i16 -29440, i16 6], [3 x i16] [i16 0, i16 0, i16 7], [3 x i16] [i16 10240, i16 0, i16 8], [3 x i16] [i16 16, i16 0, i16 9], [3 x i16] [i16 0, i16 256, i16 10], [3 x i16] [i16 0, i16 0, i16 11], [3 x i16] [i16 8192, i16 0, i16 12], [3 x i16] [i16 16, i16 0, i16 13], [3 x i16] [i16 0, i16 256, i16 14], [3 x i16] [i16 0, i16 0, i16 15], [3 x i16] [i16 12288, i16 0, i16 16], [3 x i16] [i16 16, i16 0, i16 17], [3 x i16] [i16 0, i16 -29440, i16 18], [3 x i16] [i16 128, i16 0, i16 19], [3 x i16] [i16 12288, i16 0, i16 20], [3 x i16] [i16 16, i16 0, i16 21], [3 x i16] [i16 0, i16 -29440, i16 22], [3 x i16] [i16 128, i16 0, i16 23], [3 x i16] [i16 10240, i16 0, i16 24], [3 x i16] [i16 16, i16 0, i16 25], [3 x i16] [i16 0, i16 256, i16 26], [3 x i16] [i16 0, i16 0, i16 27], [3 x i16] [i16 8192, i16 0, i16 28], [3 x i16] [i16 16, i16 0, i16 29], [3 x i16] [i16 0, i16 256, i16 30], [3 x i16] [i16 0, i16 0, i16 31], [3 x i16] [i16 14336, i16 0, i16 32], [3 x i16] [i16 16, i16 0, i16 33], [3 x i16] [i16 0, i16 -29440, i16 34], [3 x i16] [i16 0, i16 0, i16 35], [3 x i16] [i16 1024, i16 0, i16 44], [3 x i16] [i16 1024, i16 0, i16 48], [3 x i16] [i16 0, i16 4, i16 52], [3 x i16] [i16 512, i16 8, i16 56], [3 x i16] [i16 -30720, i16 0, i16 60], [3 x i16] [i16 5120, i16 1, i16 64], [3 x i16] [i16 2096, i16 0, i16 68], [3 x i16] [i16 10242, i16 0, i16 81], [3 x i16] [i16 9217, i16 0, i16 85], [3 x i16] [i16 17537, i16 0, i16 93], [3 x i16] [i16 10258, i16 0, i16 97], [3 x i16] [i16 9217, i16 0, i16 101], [3 x i16] [i16 9218, i16 0, i16 105], [3 x i16] [i16 0, i16 0, i16 112], [3 x i16] [i16 0, i16 512, i16 116], [3 x i16] [i16 1024, i16 512, i16 140], [3 x i16] [i16 20482, i16 0, i16 149], [3 x i16] [i16 11393, i16 0, i16 177], [3 x i16] [i16 771, i16 0, i16 188], [3 x i16] [i16 816, i16 0, i16 212], [3 x i16] [i16 -31743, i16 0, i16 225], [3 x i16] [i16 25618, i16 0, i16 249], [3 x i16] [i16 0, i16 64, i16 260], [3 x i16] [i16 4, i16 128, i16 264], [3 x i16] [i16 2048, i16 128, i16 268], [3 x i16] [i16 12800, i16 0, i16 272], [3 x i16] [i16 16384, i16 1, i16 276], [3 x i16] [i16 64, i16 520, i16 284], [3 x i16] [i16 -28671, i16 0, i16 293], [3 x i16] [i16 -29694, i16 0, i16 297], [3 x i16] [i16 10257, i16 0, i16 305], [3 x i16] [i16 17538, i16 0, i16 309], [3 x i16] [i16 -29695, i16 0, i16 313], [3 x i16] [i16 -29566, i16 0, i16 317], [3 x i16] [i16 20, i16 0, i16 332], [3 x i16] [i16 772, i16 0, i16 336], [3 x i16] [i16 256, i16 0, i16 340], [3 x i16] [i16 16, i16 16, i16 348], [3 x i16] [i16 32, i16 0, i16 352], [3 x i16] [i16 772, i16 0, i16 356], [3 x i16] [i16 8192, i16 0, i16 364], [3 x i16] [i16 16, i16 0, i16 365], [3 x i16] [i16 0, i16 256, i16 366], [3 x i16] [i16 0, i16 0, i16 367], [3 x i16] [i16 10240, i16 0, i16 368], [3 x i16] [i16 16, i16 0, i16 369], [3 x i16] [i16 0, i16 256, i16 370], [3 x i16] [i16 0, i16 0, i16 371], [3 x i16] [i16 14336, i16 0, i16 372], [3 x i16] [i16 16, i16 0, i16 373], [3 x i16] [i16 0, i16 -29440, i16 374], [3 x i16] [i16 0, i16 0, i16 375], [3 x i16] [i16 12288, i16 0, i16 376], [3 x i16] [i16 16, i16 0, i16 377], [3 x i16] [i16 0, i16 -29440, i16 378], [3 x i16] [i16 0, i16 0, i16 379], [3 x i16] [i16 10240, i16 0, i16 380], [3 x i16] [i16 16, i16 0, i16 381], [3 x i16] [i16 0, i16 256, i16 382], [3 x i16] [i16 0, i16 0, i16 383], [3 x i16] [i16 12288, i16 0, i16 384], [3 x i16] [i16 16, i16 0, i16 385], [3 x i16] [i16 0, i16 -29440, i16 386], [3 x i16] [i16 0, i16 0, i16 387], [3 x i16] [i16 8192, i16 0, i16 388], [3 x i16] [i16 16, i16 0, i16 389], [3 x i16] [i16 0, i16 256, i16 390], [3 x i16] [i16 0, i16 0, i16 391], [3 x i16] [i16 14336, i16 0, i16 392], [3 x i16] [i16 16, i16 0, i16 393], [3 x i16] [i16 0, i16 -29440, i16 394], [3 x i16] [i16 0, i16 0, i16 395]], align 8
@XR0 = dso_local global [1024 x i32] zeroinitializer, align 4
@XI0 = dso_local global [1024 x i32] zeroinitializer, align 4
@XR1 = dso_local global [1024 x i32] zeroinitializer, align 4
@XI1 = dso_local global [1024 x i32] zeroinitializer, align 4
@XR2 = dso_local global [1024 x i32] zeroinitializer, align 4
@XI2 = dso_local global [1024 x i32] zeroinitializer, align 4
@XR3 = dso_local global [1024 x i32] zeroinitializer, align 4
@XI3 = dso_local global [1024 x i32] zeroinitializer, align 4
@ZR0 = dso_local local_unnamed_addr global [1024 x i32] zeroinitializer, align 4
@ZI0 = dso_local local_unnamed_addr global [1024 x i32] zeroinitializer, align 4
@ZR1 = dso_local local_unnamed_addr global [1024 x i32] zeroinitializer, align 4
@ZI1 = dso_local local_unnamed_addr global [1024 x i32] zeroinitializer, align 4
@ZR2 = dso_local local_unnamed_addr global [1024 x i32] zeroinitializer, align 4
@ZI2 = dso_local local_unnamed_addr global [1024 x i32] zeroinitializer, align 4
@ZR3 = dso_local local_unnamed_addr global [1024 x i32] zeroinitializer, align 4
@ZI3 = dso_local local_unnamed_addr global [1024 x i32] zeroinitializer, align 4
@YR0 = dso_local global [1024 x i32] zeroinitializer, align 4
@YI0 = dso_local global [1024 x i32] zeroinitializer, align 4
@YR1 = dso_local global [1024 x i32] zeroinitializer, align 4
@YI1 = dso_local global [1024 x i32] zeroinitializer, align 4
@YR2 = dso_local global [1024 x i32] zeroinitializer, align 4
@YI2 = dso_local global [1024 x i32] zeroinitializer, align 4
@YR3 = dso_local global [1024 x i32] zeroinitializer, align 4
@YI3 = dso_local global [1024 x i32] zeroinitializer, align 4
@.str = private unnamed_addr constant [44 x i8] c"There is an error in location (%d)[%d, %d]\0A\00", align 1

; Function Attrs: nounwind
define dso_local void @cgra_execute(ptr nocapture noundef readonly %din_addr, ptr nocapture noundef readonly %dout_addr) local_unnamed_addr #0 {
entry:
  %cin = alloca [104 x [3 x i16]], align 8
  call void @llvm.lifetime.start.p0(i64 624, ptr nonnull %cin) #5
  call void @llvm.memcpy.p0.p0.i64(ptr nonnull align 8 %cin, ptr align 8 @__const.cgra_execute.cin, i64 624, i1 true)
  %0 = ptrtoint ptr %cin to i64
  call void asm sideeffect ".word 0b0001011 $| (0 << (7)) $| (1 << (7+5)) $| (1 << (7+5+1)) $| (0 << (7+5+2)) $| (11 << (7+5+3)) $| (12 << (7+5+3+5)) $| ((((~(~0 << 7) << 0) & 1) >> 0) << (7+5+3+5+5))\0A\09", "{x11},{x12}"(i64 %0, i64 36031477078687744) #5, !srcloc !4
  %1 = load ptr, ptr %din_addr, align 8, !tbaa !5
  %2 = ptrtoint ptr %1 to i64
  call void asm sideeffect ".word 0b0001011 $| (0 << (7)) $| (1 << (7+5)) $| (1 << (7+5+1)) $| (0 << (7+5+2)) $| (11 << (7+5+3)) $| (12 << (7+5+3+5)) $| ((((~(~0 << 7) << 0) & 1) >> 0) << (7+5+3+5+5))\0A\09", "{x11},{x12}"(i64 %2, i64 17592186077184) #5, !srcloc !9
  %arrayidx2 = getelementptr inbounds ptr, ptr %din_addr, i64 1
  %3 = load ptr, ptr %arrayidx2, align 8, !tbaa !5
  %4 = ptrtoint ptr %3 to i64
  call void asm sideeffect ".word 0b0001011 $| (0 << (7)) $| (1 << (7+5)) $| (1 << (7+5+1)) $| (0 << (7+5+2)) $| (11 << (7+5+3)) $| (12 << (7+5+3+5)) $| ((((~(~0 << 7) << 0) & 1) >> 0) << (7+5+3+5+5))\0A\09", "{x11},{x12}"(i64 %4, i64 17592186044416) #5, !srcloc !9
  %arrayidx4 = getelementptr inbounds ptr, ptr %din_addr, i64 2
  %5 = load ptr, ptr %arrayidx4, align 8, !tbaa !5
  %6 = ptrtoint ptr %5 to i64
  call void asm sideeffect ".word 0b0001011 $| (0 << (7)) $| (1 << (7+5)) $| (1 << (7+5+1)) $| (0 << (7+5+2)) $| (11 << (7+5+3)) $| (12 << (7+5+3+5)) $| ((((~(~0 << 7) << 0) & 1) >> 0) << (7+5+3+5+5))\0A\09", "{x11},{x12}"(i64 %6, i64 17592186085376) #5, !srcloc !9
  %arrayidx6 = getelementptr inbounds ptr, ptr %din_addr, i64 3
  %7 = load ptr, ptr %arrayidx6, align 8, !tbaa !5
  %8 = ptrtoint ptr %7 to i64
  call void asm sideeffect ".word 0b0001011 $| (0 << (7)) $| (1 << (7+5)) $| (1 << (7+5+1)) $| (0 << (7+5+2)) $| (11 << (7+5+3)) $| (12 << (7+5+3+5)) $| ((((~(~0 << 7) << 0) & 1) >> 0) << (7+5+3+5+5))\0A\09", "{x11},{x12}"(i64 %8, i64 17592186052608) #5, !srcloc !9
  %arrayidx8 = getelementptr inbounds ptr, ptr %din_addr, i64 4
  %9 = load ptr, ptr %arrayidx8, align 8, !tbaa !5
  %10 = ptrtoint ptr %9 to i64
  call void asm sideeffect ".word 0b0001011 $| (0 << (7)) $| (1 << (7+5)) $| (1 << (7+5+1)) $| (0 << (7+5+2)) $| (11 << (7+5+3)) $| (12 << (7+5+3+5)) $| ((((~(~0 << 7) << 0) & 1) >> 0) << (7+5+3+5+5))\0A\09", "{x11},{x12}"(i64 %10, i64 17592186109952) #5, !srcloc !9
  %arrayidx10 = getelementptr inbounds ptr, ptr %din_addr, i64 5
  %11 = load ptr, ptr %arrayidx10, align 8, !tbaa !5
  %12 = ptrtoint ptr %11 to i64
  call void asm sideeffect ".word 0b0001011 $| (0 << (7)) $| (1 << (7+5)) $| (1 << (7+5+1)) $| (0 << (7+5+2)) $| (11 << (7+5+3)) $| (12 << (7+5+3+5)) $| ((((~(~0 << 7) << 0) & 1) >> 0) << (7+5+3+5+5))\0A\09", "{x11},{x12}"(i64 %12, i64 17592186142720) #5, !srcloc !9
  %arrayidx12 = getelementptr inbounds ptr, ptr %din_addr, i64 6
  %13 = load ptr, ptr %arrayidx12, align 8, !tbaa !5
  %14 = ptrtoint ptr %13 to i64
  call void asm sideeffect ".word 0b0001011 $| (0 << (7)) $| (1 << (7+5)) $| (1 << (7+5+1)) $| (0 << (7+5+2)) $| (11 << (7+5+3)) $| (12 << (7+5+3+5)) $| ((((~(~0 << 7) << 0) & 1) >> 0) << (7+5+3+5+5))\0A\09", "{x11},{x12}"(i64 %14, i64 17592186118144) #5, !srcloc !9
  %arrayidx14 = getelementptr inbounds ptr, ptr %din_addr, i64 7
  %15 = load ptr, ptr %arrayidx14, align 8, !tbaa !5
  %16 = ptrtoint ptr %15 to i64
  call void asm sideeffect ".word 0b0001011 $| (0 << (7)) $| (1 << (7+5)) $| (1 << (7+5+1)) $| (0 << (7+5+2)) $| (11 << (7+5+3)) $| (12 << (7+5+3+5)) $| ((((~(~0 << 7) << 0) & 1) >> 0) << (7+5+3+5+5))\0A\09", "{x11},{x12}"(i64 %16, i64 17592186150912) #5, !srcloc !9
  call void asm sideeffect ".word 0b0001011 $| (0 << (7)) $| (1 << (7+5)) $| (1 << (7+5+1)) $| (0 << (7+5+2)) $| (11 << (7+5+3)) $| (12 << (7+5+3+5)) $| ((((~(~0 << 7) << 0) & 3) >> 0) << (7+5+3+5+5))\0A\09", "{x11},{x12}"(i64 0, i64 446676598784) #5, !srcloc !10
  call void asm sideeffect ".word 0b0001011 $| (0 << (7)) $| (1 << (7+5)) $| (1 << (7+5+1)) $| (0 << (7+5+2)) $| (11 << (7+5+3)) $| (12 << (7+5+3+5)) $| ((((~(~0 << 7) << 0) & 4) >> 0) << (7+5+3+5+5))\0A\09", "{x11},{x12}"(i64 65535, i64 0) #5, !srcloc !11
  %17 = load ptr, ptr %dout_addr, align 8, !tbaa !5
  %18 = ptrtoint ptr %17 to i64
  call void asm sideeffect ".word 0b0001011 $| (0 << (7)) $| (1 << (7+5)) $| (1 << (7+5+1)) $| (0 << (7+5+2)) $| (11 << (7+5+3)) $| (12 << (7+5+3+5)) $| ((((~(~0 << 7) << 0) & 2) >> 0) << (7+5+3+5+5))\0A\09", "{x11},{x12}"(i64 %18, i64 17592186126336) #5, !srcloc !12
  %arrayidx20 = getelementptr inbounds ptr, ptr %dout_addr, i64 1
  %19 = load ptr, ptr %arrayidx20, align 8, !tbaa !5
  %20 = ptrtoint ptr %19 to i64
  call void asm sideeffect ".word 0b0001011 $| (0 << (7)) $| (1 << (7+5)) $| (1 << (7+5+1)) $| (0 << (7+5+2)) $| (11 << (7+5+3)) $| (12 << (7+5+3+5)) $| ((((~(~0 << 7) << 0) & 2) >> 0) << (7+5+3+5+5))\0A\09", "{x11},{x12}"(i64 %20, i64 17592186060800) #5, !srcloc !12
  %arrayidx22 = getelementptr inbounds ptr, ptr %dout_addr, i64 2
  %21 = load ptr, ptr %arrayidx22, align 8, !tbaa !5
  %22 = ptrtoint ptr %21 to i64
  call void asm sideeffect ".word 0b0001011 $| (0 << (7)) $| (1 << (7+5)) $| (1 << (7+5+1)) $| (0 << (7+5+2)) $| (11 << (7+5+3)) $| (12 << (7+5+3+5)) $| ((((~(~0 << 7) << 0) & 2) >> 0) << (7+5+3+5+5))\0A\09", "{x11},{x12}"(i64 %22, i64 17592186159104) #5, !srcloc !12
  %arrayidx24 = getelementptr inbounds ptr, ptr %dout_addr, i64 3
  %23 = load ptr, ptr %arrayidx24, align 8, !tbaa !5
  %24 = ptrtoint ptr %23 to i64
  call void asm sideeffect ".word 0b0001011 $| (0 << (7)) $| (1 << (7+5)) $| (1 << (7+5+1)) $| (0 << (7+5+2)) $| (11 << (7+5+3)) $| (12 << (7+5+3+5)) $| ((((~(~0 << 7) << 0) & 2) >> 0) << (7+5+3+5+5))\0A\09", "{x11},{x12}"(i64 %24, i64 17592186093568) #5, !srcloc !12
  %arrayidx26 = getelementptr inbounds ptr, ptr %dout_addr, i64 4
  %25 = load ptr, ptr %arrayidx26, align 8, !tbaa !5
  %26 = ptrtoint ptr %25 to i64
  call void asm sideeffect ".word 0b0001011 $| (0 << (7)) $| (1 << (7+5)) $| (1 << (7+5+1)) $| (0 << (7+5+2)) $| (11 << (7+5+3)) $| (12 << (7+5+3+5)) $| ((((~(~0 << 7) << 0) & 2) >> 0) << (7+5+3+5+5))\0A\09", "{x11},{x12}"(i64 %26, i64 17592186134528) #5, !srcloc !12
  %arrayidx28 = getelementptr inbounds ptr, ptr %dout_addr, i64 5
  %27 = load ptr, ptr %arrayidx28, align 8, !tbaa !5
  %28 = ptrtoint ptr %27 to i64
  call void asm sideeffect ".word 0b0001011 $| (0 << (7)) $| (1 << (7+5)) $| (1 << (7+5+1)) $| (0 << (7+5+2)) $| (11 << (7+5+3)) $| (12 << (7+5+3+5)) $| ((((~(~0 << 7) << 0) & 2) >> 0) << (7+5+3+5+5))\0A\09", "{x11},{x12}"(i64 %28, i64 17592186101760) #5, !srcloc !12
  %arrayidx30 = getelementptr inbounds ptr, ptr %dout_addr, i64 6
  %29 = load ptr, ptr %arrayidx30, align 8, !tbaa !5
  %30 = ptrtoint ptr %29 to i64
  call void asm sideeffect ".word 0b0001011 $| (0 << (7)) $| (1 << (7+5)) $| (1 << (7+5+1)) $| (0 << (7+5+2)) $| (11 << (7+5+3)) $| (12 << (7+5+3+5)) $| ((((~(~0 << 7) << 0) & 2) >> 0) << (7+5+3+5+5))\0A\09", "{x11},{x12}"(i64 %30, i64 17592186068992) #5, !srcloc !12
  %arrayidx32 = getelementptr inbounds ptr, ptr %dout_addr, i64 7
  %31 = load ptr, ptr %arrayidx32, align 8, !tbaa !5
  %32 = ptrtoint ptr %31 to i64
  call void asm sideeffect ".word 0b0001011 $| (0 << (7)) $| (1 << (7+5)) $| (1 << (7+5+1)) $| (0 << (7+5+2)) $| (11 << (7+5+3)) $| (12 << (7+5+3+5)) $| ((((~(~0 << 7) << 0) & 2) >> 0) << (7+5+3+5+5))\0A\09", "{x11},{x12}"(i64 %32, i64 17592186167296) #5, !srcloc !12
  call void @llvm.lifetime.end.p0(i64 624, ptr nonnull %cin) #5
  ret void
}

; Function Attrs: argmemonly mustprogress nocallback nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: argmemonly mustprogress nocallback nofree nounwind willreturn
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #2

; Function Attrs: argmemonly mustprogress nocallback nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nofree noinline norecurse nosync nounwind
define dso_local void @fft4() local_unnamed_addr #3 {
entry:
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %arrayidx = getelementptr inbounds [1024 x i32], ptr @XR0, i64 0, i64 %indvars.iv
  %0 = load i32, ptr %arrayidx, align 4, !tbaa !13
  %arrayidx2 = getelementptr inbounds [1024 x i32], ptr @XI0, i64 0, i64 %indvars.iv
  %1 = load i32, ptr %arrayidx2, align 4, !tbaa !13
  %arrayidx4 = getelementptr inbounds [1024 x i32], ptr @XR1, i64 0, i64 %indvars.iv
  %2 = load i32, ptr %arrayidx4, align 4, !tbaa !13
  %arrayidx6 = getelementptr inbounds [1024 x i32], ptr @XI1, i64 0, i64 %indvars.iv
  %3 = load i32, ptr %arrayidx6, align 4, !tbaa !13
  %arrayidx8 = getelementptr inbounds [1024 x i32], ptr @XR2, i64 0, i64 %indvars.iv
  %4 = load i32, ptr %arrayidx8, align 4, !tbaa !13
  %arrayidx10 = getelementptr inbounds [1024 x i32], ptr @XI2, i64 0, i64 %indvars.iv
  %5 = load i32, ptr %arrayidx10, align 4, !tbaa !13
  %arrayidx12 = getelementptr inbounds [1024 x i32], ptr @XR3, i64 0, i64 %indvars.iv
  %6 = load i32, ptr %arrayidx12, align 4, !tbaa !13
  %arrayidx14 = getelementptr inbounds [1024 x i32], ptr @XI3, i64 0, i64 %indvars.iv
  %7 = load i32, ptr %arrayidx14, align 4, !tbaa !13
  %add = add nsw i32 %4, %0
  %add15 = add nsw i32 %5, %1
  %sub = sub nsw i32 %0, %4
  %sub16 = sub nsw i32 %1, %5
  %add19 = add nsw i32 %6, %2
  %add20 = add nsw i32 %7, %3
  %sub21.neg = sub i32 %6, %2
  %sub22.neg.neg = sub i32 %3, %7
  %add30 = add nsw i32 %add19, %add
  %add31 = add nsw i32 %add20, %add15
  %sub32 = sub nsw i32 %add, %add19
  %sub33 = sub nsw i32 %add15, %add20
  %add36 = add nsw i32 %sub22.neg.neg, %sub
  %add37 = add nsw i32 %sub21.neg, %sub16
  %sub38 = sub nsw i32 %sub, %sub22.neg.neg
  %sub39 = sub nsw i32 %sub16, %sub21.neg
  %arrayidx41 = getelementptr inbounds [1024 x i32], ptr @ZR0, i64 0, i64 %indvars.iv
  store i32 %add30, ptr %arrayidx41, align 4, !tbaa !13
  %arrayidx43 = getelementptr inbounds [1024 x i32], ptr @ZI0, i64 0, i64 %indvars.iv
  store i32 %add31, ptr %arrayidx43, align 4, !tbaa !13
  %arrayidx45 = getelementptr inbounds [1024 x i32], ptr @ZR1, i64 0, i64 %indvars.iv
  store i32 %sub32, ptr %arrayidx45, align 4, !tbaa !13
  %arrayidx47 = getelementptr inbounds [1024 x i32], ptr @ZI1, i64 0, i64 %indvars.iv
  store i32 %sub33, ptr %arrayidx47, align 4, !tbaa !13
  %arrayidx49 = getelementptr inbounds [1024 x i32], ptr @ZR2, i64 0, i64 %indvars.iv
  store i32 %add36, ptr %arrayidx49, align 4, !tbaa !13
  %arrayidx51 = getelementptr inbounds [1024 x i32], ptr @ZI2, i64 0, i64 %indvars.iv
  store i32 %add37, ptr %arrayidx51, align 4, !tbaa !13
  %arrayidx53 = getelementptr inbounds [1024 x i32], ptr @ZR3, i64 0, i64 %indvars.iv
  store i32 %sub38, ptr %arrayidx53, align 4, !tbaa !13
  %arrayidx55 = getelementptr inbounds [1024 x i32], ptr @ZI3, i64 0, i64 %indvars.iv
  store i32 %sub39, ptr %arrayidx55, align 4, !tbaa !13
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, 1024
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !15

for.end:                                          ; preds = %for.body
  ret void
}

; Function Attrs: nounwind
define dso_local signext i32 @main(i32 noundef signext %argc, ptr nocapture noundef readnone %argv) local_unnamed_addr #0 {
entry:
  %cin.i = alloca [104 x [3 x i16]], align 8
  %result = alloca i32, align 4
  br label %for.body.i

for.body.i:                                       ; preds = %for.body.i, %entry
  %indvars.iv.i = phi i64 [ 0, %entry ], [ %indvars.iv.next.i, %for.body.i ]
  %arrayidx.i = getelementptr inbounds [1024 x i32], ptr @XR0, i64 0, i64 %indvars.iv.i
  %0 = trunc i64 %indvars.iv.i to i32
  store i32 %0, ptr %arrayidx.i, align 4, !tbaa !13
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i, 1
  %arrayidx2.i = getelementptr inbounds [1024 x i32], ptr @XR1, i64 0, i64 %indvars.iv.i
  %1 = trunc i64 %indvars.iv.next.i to i32
  store i32 %1, ptr %arrayidx2.i, align 4, !tbaa !13
  %arrayidx5.i = getelementptr inbounds [1024 x i32], ptr @XR2, i64 0, i64 %indvars.iv.i
  %2 = add i32 %0, 2
  store i32 %2, ptr %arrayidx5.i, align 4, !tbaa !13
  %arrayidx8.i = getelementptr inbounds [1024 x i32], ptr @XR3, i64 0, i64 %indvars.iv.i
  %3 = add i32 %0, 3
  store i32 %3, ptr %arrayidx8.i, align 4, !tbaa !13
  %arrayidx11.i = getelementptr inbounds [1024 x i32], ptr @XI0, i64 0, i64 %indvars.iv.i
  %4 = add i32 %0, 4
  store i32 %4, ptr %arrayidx11.i, align 4, !tbaa !13
  %arrayidx14.i = getelementptr inbounds [1024 x i32], ptr @XI1, i64 0, i64 %indvars.iv.i
  %5 = add i32 %0, 5
  store i32 %5, ptr %arrayidx14.i, align 4, !tbaa !13
  %arrayidx17.i = getelementptr inbounds [1024 x i32], ptr @XI2, i64 0, i64 %indvars.iv.i
  %6 = add i32 %0, 6
  store i32 %6, ptr %arrayidx17.i, align 4, !tbaa !13
  %arrayidx20.i = getelementptr inbounds [1024 x i32], ptr @XI3, i64 0, i64 %indvars.iv.i
  %7 = add i32 %0, 7
  store i32 %7, ptr %arrayidx20.i, align 4, !tbaa !13
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 1024
  br i1 %exitcond.not.i, label %init_array.exit, label %for.body.i, !llvm.loop !18

init_array.exit:                                  ; preds = %for.body.i
  %8 = tail call i64 asm sideeffect "csrr $0, cycle", "=r"() #5, !srcloc !19
  tail call void @fft4() #6
  %9 = tail call i64 asm sideeffect "csrr $0, cycle", "=r"() #5, !srcloc !20
  %10 = tail call i64 asm sideeffect "csrr $0, cycle", "=r"() #5, !srcloc !21
  call void @llvm.lifetime.start.p0(i64 624, ptr nonnull %cin.i) #5
  call void @llvm.memcpy.p0.p0.i64(ptr nonnull align 8 %cin.i, ptr align 8 @__const.cgra_execute.cin, i64 624, i1 true)
  %11 = ptrtoint ptr %cin.i to i64
  call void asm sideeffect ".word 0b0001011 $| (0 << (7)) $| (1 << (7+5)) $| (1 << (7+5+1)) $| (0 << (7+5+2)) $| (11 << (7+5+3)) $| (12 << (7+5+3+5)) $| ((((~(~0 << 7) << 0) & 1) >> 0) << (7+5+3+5+5))\0A\09", "{x11},{x12}"(i64 %11, i64 36031477078687744) #5, !srcloc !4
  call void asm sideeffect ".word 0b0001011 $| (0 << (7)) $| (1 << (7+5)) $| (1 << (7+5+1)) $| (0 << (7+5+2)) $| (11 << (7+5+3)) $| (12 << (7+5+3+5)) $| ((((~(~0 << 7) << 0) & 1) >> 0) << (7+5+3+5+5))\0A\09", "{x11},{x12}"(i64 ptrtoint (ptr @XI0 to i64), i64 17592186077184) #5, !srcloc !9
  call void asm sideeffect ".word 0b0001011 $| (0 << (7)) $| (1 << (7+5)) $| (1 << (7+5+1)) $| (0 << (7+5+2)) $| (11 << (7+5+3)) $| (12 << (7+5+3+5)) $| ((((~(~0 << 7) << 0) & 1) >> 0) << (7+5+3+5+5))\0A\09", "{x11},{x12}"(i64 ptrtoint (ptr @XI1 to i64), i64 17592186044416) #5, !srcloc !9
  call void asm sideeffect ".word 0b0001011 $| (0 << (7)) $| (1 << (7+5)) $| (1 << (7+5+1)) $| (0 << (7+5+2)) $| (11 << (7+5+3)) $| (12 << (7+5+3+5)) $| ((((~(~0 << 7) << 0) & 1) >> 0) << (7+5+3+5+5))\0A\09", "{x11},{x12}"(i64 ptrtoint (ptr @XI2 to i64), i64 17592186085376) #5, !srcloc !9
  call void asm sideeffect ".word 0b0001011 $| (0 << (7)) $| (1 << (7+5)) $| (1 << (7+5+1)) $| (0 << (7+5+2)) $| (11 << (7+5+3)) $| (12 << (7+5+3+5)) $| ((((~(~0 << 7) << 0) & 1) >> 0) << (7+5+3+5+5))\0A\09", "{x11},{x12}"(i64 ptrtoint (ptr @XI3 to i64), i64 17592186052608) #5, !srcloc !9
  call void asm sideeffect ".word 0b0001011 $| (0 << (7)) $| (1 << (7+5)) $| (1 << (7+5+1)) $| (0 << (7+5+2)) $| (11 << (7+5+3)) $| (12 << (7+5+3+5)) $| ((((~(~0 << 7) << 0) & 1) >> 0) << (7+5+3+5+5))\0A\09", "{x11},{x12}"(i64 ptrtoint (ptr @XR0 to i64), i64 17592186109952) #5, !srcloc !9
  call void asm sideeffect ".word 0b0001011 $| (0 << (7)) $| (1 << (7+5)) $| (1 << (7+5+1)) $| (0 << (7+5+2)) $| (11 << (7+5+3)) $| (12 << (7+5+3+5)) $| ((((~(~0 << 7) << 0) & 1) >> 0) << (7+5+3+5+5))\0A\09", "{x11},{x12}"(i64 ptrtoint (ptr @XR1 to i64), i64 17592186142720) #5, !srcloc !9
  call void asm sideeffect ".word 0b0001011 $| (0 << (7)) $| (1 << (7+5)) $| (1 << (7+5+1)) $| (0 << (7+5+2)) $| (11 << (7+5+3)) $| (12 << (7+5+3+5)) $| ((((~(~0 << 7) << 0) & 1) >> 0) << (7+5+3+5+5))\0A\09", "{x11},{x12}"(i64 ptrtoint (ptr @XR2 to i64), i64 17592186118144) #5, !srcloc !9
  call void asm sideeffect ".word 0b0001011 $| (0 << (7)) $| (1 << (7+5)) $| (1 << (7+5+1)) $| (0 << (7+5+2)) $| (11 << (7+5+3)) $| (12 << (7+5+3+5)) $| ((((~(~0 << 7) << 0) & 1) >> 0) << (7+5+3+5+5))\0A\09", "{x11},{x12}"(i64 ptrtoint (ptr @XR3 to i64), i64 17592186150912) #5, !srcloc !9
  call void asm sideeffect ".word 0b0001011 $| (0 << (7)) $| (1 << (7+5)) $| (1 << (7+5+1)) $| (0 << (7+5+2)) $| (11 << (7+5+3)) $| (12 << (7+5+3+5)) $| ((((~(~0 << 7) << 0) & 3) >> 0) << (7+5+3+5+5))\0A\09", "{x11},{x12}"(i64 0, i64 446676598784) #5, !srcloc !10
  call void asm sideeffect ".word 0b0001011 $| (0 << (7)) $| (1 << (7+5)) $| (1 << (7+5+1)) $| (0 << (7+5+2)) $| (11 << (7+5+3)) $| (12 << (7+5+3+5)) $| ((((~(~0 << 7) << 0) & 4) >> 0) << (7+5+3+5+5))\0A\09", "{x11},{x12}"(i64 65535, i64 0) #5, !srcloc !11
  call void asm sideeffect ".word 0b0001011 $| (0 << (7)) $| (1 << (7+5)) $| (1 << (7+5+1)) $| (0 << (7+5+2)) $| (11 << (7+5+3)) $| (12 << (7+5+3+5)) $| ((((~(~0 << 7) << 0) & 2) >> 0) << (7+5+3+5+5))\0A\09", "{x11},{x12}"(i64 ptrtoint (ptr @YR0 to i64), i64 17592186126336) #5, !srcloc !12
  call void asm sideeffect ".word 0b0001011 $| (0 << (7)) $| (1 << (7+5)) $| (1 << (7+5+1)) $| (0 << (7+5+2)) $| (11 << (7+5+3)) $| (12 << (7+5+3+5)) $| ((((~(~0 << 7) << 0) & 2) >> 0) << (7+5+3+5+5))\0A\09", "{x11},{x12}"(i64 ptrtoint (ptr @YI0 to i64), i64 17592186060800) #5, !srcloc !12
  call void asm sideeffect ".word 0b0001011 $| (0 << (7)) $| (1 << (7+5)) $| (1 << (7+5+1)) $| (0 << (7+5+2)) $| (11 << (7+5+3)) $| (12 << (7+5+3+5)) $| ((((~(~0 << 7) << 0) & 2) >> 0) << (7+5+3+5+5))\0A\09", "{x11},{x12}"(i64 ptrtoint (ptr @YR1 to i64), i64 17592186159104) #5, !srcloc !12
  call void asm sideeffect ".word 0b0001011 $| (0 << (7)) $| (1 << (7+5)) $| (1 << (7+5+1)) $| (0 << (7+5+2)) $| (11 << (7+5+3)) $| (12 << (7+5+3+5)) $| ((((~(~0 << 7) << 0) & 2) >> 0) << (7+5+3+5+5))\0A\09", "{x11},{x12}"(i64 ptrtoint (ptr @YI1 to i64), i64 17592186093568) #5, !srcloc !12
  call void asm sideeffect ".word 0b0001011 $| (0 << (7)) $| (1 << (7+5)) $| (1 << (7+5+1)) $| (0 << (7+5+2)) $| (11 << (7+5+3)) $| (12 << (7+5+3+5)) $| ((((~(~0 << 7) << 0) & 2) >> 0) << (7+5+3+5+5))\0A\09", "{x11},{x12}"(i64 ptrtoint (ptr @YR2 to i64), i64 17592186134528) #5, !srcloc !12
  call void asm sideeffect ".word 0b0001011 $| (0 << (7)) $| (1 << (7+5)) $| (1 << (7+5+1)) $| (0 << (7+5+2)) $| (11 << (7+5+3)) $| (12 << (7+5+3+5)) $| ((((~(~0 << 7) << 0) & 2) >> 0) << (7+5+3+5+5))\0A\09", "{x11},{x12}"(i64 ptrtoint (ptr @YI2 to i64), i64 17592186101760) #5, !srcloc !12
  call void asm sideeffect ".word 0b0001011 $| (0 << (7)) $| (1 << (7+5)) $| (1 << (7+5+1)) $| (0 << (7+5+2)) $| (11 << (7+5+3)) $| (12 << (7+5+3+5)) $| ((((~(~0 << 7) << 0) & 2) >> 0) << (7+5+3+5+5))\0A\09", "{x11},{x12}"(i64 ptrtoint (ptr @YR3 to i64), i64 17592186068992) #5, !srcloc !12
  call void asm sideeffect ".word 0b0001011 $| (0 << (7)) $| (1 << (7+5)) $| (1 << (7+5+1)) $| (0 << (7+5+2)) $| (11 << (7+5+3)) $| (12 << (7+5+3+5)) $| ((((~(~0 << 7) << 0) & 2) >> 0) << (7+5+3+5+5))\0A\09", "{x11},{x12}"(i64 ptrtoint (ptr @YI3 to i64), i64 17592186167296) #5, !srcloc !12
  call void @llvm.lifetime.end.p0(i64 624, ptr nonnull %cin.i) #5
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %result)
  %12 = call i64 asm sideeffect ".word 0b0001011 $| (10 << (7)) $| (0 << (7+5)) $| (0 << (7+5+1)) $| (1 << (7+5+2)) $| (0 << (7+5+3)) $| (0 << (7+5+3+5)) $| ((((~(~0 << 7) << 0) & 0) >> 0) << (7+5+3+5+5))\0A\09", "={x10}"() #5, !srcloc !22
  %cmp.i = icmp eq i64 %12, 1
  %conv.i = zext i1 %cmp.i to i32
  store volatile i32 %conv.i, ptr %result, align 4, !tbaa !13
  %13 = call i64 asm sideeffect "csrr $0, cycle", "=r"() #5, !srcloc !23
  br label %for.body.i15

for.body.i15:                                     ; preds = %for.inc.i, %init_array.exit
  %indvars.iv.i12 = phi i64 [ 0, %init_array.exit ], [ %indvars.iv.next.i19, %for.inc.i ]
  %arrayidx.i13 = getelementptr inbounds [1024 x i32], ptr @ZR0, i64 0, i64 %indvars.iv.i12
  %14 = load i32, ptr %arrayidx.i13, align 4, !tbaa !13
  %arrayidx2.i14 = getelementptr inbounds [1024 x i32], ptr @YR0, i64 0, i64 %indvars.iv.i12
  %15 = load i32, ptr %arrayidx2.i14, align 4, !tbaa !13
  %cmp3.not.i = icmp eq i32 %14, %15
  br i1 %cmp3.not.i, label %lor.lhs.false.i, label %if.then.i

lor.lhs.false.i:                                  ; preds = %for.body.i15
  %arrayidx5.i16 = getelementptr inbounds [1024 x i32], ptr @ZI0, i64 0, i64 %indvars.iv.i12
  %16 = load i32, ptr %arrayidx5.i16, align 4, !tbaa !13
  %arrayidx7.i = getelementptr inbounds [1024 x i32], ptr @YI0, i64 0, i64 %indvars.iv.i12
  %17 = load i32, ptr %arrayidx7.i, align 4, !tbaa !13
  %cmp8.not.i = icmp eq i32 %16, %17
  br i1 %cmp8.not.i, label %lor.lhs.false9.i, label %if.then.i

lor.lhs.false9.i:                                 ; preds = %lor.lhs.false.i
  %arrayidx11.i17 = getelementptr inbounds [1024 x i32], ptr @ZR1, i64 0, i64 %indvars.iv.i12
  %18 = load i32, ptr %arrayidx11.i17, align 4, !tbaa !13
  %arrayidx13.i = getelementptr inbounds [1024 x i32], ptr @YR1, i64 0, i64 %indvars.iv.i12
  %19 = load i32, ptr %arrayidx13.i, align 4, !tbaa !13
  %cmp14.not.i = icmp eq i32 %18, %19
  br i1 %cmp14.not.i, label %lor.lhs.false15.i, label %if.then.i

lor.lhs.false15.i:                                ; preds = %lor.lhs.false9.i
  %arrayidx17.i18 = getelementptr inbounds [1024 x i32], ptr @ZI1, i64 0, i64 %indvars.iv.i12
  %20 = load i32, ptr %arrayidx17.i18, align 4, !tbaa !13
  %arrayidx19.i = getelementptr inbounds [1024 x i32], ptr @YI1, i64 0, i64 %indvars.iv.i12
  %21 = load i32, ptr %arrayidx19.i, align 4, !tbaa !13
  %cmp20.not.i = icmp eq i32 %20, %21
  br i1 %cmp20.not.i, label %lor.lhs.false21.i, label %if.then.i

lor.lhs.false21.i:                                ; preds = %lor.lhs.false15.i
  %arrayidx23.i = getelementptr inbounds [1024 x i32], ptr @ZR2, i64 0, i64 %indvars.iv.i12
  %22 = load i32, ptr %arrayidx23.i, align 4, !tbaa !13
  %arrayidx25.i = getelementptr inbounds [1024 x i32], ptr @YR2, i64 0, i64 %indvars.iv.i12
  %23 = load i32, ptr %arrayidx25.i, align 4, !tbaa !13
  %cmp26.not.i = icmp eq i32 %22, %23
  br i1 %cmp26.not.i, label %lor.lhs.false27.i, label %if.then.i

lor.lhs.false27.i:                                ; preds = %lor.lhs.false21.i
  %arrayidx29.i = getelementptr inbounds [1024 x i32], ptr @ZI2, i64 0, i64 %indvars.iv.i12
  %24 = load i32, ptr %arrayidx29.i, align 4, !tbaa !13
  %arrayidx31.i = getelementptr inbounds [1024 x i32], ptr @YI2, i64 0, i64 %indvars.iv.i12
  %25 = load i32, ptr %arrayidx31.i, align 4, !tbaa !13
  %cmp32.not.i = icmp eq i32 %24, %25
  br i1 %cmp32.not.i, label %lor.lhs.false33.i, label %if.then.i

lor.lhs.false33.i:                                ; preds = %lor.lhs.false27.i
  %arrayidx35.i = getelementptr inbounds [1024 x i32], ptr @ZR3, i64 0, i64 %indvars.iv.i12
  %26 = load i32, ptr %arrayidx35.i, align 4, !tbaa !13
  %arrayidx37.i = getelementptr inbounds [1024 x i32], ptr @YR3, i64 0, i64 %indvars.iv.i12
  %27 = load i32, ptr %arrayidx37.i, align 4, !tbaa !13
  %cmp38.not.i = icmp eq i32 %26, %27
  br i1 %cmp38.not.i, label %lor.lhs.false39.i, label %if.then.i

lor.lhs.false39.i:                                ; preds = %lor.lhs.false33.i
  %arrayidx41.i = getelementptr inbounds [1024 x i32], ptr @ZI3, i64 0, i64 %indvars.iv.i12
  %28 = load i32, ptr %arrayidx41.i, align 4, !tbaa !13
  %arrayidx43.i = getelementptr inbounds [1024 x i32], ptr @YI3, i64 0, i64 %indvars.iv.i12
  %29 = load i32, ptr %arrayidx43.i, align 4, !tbaa !13
  %cmp44.not.i = icmp eq i32 %28, %29
  br i1 %cmp44.not.i, label %for.inc.i, label %if.then.i

if.then.i:                                        ; preds = %lor.lhs.false39.i, %lor.lhs.false33.i, %lor.lhs.false27.i, %lor.lhs.false21.i, %lor.lhs.false15.i, %lor.lhs.false9.i, %lor.lhs.false.i, %for.body.i15
  %30 = trunc i64 %indvars.iv.i12 to i32
  %call.i = call signext i32 (ptr, ...) @printf(ptr noundef nonnull @.str, i32 noundef signext %30, i32 noundef signext %14, i32 noundef signext %15) #7
  br label %for.inc.i

for.inc.i:                                        ; preds = %if.then.i, %lor.lhs.false39.i
  %indvars.iv.next.i19 = add nuw nsw i64 %indvars.iv.i12, 1
  %exitcond.not.i20 = icmp eq i64 %indvars.iv.next.i19, 1024
  br i1 %exitcond.not.i20, label %result_check.exit, label %for.body.i15, !llvm.loop !24

result_check.exit:                                ; preds = %for.inc.i
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %result)
  ret i32 0
}

declare dso_local signext i32 @printf(ptr noundef, ...) local_unnamed_addr #4

attributes #0 = { nounwind "frame-pointer"="none" "min-legal-vector-width"="0" "no-builtin-printf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-features"="+64bit,+a,+c,+m,+relax,-save-restore" }
attributes #1 = { argmemonly mustprogress nocallback nofree nosync nounwind willreturn }
attributes #2 = { argmemonly mustprogress nocallback nofree nounwind willreturn }
attributes #3 = { nofree noinline norecurse nosync nounwind "frame-pointer"="none" "min-legal-vector-width"="0" "no-builtin-printf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-features"="+64bit,+a,+c,+m,+relax,-save-restore" }
attributes #4 = { "frame-pointer"="none" "no-builtin-printf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-features"="+64bit,+a,+c,+m,+relax,-save-restore" }
attributes #5 = { nounwind }
attributes #6 = { "no-builtin-printf" }
attributes #7 = { nobuiltin nounwind "no-builtin-printf" }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 1, !"target-abi", !"lp64"}
!2 = !{i32 1, !"SmallDataLimit", i32 8}
!3 = !{!"clang version 16.0.0"}
!4 = !{i64 2147878825, i64 2147878887}
!5 = !{!6, !6, i64 0}
!6 = !{!"any pointer", !7, i64 0}
!7 = !{!"omnipotent char", !8, i64 0}
!8 = !{!"Simple C/C++ TBAA"}
!9 = !{i64 2147880378, i64 2147880440}
!10 = !{i64 2147883467, i64 2147883529}
!11 = !{i64 2147884986, i64 2147885048}
!12 = !{i64 2147881931, i64 2147881993}
!13 = !{!14, !14, i64 0}
!14 = !{!"int", !7, i64 0}
!15 = distinct !{!15, !16, !17}
!16 = !{!"llvm.loop.mustprogress"}
!17 = !{!"llvm.loop.unroll.disable"}
!18 = distinct !{!18, !16, !17}
!19 = !{i64 2147892756}
!20 = !{i64 2147892869}
!21 = !{i64 2147892982}
!22 = !{i64 2147886425, i64 2147886485}
!23 = !{i64 2147893095}
!24 = distinct !{!24, !16, !17}

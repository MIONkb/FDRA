; ModuleID = 'kernel.c'
source_filename = "kernel.c"
target datalayout = "e-m:e-p:32:32-p270:32:32-p271:32:32-p272:64:64-f64:32:64-f80:32-n8:16:32-S128"
target triple = "i386-unknown-linux-gnu"

@coefficients = dso_local local_unnamed_addr global [32 x i32] [i32 21, i32 150, i32 375, i32 -225, i32 40, i32 61, i32 -300, i32 125, i32 21, i32 150, i32 375, i32 -225, i32 40, i32 61, i32 -300, i32 125, i32 21, i32 150, i32 375, i32 -225, i32 40, i32 61, i32 -300, i32 125, i32 21, i32 150, i32 375, i32 -225, i32 40, i32 61, i32 -300, i32 125], align 4
@input = dso_local local_unnamed_addr global [32 x i32] zeroinitializer, align 4
@output = dso_local local_unnamed_addr global [32 x i32] zeroinitializer, align 4

; Function Attrs: nounwind uwtable
define dso_local i32 @main() local_unnamed_addr #0 {
entry:
  tail call void @kernel()
  ret i32 0
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @kernel() local_unnamed_addr #1 {
entry:
  br label %for.cond1.preheader

for.cond1.preheader:                              ; preds = %entry, %for.end
  %j.018 = phi i32 [ 0, %entry ], [ %inc8, %for.end ]
  br label %for.body3

for.body3:                                        ; preds = %for.body3, %for.cond1.preheader
  %sum.017 = phi i32 [ 0, %for.cond1.preheader ], [ %add.3, %for.body3 ]
  %i.016 = phi i32 [ 0, %for.cond1.preheader ], [ %inc.3, %for.body3 ]
  tail call void @please_map_me() #3
  %arrayidx = getelementptr inbounds [32 x i32], ptr @input, i32 0, i32 %i.016
  %0 = load i32, ptr %arrayidx, align 4, !tbaa !6
  %arrayidx4 = getelementptr inbounds [32 x i32], ptr @coefficients, i32 0, i32 %i.016
  %1 = load i32, ptr %arrayidx4, align 4, !tbaa !6
  %mul = mul nsw i32 %1, %0
  %add = add nsw i32 %mul, %sum.017
  %inc = or i32 %i.016, 1
  tail call void @please_map_me() #3
  %arrayidx.1 = getelementptr inbounds [32 x i32], ptr @input, i32 0, i32 %inc
  %2 = load i32, ptr %arrayidx.1, align 4, !tbaa !6
  %arrayidx4.1 = getelementptr inbounds [32 x i32], ptr @coefficients, i32 0, i32 %inc
  %3 = load i32, ptr %arrayidx4.1, align 4, !tbaa !6
  %mul.1 = mul nsw i32 %3, %2
  %add.1 = add nsw i32 %mul.1, %add
  %inc.1 = or i32 %i.016, 2
  tail call void @please_map_me() #3
  %arrayidx.2 = getelementptr inbounds [32 x i32], ptr @input, i32 0, i32 %inc.1
  %4 = load i32, ptr %arrayidx.2, align 4, !tbaa !6
  %arrayidx4.2 = getelementptr inbounds [32 x i32], ptr @coefficients, i32 0, i32 %inc.1
  %5 = load i32, ptr %arrayidx4.2, align 4, !tbaa !6
  %mul.2 = mul nsw i32 %5, %4
  %add.2 = add nsw i32 %mul.2, %add.1
  %inc.2 = or i32 %i.016, 3
  tail call void @please_map_me() #3
  %arrayidx.3 = getelementptr inbounds [32 x i32], ptr @input, i32 0, i32 %inc.2
  %6 = load i32, ptr %arrayidx.3, align 4, !tbaa !6
  %arrayidx4.3 = getelementptr inbounds [32 x i32], ptr @coefficients, i32 0, i32 %inc.2
  %7 = load i32, ptr %arrayidx4.3, align 4, !tbaa !6
  %mul.3 = mul nsw i32 %7, %6
  %add.3 = add nsw i32 %mul.3, %add.2
  %inc.3 = add nuw nsw i32 %i.016, 4
  %exitcond.3.not = icmp eq i32 %inc.3, 32
  br i1 %exitcond.3.not, label %for.end, label %for.body3, !llvm.loop !10

for.end:                                          ; preds = %for.body3
  %arrayidx5 = getelementptr inbounds [32 x i32], ptr @output, i32 0, i32 %j.018
  %8 = load i32, ptr %arrayidx5, align 4, !tbaa !6
  %add6 = add nsw i32 %8, %add.3
  store i32 %add6, ptr %arrayidx5, align 4, !tbaa !6
  %inc8 = add nuw nsw i32 %j.018, 1
  %exitcond.not = icmp eq i32 %inc8, 32
  br i1 %exitcond.not, label %for.end9, label %for.cond1.preheader, !llvm.loop !13

for.end9:                                         ; preds = %for.end
  ret void
}

declare void @please_map_me(...) local_unnamed_addr #2

attributes #0 = { nounwind uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="pentium4" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { noinline nounwind uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="pentium4" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="pentium4" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"NumRegisterParameters", i32 0}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"PIE Level", i32 2}
!4 = !{i32 7, !"uwtable", i32 2}
!5 = !{!"clang version 16.0.0"}
!6 = !{!7, !7, i64 0}
!7 = !{!"int", !8, i64 0}
!8 = !{!"omnipotent char", !9, i64 0}
!9 = !{!"Simple C/C++ TBAA"}
!10 = distinct !{!10, !11, !12}
!11 = !{!"llvm.loop.mustprogress"}
!12 = !{!"llvm.loop.unroll.disable"}
!13 = distinct !{!13, !11, !12}

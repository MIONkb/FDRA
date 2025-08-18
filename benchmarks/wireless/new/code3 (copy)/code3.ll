; ModuleID = 'code3.c'
source_filename = "code3.c"
target datalayout = "e-m:e-p:32:32-p270:32:32-p271:32:32-p272:64:64-f64:32:64-f80:32-n8:16:32-S128"
target triple = "i386-unknown-linux-gnu"

@Input1 = dso_local local_unnamed_addr global [16 x i32] [i32 4369, i32 8738, i32 13107, i32 17476, i32 21845, i32 26214, i32 30583, i32 34952, i32 39321, i32 43690, i32 48059, i32 52428, i32 56797, i32 61166, i32 65535, i32 26214], align 4
@Input0 = dso_local local_unnamed_addr global [1 x i32] [i32 6939], align 4
@Output0 = dso_local local_unnamed_addr global [16 x i32] zeroinitializer, align 4
@Output1 = dso_local local_unnamed_addr global [16 x i32] zeroinitializer, align 4
@Output2 = dso_local local_unnamed_addr global [16 x i32] zeroinitializer, align 4
@Output3 = dso_local local_unnamed_addr global [16 x i32] zeroinitializer, align 4
@.str = private unnamed_addr constant [4 x i8] c"%x \00", align 1

; Function Attrs: nounwind
define dso_local i32 @kernel(i32 %Gran_selection) local_unnamed_addr #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %if.end20, %entry
  %type_shift.0111 = phi i32 [ 0, %entry ], [ %add, %if.end20 ]
  %i.0109 = phi i32 [ 0, %entry ], [ %inc, %if.end20 ]
  %outidx0.0108 = phi i32 [ 0, %entry ], [ %outidx0.1, %if.end20 ]
  %outidx1.0107 = phi i32 [ 0, %entry ], [ %outidx1.1, %if.end20 ]
  %call = call i32 bitcast (i32 (...)* @please_map_me to i32 ()*)() #4
  %0 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @Input0, i32 0, i32 0), align 4, !tbaa !3
  %shr = lshr i32 %0, %type_shift.0111
  %and = and i32 %shr, 3
  %add = add nuw nsw i32 %type_shift.0111, 2
  switch i32 %and, label %if.end20 [
    i32 0, label %if.then
    i32 1, label %if.then10
  ]

if.then:                                          ; preds = %for.body
  %mul = shl nuw nsw i32 %i.0109, 1
  %arrayidx = getelementptr inbounds [16 x i32], [16 x i32]* @Input1, i32 0, i32 %mul
  %1 = load i32, i32* %arrayidx, align 4, !tbaa !3
  %arrayidx2 = getelementptr inbounds [16 x i32], [16 x i32]* @Output0, i32 0, i32 %outidx0.0108
  store i32 %1, i32* %arrayidx2, align 4, !tbaa !3
  %add3 = add nsw i32 %outidx0.0108, 1
  %add5 = or i32 %mul, 1
  %arrayidx6 = getelementptr inbounds [16 x i32], [16 x i32]* @Input1, i32 0, i32 %add5
  %2 = load i32, i32* %arrayidx6, align 4, !tbaa !3
  %arrayidx7 = getelementptr inbounds [16 x i32], [16 x i32]* @Output0, i32 0, i32 %add3
  store i32 %2, i32* %arrayidx7, align 4, !tbaa !3
  %add8 = add nsw i32 %outidx0.0108, 2
  br label %if.end20

if.then10:                                        ; preds = %for.body
  %mul11 = shl nuw nsw i32 %i.0109, 1
  %arrayidx12 = getelementptr inbounds [16 x i32], [16 x i32]* @Input1, i32 0, i32 %mul11
  %3 = load i32, i32* %arrayidx12, align 4, !tbaa !3
  %arrayidx13 = getelementptr inbounds [16 x i32], [16 x i32]* @Output1, i32 0, i32 %outidx1.0107
  store i32 %3, i32* %arrayidx13, align 4, !tbaa !3
  %add14 = add nsw i32 %outidx1.0107, 1
  %add16 = or i32 %mul11, 1
  %arrayidx17 = getelementptr inbounds [16 x i32], [16 x i32]* @Input1, i32 0, i32 %add16
  %4 = load i32, i32* %arrayidx17, align 4, !tbaa !3
  %arrayidx18 = getelementptr inbounds [16 x i32], [16 x i32]* @Output1, i32 0, i32 %add14
  store i32 %4, i32* %arrayidx18, align 4, !tbaa !3
  %add19 = add nsw i32 %outidx1.0107, 2
  br label %if.end20

if.end20:                                         ; preds = %for.body, %if.then10, %if.then
  %outidx1.1 = phi i32 [ %outidx1.0107, %if.then ], [ %add19, %if.then10 ], [ %outidx1.0107, %for.body ]
  %outidx0.1 = phi i32 [ %add8, %if.then ], [ %outidx0.0108, %if.then10 ], [ %outidx0.0108, %for.body ]
  %inc = add nuw nsw i32 %i.0109, 1
  %exitcond115 = icmp eq i32 %inc, 16
  br i1 %exitcond115, label %for.body25, label %for.body

for.cond.cleanup24:                               ; preds = %for.body25
  %putchar = call i32 @putchar(i32 10)
  br label %for.body36

for.body25:                                       ; preds = %if.end20, %for.body25
  %i21.0106 = phi i32 [ %inc29, %for.body25 ], [ 0, %if.end20 ]
  %arrayidx26 = getelementptr inbounds [16 x i32], [16 x i32]* @Output0, i32 0, i32 %i21.0106
  %5 = load i32, i32* %arrayidx26, align 4, !tbaa !3
  %call27 = call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i32 0, i32 0), i32 %5)
  %inc29 = add nuw nsw i32 %i21.0106, 1
  %exitcond114 = icmp eq i32 %inc29, 16
  br i1 %exitcond114, label %for.cond.cleanup24, label %for.body25

for.cond.cleanup35:                               ; preds = %for.body36
  %putchar100 = call i32 @putchar(i32 10)
  br label %for.body47

for.body36:                                       ; preds = %for.body36, %for.cond.cleanup24
  %i32.0105 = phi i32 [ 0, %for.cond.cleanup24 ], [ %inc40, %for.body36 ]
  %arrayidx37 = getelementptr inbounds [16 x i32], [16 x i32]* @Output1, i32 0, i32 %i32.0105
  %6 = load i32, i32* %arrayidx37, align 4, !tbaa !3
  %call38 = call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i32 0, i32 0), i32 %6)
  %inc40 = add nuw nsw i32 %i32.0105, 1
  %exitcond113 = icmp eq i32 %inc40, 16
  br i1 %exitcond113, label %for.cond.cleanup35, label %for.body36

for.cond.cleanup46:                               ; preds = %for.body47
  %putchar101 = call i32 @putchar(i32 10)
  br label %for.body58

for.body47:                                       ; preds = %for.body47, %for.cond.cleanup35
  %i43.0104 = phi i32 [ 0, %for.cond.cleanup35 ], [ %inc51, %for.body47 ]
  %arrayidx48 = getelementptr inbounds [16 x i32], [16 x i32]* @Output2, i32 0, i32 %i43.0104
  %7 = load i32, i32* %arrayidx48, align 4, !tbaa !3
  %call49 = call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i32 0, i32 0), i32 %7)
  %inc51 = add nuw nsw i32 %i43.0104, 1
  %exitcond112 = icmp eq i32 %inc51, 16
  br i1 %exitcond112, label %for.cond.cleanup46, label %for.body47

for.cond.cleanup57:                               ; preds = %for.body58
  %putchar102 = call i32 @putchar(i32 10)
  ret i32 0

for.body58:                                       ; preds = %for.body58, %for.cond.cleanup46
  %i54.0103 = phi i32 [ 0, %for.cond.cleanup46 ], [ %inc62, %for.body58 ]
  %arrayidx59 = getelementptr inbounds [16 x i32], [16 x i32]* @Output3, i32 0, i32 %i54.0103
  %8 = load i32, i32* %arrayidx59, align 4, !tbaa !3
  %call60 = call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i32 0, i32 0), i32 %8)
  %inc62 = add nuw nsw i32 %i54.0103, 1
  %exitcond = icmp eq i32 %inc62, 16
  br i1 %exitcond, label %for.cond.cleanup57, label %for.body58
}

declare dso_local i32 @please_map_me(...) local_unnamed_addr #1

; Function Attrs: nofree nounwind
declare dso_local i32 @printf(i8* nocapture readonly, ...) local_unnamed_addr #2

; Function Attrs: nofree nounwind
declare i32 @putchar(i32) local_unnamed_addr #3

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="pentium4" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="pentium4" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nofree nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="pentium4" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nofree nounwind }
attributes #4 = { nounwind }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"NumRegisterParameters", i32 0}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{!"clang version 10.0.0 "}
!3 = !{!4, !4, i64 0}
!4 = !{!"int", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C/C++ TBAA"}

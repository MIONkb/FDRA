; ModuleID = 'Nokernel.c'
source_filename = "Nokernel.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n64-S128"
target triple = "riscv64-unknown-unknown-elf"

@.str = private unnamed_addr constant [13 x i8] c"I am stupid\0A\00", align 1

; Function Attrs: nounwind
define dso_local signext i32 @main(i32 noundef signext %argc, ptr nocapture noundef readnone %argv) local_unnamed_addr #0 {
entry:
  %call = tail call signext i32 (ptr, ...) @printf(ptr noundef nonnull @.str) #2
  ret i32 0
}

declare dso_local signext i32 @printf(ptr noundef, ...) local_unnamed_addr #1

attributes #0 = { nounwind "frame-pointer"="none" "min-legal-vector-width"="0" "no-builtin-printf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-features"="+64bit,+a,+c,+m,+relax,-save-restore" }
attributes #1 = { "frame-pointer"="none" "no-builtin-printf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-features"="+64bit,+a,+c,+m,+relax,-save-restore" }
attributes #2 = { nobuiltin nounwind "no-builtin-printf" }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 1, !"target-abi", !"lp64"}
!2 = !{i32 1, !"SmallDataLimit", i32 8}
!3 = !{!"clang version 16.0.0"}

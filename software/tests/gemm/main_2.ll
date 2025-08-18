; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target triple = "x86_64-unknown-linux-gnu"

; @prod = global [1024 x i32] zeroinitializer
; @m2 = global [1024 x i32] zeroinitializer
; @m1 = global [1024 x i32] zeroinitializer

declare ptr @malloc(i64)

declare void @free(ptr)

define void @main() !dbg !3 {
  call void @cgra_execute(), !dbg !7
  ret void, !dbg !9
}

declare void @cgra_execute()

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2}

!0 = distinct !DICompileUnit(language: DW_LANG_C, file: !1, producer: "mlir", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug)
!1 = !DIFile(filename: "LLVMDialectModule", directory: "/")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = distinct !DISubprogram(name: "gemm", linkageName: "gemm", scope: null, file: !4, line: 14, type: !5, scopeLine: 14, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !6)
!4 = !DIFile(filename: "3_gemm_outlined_funcall_llvm.mlir", directory: "/home/tianyi/MLIRCGRA/CGRA-Flow/mlir-cgra/experiments/LJHtest/gemm_new")
!5 = !DISubroutineType(types: !6)
!6 = !{}
!7 = !DILocation(line: 63, column: 5, scope: !8)
!8 = !DILexicalBlockFile(scope: !3, file: !4, discriminator: 0)
!9 = !DILocation(line: 64, column: 5, scope: !8)

; ModuleID = 'test.ll'
source_filename = "test.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @foo(i32 %0) #0 {
  %2 = alloca i32, align 4
  store i32 -65536, i32* %2, align 4
  %3 = bitcast i32* %2 to i16*
  %4 = getelementptr inbounds i16, i16* %3, i64 2
  %5 = icmp sgt i32 %0, 3
  br i1 %5, label %6, label %7

6:                                                ; preds = %1
  store i16 0, i16* %3, align 2
  br label %8

7:                                                ; preds = %1
  store i16 -1, i16* %4, align 2
  br label %8

8:                                                ; preds = %7, %6
  %.0 = phi i32 [ 12, %6 ], [ 7, %7 ]
  %9 = load i32, i32* %2, align 4
  %10 = add nsw i32 %9, %.0
  ret i32 %10
}

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 1}
!2 = !{i32 7, !"frame-pointer", i32 2}
!3 = !{!"clang version 13.0.0 (https://github.com/llvm/llvm-project/ 24c8eaec9467b2aaf70b0db33a4e4dd415139a50)"}

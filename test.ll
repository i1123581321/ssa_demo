; ModuleID = 'test.c'
source_filename = "test.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @foo(i32 %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i16*, align 8
  %5 = alloca i16*, align 8
  %6 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  store i32 -65536, i32* %3, align 4
  %7 = bitcast i32* %3 to i16*
  store i16* %7, i16** %4, align 8
  %8 = load i16*, i16** %4, align 8
  %9 = getelementptr inbounds i16, i16* %8, i64 2
  store i16* %9, i16** %5, align 8
  store i32 14, i32* %6, align 4
  %10 = load i32, i32* %2, align 4
  %11 = icmp sgt i32 %10, 3
  br i1 %11, label %12, label %14

12:                                               ; preds = %1
  %13 = load i16*, i16** %4, align 8
  store i16 0, i16* %13, align 2
  store i32 12, i32* %6, align 4
  br label %16

14:                                               ; preds = %1
  %15 = load i16*, i16** %5, align 8
  store i16 -1, i16* %15, align 2
  store i32 7, i32* %6, align 4
  br label %16

16:                                               ; preds = %14, %12
  %17 = load i32, i32* %3, align 4
  %18 = load i32, i32* %6, align 4
  %19 = add nsw i32 %17, %18
  ret i32 %19
}

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 1}
!2 = !{i32 7, !"frame-pointer", i32 2}
!3 = !{!"clang version 13.0.0 (https://github.com/llvm/llvm-project/ 24c8eaec9467b2aaf70b0db33a4e4dd415139a50)"}

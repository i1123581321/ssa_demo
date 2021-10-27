# 软件分析测试课堂作业

MG21330045 钱正轩

要求实现不能完全转换为 SSA 的代码。选择使用 c 代码，利用 clang 前端和 llvm opt 进行 ssa 的转换，先将 c 代码转换为 llvm IR

```bash
clang -Xclang -disable-O0-optnone -O0 -emit-llvm -S test.c
```

然后将 IR 转换为 SSA 形式

```bash
opt -O0 -S -mem2reg test.ll -o m2r.ll
```

原始 C 代码为

```c
int foo(int cond){
    int x = 0xffff0000;
    short* p1 = (short*)&x;
    short* p2 = p1 + 2;
    int y = 14;
    if (cond > 3){
        *p1 = 0x0000;
        y = 12;
    } else {
        *p2 = 0xffff;
        y = 7;
    }
    return x + y;
}
```

转换为 SSA

```
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
```

可以看出变量 y 被转换成了 SSA 代码，在跳转结束后使用 phi 函数求值，而变量 x 因为有两个指针指向其不同部分，无法做到赋值后内存内容不变，故仍使用 alloca/store/load 的方式被操作
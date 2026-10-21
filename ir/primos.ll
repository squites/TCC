; ModuleID = 'benchmarks/primos.c'
source_filename = "benchmarks/primos.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@primos = global [100000 x i32] zeroinitializer, align 4
@.str = private unnamed_addr constant [21 x i8] c"Total de primos: %d\0A\00", align 1

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @eh_primo(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  %5 = load i32, ptr %3, align 4
  %6 = icmp slt i32 %5, 2
  br i1 %6, label %7, label %8

7:                                                ; preds = %1
  store i32 0, ptr %2, align 4
  br label %26

8:                                                ; preds = %1
  store i32 2, ptr %4, align 4
  br label %9

9:                                                ; preds = %22, %8
  %10 = load i32, ptr %4, align 4
  %11 = load i32, ptr %4, align 4
  %12 = mul nsw i32 %10, %11
  %13 = load i32, ptr %3, align 4
  %14 = icmp sle i32 %12, %13
  br i1 %14, label %15, label %25

15:                                               ; preds = %9
  %16 = load i32, ptr %3, align 4
  %17 = load i32, ptr %4, align 4
  %18 = srem i32 %16, %17
  %19 = icmp eq i32 %18, 0
  br i1 %19, label %20, label %21

20:                                               ; preds = %15
  store i32 0, ptr %2, align 4
  br label %26

21:                                               ; preds = %15
  br label %22

22:                                               ; preds = %21
  %23 = load i32, ptr %4, align 4
  %24 = add nsw i32 %23, 1
  store i32 %24, ptr %4, align 4
  br label %9, !llvm.loop !6

25:                                               ; preds = %9
  store i32 1, ptr %2, align 4
  br label %26

26:                                               ; preds = %25, %20, %7
  %27 = load i32, ptr %2, align 4
  ret i32 %27
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i32 0, ptr %2, align 4
  store i32 2, ptr %3, align 4
  br label %4

4:                                                ; preds = %18, %0
  %5 = load i32, ptr %3, align 4
  %6 = icmp slt i32 %5, 100000
  br i1 %6, label %7, label %21

7:                                                ; preds = %4
  %8 = load i32, ptr %3, align 4
  %9 = call i32 @eh_primo(i32 noundef %8)
  %10 = icmp ne i32 %9, 0
  br i1 %10, label %11, label %17

11:                                               ; preds = %7
  %12 = load i32, ptr %3, align 4
  %13 = load i32, ptr %2, align 4
  %14 = add nsw i32 %13, 1
  store i32 %14, ptr %2, align 4
  %15 = sext i32 %13 to i64
  %16 = getelementptr inbounds [100000 x i32], ptr @primos, i64 0, i64 %15
  store i32 %12, ptr %16, align 4
  br label %17

17:                                               ; preds = %11, %7
  br label %18

18:                                               ; preds = %17
  %19 = load i32, ptr %3, align 4
  %20 = add nsw i32 %19, 1
  store i32 %20, ptr %3, align 4
  br label %4, !llvm.loop !8

21:                                               ; preds = %4
  %22 = load i32, ptr %2, align 4
  %23 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %22)
  ret i32 0
}

declare i32 @printf(ptr noundef, ...) #1

attributes #0 = { noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 15, i32 5]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 4}
!5 = !{!"Homebrew clang version 22.1.0"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}

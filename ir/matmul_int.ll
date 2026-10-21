; ModuleID = 'matmul/mm_int.c'
source_filename = "matmul/mm_int.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@A = global [1024 x [1024 x i32]] zeroinitializer, align 4
@B = global [1024 x [1024 x i32]] zeroinitializer, align 4
@C = global [1024 x [1024 x i32]] zeroinitializer, align 4
@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

; Function Attrs: noinline nounwind ssp uwtable(sync)
define void @init() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  br label %3

3:                                                ; preds = %39, %0
  %4 = load i32, ptr %1, align 4
  %5 = icmp slt i32 %4, 1024
  br i1 %5, label %6, label %42

6:                                                ; preds = %3
  store i32 0, ptr %2, align 4
  br label %7

7:                                                ; preds = %35, %6
  %8 = load i32, ptr %2, align 4
  %9 = icmp slt i32 %8, 1024
  br i1 %9, label %10, label %38

10:                                               ; preds = %7
  %11 = load i32, ptr %1, align 4
  %12 = load i32, ptr %2, align 4
  %13 = add nsw i32 %11, %12
  %14 = load i32, ptr %1, align 4
  %15 = sext i32 %14 to i64
  %16 = getelementptr inbounds [1024 x [1024 x i32]], ptr @A, i64 0, i64 %15
  %17 = load i32, ptr %2, align 4
  %18 = sext i32 %17 to i64
  %19 = getelementptr inbounds [1024 x i32], ptr %16, i64 0, i64 %18
  store i32 %13, ptr %19, align 4
  %20 = load i32, ptr %1, align 4
  %21 = load i32, ptr %2, align 4
  %22 = sub nsw i32 %20, %21
  %23 = load i32, ptr %1, align 4
  %24 = sext i32 %23 to i64
  %25 = getelementptr inbounds [1024 x [1024 x i32]], ptr @B, i64 0, i64 %24
  %26 = load i32, ptr %2, align 4
  %27 = sext i32 %26 to i64
  %28 = getelementptr inbounds [1024 x i32], ptr %25, i64 0, i64 %27
  store i32 %22, ptr %28, align 4
  %29 = load i32, ptr %1, align 4
  %30 = sext i32 %29 to i64
  %31 = getelementptr inbounds [1024 x [1024 x i32]], ptr @C, i64 0, i64 %30
  %32 = load i32, ptr %2, align 4
  %33 = sext i32 %32 to i64
  %34 = getelementptr inbounds [1024 x i32], ptr %31, i64 0, i64 %33
  store i32 0, ptr %34, align 4
  br label %35

35:                                               ; preds = %10
  %36 = load i32, ptr %2, align 4
  %37 = add nsw i32 %36, 1
  store i32 %37, ptr %2, align 4
  br label %7, !llvm.loop !5

38:                                               ; preds = %7
  br label %39

39:                                               ; preds = %38
  %40 = load i32, ptr %1, align 4
  %41 = add nsw i32 %40, 1
  store i32 %41, ptr %1, align 4
  br label %3, !llvm.loop !7

42:                                               ; preds = %3
  ret void
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define void @matmul() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  br label %4

4:                                                ; preds = %47, %0
  %5 = load i32, ptr %1, align 4
  %6 = icmp slt i32 %5, 1024
  br i1 %6, label %7, label %50

7:                                                ; preds = %4
  store i32 0, ptr %2, align 4
  br label %8

8:                                                ; preds = %43, %7
  %9 = load i32, ptr %2, align 4
  %10 = icmp slt i32 %9, 1024
  br i1 %10, label %11, label %46

11:                                               ; preds = %8
  store i32 0, ptr %3, align 4
  br label %12

12:                                               ; preds = %39, %11
  %13 = load i32, ptr %3, align 4
  %14 = icmp slt i32 %13, 1024
  br i1 %14, label %15, label %42

15:                                               ; preds = %12
  %16 = load i32, ptr %1, align 4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds [1024 x [1024 x i32]], ptr @A, i64 0, i64 %17
  %19 = load i32, ptr %3, align 4
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds [1024 x i32], ptr %18, i64 0, i64 %20
  %22 = load i32, ptr %21, align 4
  %23 = load i32, ptr %3, align 4
  %24 = sext i32 %23 to i64
  %25 = getelementptr inbounds [1024 x [1024 x i32]], ptr @B, i64 0, i64 %24
  %26 = load i32, ptr %2, align 4
  %27 = sext i32 %26 to i64
  %28 = getelementptr inbounds [1024 x i32], ptr %25, i64 0, i64 %27
  %29 = load i32, ptr %28, align 4
  %30 = mul nsw i32 %22, %29
  %31 = load i32, ptr %1, align 4
  %32 = sext i32 %31 to i64
  %33 = getelementptr inbounds [1024 x [1024 x i32]], ptr @C, i64 0, i64 %32
  %34 = load i32, ptr %2, align 4
  %35 = sext i32 %34 to i64
  %36 = getelementptr inbounds [1024 x i32], ptr %33, i64 0, i64 %35
  %37 = load i32, ptr %36, align 4
  %38 = add nsw i32 %37, %30
  store i32 %38, ptr %36, align 4
  br label %39

39:                                               ; preds = %15
  %40 = load i32, ptr %3, align 4
  %41 = add nsw i32 %40, 1
  store i32 %41, ptr %3, align 4
  br label %12, !llvm.loop !8

42:                                               ; preds = %12
  br label %43

43:                                               ; preds = %42
  %44 = load i32, ptr %2, align 4
  %45 = add nsw i32 %44, 1
  store i32 %45, ptr %2, align 4
  br label %8, !llvm.loop !9

46:                                               ; preds = %8
  br label %47

47:                                               ; preds = %46
  %48 = load i32, ptr %1, align 4
  %49 = add nsw i32 %48, 1
  store i32 %49, ptr %1, align 4
  br label %4, !llvm.loop !10

50:                                               ; preds = %4
  ret void
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @main() #0 {
  %1 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  call void @init()
  call void @matmul()
  %2 = load i32, ptr @C, align 4
  %3 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %2)
  ret i32 0
}

declare i32 @printf(ptr noundef, ...) #1

attributes #0 = { noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" "tune-cpu"="apple-m5" }
attributes #1 = { "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" "tune-cpu"="apple-m5" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 15, i32 5]}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 1}
!3 = !{i32 7, !"frame-pointer", i32 4}
!4 = !{!"clang version 23.0.0git (https://github.com/llvm/llvm-project.git 8b5b987cfa7bff5b46bd8b384a52347ab74f6e4c)"}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.mustprogress"}
!7 = distinct !{!7, !6}
!8 = distinct !{!8, !6}
!9 = distinct !{!9, !6}
!10 = distinct !{!10, !6}

; ModuleID = 'matmul/mm_float.c'
source_filename = "matmul/mm_float.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@A = global [1024 x [1024 x float]] zeroinitializer, align 4
@B = global [1024 x [1024 x float]] zeroinitializer, align 4
@C = global [1024 x [1024 x float]] zeroinitializer, align 4
@.str = private unnamed_addr constant [4 x i8] c"%f\0A\00", align 1

; Function Attrs: noinline nounwind ssp uwtable(sync)
define void @init() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  br label %3

3:                                                ; preds = %41, %0
  %4 = load i32, ptr %1, align 4
  %5 = icmp slt i32 %4, 1024
  br i1 %5, label %6, label %44

6:                                                ; preds = %3
  store i32 0, ptr %2, align 4
  br label %7

7:                                                ; preds = %37, %6
  %8 = load i32, ptr %2, align 4
  %9 = icmp slt i32 %8, 1024
  br i1 %9, label %10, label %40

10:                                               ; preds = %7
  %11 = load i32, ptr %1, align 4
  %12 = load i32, ptr %2, align 4
  %13 = add nsw i32 %11, %12
  %14 = sitofp i32 %13 to float
  %15 = load i32, ptr %1, align 4
  %16 = sext i32 %15 to i64
  %17 = getelementptr inbounds [1024 x [1024 x float]], ptr @A, i64 0, i64 %16
  %18 = load i32, ptr %2, align 4
  %19 = sext i32 %18 to i64
  %20 = getelementptr inbounds [1024 x float], ptr %17, i64 0, i64 %19
  store float %14, ptr %20, align 4
  %21 = load i32, ptr %1, align 4
  %22 = load i32, ptr %2, align 4
  %23 = sub nsw i32 %21, %22
  %24 = sitofp i32 %23 to float
  %25 = load i32, ptr %1, align 4
  %26 = sext i32 %25 to i64
  %27 = getelementptr inbounds [1024 x [1024 x float]], ptr @B, i64 0, i64 %26
  %28 = load i32, ptr %2, align 4
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds [1024 x float], ptr %27, i64 0, i64 %29
  store float %24, ptr %30, align 4
  %31 = load i32, ptr %1, align 4
  %32 = sext i32 %31 to i64
  %33 = getelementptr inbounds [1024 x [1024 x float]], ptr @C, i64 0, i64 %32
  %34 = load i32, ptr %2, align 4
  %35 = sext i32 %34 to i64
  %36 = getelementptr inbounds [1024 x float], ptr %33, i64 0, i64 %35
  store float 0.000000e+00, ptr %36, align 4
  br label %37

37:                                               ; preds = %10
  %38 = load i32, ptr %2, align 4
  %39 = add nsw i32 %38, 1
  store i32 %39, ptr %2, align 4
  br label %7, !llvm.loop !5

40:                                               ; preds = %7
  br label %41

41:                                               ; preds = %40
  %42 = load i32, ptr %1, align 4
  %43 = add nsw i32 %42, 1
  store i32 %43, ptr %1, align 4
  br label %3, !llvm.loop !7

44:                                               ; preds = %3
  ret void
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define void @matmul() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  br label %4

4:                                                ; preds = %46, %0
  %5 = load i32, ptr %1, align 4
  %6 = icmp slt i32 %5, 1024
  br i1 %6, label %7, label %49

7:                                                ; preds = %4
  store i32 0, ptr %2, align 4
  br label %8

8:                                                ; preds = %42, %7
  %9 = load i32, ptr %2, align 4
  %10 = icmp slt i32 %9, 1024
  br i1 %10, label %11, label %45

11:                                               ; preds = %8
  store i32 0, ptr %3, align 4
  br label %12

12:                                               ; preds = %38, %11
  %13 = load i32, ptr %3, align 4
  %14 = icmp slt i32 %13, 1024
  br i1 %14, label %15, label %41

15:                                               ; preds = %12
  %16 = load i32, ptr %1, align 4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds [1024 x [1024 x float]], ptr @A, i64 0, i64 %17
  %19 = load i32, ptr %3, align 4
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds [1024 x float], ptr %18, i64 0, i64 %20
  %22 = load float, ptr %21, align 4
  %23 = load i32, ptr %3, align 4
  %24 = sext i32 %23 to i64
  %25 = getelementptr inbounds [1024 x [1024 x float]], ptr @B, i64 0, i64 %24
  %26 = load i32, ptr %2, align 4
  %27 = sext i32 %26 to i64
  %28 = getelementptr inbounds [1024 x float], ptr %25, i64 0, i64 %27
  %29 = load float, ptr %28, align 4
  %30 = load i32, ptr %1, align 4
  %31 = sext i32 %30 to i64
  %32 = getelementptr inbounds [1024 x [1024 x float]], ptr @C, i64 0, i64 %31
  %33 = load i32, ptr %2, align 4
  %34 = sext i32 %33 to i64
  %35 = getelementptr inbounds [1024 x float], ptr %32, i64 0, i64 %34
  %36 = load float, ptr %35, align 4
  %37 = call float @llvm.fmuladd.f32(float %22, float %29, float %36)
  store float %37, ptr %35, align 4
  br label %38

38:                                               ; preds = %15
  %39 = load i32, ptr %3, align 4
  %40 = add nsw i32 %39, 1
  store i32 %40, ptr %3, align 4
  br label %12, !llvm.loop !8

41:                                               ; preds = %12
  br label %42

42:                                               ; preds = %41
  %43 = load i32, ptr %2, align 4
  %44 = add nsw i32 %43, 1
  store i32 %44, ptr %2, align 4
  br label %8, !llvm.loop !9

45:                                               ; preds = %8
  br label %46

46:                                               ; preds = %45
  %47 = load i32, ptr %1, align 4
  %48 = add nsw i32 %47, 1
  store i32 %48, ptr %1, align 4
  br label %4, !llvm.loop !10

49:                                               ; preds = %4
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.fmuladd.f32(float, float, float) #1

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @main() #0 {
  %1 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  call void @init()
  call void @matmul()
  %2 = load float, ptr @C, align 4
  %3 = fpext float %2 to double
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str, double noundef %3)
  ret i32 0
}

declare i32 @printf(ptr noundef, ...) #2

attributes #0 = { noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" "tune-cpu"="apple-m5" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" "tune-cpu"="apple-m5" }

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

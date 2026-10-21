; ModuleID = 'benchmarks/matmul_hard.c'
source_filename = "benchmarks/matmul_hard.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@.str = private unnamed_addr constant [22 x i8] c"matmul %dx%d: %.3f s\0A\00", align 1
@.str.1 = private unnamed_addr constant [14 x i8] c"checksum: %f\0A\00", align 1

; Function Attrs: noinline nounwind ssp uwtable(sync)
define void @matmul(ptr noalias noundef %0, ptr noalias noundef %1, ptr noalias noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  store i32 1024, ptr %7, align 4
  store i32 0, ptr %8, align 4
  br label %11

11:                                               ; preds = %56, %3
  %12 = load i32, ptr %8, align 4
  %13 = icmp slt i32 %12, 1024
  br i1 %13, label %14, label %59

14:                                               ; preds = %11
  store i32 0, ptr %9, align 4
  br label %15

15:                                               ; preds = %52, %14
  %16 = load i32, ptr %9, align 4
  %17 = icmp slt i32 %16, 1024
  br i1 %17, label %18, label %55

18:                                               ; preds = %15
  store i32 0, ptr %10, align 4
  br label %19

19:                                               ; preds = %48, %18
  %20 = load i32, ptr %10, align 4
  %21 = icmp slt i32 %20, 1024
  br i1 %21, label %22, label %51

22:                                               ; preds = %19
  %23 = load ptr, ptr %4, align 8
  %24 = load i32, ptr %8, align 4
  %25 = mul nsw i32 %24, 1024
  %26 = load i32, ptr %10, align 4
  %27 = add nsw i32 %25, %26
  %28 = sext i32 %27 to i64
  %29 = getelementptr inbounds double, ptr %23, i64 %28
  %30 = load double, ptr %29, align 8
  %31 = load ptr, ptr %5, align 8
  %32 = load i32, ptr %10, align 4
  %33 = mul nsw i32 %32, 1024
  %34 = load i32, ptr %9, align 4
  %35 = add nsw i32 %33, %34
  %36 = sext i32 %35 to i64
  %37 = getelementptr inbounds double, ptr %31, i64 %36
  %38 = load double, ptr %37, align 8
  %39 = load ptr, ptr %6, align 8
  %40 = load i32, ptr %8, align 4
  %41 = mul nsw i32 %40, 1024
  %42 = load i32, ptr %9, align 4
  %43 = add nsw i32 %41, %42
  %44 = sext i32 %43 to i64
  %45 = getelementptr inbounds double, ptr %39, i64 %44
  %46 = load double, ptr %45, align 8
  %47 = call double @llvm.fmuladd.f64(double %30, double %38, double %46)
  store double %47, ptr %45, align 8
  br label %48

48:                                               ; preds = %22
  %49 = load i32, ptr %10, align 4
  %50 = add nsw i32 %49, 1
  store i32 %50, ptr %10, align 4
  br label %19, !llvm.loop !6

51:                                               ; preds = %19
  br label %52

52:                                               ; preds = %51
  %53 = load i32, ptr %9, align 4
  %54 = add nsw i32 %53, 1
  store i32 %54, ptr %9, align 4
  br label %15, !llvm.loop !8

55:                                               ; preds = %15
  br label %56

56:                                               ; preds = %55
  %57 = load i32, ptr %8, align 4
  %58 = add nsw i32 %57, 1
  store i32 %58, ptr %8, align 4
  br label %11, !llvm.loop !9

59:                                               ; preds = %11
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #1

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i64, align 8
  %7 = alloca i64, align 8
  %8 = alloca double, align 8
  store i32 0, ptr %1, align 4
  %9 = call ptr @malloc(i64 noundef 8388608) #4
  store ptr %9, ptr %2, align 8
  %10 = call ptr @malloc(i64 noundef 8388608) #4
  store ptr %10, ptr %3, align 8
  %11 = call ptr @malloc(i64 noundef 8388608) #4
  store ptr %11, ptr %4, align 8
  call void @srand(i32 noundef 42)
  store i32 0, ptr %5, align 4
  br label %12

12:                                               ; preds = %34, %0
  %13 = load i32, ptr %5, align 4
  %14 = icmp slt i32 %13, 1048576
  br i1 %14, label %15, label %37

15:                                               ; preds = %12
  %16 = call i32 @rand()
  %17 = sitofp i32 %16 to double
  %18 = fdiv double %17, 0x41DFFFFFFFC00000
  %19 = load ptr, ptr %2, align 8
  %20 = load i32, ptr %5, align 4
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds double, ptr %19, i64 %21
  store double %18, ptr %22, align 8
  %23 = call i32 @rand()
  %24 = sitofp i32 %23 to double
  %25 = fdiv double %24, 0x41DFFFFFFFC00000
  %26 = load ptr, ptr %3, align 8
  %27 = load i32, ptr %5, align 4
  %28 = sext i32 %27 to i64
  %29 = getelementptr inbounds double, ptr %26, i64 %28
  store double %25, ptr %29, align 8
  %30 = load ptr, ptr %4, align 8
  %31 = load i32, ptr %5, align 4
  %32 = sext i32 %31 to i64
  %33 = getelementptr inbounds double, ptr %30, i64 %32
  store double 0.000000e+00, ptr %33, align 8
  br label %34

34:                                               ; preds = %15
  %35 = load i32, ptr %5, align 4
  %36 = add nsw i32 %35, 1
  store i32 %36, ptr %5, align 4
  br label %12, !llvm.loop !10

37:                                               ; preds = %12
  %38 = call i64 @"\01_clock"()
  store i64 %38, ptr %6, align 8
  %39 = load ptr, ptr %2, align 8
  %40 = load ptr, ptr %3, align 8
  %41 = load ptr, ptr %4, align 8
  call void @matmul(ptr noundef %39, ptr noundef %40, ptr noundef %41)
  %42 = call i64 @"\01_clock"()
  store i64 %42, ptr %7, align 8
  %43 = load i64, ptr %7, align 8
  %44 = load i64, ptr %6, align 8
  %45 = sub i64 %43, %44
  %46 = uitofp i64 %45 to double
  %47 = fdiv double %46, 1.000000e+06
  store double %47, ptr %8, align 8
  %48 = load double, ptr %8, align 8
  %49 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef 1024, i32 noundef 1024, double noundef %48)
  %50 = load ptr, ptr %4, align 8
  %51 = getelementptr inbounds double, ptr %50, i64 524800
  %52 = load double, ptr %51, align 8
  %53 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, double noundef %52)
  %54 = load ptr, ptr %2, align 8
  call void @free(ptr noundef %54)
  %55 = load ptr, ptr %3, align 8
  call void @free(ptr noundef %55)
  %56 = load ptr, ptr %4, align 8
  call void @free(ptr noundef %56)
  ret i32 0
}

; Function Attrs: allocsize(0)
declare ptr @malloc(i64 noundef) #2

declare void @srand(i32 noundef) #3

declare i32 @rand() #3

declare i64 @"\01_clock"() #3

declare i32 @printf(ptr noundef, ...) #3

declare void @free(ptr noundef) #3

attributes #0 = { noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { allocsize(0) "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #3 = { "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #4 = { allocsize(0) }

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
!9 = distinct !{!9, !7}
!10 = distinct !{!10, !7}

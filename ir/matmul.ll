; ModuleID = 'benchmarks/matmul.c'
source_filename = "benchmarks/matmul.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@a = internal global [512 x [512 x double]] zeroinitializer, align 8
@b = internal global [512 x [512 x double]] zeroinitializer, align 8
@c = internal global [512 x [512 x double]] zeroinitializer, align 8
@.str = private unnamed_addr constant [37 x i8] c"matmul %dx%d: %.3f s (%.2f GFLOP/s)\0A\00", align 1
@.str.1 = private unnamed_addr constant [14 x i8] c"checksum: %f\0A\00", align 1

; Function Attrs: noinline nounwind ssp uwtable(sync)
define void @matmul() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  br label %4

4:                                                ; preds = %46, %0
  %5 = load i32, ptr %1, align 4
  %6 = icmp slt i32 %5, 512
  br i1 %6, label %7, label %49

7:                                                ; preds = %4
  store i32 0, ptr %2, align 4
  br label %8

8:                                                ; preds = %42, %7
  %9 = load i32, ptr %2, align 4
  %10 = icmp slt i32 %9, 512
  br i1 %10, label %11, label %45

11:                                               ; preds = %8
  store i32 0, ptr %3, align 4
  br label %12

12:                                               ; preds = %38, %11
  %13 = load i32, ptr %3, align 4
  %14 = icmp slt i32 %13, 512
  br i1 %14, label %15, label %41

15:                                               ; preds = %12
  %16 = load i32, ptr %1, align 4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds [512 x [512 x double]], ptr @a, i64 0, i64 %17
  %19 = load i32, ptr %3, align 4
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds [512 x double], ptr %18, i64 0, i64 %20
  %22 = load double, ptr %21, align 8
  %23 = load i32, ptr %3, align 4
  %24 = sext i32 %23 to i64
  %25 = getelementptr inbounds [512 x [512 x double]], ptr @b, i64 0, i64 %24
  %26 = load i32, ptr %2, align 4
  %27 = sext i32 %26 to i64
  %28 = getelementptr inbounds [512 x double], ptr %25, i64 0, i64 %27
  %29 = load double, ptr %28, align 8
  %30 = load i32, ptr %1, align 4
  %31 = sext i32 %30 to i64
  %32 = getelementptr inbounds [512 x [512 x double]], ptr @c, i64 0, i64 %31
  %33 = load i32, ptr %2, align 4
  %34 = sext i32 %33 to i64
  %35 = getelementptr inbounds [512 x double], ptr %32, i64 0, i64 %34
  %36 = load volatile double, ptr %35, align 8
  %37 = call double @llvm.fmuladd.f64(double %22, double %29, double %36)
  store volatile double %37, ptr %35, align 8
  br label %38

38:                                               ; preds = %15
  %39 = load i32, ptr %3, align 4
  %40 = add nsw i32 %39, 1
  store i32 %40, ptr %3, align 4
  br label %12, !llvm.loop !6

41:                                               ; preds = %12
  br label %42

42:                                               ; preds = %41
  %43 = load i32, ptr %2, align 4
  %44 = add nsw i32 %43, 1
  store i32 %44, ptr %2, align 4
  br label %8, !llvm.loop !8

45:                                               ; preds = %8
  br label %46

46:                                               ; preds = %45
  %47 = load i32, ptr %1, align 4
  %48 = add nsw i32 %47, 1
  store i32 %48, ptr %1, align 4
  br label %4, !llvm.loop !9

49:                                               ; preds = %4
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #1

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i64, align 8
  %5 = alloca i64, align 8
  %6 = alloca double, align 8
  %7 = alloca double, align 8
  store i32 0, ptr %1, align 4
  call void @srand(i32 noundef 42)
  store i32 0, ptr %2, align 4
  br label %8

8:                                                ; preds = %38, %0
  %9 = load i32, ptr %2, align 4
  %10 = icmp slt i32 %9, 512
  br i1 %10, label %11, label %41

11:                                               ; preds = %8
  store i32 0, ptr %3, align 4
  br label %12

12:                                               ; preds = %34, %11
  %13 = load i32, ptr %3, align 4
  %14 = icmp slt i32 %13, 512
  br i1 %14, label %15, label %37

15:                                               ; preds = %12
  %16 = call i32 @rand()
  %17 = sitofp i32 %16 to double
  %18 = fdiv double %17, 0x41DFFFFFFFC00000
  %19 = load i32, ptr %2, align 4
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds [512 x [512 x double]], ptr @a, i64 0, i64 %20
  %22 = load i32, ptr %3, align 4
  %23 = sext i32 %22 to i64
  %24 = getelementptr inbounds [512 x double], ptr %21, i64 0, i64 %23
  store double %18, ptr %24, align 8
  %25 = call i32 @rand()
  %26 = sitofp i32 %25 to double
  %27 = fdiv double %26, 0x41DFFFFFFFC00000
  %28 = load i32, ptr %2, align 4
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds [512 x [512 x double]], ptr @b, i64 0, i64 %29
  %31 = load i32, ptr %3, align 4
  %32 = sext i32 %31 to i64
  %33 = getelementptr inbounds [512 x double], ptr %30, i64 0, i64 %32
  store double %27, ptr %33, align 8
  br label %34

34:                                               ; preds = %15
  %35 = load i32, ptr %3, align 4
  %36 = add nsw i32 %35, 1
  store i32 %36, ptr %3, align 4
  br label %12, !llvm.loop !10

37:                                               ; preds = %12
  br label %38

38:                                               ; preds = %37
  %39 = load i32, ptr %2, align 4
  %40 = add nsw i32 %39, 1
  store i32 %40, ptr %2, align 4
  br label %8, !llvm.loop !11

41:                                               ; preds = %8
  %42 = call i64 @"\01_clock"()
  store i64 %42, ptr %4, align 8
  call void @matmul()
  %43 = call i64 @"\01_clock"()
  store i64 %43, ptr %5, align 8
  %44 = load i64, ptr %5, align 8
  %45 = load i64, ptr %4, align 8
  %46 = sub i64 %44, %45
  %47 = uitofp i64 %46 to double
  %48 = fdiv double %47, 1.000000e+06
  store double %48, ptr %6, align 8
  %49 = load double, ptr %6, align 8
  %50 = fdiv double 0x41B0000000000000, %49
  %51 = fdiv double %50, 1.000000e+09
  store double %51, ptr %7, align 8
  %52 = load double, ptr %6, align 8
  %53 = load double, ptr %7, align 8
  %54 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef 512, i32 noundef 512, double noundef %52, double noundef %53)
  %55 = load volatile double, ptr getelementptr inbounds ([512 x double], ptr getelementptr inbounds ([512 x [512 x double]], ptr @c, i64 0, i64 256), i64 0, i64 256), align 8
  %56 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, double noundef %55)
  ret i32 0
}

declare void @srand(i32 noundef) #2

declare i32 @rand() #2

declare i64 @"\01_clock"() #2

declare i32 @printf(ptr noundef, ...) #2

attributes #0 = { noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }

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
!11 = distinct !{!11, !7}

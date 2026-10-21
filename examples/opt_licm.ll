; ModuleID = 'sem_opt.ll'
source_filename = "matmul.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@A = global [32 x [32 x double]] zeroinitializer, align 8
@B = global [32 x [32 x double]] zeroinitializer, align 8
@C = global [32 x [32 x double]] zeroinitializer, align 8
@.str = private unnamed_addr constant [22 x i8] c"Tempo: %.4f segundos\0A\00", align 1
@.str.1 = private unnamed_addr constant [16 x i8] c"C[0][0] = %.6f\0A\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @matmul() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  br label %4

4:                                                ; preds = %46, %0
  %5 = load i32, ptr %1, align 4
  %6 = icmp slt i32 %5, 32
  br i1 %6, label %7, label %49

7:                                                ; preds = %4
  store i32 0, ptr %2, align 4
  br label %8

8:                                                ; preds = %42, %7
  %9 = load i32, ptr %2, align 4
  %10 = icmp slt i32 %9, 32
  br i1 %10, label %11, label %45

11:                                               ; preds = %8
  store i32 0, ptr %3, align 4
  br label %12

12:                                               ; preds = %38, %11
  %13 = load i32, ptr %3, align 4
  %14 = icmp slt i32 %13, 32
  br i1 %14, label %15, label %41

15:                                               ; preds = %12
  %16 = load i32, ptr %1, align 4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds [32 x [32 x double]], ptr @A, i64 0, i64 %17
  %19 = load i32, ptr %3, align 4
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds [32 x double], ptr %18, i64 0, i64 %20
  %22 = load double, ptr %21, align 8
  %23 = load i32, ptr %3, align 4
  %24 = sext i32 %23 to i64
  %25 = getelementptr inbounds [32 x [32 x double]], ptr @B, i64 0, i64 %24
  %26 = load i32, ptr %2, align 4
  %27 = sext i32 %26 to i64
  %28 = getelementptr inbounds [32 x double], ptr %25, i64 0, i64 %27
  %29 = load double, ptr %28, align 8
  %30 = load i32, ptr %1, align 4
  %31 = sext i32 %30 to i64
  %32 = getelementptr inbounds [32 x [32 x double]], ptr @C, i64 0, i64 %31
  %33 = load i32, ptr %2, align 4
  %34 = sext i32 %33 to i64
  %35 = getelementptr inbounds [32 x double], ptr %32, i64 0, i64 %34
  %36 = load double, ptr %35, align 8
  %37 = call double @llvm.fmuladd.f64(double %22, double %29, double %36)
  store double %37, ptr %35, align 8
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

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @init() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  br label %3

3:                                                ; preds = %39, %0
  %4 = load i32, ptr %1, align 4
  %5 = icmp slt i32 %4, 32
  br i1 %5, label %6, label %42

6:                                                ; preds = %3
  store i32 0, ptr %2, align 4
  br label %7

7:                                                ; preds = %35, %6
  %8 = load i32, ptr %2, align 4
  %9 = icmp slt i32 %8, 32
  br i1 %9, label %10, label %38

10:                                               ; preds = %7
  %11 = call i32 @rand()
  %12 = sitofp i32 %11 to double
  %13 = fdiv double %12, 0x41DFFFFFFFC00000
  %14 = load i32, ptr %1, align 4
  %15 = sext i32 %14 to i64
  %16 = getelementptr inbounds [32 x [32 x double]], ptr @A, i64 0, i64 %15
  %17 = load i32, ptr %2, align 4
  %18 = sext i32 %17 to i64
  %19 = getelementptr inbounds [32 x double], ptr %16, i64 0, i64 %18
  store double %13, ptr %19, align 8
  %20 = call i32 @rand()
  %21 = sitofp i32 %20 to double
  %22 = fdiv double %21, 0x41DFFFFFFFC00000
  %23 = load i32, ptr %1, align 4
  %24 = sext i32 %23 to i64
  %25 = getelementptr inbounds [32 x [32 x double]], ptr @B, i64 0, i64 %24
  %26 = load i32, ptr %2, align 4
  %27 = sext i32 %26 to i64
  %28 = getelementptr inbounds [32 x double], ptr %25, i64 0, i64 %27
  store double %22, ptr %28, align 8
  %29 = load i32, ptr %1, align 4
  %30 = sext i32 %29 to i64
  %31 = getelementptr inbounds [32 x [32 x double]], ptr @C, i64 0, i64 %30
  %32 = load i32, ptr %2, align 4
  %33 = sext i32 %32 to i64
  %34 = getelementptr inbounds [32 x double], ptr %31, i64 0, i64 %33
  store double 0.000000e+00, ptr %34, align 8
  br label %35

35:                                               ; preds = %10
  %36 = load i32, ptr %2, align 4
  %37 = add nsw i32 %36, 1
  store i32 %37, ptr %2, align 4
  br label %7, !llvm.loop !10

38:                                               ; preds = %7
  br label %39

39:                                               ; preds = %38
  %40 = load i32, ptr %1, align 4
  %41 = add nsw i32 %40, 1
  store i32 %41, ptr %1, align 4
  br label %3, !llvm.loop !11

42:                                               ; preds = %3
  ret void
}

declare i32 @rand() #2

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i64, align 8
  %3 = alloca i64, align 8
  %4 = alloca double, align 8
  store i32 0, ptr %1, align 4
  call void @srand(i32 noundef 42)
  call void @init()
  %5 = call i64 @"\01_clock"()
  store i64 %5, ptr %2, align 8
  call void @matmul()
  %6 = call i64 @"\01_clock"()
  store i64 %6, ptr %3, align 8
  %7 = load i64, ptr %3, align 8
  %8 = load i64, ptr %2, align 8
  %9 = sub i64 %7, %8
  %10 = uitofp i64 %9 to double
  %11 = fdiv double %10, 1.000000e+06
  store double %11, ptr %4, align 8
  %12 = load double, ptr %4, align 8
  %13 = call i32 (ptr, ...) @printf(ptr noundef @.str, double noundef %12)
  %14 = load double, ptr @C, align 8
  %15 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, double noundef %14)
  ret i32 0
}

declare void @srand(i32 noundef) #2

declare i64 @"\01_clock"() #2

declare i32 @printf(ptr noundef, ...) #2

attributes #0 = { noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 15, i32 4]}
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

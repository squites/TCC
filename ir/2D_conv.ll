; ModuleID = './benchmarks/2D_conv.c'
source_filename = "./benchmarks/2D_conv.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@out = internal global [1048576 x double] zeroinitializer, align 8
@.str = private unnamed_addr constant [39 x i8] c"2d_conv %dx%d K=%dx%d reps=%d: %.3f s\0A\00", align 1
@.str.1 = private unnamed_addr constant [14 x i8] c"checksum: %f\0A\00", align 1
@in = internal global [1048576 x double] zeroinitializer, align 8
@kernel = internal global [9 x double] zeroinitializer, align 8
@rng_state = internal global i64 42, align 8

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i64, align 8
  %3 = alloca i32, align 4
  %4 = alloca i64, align 8
  %5 = alloca double, align 8
  %6 = alloca double, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  call void @init()
  %9 = call i64 @"\01_clock"()
  store i64 %9, ptr %2, align 8
  store i32 0, ptr %3, align 4
  br label %10

10:                                               ; preds = %14, %0
  %11 = load i32, ptr %3, align 4
  %12 = icmp slt i32 %11, 50
  br i1 %12, label %13, label %17

13:                                               ; preds = %10
  call void @conv2d()
  br label %14

14:                                               ; preds = %13
  %15 = load i32, ptr %3, align 4
  %16 = add nsw i32 %15, 1
  store i32 %16, ptr %3, align 4
  br label %10, !llvm.loop !6

17:                                               ; preds = %10
  %18 = call i64 @"\01_clock"()
  store i64 %18, ptr %4, align 8
  %19 = load i64, ptr %4, align 8
  %20 = load i64, ptr %2, align 8
  %21 = sub i64 %19, %20
  %22 = uitofp i64 %21 to double
  %23 = fdiv double %22, 1.000000e+06
  store double %23, ptr %5, align 8
  store double 0.000000e+00, ptr %6, align 8
  store i32 0, ptr %7, align 4
  br label %24

24:                                               ; preds = %45, %17
  %25 = load i32, ptr %7, align 4
  %26 = icmp slt i32 %25, 1022
  br i1 %26, label %27, label %48

27:                                               ; preds = %24
  store i32 0, ptr %8, align 4
  br label %28

28:                                               ; preds = %41, %27
  %29 = load i32, ptr %8, align 4
  %30 = icmp slt i32 %29, 1022
  br i1 %30, label %31, label %44

31:                                               ; preds = %28
  %32 = load i32, ptr %7, align 4
  %33 = mul nsw i32 %32, 1024
  %34 = load i32, ptr %8, align 4
  %35 = add nsw i32 %33, %34
  %36 = sext i32 %35 to i64
  %37 = getelementptr inbounds [1048576 x double], ptr @out, i64 0, i64 %36
  %38 = load double, ptr %37, align 8
  %39 = load double, ptr %6, align 8
  %40 = fadd double %39, %38
  store double %40, ptr %6, align 8
  br label %41

41:                                               ; preds = %31
  %42 = load i32, ptr %8, align 4
  %43 = add nsw i32 %42, 1
  store i32 %43, ptr %8, align 4
  br label %28, !llvm.loop !8

44:                                               ; preds = %28
  br label %45

45:                                               ; preds = %44
  %46 = load i32, ptr %7, align 4
  %47 = add nsw i32 %46, 1
  store i32 %47, ptr %7, align 4
  br label %24, !llvm.loop !9

48:                                               ; preds = %24
  %49 = load double, ptr %5, align 8
  %50 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef 1024, i32 noundef 1024, i32 noundef 3, i32 noundef 3, i32 noundef 50, double noundef %49)
  %51 = load double, ptr %6, align 8
  %52 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, double noundef %51)
  ret i32 0
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define internal void @init() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  br label %3

3:                                                ; preds = %11, %0
  %4 = load i32, ptr %1, align 4
  %5 = icmp slt i32 %4, 1048576
  br i1 %5, label %6, label %14

6:                                                ; preds = %3
  %7 = call double @frand()
  %8 = load i32, ptr %1, align 4
  %9 = sext i32 %8 to i64
  %10 = getelementptr inbounds [1048576 x double], ptr @in, i64 0, i64 %9
  store double %7, ptr %10, align 8
  br label %11

11:                                               ; preds = %6
  %12 = load i32, ptr %1, align 4
  %13 = add nsw i32 %12, 1
  store i32 %13, ptr %1, align 4
  br label %3, !llvm.loop !10

14:                                               ; preds = %3
  store i32 0, ptr %2, align 4
  br label %15

15:                                               ; preds = %23, %14
  %16 = load i32, ptr %2, align 4
  %17 = icmp slt i32 %16, 9
  br i1 %17, label %18, label %26

18:                                               ; preds = %15
  %19 = call double @frand()
  %20 = load i32, ptr %2, align 4
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds [9 x double], ptr @kernel, i64 0, i64 %21
  store double %19, ptr %22, align 8
  br label %23

23:                                               ; preds = %18
  %24 = load i32, ptr %2, align 4
  %25 = add nsw i32 %24, 1
  store i32 %25, ptr %2, align 4
  br label %15, !llvm.loop !11

26:                                               ; preds = %15
  ret void
}

declare i64 @"\01_clock"() #1

; Function Attrs: noinline nounwind ssp uwtable(sync)
define internal void @conv2d() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca double, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  br label %6

6:                                                ; preds = %61, %0
  %7 = load i32, ptr %1, align 4
  %8 = icmp slt i32 %7, 1022
  br i1 %8, label %9, label %64

9:                                                ; preds = %6
  store i32 0, ptr %2, align 4
  br label %10

10:                                               ; preds = %57, %9
  %11 = load i32, ptr %2, align 4
  %12 = icmp slt i32 %11, 1022
  br i1 %12, label %13, label %60

13:                                               ; preds = %10
  store double 0.000000e+00, ptr %3, align 8
  store i32 0, ptr %4, align 4
  br label %14

14:                                               ; preds = %46, %13
  %15 = load i32, ptr %4, align 4
  %16 = icmp slt i32 %15, 3
  br i1 %16, label %17, label %49

17:                                               ; preds = %14
  store i32 0, ptr %5, align 4
  br label %18

18:                                               ; preds = %42, %17
  %19 = load i32, ptr %5, align 4
  %20 = icmp slt i32 %19, 3
  br i1 %20, label %21, label %45

21:                                               ; preds = %18
  %22 = load i32, ptr %1, align 4
  %23 = load i32, ptr %4, align 4
  %24 = add nsw i32 %22, %23
  %25 = mul nsw i32 %24, 1024
  %26 = load i32, ptr %2, align 4
  %27 = load i32, ptr %5, align 4
  %28 = add nsw i32 %26, %27
  %29 = add nsw i32 %25, %28
  %30 = sext i32 %29 to i64
  %31 = getelementptr inbounds [1048576 x double], ptr @in, i64 0, i64 %30
  %32 = load double, ptr %31, align 8
  %33 = load i32, ptr %4, align 4
  %34 = mul nsw i32 %33, 3
  %35 = load i32, ptr %5, align 4
  %36 = add nsw i32 %34, %35
  %37 = sext i32 %36 to i64
  %38 = getelementptr inbounds [9 x double], ptr @kernel, i64 0, i64 %37
  %39 = load double, ptr %38, align 8
  %40 = load double, ptr %3, align 8
  %41 = call double @llvm.fmuladd.f64(double %32, double %39, double %40)
  store double %41, ptr %3, align 8
  br label %42

42:                                               ; preds = %21
  %43 = load i32, ptr %5, align 4
  %44 = add nsw i32 %43, 1
  store i32 %44, ptr %5, align 4
  br label %18, !llvm.loop !12

45:                                               ; preds = %18
  br label %46

46:                                               ; preds = %45
  %47 = load i32, ptr %4, align 4
  %48 = add nsw i32 %47, 1
  store i32 %48, ptr %4, align 4
  br label %14, !llvm.loop !13

49:                                               ; preds = %14
  %50 = load double, ptr %3, align 8
  %51 = load i32, ptr %1, align 4
  %52 = mul nsw i32 %51, 1024
  %53 = load i32, ptr %2, align 4
  %54 = add nsw i32 %52, %53
  %55 = sext i32 %54 to i64
  %56 = getelementptr inbounds [1048576 x double], ptr @out, i64 0, i64 %55
  store double %50, ptr %56, align 8
  br label %57

57:                                               ; preds = %49
  %58 = load i32, ptr %2, align 4
  %59 = add nsw i32 %58, 1
  store i32 %59, ptr %2, align 4
  br label %10, !llvm.loop !14

60:                                               ; preds = %10
  br label %61

61:                                               ; preds = %60
  %62 = load i32, ptr %1, align 4
  %63 = add nsw i32 %62, 1
  store i32 %63, ptr %1, align 4
  br label %6, !llvm.loop !15

64:                                               ; preds = %6
  ret void
}

declare i32 @printf(ptr noundef, ...) #1

; Function Attrs: noinline nounwind ssp uwtable(sync)
define internal double @frand() #0 {
  %1 = load i64, ptr @rng_state, align 8
  %2 = mul i64 %1, 6364136223846793005
  %3 = add i64 %2, 1442695040888963407
  store i64 %3, ptr @rng_state, align 8
  %4 = load i64, ptr @rng_state, align 8
  %5 = lshr i64 %4, 11
  %6 = uitofp i64 %5 to double
  %7 = fmul double %6, 0x3CA0000000000000
  ret double %7
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #2

attributes #0 = { noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }

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
!12 = distinct !{!12, !7}
!13 = distinct !{!13, !7}
!14 = distinct !{!14, !7}
!15 = distinct !{!15, !7}

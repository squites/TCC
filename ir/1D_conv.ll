; ModuleID = './benchmarks/1D_conv.c'
source_filename = "./benchmarks/1D_conv.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@out = internal global [1000000 x double] zeroinitializer, align 8
@.str = private unnamed_addr constant [35 x i8] c"1d_conv N=%d K=%d reps=%d: %.3f s\0A\00", align 1
@.str.1 = private unnamed_addr constant [14 x i8] c"checksum: %f\0A\00", align 1
@in = internal global [1000000 x double] zeroinitializer, align 8
@kernel = internal global [5 x double] zeroinitializer, align 8
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
  store i32 0, ptr %1, align 4
  call void @init()
  %8 = call i64 @"\01_clock"()
  store i64 %8, ptr %2, align 8
  store i32 0, ptr %3, align 4
  br label %9

9:                                                ; preds = %13, %0
  %10 = load i32, ptr %3, align 4
  %11 = icmp slt i32 %10, 100
  br i1 %11, label %12, label %16

12:                                               ; preds = %9
  call void @conv1d()
  br label %13

13:                                               ; preds = %12
  %14 = load i32, ptr %3, align 4
  %15 = add nsw i32 %14, 1
  store i32 %15, ptr %3, align 4
  br label %9, !llvm.loop !6

16:                                               ; preds = %9
  %17 = call i64 @"\01_clock"()
  store i64 %17, ptr %4, align 8
  %18 = load i64, ptr %4, align 8
  %19 = load i64, ptr %2, align 8
  %20 = sub i64 %18, %19
  %21 = uitofp i64 %20 to double
  %22 = fdiv double %21, 1.000000e+06
  store double %22, ptr %5, align 8
  store double 0.000000e+00, ptr %6, align 8
  store i32 0, ptr %7, align 4
  br label %23

23:                                               ; preds = %33, %16
  %24 = load i32, ptr %7, align 4
  %25 = icmp slt i32 %24, 999996
  br i1 %25, label %26, label %36

26:                                               ; preds = %23
  %27 = load i32, ptr %7, align 4
  %28 = sext i32 %27 to i64
  %29 = getelementptr inbounds [1000000 x double], ptr @out, i64 0, i64 %28
  %30 = load double, ptr %29, align 8
  %31 = load double, ptr %6, align 8
  %32 = fadd double %31, %30
  store double %32, ptr %6, align 8
  br label %33

33:                                               ; preds = %26
  %34 = load i32, ptr %7, align 4
  %35 = add nsw i32 %34, 1
  store i32 %35, ptr %7, align 4
  br label %23, !llvm.loop !8

36:                                               ; preds = %23
  %37 = load double, ptr %5, align 8
  %38 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef 1000000, i32 noundef 5, i32 noundef 100, double noundef %37)
  %39 = load double, ptr %6, align 8
  %40 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, double noundef %39)
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
  %5 = icmp slt i32 %4, 1000000
  br i1 %5, label %6, label %14

6:                                                ; preds = %3
  %7 = call double @frand()
  %8 = load i32, ptr %1, align 4
  %9 = sext i32 %8 to i64
  %10 = getelementptr inbounds [1000000 x double], ptr @in, i64 0, i64 %9
  store double %7, ptr %10, align 8
  br label %11

11:                                               ; preds = %6
  %12 = load i32, ptr %1, align 4
  %13 = add nsw i32 %12, 1
  store i32 %13, ptr %1, align 4
  br label %3, !llvm.loop !9

14:                                               ; preds = %3
  store i32 0, ptr %2, align 4
  br label %15

15:                                               ; preds = %23, %14
  %16 = load i32, ptr %2, align 4
  %17 = icmp slt i32 %16, 5
  br i1 %17, label %18, label %26

18:                                               ; preds = %15
  %19 = call double @frand()
  %20 = load i32, ptr %2, align 4
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds [5 x double], ptr @kernel, i64 0, i64 %21
  store double %19, ptr %22, align 8
  br label %23

23:                                               ; preds = %18
  %24 = load i32, ptr %2, align 4
  %25 = add nsw i32 %24, 1
  store i32 %25, ptr %2, align 4
  br label %15, !llvm.loop !10

26:                                               ; preds = %15
  ret void
}

declare i64 @"\01_clock"() #1

; Function Attrs: noinline nounwind ssp uwtable(sync)
define internal void @conv1d() #0 {
  %1 = alloca i32, align 4
  %2 = alloca double, align 8
  %3 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  br label %4

4:                                                ; preds = %32, %0
  %5 = load i32, ptr %1, align 4
  %6 = icmp slt i32 %5, 999996
  br i1 %6, label %7, label %35

7:                                                ; preds = %4
  store double 0.000000e+00, ptr %2, align 8
  store i32 0, ptr %3, align 4
  br label %8

8:                                                ; preds = %24, %7
  %9 = load i32, ptr %3, align 4
  %10 = icmp slt i32 %9, 5
  br i1 %10, label %11, label %27

11:                                               ; preds = %8
  %12 = load i32, ptr %1, align 4
  %13 = load i32, ptr %3, align 4
  %14 = add nsw i32 %12, %13
  %15 = sext i32 %14 to i64
  %16 = getelementptr inbounds [1000000 x double], ptr @in, i64 0, i64 %15
  %17 = load double, ptr %16, align 8
  %18 = load i32, ptr %3, align 4
  %19 = sext i32 %18 to i64
  %20 = getelementptr inbounds [5 x double], ptr @kernel, i64 0, i64 %19
  %21 = load double, ptr %20, align 8
  %22 = load double, ptr %2, align 8
  %23 = call double @llvm.fmuladd.f64(double %17, double %21, double %22)
  store double %23, ptr %2, align 8
  br label %24

24:                                               ; preds = %11
  %25 = load i32, ptr %3, align 4
  %26 = add nsw i32 %25, 1
  store i32 %26, ptr %3, align 4
  br label %8, !llvm.loop !11

27:                                               ; preds = %8
  %28 = load double, ptr %2, align 8
  %29 = load i32, ptr %1, align 4
  %30 = sext i32 %29 to i64
  %31 = getelementptr inbounds [1000000 x double], ptr @out, i64 0, i64 %30
  store double %28, ptr %31, align 8
  br label %32

32:                                               ; preds = %27
  %33 = load i32, ptr %1, align 4
  %34 = add nsw i32 %33, 1
  store i32 %34, ptr %1, align 4
  br label %4, !llvm.loop !12

35:                                               ; preds = %4
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

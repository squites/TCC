; ModuleID = 'ir/2D_conv.ll'
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
  call void @init()
  %1 = call i64 @"\01_clock"()
  br label %2

2:                                                ; preds = %5, %0
  %.02 = phi i32 [ 0, %0 ], [ %6, %5 ]
  %3 = icmp slt i32 %.02, 50
  br i1 %3, label %4, label %7

4:                                                ; preds = %2
  call void @conv2d()
  br label %5

5:                                                ; preds = %4
  %6 = add nsw i32 %.02, 1
  br label %2, !llvm.loop !6

7:                                                ; preds = %2
  %8 = call i64 @"\01_clock"()
  %9 = sub i64 %8, %1
  %10 = uitofp i64 %9 to double
  %11 = fdiv double %10, 1.000000e+06
  br label %12

12:                                               ; preds = %27, %7
  %.03 = phi double [ 0.000000e+00, %7 ], [ %.1, %27 ]
  %.01 = phi i32 [ 0, %7 ], [ %28, %27 ]
  %13 = icmp slt i32 %.01, 1022
  br i1 %13, label %14, label %29

14:                                               ; preds = %12
  br label %15

15:                                               ; preds = %24, %14
  %.1 = phi double [ %.03, %14 ], [ %23, %24 ]
  %.0 = phi i32 [ 0, %14 ], [ %25, %24 ]
  %16 = icmp slt i32 %.0, 1022
  br i1 %16, label %17, label %26

17:                                               ; preds = %15
  %18 = mul nsw i32 %.01, 1024
  %19 = add nsw i32 %18, %.0
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds [1048576 x double], ptr @out, i64 0, i64 %20
  %22 = load double, ptr %21, align 8
  %23 = fadd double %.1, %22
  br label %24

24:                                               ; preds = %17
  %25 = add nsw i32 %.0, 1
  br label %15, !llvm.loop !8

26:                                               ; preds = %15
  br label %27

27:                                               ; preds = %26
  %28 = add nsw i32 %.01, 1
  br label %12, !llvm.loop !9

29:                                               ; preds = %12
  %30 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef 1024, i32 noundef 1024, i32 noundef 3, i32 noundef 3, i32 noundef 50, double noundef %11)
  %31 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, double noundef %.03)
  ret i32 0
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define internal void @init() #0 {
  br label %1

1:                                                ; preds = %7, %0
  %.0 = phi i32 [ 0, %0 ], [ %8, %7 ]
  %2 = icmp slt i32 %.0, 1048576
  br i1 %2, label %3, label %9

3:                                                ; preds = %1
  %4 = call double @frand()
  %5 = sext i32 %.0 to i64
  %6 = getelementptr inbounds [1048576 x double], ptr @in, i64 0, i64 %5
  store double %4, ptr %6, align 8
  br label %7

7:                                                ; preds = %3
  %8 = add nsw i32 %.0, 1
  br label %1, !llvm.loop !10

9:                                                ; preds = %1
  br label %10

10:                                               ; preds = %16, %9
  %.01 = phi i32 [ 0, %9 ], [ %17, %16 ]
  %11 = icmp slt i32 %.01, 9
  br i1 %11, label %12, label %18

12:                                               ; preds = %10
  %13 = call double @frand()
  %14 = sext i32 %.01 to i64
  %15 = getelementptr inbounds [9 x double], ptr @kernel, i64 0, i64 %14
  store double %13, ptr %15, align 8
  br label %16

16:                                               ; preds = %12
  %17 = add nsw i32 %.01, 1
  br label %10, !llvm.loop !11

18:                                               ; preds = %10
  ret void
}

declare i64 @"\01_clock"() #1

; Function Attrs: noinline nounwind ssp uwtable(sync)
define internal void @conv2d() #0 {
  br label %1

1:                                                ; preds = %39, %0
  %.0 = phi i32 [ 0, %0 ], [ %40, %39 ]
  %2 = icmp slt i32 %.0, 1022
  br i1 %2, label %3, label %41

3:                                                ; preds = %1
  br label %4

4:                                                ; preds = %36, %3
  %.01 = phi i32 [ 0, %3 ], [ %37, %36 ]
  %5 = icmp slt i32 %.01, 1022
  br i1 %5, label %6, label %38

6:                                                ; preds = %4
  br label %7

7:                                                ; preds = %29, %6
  %.03 = phi i32 [ 0, %6 ], [ %30, %29 ]
  %.02 = phi double [ 0.000000e+00, %6 ], [ %.1, %29 ]
  %8 = icmp slt i32 %.03, 3
  br i1 %8, label %9, label %31

9:                                                ; preds = %7
  br label %10

10:                                               ; preds = %26, %9
  %.04 = phi i32 [ 0, %9 ], [ %27, %26 ]
  %.1 = phi double [ %.02, %9 ], [ %25, %26 ]
  %11 = icmp slt i32 %.04, 3
  br i1 %11, label %12, label %28

12:                                               ; preds = %10
  %13 = add nsw i32 %.0, %.03
  %14 = mul nsw i32 %13, 1024
  %15 = add nsw i32 %.01, %.04
  %16 = add nsw i32 %14, %15
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds [1048576 x double], ptr @in, i64 0, i64 %17
  %19 = load double, ptr %18, align 8
  %20 = mul nsw i32 %.03, 3
  %21 = add nsw i32 %20, %.04
  %22 = sext i32 %21 to i64
  %23 = getelementptr inbounds [9 x double], ptr @kernel, i64 0, i64 %22
  %24 = load double, ptr %23, align 8
  %25 = call double @llvm.fmuladd.f64(double %19, double %24, double %.1)
  br label %26

26:                                               ; preds = %12
  %27 = add nsw i32 %.04, 1
  br label %10, !llvm.loop !12

28:                                               ; preds = %10
  br label %29

29:                                               ; preds = %28
  %30 = add nsw i32 %.03, 1
  br label %7, !llvm.loop !13

31:                                               ; preds = %7
  %32 = mul nsw i32 %.0, 1024
  %33 = add nsw i32 %32, %.01
  %34 = sext i32 %33 to i64
  %35 = getelementptr inbounds [1048576 x double], ptr @out, i64 0, i64 %34
  store double %.02, ptr %35, align 8
  br label %36

36:                                               ; preds = %31
  %37 = add nsw i32 %.01, 1
  br label %4, !llvm.loop !14

38:                                               ; preds = %4
  br label %39

39:                                               ; preds = %38
  %40 = add nsw i32 %.0, 1
  br label %1, !llvm.loop !15

41:                                               ; preds = %1
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

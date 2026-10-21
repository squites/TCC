; ModuleID = 'ir/kmeans.ll'
source_filename = "benchmarks/kmeans.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@centers = internal global [128 x double] zeroinitializer, align 8
@.str = private unnamed_addr constant [35 x i8] c"kmeans N=%d K=%d iters=%d: %.3f s\0A\00", align 1
@.str.1 = private unnamed_addr constant [14 x i8] c"checksum: %f\0A\00", align 1
@points = internal global [800000 x double] zeroinitializer, align 8
@rng_state = internal global i64 42, align 8
@assign = internal global [100000 x i32] zeroinitializer, align 4
@counts = internal global [16 x i32] zeroinitializer, align 4
@sums = internal global [128 x double] zeroinitializer, align 8

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @main() #0 {
  call void @init()
  %1 = call i64 @"\01_clock"()
  br label %2

2:                                                ; preds = %5, %0
  %.02 = phi i32 [ 0, %0 ], [ %6, %5 ]
  %3 = icmp slt i32 %.02, 20
  br i1 %3, label %4, label %7

4:                                                ; preds = %2
  call void @assign_clusters()
  call void @update_centers()
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
  %13 = icmp slt i32 %.01, 16
  br i1 %13, label %14, label %29

14:                                               ; preds = %12
  br label %15

15:                                               ; preds = %24, %14
  %.1 = phi double [ %.03, %14 ], [ %23, %24 ]
  %.0 = phi i32 [ 0, %14 ], [ %25, %24 ]
  %16 = icmp slt i32 %.0, 8
  br i1 %16, label %17, label %26

17:                                               ; preds = %15
  %18 = mul nsw i32 %.01, 8
  %19 = add nsw i32 %18, %.0
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds [128 x double], ptr @centers, i64 0, i64 %20
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
  %30 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef 100000, i32 noundef 16, i32 noundef 20, double noundef %11)
  %31 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, double noundef %.03)
  ret i32 0
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define internal void @init() #0 {
  br label %1

1:                                                ; preds = %15, %0
  %.0 = phi i32 [ 0, %0 ], [ %16, %15 ]
  %2 = icmp slt i32 %.0, 100000
  br i1 %2, label %3, label %17

3:                                                ; preds = %1
  br label %4

4:                                                ; preds = %12, %3
  %.01 = phi i32 [ 0, %3 ], [ %13, %12 ]
  %5 = icmp slt i32 %.01, 8
  br i1 %5, label %6, label %14

6:                                                ; preds = %4
  %7 = call double @frand()
  %8 = mul nsw i32 %.0, 8
  %9 = add nsw i32 %8, %.01
  %10 = sext i32 %9 to i64
  %11 = getelementptr inbounds [800000 x double], ptr @points, i64 0, i64 %10
  store double %7, ptr %11, align 8
  br label %12

12:                                               ; preds = %6
  %13 = add nsw i32 %.01, 1
  br label %4, !llvm.loop !10

14:                                               ; preds = %4
  br label %15

15:                                               ; preds = %14
  %16 = add nsw i32 %.0, 1
  br label %1, !llvm.loop !11

17:                                               ; preds = %1
  br label %18

18:                                               ; preds = %36, %17
  %.02 = phi i32 [ 0, %17 ], [ %37, %36 ]
  %19 = icmp slt i32 %.02, 16
  br i1 %19, label %20, label %38

20:                                               ; preds = %18
  br label %21

21:                                               ; preds = %33, %20
  %.03 = phi i32 [ 0, %20 ], [ %34, %33 ]
  %22 = icmp slt i32 %.03, 8
  br i1 %22, label %23, label %35

23:                                               ; preds = %21
  %24 = mul nsw i32 %.02, 8
  %25 = add nsw i32 %24, %.03
  %26 = sext i32 %25 to i64
  %27 = getelementptr inbounds [800000 x double], ptr @points, i64 0, i64 %26
  %28 = load double, ptr %27, align 8
  %29 = mul nsw i32 %.02, 8
  %30 = add nsw i32 %29, %.03
  %31 = sext i32 %30 to i64
  %32 = getelementptr inbounds [128 x double], ptr @centers, i64 0, i64 %31
  store double %28, ptr %32, align 8
  br label %33

33:                                               ; preds = %23
  %34 = add nsw i32 %.03, 1
  br label %21, !llvm.loop !12

35:                                               ; preds = %21
  br label %36

36:                                               ; preds = %35
  %37 = add nsw i32 %.02, 1
  br label %18, !llvm.loop !13

38:                                               ; preds = %18
  ret void
}

declare i64 @"\01_clock"() #1

; Function Attrs: noinline nounwind ssp uwtable(sync)
define internal void @assign_clusters() #0 {
  br label %1

1:                                                ; preds = %33, %0
  %.0 = phi i32 [ 0, %0 ], [ %34, %33 ]
  %2 = icmp slt i32 %.0, 100000
  br i1 %2, label %3, label %35

3:                                                ; preds = %1
  br label %4

4:                                                ; preds = %28, %3
  %.04 = phi i32 [ 0, %3 ], [ %29, %28 ]
  %.02 = phi double [ 0x7FEFFFFFFFFFFFFF, %3 ], [ %.13, %28 ]
  %.01 = phi i32 [ 0, %3 ], [ %.1, %28 ]
  %5 = icmp slt i32 %.04, 16
  br i1 %5, label %6, label %30

6:                                                ; preds = %4
  br label %7

7:                                                ; preds = %22, %6
  %.06 = phi i32 [ 0, %6 ], [ %23, %22 ]
  %.05 = phi double [ 0.000000e+00, %6 ], [ %21, %22 ]
  %8 = icmp slt i32 %.06, 8
  br i1 %8, label %9, label %24

9:                                                ; preds = %7
  %10 = mul nsw i32 %.0, 8
  %11 = add nsw i32 %10, %.06
  %12 = sext i32 %11 to i64
  %13 = getelementptr inbounds [800000 x double], ptr @points, i64 0, i64 %12
  %14 = load double, ptr %13, align 8
  %15 = mul nsw i32 %.04, 8
  %16 = add nsw i32 %15, %.06
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds [128 x double], ptr @centers, i64 0, i64 %17
  %19 = load double, ptr %18, align 8
  %20 = fsub double %14, %19
  %21 = call double @llvm.fmuladd.f64(double %20, double %20, double %.05)
  br label %22

22:                                               ; preds = %9
  %23 = add nsw i32 %.06, 1
  br label %7, !llvm.loop !14

24:                                               ; preds = %7
  %25 = fcmp olt double %.05, %.02
  br i1 %25, label %26, label %27

26:                                               ; preds = %24
  br label %27

27:                                               ; preds = %26, %24
  %.13 = phi double [ %.05, %26 ], [ %.02, %24 ]
  %.1 = phi i32 [ %.04, %26 ], [ %.01, %24 ]
  br label %28

28:                                               ; preds = %27
  %29 = add nsw i32 %.04, 1
  br label %4, !llvm.loop !15

30:                                               ; preds = %4
  %31 = sext i32 %.0 to i64
  %32 = getelementptr inbounds [100000 x i32], ptr @assign, i64 0, i64 %31
  store i32 %.01, ptr %32, align 4
  br label %33

33:                                               ; preds = %30
  %34 = add nsw i32 %.0, 1
  br label %1, !llvm.loop !16

35:                                               ; preds = %1
  ret void
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define internal void @update_centers() #0 {
  br label %1

1:                                                ; preds = %16, %0
  %.0 = phi i32 [ 0, %0 ], [ %17, %16 ]
  %2 = icmp slt i32 %.0, 16
  br i1 %2, label %3, label %18

3:                                                ; preds = %1
  %4 = sext i32 %.0 to i64
  %5 = getelementptr inbounds [16 x i32], ptr @counts, i64 0, i64 %4
  store i32 0, ptr %5, align 4
  br label %6

6:                                                ; preds = %13, %3
  %.01 = phi i32 [ 0, %3 ], [ %14, %13 ]
  %7 = icmp slt i32 %.01, 8
  br i1 %7, label %8, label %15

8:                                                ; preds = %6
  %9 = mul nsw i32 %.0, 8
  %10 = add nsw i32 %9, %.01
  %11 = sext i32 %10 to i64
  %12 = getelementptr inbounds [128 x double], ptr @sums, i64 0, i64 %11
  store double 0.000000e+00, ptr %12, align 8
  br label %13

13:                                               ; preds = %8
  %14 = add nsw i32 %.01, 1
  br label %6, !llvm.loop !17

15:                                               ; preds = %6
  br label %16

16:                                               ; preds = %15
  %17 = add nsw i32 %.0, 1
  br label %1, !llvm.loop !18

18:                                               ; preds = %1
  br label %19

19:                                               ; preds = %46, %18
  %.02 = phi i32 [ 0, %18 ], [ %47, %46 ]
  %20 = icmp slt i32 %.02, 100000
  br i1 %20, label %21, label %48

21:                                               ; preds = %19
  %22 = sext i32 %.02 to i64
  %23 = getelementptr inbounds [100000 x i32], ptr @assign, i64 0, i64 %22
  %24 = load i32, ptr %23, align 4
  %25 = sext i32 %24 to i64
  %26 = getelementptr inbounds [16 x i32], ptr @counts, i64 0, i64 %25
  %27 = load i32, ptr %26, align 4
  %28 = add nsw i32 %27, 1
  store i32 %28, ptr %26, align 4
  br label %29

29:                                               ; preds = %43, %21
  %.04 = phi i32 [ 0, %21 ], [ %44, %43 ]
  %30 = icmp slt i32 %.04, 8
  br i1 %30, label %31, label %45

31:                                               ; preds = %29
  %32 = mul nsw i32 %.02, 8
  %33 = add nsw i32 %32, %.04
  %34 = sext i32 %33 to i64
  %35 = getelementptr inbounds [800000 x double], ptr @points, i64 0, i64 %34
  %36 = load double, ptr %35, align 8
  %37 = mul nsw i32 %24, 8
  %38 = add nsw i32 %37, %.04
  %39 = sext i32 %38 to i64
  %40 = getelementptr inbounds [128 x double], ptr @sums, i64 0, i64 %39
  %41 = load double, ptr %40, align 8
  %42 = fadd double %41, %36
  store double %42, ptr %40, align 8
  br label %43

43:                                               ; preds = %31
  %44 = add nsw i32 %.04, 1
  br label %29, !llvm.loop !19

45:                                               ; preds = %29
  br label %46

46:                                               ; preds = %45
  %47 = add nsw i32 %.02, 1
  br label %19, !llvm.loop !20

48:                                               ; preds = %19
  br label %49

49:                                               ; preds = %78, %48
  %.05 = phi i32 [ 0, %48 ], [ %79, %78 ]
  %50 = icmp slt i32 %.05, 16
  br i1 %50, label %51, label %80

51:                                               ; preds = %49
  %52 = sext i32 %.05 to i64
  %53 = getelementptr inbounds [16 x i32], ptr @counts, i64 0, i64 %52
  %54 = load i32, ptr %53, align 4
  %55 = icmp eq i32 %54, 0
  br i1 %55, label %56, label %57

56:                                               ; preds = %51
  br label %78

57:                                               ; preds = %51
  br label %58

58:                                               ; preds = %75, %57
  %.03 = phi i32 [ 0, %57 ], [ %76, %75 ]
  %59 = icmp slt i32 %.03, 8
  br i1 %59, label %60, label %77

60:                                               ; preds = %58
  %61 = mul nsw i32 %.05, 8
  %62 = add nsw i32 %61, %.03
  %63 = sext i32 %62 to i64
  %64 = getelementptr inbounds [128 x double], ptr @sums, i64 0, i64 %63
  %65 = load double, ptr %64, align 8
  %66 = sext i32 %.05 to i64
  %67 = getelementptr inbounds [16 x i32], ptr @counts, i64 0, i64 %66
  %68 = load i32, ptr %67, align 4
  %69 = sitofp i32 %68 to double
  %70 = fdiv double %65, %69
  %71 = mul nsw i32 %.05, 8
  %72 = add nsw i32 %71, %.03
  %73 = sext i32 %72 to i64
  %74 = getelementptr inbounds [128 x double], ptr @centers, i64 0, i64 %73
  store double %70, ptr %74, align 8
  br label %75

75:                                               ; preds = %60
  %76 = add nsw i32 %.03, 1
  br label %58, !llvm.loop !21

77:                                               ; preds = %58
  br label %78

78:                                               ; preds = %77, %56
  %79 = add nsw i32 %.05, 1
  br label %49, !llvm.loop !22

80:                                               ; preds = %49
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
!16 = distinct !{!16, !7}
!17 = distinct !{!17, !7}
!18 = distinct !{!18, !7}
!19 = distinct !{!19, !7}
!20 = distinct !{!20, !7}
!21 = distinct !{!21, !7}
!22 = distinct !{!22, !7}

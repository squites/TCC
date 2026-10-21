; ModuleID = 'benchmarks/kmeans.c'
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
  %12 = icmp slt i32 %11, 20
  br i1 %12, label %13, label %17

13:                                               ; preds = %10
  call void @assign_clusters()
  call void @update_centers()
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
  %26 = icmp slt i32 %25, 16
  br i1 %26, label %27, label %48

27:                                               ; preds = %24
  store i32 0, ptr %8, align 4
  br label %28

28:                                               ; preds = %41, %27
  %29 = load i32, ptr %8, align 4
  %30 = icmp slt i32 %29, 8
  br i1 %30, label %31, label %44

31:                                               ; preds = %28
  %32 = load i32, ptr %7, align 4
  %33 = mul nsw i32 %32, 8
  %34 = load i32, ptr %8, align 4
  %35 = add nsw i32 %33, %34
  %36 = sext i32 %35 to i64
  %37 = getelementptr inbounds [128 x double], ptr @centers, i64 0, i64 %36
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
  %50 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef 100000, i32 noundef 16, i32 noundef 20, double noundef %49)
  %51 = load double, ptr %6, align 8
  %52 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, double noundef %51)
  ret i32 0
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define internal void @init() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  br label %5

5:                                                ; preds = %24, %0
  %6 = load i32, ptr %1, align 4
  %7 = icmp slt i32 %6, 100000
  br i1 %7, label %8, label %27

8:                                                ; preds = %5
  store i32 0, ptr %2, align 4
  br label %9

9:                                                ; preds = %20, %8
  %10 = load i32, ptr %2, align 4
  %11 = icmp slt i32 %10, 8
  br i1 %11, label %12, label %23

12:                                               ; preds = %9
  %13 = call double @frand()
  %14 = load i32, ptr %1, align 4
  %15 = mul nsw i32 %14, 8
  %16 = load i32, ptr %2, align 4
  %17 = add nsw i32 %15, %16
  %18 = sext i32 %17 to i64
  %19 = getelementptr inbounds [800000 x double], ptr @points, i64 0, i64 %18
  store double %13, ptr %19, align 8
  br label %20

20:                                               ; preds = %12
  %21 = load i32, ptr %2, align 4
  %22 = add nsw i32 %21, 1
  store i32 %22, ptr %2, align 4
  br label %9, !llvm.loop !10

23:                                               ; preds = %9
  br label %24

24:                                               ; preds = %23
  %25 = load i32, ptr %1, align 4
  %26 = add nsw i32 %25, 1
  store i32 %26, ptr %1, align 4
  br label %5, !llvm.loop !11

27:                                               ; preds = %5
  store i32 0, ptr %3, align 4
  br label %28

28:                                               ; preds = %53, %27
  %29 = load i32, ptr %3, align 4
  %30 = icmp slt i32 %29, 16
  br i1 %30, label %31, label %56

31:                                               ; preds = %28
  store i32 0, ptr %4, align 4
  br label %32

32:                                               ; preds = %49, %31
  %33 = load i32, ptr %4, align 4
  %34 = icmp slt i32 %33, 8
  br i1 %34, label %35, label %52

35:                                               ; preds = %32
  %36 = load i32, ptr %3, align 4
  %37 = mul nsw i32 %36, 8
  %38 = load i32, ptr %4, align 4
  %39 = add nsw i32 %37, %38
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds [800000 x double], ptr @points, i64 0, i64 %40
  %42 = load double, ptr %41, align 8
  %43 = load i32, ptr %3, align 4
  %44 = mul nsw i32 %43, 8
  %45 = load i32, ptr %4, align 4
  %46 = add nsw i32 %44, %45
  %47 = sext i32 %46 to i64
  %48 = getelementptr inbounds [128 x double], ptr @centers, i64 0, i64 %47
  store double %42, ptr %48, align 8
  br label %49

49:                                               ; preds = %35
  %50 = load i32, ptr %4, align 4
  %51 = add nsw i32 %50, 1
  store i32 %51, ptr %4, align 4
  br label %32, !llvm.loop !12

52:                                               ; preds = %32
  br label %53

53:                                               ; preds = %52
  %54 = load i32, ptr %3, align 4
  %55 = add nsw i32 %54, 1
  store i32 %55, ptr %3, align 4
  br label %28, !llvm.loop !13

56:                                               ; preds = %28
  ret void
}

declare i64 @"\01_clock"() #1

; Function Attrs: noinline nounwind ssp uwtable(sync)
define internal void @assign_clusters() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca double, align 8
  %4 = alloca i32, align 4
  %5 = alloca double, align 8
  %6 = alloca i32, align 4
  %7 = alloca double, align 8
  store i32 0, ptr %1, align 4
  br label %8

8:                                                ; preds = %58, %0
  %9 = load i32, ptr %1, align 4
  %10 = icmp slt i32 %9, 100000
  br i1 %10, label %11, label %61

11:                                               ; preds = %8
  store i32 0, ptr %2, align 4
  store double 0x7FEFFFFFFFFFFFFF, ptr %3, align 8
  store i32 0, ptr %4, align 4
  br label %12

12:                                               ; preds = %50, %11
  %13 = load i32, ptr %4, align 4
  %14 = icmp slt i32 %13, 16
  br i1 %14, label %15, label %53

15:                                               ; preds = %12
  store double 0.000000e+00, ptr %5, align 8
  store i32 0, ptr %6, align 4
  br label %16

16:                                               ; preds = %39, %15
  %17 = load i32, ptr %6, align 4
  %18 = icmp slt i32 %17, 8
  br i1 %18, label %19, label %42

19:                                               ; preds = %16
  %20 = load i32, ptr %1, align 4
  %21 = mul nsw i32 %20, 8
  %22 = load i32, ptr %6, align 4
  %23 = add nsw i32 %21, %22
  %24 = sext i32 %23 to i64
  %25 = getelementptr inbounds [800000 x double], ptr @points, i64 0, i64 %24
  %26 = load double, ptr %25, align 8
  %27 = load i32, ptr %4, align 4
  %28 = mul nsw i32 %27, 8
  %29 = load i32, ptr %6, align 4
  %30 = add nsw i32 %28, %29
  %31 = sext i32 %30 to i64
  %32 = getelementptr inbounds [128 x double], ptr @centers, i64 0, i64 %31
  %33 = load double, ptr %32, align 8
  %34 = fsub double %26, %33
  store double %34, ptr %7, align 8
  %35 = load double, ptr %7, align 8
  %36 = load double, ptr %7, align 8
  %37 = load double, ptr %5, align 8
  %38 = call double @llvm.fmuladd.f64(double %35, double %36, double %37)
  store double %38, ptr %5, align 8
  br label %39

39:                                               ; preds = %19
  %40 = load i32, ptr %6, align 4
  %41 = add nsw i32 %40, 1
  store i32 %41, ptr %6, align 4
  br label %16, !llvm.loop !14

42:                                               ; preds = %16
  %43 = load double, ptr %5, align 8
  %44 = load double, ptr %3, align 8
  %45 = fcmp olt double %43, %44
  br i1 %45, label %46, label %49

46:                                               ; preds = %42
  %47 = load double, ptr %5, align 8
  store double %47, ptr %3, align 8
  %48 = load i32, ptr %4, align 4
  store i32 %48, ptr %2, align 4
  br label %49

49:                                               ; preds = %46, %42
  br label %50

50:                                               ; preds = %49
  %51 = load i32, ptr %4, align 4
  %52 = add nsw i32 %51, 1
  store i32 %52, ptr %4, align 4
  br label %12, !llvm.loop !15

53:                                               ; preds = %12
  %54 = load i32, ptr %2, align 4
  %55 = load i32, ptr %1, align 4
  %56 = sext i32 %55 to i64
  %57 = getelementptr inbounds [100000 x i32], ptr @assign, i64 0, i64 %56
  store i32 %54, ptr %57, align 4
  br label %58

58:                                               ; preds = %53
  %59 = load i32, ptr %1, align 4
  %60 = add nsw i32 %59, 1
  store i32 %60, ptr %1, align 4
  br label %8, !llvm.loop !16

61:                                               ; preds = %8
  ret void
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define internal void @update_centers() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  br label %8

8:                                                ; preds = %29, %0
  %9 = load i32, ptr %1, align 4
  %10 = icmp slt i32 %9, 16
  br i1 %10, label %11, label %32

11:                                               ; preds = %8
  %12 = load i32, ptr %1, align 4
  %13 = sext i32 %12 to i64
  %14 = getelementptr inbounds [16 x i32], ptr @counts, i64 0, i64 %13
  store i32 0, ptr %14, align 4
  store i32 0, ptr %2, align 4
  br label %15

15:                                               ; preds = %25, %11
  %16 = load i32, ptr %2, align 4
  %17 = icmp slt i32 %16, 8
  br i1 %17, label %18, label %28

18:                                               ; preds = %15
  %19 = load i32, ptr %1, align 4
  %20 = mul nsw i32 %19, 8
  %21 = load i32, ptr %2, align 4
  %22 = add nsw i32 %20, %21
  %23 = sext i32 %22 to i64
  %24 = getelementptr inbounds [128 x double], ptr @sums, i64 0, i64 %23
  store double 0.000000e+00, ptr %24, align 8
  br label %25

25:                                               ; preds = %18
  %26 = load i32, ptr %2, align 4
  %27 = add nsw i32 %26, 1
  store i32 %27, ptr %2, align 4
  br label %15, !llvm.loop !17

28:                                               ; preds = %15
  br label %29

29:                                               ; preds = %28
  %30 = load i32, ptr %1, align 4
  %31 = add nsw i32 %30, 1
  store i32 %31, ptr %1, align 4
  br label %8, !llvm.loop !18

32:                                               ; preds = %8
  store i32 0, ptr %3, align 4
  br label %33

33:                                               ; preds = %69, %32
  %34 = load i32, ptr %3, align 4
  %35 = icmp slt i32 %34, 100000
  br i1 %35, label %36, label %72

36:                                               ; preds = %33
  %37 = load i32, ptr %3, align 4
  %38 = sext i32 %37 to i64
  %39 = getelementptr inbounds [100000 x i32], ptr @assign, i64 0, i64 %38
  %40 = load i32, ptr %39, align 4
  store i32 %40, ptr %4, align 4
  %41 = load i32, ptr %4, align 4
  %42 = sext i32 %41 to i64
  %43 = getelementptr inbounds [16 x i32], ptr @counts, i64 0, i64 %42
  %44 = load i32, ptr %43, align 4
  %45 = add nsw i32 %44, 1
  store i32 %45, ptr %43, align 4
  store i32 0, ptr %5, align 4
  br label %46

46:                                               ; preds = %65, %36
  %47 = load i32, ptr %5, align 4
  %48 = icmp slt i32 %47, 8
  br i1 %48, label %49, label %68

49:                                               ; preds = %46
  %50 = load i32, ptr %3, align 4
  %51 = mul nsw i32 %50, 8
  %52 = load i32, ptr %5, align 4
  %53 = add nsw i32 %51, %52
  %54 = sext i32 %53 to i64
  %55 = getelementptr inbounds [800000 x double], ptr @points, i64 0, i64 %54
  %56 = load double, ptr %55, align 8
  %57 = load i32, ptr %4, align 4
  %58 = mul nsw i32 %57, 8
  %59 = load i32, ptr %5, align 4
  %60 = add nsw i32 %58, %59
  %61 = sext i32 %60 to i64
  %62 = getelementptr inbounds [128 x double], ptr @sums, i64 0, i64 %61
  %63 = load double, ptr %62, align 8
  %64 = fadd double %63, %56
  store double %64, ptr %62, align 8
  br label %65

65:                                               ; preds = %49
  %66 = load i32, ptr %5, align 4
  %67 = add nsw i32 %66, 1
  store i32 %67, ptr %5, align 4
  br label %46, !llvm.loop !19

68:                                               ; preds = %46
  br label %69

69:                                               ; preds = %68
  %70 = load i32, ptr %3, align 4
  %71 = add nsw i32 %70, 1
  store i32 %71, ptr %3, align 4
  br label %33, !llvm.loop !20

72:                                               ; preds = %33
  store i32 0, ptr %6, align 4
  br label %73

73:                                               ; preds = %111, %72
  %74 = load i32, ptr %6, align 4
  %75 = icmp slt i32 %74, 16
  br i1 %75, label %76, label %114

76:                                               ; preds = %73
  %77 = load i32, ptr %6, align 4
  %78 = sext i32 %77 to i64
  %79 = getelementptr inbounds [16 x i32], ptr @counts, i64 0, i64 %78
  %80 = load i32, ptr %79, align 4
  %81 = icmp eq i32 %80, 0
  br i1 %81, label %82, label %83

82:                                               ; preds = %76
  br label %111

83:                                               ; preds = %76
  store i32 0, ptr %7, align 4
  br label %84

84:                                               ; preds = %107, %83
  %85 = load i32, ptr %7, align 4
  %86 = icmp slt i32 %85, 8
  br i1 %86, label %87, label %110

87:                                               ; preds = %84
  %88 = load i32, ptr %6, align 4
  %89 = mul nsw i32 %88, 8
  %90 = load i32, ptr %7, align 4
  %91 = add nsw i32 %89, %90
  %92 = sext i32 %91 to i64
  %93 = getelementptr inbounds [128 x double], ptr @sums, i64 0, i64 %92
  %94 = load double, ptr %93, align 8
  %95 = load i32, ptr %6, align 4
  %96 = sext i32 %95 to i64
  %97 = getelementptr inbounds [16 x i32], ptr @counts, i64 0, i64 %96
  %98 = load i32, ptr %97, align 4
  %99 = sitofp i32 %98 to double
  %100 = fdiv double %94, %99
  %101 = load i32, ptr %6, align 4
  %102 = mul nsw i32 %101, 8
  %103 = load i32, ptr %7, align 4
  %104 = add nsw i32 %102, %103
  %105 = sext i32 %104 to i64
  %106 = getelementptr inbounds [128 x double], ptr @centers, i64 0, i64 %105
  store double %100, ptr %106, align 8
  br label %107

107:                                              ; preds = %87
  %108 = load i32, ptr %7, align 4
  %109 = add nsw i32 %108, 1
  store i32 %109, ptr %7, align 4
  br label %84, !llvm.loop !21

110:                                              ; preds = %84
  br label %111

111:                                              ; preds = %110, %82
  %112 = load i32, ptr %6, align 4
  %113 = add nsw i32 %112, 1
  store i32 %113, ptr %6, align 4
  br label %73, !llvm.loop !22

114:                                              ; preds = %73
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

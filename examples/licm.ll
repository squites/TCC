; ModuleID = 'loops.ll'
source_filename = "loops.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @test_licm(ptr noundef %0, float noundef %1, float noundef %2, i32 noundef %3) #0 {
  %5 = alloca ptr, align 8
  %6 = alloca float, align 4
  %7 = alloca float, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  store ptr %0, ptr %5, align 8
  store float %1, ptr %6, align 4
  store float %2, ptr %7, align 4
  store i32 %3, ptr %8, align 4
  store i32 0, ptr %9, align 4
  br label %10

10:                                               ; preds = %27, %4
  %11 = load i32, ptr %9, align 4
  %12 = load i32, ptr %8, align 4
  %13 = icmp slt i32 %11, %12
  br i1 %13, label %14, label %30

14:                                               ; preds = %10
  %15 = load ptr, ptr %5, align 8
  %16 = load i32, ptr %9, align 4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds float, ptr %15, i64 %17
  %19 = load float, ptr %18, align 4
  %20 = load float, ptr %6, align 4
  %21 = load float, ptr %7, align 4
  %22 = call float @llvm.fmuladd.f32(float %20, float %21, float %19)
  %23 = load ptr, ptr %5, align 8
  %24 = load i32, ptr %9, align 4
  %25 = sext i32 %24 to i64
  %26 = getelementptr inbounds float, ptr %23, i64 %25
  store float %22, ptr %26, align 4
  br label %27

27:                                               ; preds = %14
  %28 = load i32, ptr %9, align 4
  %29 = add nsw i32 %28, 1
  store i32 %29, ptr %9, align 4
  br label %10, !llvm.loop !5

30:                                               ; preds = %10
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.fmuladd.f32(float, float, float) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @test_licm_blocked(ptr noundef %0, float noundef %1, i32 noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca float, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store float %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  store i32 0, ptr %7, align 4
  br label %8

8:                                                ; preds = %28, %3
  %9 = load i32, ptr %7, align 4
  %10 = load i32, ptr %6, align 4
  %11 = icmp slt i32 %9, %10
  br i1 %11, label %12, label %31

12:                                               ; preds = %8
  %13 = load ptr, ptr %4, align 8
  %14 = load i32, ptr %7, align 4
  %15 = sext i32 %14 to i64
  %16 = getelementptr inbounds float, ptr %13, i64 %15
  %17 = load float, ptr %16, align 4
  %18 = fpext float %17 to double
  %19 = load float, ptr %5, align 4
  %20 = fpext float %19 to double
  %21 = call double @llvm.sqrt.f64(double %20)
  %22 = fadd double %18, %21
  %23 = fptrunc double %22 to float
  %24 = load ptr, ptr %4, align 8
  %25 = load i32, ptr %7, align 4
  %26 = sext i32 %25 to i64
  %27 = getelementptr inbounds float, ptr %24, i64 %26
  store float %23, ptr %27, align 4
  br label %28

28:                                               ; preds = %12
  %29 = load i32, ptr %7, align 4
  %30 = add nsw i32 %29, 1
  store i32 %30, ptr %7, align 4
  br label %8, !llvm.loop !7

31:                                               ; preds = %8
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.sqrt.f64(double) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @test_unswitch(ptr noundef %0, ptr noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  store ptr %0, ptr %5, align 8
  store ptr %1, ptr %6, align 8
  store i32 %2, ptr %7, align 4
  store i32 %3, ptr %8, align 4
  store i32 0, ptr %9, align 4
  br label %10

10:                                               ; preds = %40, %4
  %11 = load i32, ptr %9, align 4
  %12 = load i32, ptr %7, align 4
  %13 = icmp slt i32 %11, %12
  br i1 %13, label %14, label %43

14:                                               ; preds = %10
  %15 = load i32, ptr %8, align 4
  %16 = icmp eq i32 %15, 0
  br i1 %16, label %17, label %28

17:                                               ; preds = %14
  %18 = load ptr, ptr %6, align 8
  %19 = load i32, ptr %9, align 4
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds float, ptr %18, i64 %20
  %22 = load float, ptr %21, align 4
  %23 = fmul float %22, 2.000000e+00
  %24 = load ptr, ptr %5, align 8
  %25 = load i32, ptr %9, align 4
  %26 = sext i32 %25 to i64
  %27 = getelementptr inbounds float, ptr %24, i64 %26
  store float %23, ptr %27, align 4
  br label %39

28:                                               ; preds = %14
  %29 = load ptr, ptr %6, align 8
  %30 = load i32, ptr %9, align 4
  %31 = sext i32 %30 to i64
  %32 = getelementptr inbounds float, ptr %29, i64 %31
  %33 = load float, ptr %32, align 4
  %34 = fadd float %33, 2.000000e+00
  %35 = load ptr, ptr %5, align 8
  %36 = load i32, ptr %9, align 4
  %37 = sext i32 %36 to i64
  %38 = getelementptr inbounds float, ptr %35, i64 %37
  store float %34, ptr %38, align 4
  br label %39

39:                                               ; preds = %28, %17
  br label %40

40:                                               ; preds = %39
  %41 = load i32, ptr %9, align 4
  %42 = add nsw i32 %41, 1
  store i32 %42, ptr %9, align 4
  br label %10, !llvm.loop !8

43:                                               ; preds = %10
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @test_vectorize(ptr noundef %0, ptr noundef %1, ptr noundef %2, i32 noundef %3) #0 {
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  store ptr %0, ptr %5, align 8
  store ptr %1, ptr %6, align 8
  store ptr %2, ptr %7, align 8
  store i32 %3, ptr %8, align 4
  store i32 0, ptr %9, align 4
  br label %10

10:                                               ; preds = %30, %4
  %11 = load i32, ptr %9, align 4
  %12 = load i32, ptr %8, align 4
  %13 = icmp slt i32 %11, %12
  br i1 %13, label %14, label %33

14:                                               ; preds = %10
  %15 = load ptr, ptr %5, align 8
  %16 = load i32, ptr %9, align 4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds float, ptr %15, i64 %17
  %19 = load float, ptr %18, align 4
  %20 = load ptr, ptr %6, align 8
  %21 = load i32, ptr %9, align 4
  %22 = sext i32 %21 to i64
  %23 = getelementptr inbounds float, ptr %20, i64 %22
  %24 = load float, ptr %23, align 4
  %25 = fadd float %19, %24
  %26 = load ptr, ptr %7, align 8
  %27 = load i32, ptr %9, align 4
  %28 = sext i32 %27 to i64
  %29 = getelementptr inbounds float, ptr %26, i64 %28
  store float %25, ptr %29, align 4
  br label %30

30:                                               ; preds = %14
  %31 = load i32, ptr %9, align 4
  %32 = add nsw i32 %31, 1
  store i32 %32, ptr %9, align 4
  br label %10, !llvm.loop !9

33:                                               ; preds = %10
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @test_interchange(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  store i32 0, ptr %5, align 4
  br label %7

7:                                                ; preds = %35, %2
  %8 = load i32, ptr %5, align 4
  %9 = icmp slt i32 %8, 256
  br i1 %9, label %10, label %38

10:                                               ; preds = %7
  store i32 0, ptr %6, align 4
  br label %11

11:                                               ; preds = %31, %10
  %12 = load i32, ptr %6, align 4
  %13 = icmp slt i32 %12, 256
  br i1 %13, label %14, label %34

14:                                               ; preds = %11
  %15 = load ptr, ptr %3, align 8
  %16 = load i32, ptr %6, align 4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds [256 x float], ptr %15, i64 %17
  %19 = load i32, ptr %5, align 4
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds [256 x float], ptr %18, i64 0, i64 %20
  %22 = load float, ptr %21, align 4
  %23 = fmul float %22, 2.000000e+00
  %24 = load ptr, ptr %4, align 8
  %25 = load i32, ptr %6, align 4
  %26 = sext i32 %25 to i64
  %27 = getelementptr inbounds [256 x float], ptr %24, i64 %26
  %28 = load i32, ptr %5, align 4
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds [256 x float], ptr %27, i64 0, i64 %29
  store float %23, ptr %30, align 4
  br label %31

31:                                               ; preds = %14
  %32 = load i32, ptr %6, align 4
  %33 = add nsw i32 %32, 1
  store i32 %33, ptr %6, align 4
  br label %11, !llvm.loop !10

34:                                               ; preds = %11
  br label %35

35:                                               ; preds = %34
  %36 = load i32, ptr %5, align 4
  %37 = add nsw i32 %36, 1
  store i32 %37, ptr %5, align 4
  br label %7, !llvm.loop !11

38:                                               ; preds = %7
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @test_tiling(ptr noundef %0, ptr noundef %1, ptr noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  store i32 0, ptr %7, align 4
  br label %10

10:                                               ; preds = %55, %3
  %11 = load i32, ptr %7, align 4
  %12 = icmp slt i32 %11, 256
  br i1 %12, label %13, label %58

13:                                               ; preds = %10
  store i32 0, ptr %8, align 4
  br label %14

14:                                               ; preds = %51, %13
  %15 = load i32, ptr %8, align 4
  %16 = icmp slt i32 %15, 256
  br i1 %16, label %17, label %54

17:                                               ; preds = %14
  store i32 0, ptr %9, align 4
  br label %18

18:                                               ; preds = %47, %17
  %19 = load i32, ptr %9, align 4
  %20 = icmp slt i32 %19, 256
  br i1 %20, label %21, label %50

21:                                               ; preds = %18
  %22 = load ptr, ptr %4, align 8
  %23 = load i32, ptr %7, align 4
  %24 = sext i32 %23 to i64
  %25 = getelementptr inbounds [256 x float], ptr %22, i64 %24
  %26 = load i32, ptr %9, align 4
  %27 = sext i32 %26 to i64
  %28 = getelementptr inbounds [256 x float], ptr %25, i64 0, i64 %27
  %29 = load float, ptr %28, align 4
  %30 = load ptr, ptr %5, align 8
  %31 = load i32, ptr %9, align 4
  %32 = sext i32 %31 to i64
  %33 = getelementptr inbounds [256 x float], ptr %30, i64 %32
  %34 = load i32, ptr %8, align 4
  %35 = sext i32 %34 to i64
  %36 = getelementptr inbounds [256 x float], ptr %33, i64 0, i64 %35
  %37 = load float, ptr %36, align 4
  %38 = load ptr, ptr %6, align 8
  %39 = load i32, ptr %7, align 4
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds [256 x float], ptr %38, i64 %40
  %42 = load i32, ptr %8, align 4
  %43 = sext i32 %42 to i64
  %44 = getelementptr inbounds [256 x float], ptr %41, i64 0, i64 %43
  %45 = load float, ptr %44, align 4
  %46 = call float @llvm.fmuladd.f32(float %29, float %37, float %45)
  store float %46, ptr %44, align 4
  br label %47

47:                                               ; preds = %21
  %48 = load i32, ptr %9, align 4
  %49 = add nsw i32 %48, 1
  store i32 %49, ptr %9, align 4
  br label %18, !llvm.loop !12

50:                                               ; preds = %18
  br label %51

51:                                               ; preds = %50
  %52 = load i32, ptr %8, align 4
  %53 = add nsw i32 %52, 1
  store i32 %53, ptr %8, align 4
  br label %14, !llvm.loop !13

54:                                               ; preds = %14
  br label %55

55:                                               ; preds = %54
  %56 = load i32, ptr %7, align 4
  %57 = add nsw i32 %56, 1
  store i32 %57, ptr %7, align 4
  br label %10, !llvm.loop !14

58:                                               ; preds = %10
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @test_deletion(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  store i32 0, ptr %3, align 4
  store i32 0, ptr %4, align 4
  br label %5

5:                                                ; preds = %13, %1
  %6 = load i32, ptr %4, align 4
  %7 = load i32, ptr %2, align 4
  %8 = icmp slt i32 %6, %7
  br i1 %8, label %9, label %16

9:                                                ; preds = %5
  %10 = load i32, ptr %4, align 4
  %11 = load i32, ptr %3, align 4
  %12 = add nsw i32 %11, %10
  store i32 %12, ptr %3, align 4
  br label %13

13:                                               ; preds = %9
  %14 = load i32, ptr %4, align 4
  %15 = add nsw i32 %14, 1
  store i32 %15, ptr %4, align 4
  br label %5, !llvm.loop !15

16:                                               ; preds = %5
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @test_unroll(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  store i32 0, ptr %5, align 4
  br label %6

6:                                                ; preds = %20, %2
  %7 = load i32, ptr %5, align 4
  %8 = icmp slt i32 %7, 8
  br i1 %8, label %9, label %23

9:                                                ; preds = %6
  %10 = load ptr, ptr %4, align 8
  %11 = load i32, ptr %5, align 4
  %12 = sext i32 %11 to i64
  %13 = getelementptr inbounds float, ptr %10, i64 %12
  %14 = load float, ptr %13, align 4
  %15 = fmul float %14, 0x40091EB860000000
  %16 = load ptr, ptr %3, align 8
  %17 = load i32, ptr %5, align 4
  %18 = sext i32 %17 to i64
  %19 = getelementptr inbounds float, ptr %16, i64 %18
  store float %15, ptr %19, align 4
  br label %20

20:                                               ; preds = %9
  %21 = load i32, ptr %5, align 4
  %22 = add nsw i32 %21, 1
  store i32 %22, ptr %5, align 4
  br label %6, !llvm.loop !16

23:                                               ; preds = %6
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define float @test_reduction(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca float, align 4
  %6 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  store float 0.000000e+00, ptr %5, align 4
  store i32 0, ptr %6, align 4
  br label %7

7:                                                ; preds = %19, %2
  %8 = load i32, ptr %6, align 4
  %9 = load i32, ptr %4, align 4
  %10 = icmp slt i32 %8, %9
  br i1 %10, label %11, label %22

11:                                               ; preds = %7
  %12 = load ptr, ptr %3, align 8
  %13 = load i32, ptr %6, align 4
  %14 = sext i32 %13 to i64
  %15 = getelementptr inbounds float, ptr %12, i64 %14
  %16 = load float, ptr %15, align 4
  %17 = load float, ptr %5, align 4
  %18 = fadd float %17, %16
  store float %18, ptr %5, align 4
  br label %19

19:                                               ; preds = %11
  %20 = load i32, ptr %6, align 4
  %21 = add nsw i32 %20, 1
  store i32 %21, ptr %6, align 4
  br label %7, !llvm.loop !17

22:                                               ; preds = %7
  %23 = load float, ptr %5, align 4
  ret float %23
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [256 x float], align 4
  %3 = alloca [256 x float], align 4
  %4 = alloca [256 x float], align 4
  %5 = alloca [256 x [256 x float]], align 4
  %6 = alloca [256 x [256 x float]], align 4
  %7 = alloca [256 x [256 x float]], align 4
  %8 = alloca float, align 4
  store i32 0, ptr %1, align 4
  %9 = getelementptr inbounds [256 x float], ptr %2, i64 0, i64 0
  call void @test_licm(ptr noundef %9, float noundef 2.000000e+00, float noundef 3.000000e+00, i32 noundef 256)
  %10 = getelementptr inbounds [256 x float], ptr %2, i64 0, i64 0
  call void @test_licm_blocked(ptr noundef %10, float noundef 4.000000e+00, i32 noundef 256)
  %11 = getelementptr inbounds [256 x float], ptr %2, i64 0, i64 0
  %12 = getelementptr inbounds [256 x float], ptr %3, i64 0, i64 0
  call void @test_unswitch(ptr noundef %11, ptr noundef %12, i32 noundef 256, i32 noundef 0)
  %13 = getelementptr inbounds [256 x float], ptr %2, i64 0, i64 0
  %14 = getelementptr inbounds [256 x float], ptr %3, i64 0, i64 0
  %15 = getelementptr inbounds [256 x float], ptr %4, i64 0, i64 0
  call void @test_vectorize(ptr noundef %13, ptr noundef %14, ptr noundef %15, i32 noundef 256)
  %16 = getelementptr inbounds [256 x [256 x float]], ptr %5, i64 0, i64 0
  %17 = getelementptr inbounds [256 x [256 x float]], ptr %6, i64 0, i64 0
  call void @test_interchange(ptr noundef %16, ptr noundef %17)
  %18 = getelementptr inbounds [256 x [256 x float]], ptr %5, i64 0, i64 0
  %19 = getelementptr inbounds [256 x [256 x float]], ptr %6, i64 0, i64 0
  %20 = getelementptr inbounds [256 x [256 x float]], ptr %7, i64 0, i64 0
  call void @test_tiling(ptr noundef %18, ptr noundef %19, ptr noundef %20)
  call void @test_deletion(i32 noundef 256)
  %21 = getelementptr inbounds [256 x float], ptr %2, i64 0, i64 0
  %22 = getelementptr inbounds [256 x float], ptr %3, i64 0, i64 0
  call void @test_unroll(ptr noundef %21, ptr noundef %22)
  %23 = getelementptr inbounds [256 x float], ptr %2, i64 0, i64 0
  %24 = call float @test_reduction(ptr noundef %23, i32 noundef 256)
  store float %24, ptr %8, align 4
  ret i32 0
}

attributes #0 = { noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" "tune-cpu"="apple-m5" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }

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
!11 = distinct !{!11, !6}
!12 = distinct !{!12, !6}
!13 = distinct !{!13, !6}
!14 = distinct !{!14, !6}
!15 = distinct !{!15, !6}
!16 = distinct !{!16, !6}
!17 = distinct !{!17, !6}

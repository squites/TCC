; ModuleID = 'loops.c'
source_filename = "loops.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

; Function Attrs: nofree norecurse nosync nounwind ssp memory(argmem: readwrite) uwtable(sync)
define void @test_licm(ptr noundef captures(none) %0, float noundef %1, float noundef %2, i32 noundef %3) local_unnamed_addr #0 {
  %5 = icmp sgt i32 %3, 0
  br i1 %5, label %6, label %56

6:                                                ; preds = %4
  %7 = zext nneg i32 %3 to i64
  %8 = icmp ult i32 %3, 4
  br i1 %8, label %54, label %9

9:                                                ; preds = %6
  %10 = icmp ult i32 %3, 16
  br i1 %10, label %38, label %11

11:                                               ; preds = %9
  %12 = and i64 %7, 12
  %13 = and i64 %7, 2147483632
  %14 = insertelement <4 x float> poison, float %1, i64 0
  %15 = shufflevector <4 x float> %14, <4 x float> poison, <4 x i32> zeroinitializer
  %16 = insertelement <4 x float> poison, float %2, i64 0
  %17 = shufflevector <4 x float> %16, <4 x float> poison, <4 x i32> zeroinitializer
  br label %18

18:                                               ; preds = %18, %11
  %19 = phi i64 [ 0, %11 ], [ %32, %18 ]
  %20 = getelementptr inbounds nuw [4 x i8], ptr %0, i64 %19
  %21 = getelementptr inbounds nuw i8, ptr %20, i64 16
  %22 = getelementptr inbounds nuw i8, ptr %20, i64 32
  %23 = getelementptr inbounds nuw i8, ptr %20, i64 48
  %24 = load <4 x float>, ptr %20, align 4, !tbaa !9
  %25 = load <4 x float>, ptr %21, align 4, !tbaa !9
  %26 = load <4 x float>, ptr %22, align 4, !tbaa !9
  %27 = load <4 x float>, ptr %23, align 4, !tbaa !9
  %28 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %15, <4 x float> %17, <4 x float> %24)
  %29 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %15, <4 x float> %17, <4 x float> %25)
  %30 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %15, <4 x float> %17, <4 x float> %26)
  %31 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %15, <4 x float> %17, <4 x float> %27)
  store <4 x float> %28, ptr %20, align 4, !tbaa !9
  store <4 x float> %29, ptr %21, align 4, !tbaa !9
  store <4 x float> %30, ptr %22, align 4, !tbaa !9
  store <4 x float> %31, ptr %23, align 4, !tbaa !9
  %32 = add nuw i64 %19, 16
  %33 = icmp eq i64 %32, %13
  br i1 %33, label %34, label %18, !llvm.loop !11

34:                                               ; preds = %18
  %35 = icmp eq i64 %13, %7
  br i1 %35, label %56, label %36

36:                                               ; preds = %34
  %37 = icmp eq i64 %12, 0
  br i1 %37, label %54, label %38, !prof !15

38:                                               ; preds = %9, %36
  %39 = phi i64 [ %13, %36 ], [ 0, %9 ]
  %40 = and i64 %7, 2147483644
  %41 = insertelement <4 x float> poison, float %1, i64 0
  %42 = shufflevector <4 x float> %41, <4 x float> poison, <4 x i32> zeroinitializer
  %43 = insertelement <4 x float> poison, float %2, i64 0
  %44 = shufflevector <4 x float> %43, <4 x float> poison, <4 x i32> zeroinitializer
  br label %45

45:                                               ; preds = %45, %38
  %46 = phi i64 [ %39, %38 ], [ %50, %45 ]
  %47 = getelementptr inbounds nuw [4 x i8], ptr %0, i64 %46
  %48 = load <4 x float>, ptr %47, align 4, !tbaa !9
  %49 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %42, <4 x float> %44, <4 x float> %48)
  store <4 x float> %49, ptr %47, align 4, !tbaa !9
  %50 = add nuw i64 %46, 4
  %51 = icmp eq i64 %50, %40
  br i1 %51, label %52, label %45, !llvm.loop !16

52:                                               ; preds = %45
  %53 = icmp eq i64 %40, %7
  br i1 %53, label %56, label %54

54:                                               ; preds = %6, %36, %52
  %55 = phi i64 [ 0, %6 ], [ %13, %36 ], [ %40, %52 ]
  br label %57

56:                                               ; preds = %57, %34, %52, %4
  ret void

57:                                               ; preds = %54, %57
  %58 = phi i64 [ %62, %57 ], [ %55, %54 ]
  %59 = getelementptr inbounds nuw [4 x i8], ptr %0, i64 %58
  %60 = load float, ptr %59, align 4, !tbaa !9
  %61 = tail call float @llvm.fmuladd.f32(float %1, float %2, float %60)
  store float %61, ptr %59, align 4, !tbaa !9
  %62 = add nuw nsw i64 %58, 1
  %63 = icmp eq i64 %62, %7
  br i1 %63, label %56, label %57, !llvm.loop !17
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(ptr captures(none)) #1

; Function Attrs: mustprogress nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.fmuladd.f32(float, float, float) #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(ptr captures(none)) #1

; Function Attrs: nofree norecurse nosync nounwind ssp memory(argmem: readwrite) uwtable(sync)
define void @test_licm_blocked(ptr noundef captures(none) %0, float noundef %1, i32 noundef %2) local_unnamed_addr #0 {
  %4 = icmp sgt i32 %2, 0
  br i1 %4, label %5, label %63

5:                                                ; preds = %3
  %6 = fpext float %1 to double
  %7 = tail call double @llvm.sqrt.f64(double %6)
  %8 = zext nneg i32 %2 to i64
  %9 = icmp ult i32 %2, 4
  br i1 %9, label %61, label %10

10:                                               ; preds = %5
  %11 = icmp ult i32 %2, 16
  br i1 %11, label %45, label %12

12:                                               ; preds = %10
  %13 = and i64 %8, 12
  %14 = and i64 %8, 2147483632
  %15 = insertelement <4 x double> poison, double %7, i64 0
  %16 = shufflevector <4 x double> %15, <4 x double> poison, <4 x i32> zeroinitializer
  br label %17

17:                                               ; preds = %17, %12
  %18 = phi i64 [ 0, %12 ], [ %39, %17 ]
  %19 = getelementptr inbounds nuw [4 x i8], ptr %0, i64 %18
  %20 = getelementptr inbounds nuw i8, ptr %19, i64 16
  %21 = getelementptr inbounds nuw i8, ptr %19, i64 32
  %22 = getelementptr inbounds nuw i8, ptr %19, i64 48
  %23 = load <4 x float>, ptr %19, align 4, !tbaa !9
  %24 = load <4 x float>, ptr %20, align 4, !tbaa !9
  %25 = load <4 x float>, ptr %21, align 4, !tbaa !9
  %26 = load <4 x float>, ptr %22, align 4, !tbaa !9
  %27 = fpext <4 x float> %23 to <4 x double>
  %28 = fpext <4 x float> %24 to <4 x double>
  %29 = fpext <4 x float> %25 to <4 x double>
  %30 = fpext <4 x float> %26 to <4 x double>
  %31 = fadd <4 x double> %16, %27
  %32 = fadd <4 x double> %16, %28
  %33 = fadd <4 x double> %16, %29
  %34 = fadd <4 x double> %16, %30
  %35 = fptrunc <4 x double> %31 to <4 x float>
  %36 = fptrunc <4 x double> %32 to <4 x float>
  %37 = fptrunc <4 x double> %33 to <4 x float>
  %38 = fptrunc <4 x double> %34 to <4 x float>
  store <4 x float> %35, ptr %19, align 4, !tbaa !9
  store <4 x float> %36, ptr %20, align 4, !tbaa !9
  store <4 x float> %37, ptr %21, align 4, !tbaa !9
  store <4 x float> %38, ptr %22, align 4, !tbaa !9
  %39 = add nuw i64 %18, 16
  %40 = icmp eq i64 %39, %14
  br i1 %40, label %41, label %17, !llvm.loop !18

41:                                               ; preds = %17
  %42 = icmp eq i64 %14, %8
  br i1 %42, label %63, label %43

43:                                               ; preds = %41
  %44 = icmp eq i64 %13, 0
  br i1 %44, label %61, label %45, !prof !15

45:                                               ; preds = %10, %43
  %46 = phi i64 [ %14, %43 ], [ 0, %10 ]
  %47 = and i64 %8, 2147483644
  %48 = insertelement <4 x double> poison, double %7, i64 0
  %49 = shufflevector <4 x double> %48, <4 x double> poison, <4 x i32> zeroinitializer
  br label %50

50:                                               ; preds = %50, %45
  %51 = phi i64 [ %46, %45 ], [ %57, %50 ]
  %52 = getelementptr inbounds nuw [4 x i8], ptr %0, i64 %51
  %53 = load <4 x float>, ptr %52, align 4, !tbaa !9
  %54 = fpext <4 x float> %53 to <4 x double>
  %55 = fadd <4 x double> %49, %54
  %56 = fptrunc <4 x double> %55 to <4 x float>
  store <4 x float> %56, ptr %52, align 4, !tbaa !9
  %57 = add nuw i64 %51, 4
  %58 = icmp eq i64 %57, %47
  br i1 %58, label %59, label %50, !llvm.loop !19

59:                                               ; preds = %50
  %60 = icmp eq i64 %47, %8
  br i1 %60, label %63, label %61

61:                                               ; preds = %5, %43, %59
  %62 = phi i64 [ 0, %5 ], [ %14, %43 ], [ %47, %59 ]
  br label %64

63:                                               ; preds = %64, %41, %59, %3
  ret void

64:                                               ; preds = %61, %64
  %65 = phi i64 [ %71, %64 ], [ %62, %61 ]
  %66 = getelementptr inbounds nuw [4 x i8], ptr %0, i64 %65
  %67 = load float, ptr %66, align 4, !tbaa !9
  %68 = fpext float %67 to double
  %69 = fadd double %7, %68
  %70 = fptrunc double %69 to float
  store float %70, ptr %66, align 4, !tbaa !9
  %71 = add nuw nsw i64 %65, 1
  %72 = icmp eq i64 %71, %8
  br i1 %72, label %63, label %64, !llvm.loop !20
}

; Function Attrs: mustprogress nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.sqrt.f64(double) #2

; Function Attrs: nofree norecurse nosync nounwind ssp memory(argmem: readwrite) uwtable(sync)
define void @test_unswitch(ptr noundef writeonly captures(none) %0, ptr noundef readonly captures(none) %1, i32 noundef %2, i32 noundef %3) local_unnamed_addr #0 {
  %5 = icmp sgt i32 %2, 0
  br i1 %5, label %6, label %69

6:                                                ; preds = %4
  %7 = ptrtoaddr ptr %0 to i64
  %8 = ptrtoaddr ptr %1 to i64
  %9 = icmp eq i32 %3, 0
  %10 = zext nneg i32 %2 to i64
  %11 = icmp ult i32 %2, 4
  %12 = sub i64 %7, %8
  %13 = icmp ult i64 %12, 64
  %14 = or i1 %11, %13
  br i1 %14, label %67, label %15

15:                                               ; preds = %6
  %16 = icmp ult i32 %2, 16
  br i1 %16, label %52, label %17

17:                                               ; preds = %15
  %18 = and i64 %10, 12
  %19 = and i64 %10, 2147483632
  br label %20

20:                                               ; preds = %20, %17
  %21 = phi i64 [ 0, %17 ], [ %46, %20 ]
  %22 = getelementptr inbounds nuw [4 x i8], ptr %1, i64 %21
  %23 = getelementptr inbounds nuw i8, ptr %22, i64 16
  %24 = getelementptr inbounds nuw i8, ptr %22, i64 32
  %25 = getelementptr inbounds nuw i8, ptr %22, i64 48
  %26 = load <4 x float>, ptr %22, align 4, !tbaa !9
  %27 = load <4 x float>, ptr %23, align 4, !tbaa !9
  %28 = load <4 x float>, ptr %24, align 4, !tbaa !9
  %29 = load <4 x float>, ptr %25, align 4, !tbaa !9
  %30 = fmul <4 x float> %26, splat (float 2.000000e+00)
  %31 = fmul <4 x float> %27, splat (float 2.000000e+00)
  %32 = fmul <4 x float> %28, splat (float 2.000000e+00)
  %33 = fmul <4 x float> %29, splat (float 2.000000e+00)
  %34 = fadd <4 x float> %26, splat (float 2.000000e+00)
  %35 = fadd <4 x float> %27, splat (float 2.000000e+00)
  %36 = fadd <4 x float> %28, splat (float 2.000000e+00)
  %37 = fadd <4 x float> %29, splat (float 2.000000e+00)
  %38 = select i1 %9, <4 x float> %30, <4 x float> %34
  %39 = select i1 %9, <4 x float> %31, <4 x float> %35
  %40 = select i1 %9, <4 x float> %32, <4 x float> %36
  %41 = select i1 %9, <4 x float> %33, <4 x float> %37
  %42 = getelementptr inbounds nuw [4 x i8], ptr %0, i64 %21
  %43 = getelementptr inbounds nuw i8, ptr %42, i64 16
  %44 = getelementptr inbounds nuw i8, ptr %42, i64 32
  %45 = getelementptr inbounds nuw i8, ptr %42, i64 48
  store <4 x float> %38, ptr %42, align 4, !tbaa !9
  store <4 x float> %39, ptr %43, align 4, !tbaa !9
  store <4 x float> %40, ptr %44, align 4, !tbaa !9
  store <4 x float> %41, ptr %45, align 4, !tbaa !9
  %46 = add nuw i64 %21, 16
  %47 = icmp eq i64 %46, %19
  br i1 %47, label %48, label %20, !llvm.loop !21

48:                                               ; preds = %20
  %49 = icmp eq i64 %19, %10
  br i1 %49, label %69, label %50

50:                                               ; preds = %48
  %51 = icmp eq i64 %18, 0
  br i1 %51, label %67, label %52, !prof !15

52:                                               ; preds = %15, %50
  %53 = phi i64 [ %19, %50 ], [ 0, %15 ]
  %54 = and i64 %10, 2147483644
  br label %55

55:                                               ; preds = %55, %52
  %56 = phi i64 [ %53, %52 ], [ %63, %55 ]
  %57 = getelementptr inbounds nuw [4 x i8], ptr %1, i64 %56
  %58 = load <4 x float>, ptr %57, align 4, !tbaa !9
  %59 = fmul <4 x float> %58, splat (float 2.000000e+00)
  %60 = fadd <4 x float> %58, splat (float 2.000000e+00)
  %61 = select i1 %9, <4 x float> %59, <4 x float> %60
  %62 = getelementptr inbounds nuw [4 x i8], ptr %0, i64 %56
  store <4 x float> %61, ptr %62, align 4, !tbaa !9
  %63 = add nuw i64 %56, 4
  %64 = icmp eq i64 %63, %54
  br i1 %64, label %65, label %55, !llvm.loop !22

65:                                               ; preds = %55
  %66 = icmp eq i64 %54, %10
  br i1 %66, label %69, label %67

67:                                               ; preds = %6, %50, %65
  %68 = phi i64 [ 0, %6 ], [ %19, %50 ], [ %54, %65 ]
  br label %70

69:                                               ; preds = %70, %48, %65, %4
  ret void

70:                                               ; preds = %67, %70
  %71 = phi i64 [ %78, %70 ], [ %68, %67 ]
  %72 = getelementptr inbounds nuw [4 x i8], ptr %1, i64 %71
  %73 = load float, ptr %72, align 4, !tbaa !9
  %74 = fmul float %73, 2.000000e+00
  %75 = fadd float %73, 2.000000e+00
  %76 = select i1 %9, float %74, float %75
  %77 = getelementptr inbounds nuw [4 x i8], ptr %0, i64 %71
  store float %76, ptr %77, align 4, !tbaa !9
  %78 = add nuw nsw i64 %71, 1
  %79 = icmp eq i64 %78, %10
  br i1 %79, label %69, label %70, !llvm.loop !23
}

; Function Attrs: nofree norecurse nosync nounwind ssp memory(argmem: readwrite) uwtable(sync)
define void @test_vectorize(ptr noundef readonly captures(none) %0, ptr noundef readonly captures(none) %1, ptr noundef writeonly captures(none) %2, i32 noundef %3) local_unnamed_addr #0 {
  %5 = ptrtoaddr ptr %1 to i64
  %6 = ptrtoaddr ptr %0 to i64
  %7 = ptrtoaddr ptr %2 to i64
  %8 = icmp sgt i32 %3, 0
  br i1 %8, label %9, label %72

9:                                                ; preds = %4
  %10 = zext nneg i32 %3 to i64
  %11 = icmp ult i32 %3, 4
  br i1 %11, label %70, label %12

12:                                               ; preds = %9
  %13 = sub i64 %7, %6
  %14 = icmp ult i64 %13, 64
  %15 = sub i64 %7, %5
  %16 = icmp ult i64 %15, 64
  %17 = or i1 %14, %16
  br i1 %17, label %70, label %18

18:                                               ; preds = %12
  %19 = icmp ult i32 %3, 16
  br i1 %19, label %55, label %20

20:                                               ; preds = %18
  %21 = and i64 %10, 12
  %22 = and i64 %10, 2147483632
  br label %23

23:                                               ; preds = %23, %20
  %24 = phi i64 [ 0, %20 ], [ %49, %23 ]
  %25 = getelementptr inbounds nuw [4 x i8], ptr %0, i64 %24
  %26 = getelementptr inbounds nuw i8, ptr %25, i64 16
  %27 = getelementptr inbounds nuw i8, ptr %25, i64 32
  %28 = getelementptr inbounds nuw i8, ptr %25, i64 48
  %29 = load <4 x float>, ptr %25, align 4, !tbaa !9
  %30 = load <4 x float>, ptr %26, align 4, !tbaa !9
  %31 = load <4 x float>, ptr %27, align 4, !tbaa !9
  %32 = load <4 x float>, ptr %28, align 4, !tbaa !9
  %33 = getelementptr inbounds nuw [4 x i8], ptr %1, i64 %24
  %34 = getelementptr inbounds nuw i8, ptr %33, i64 16
  %35 = getelementptr inbounds nuw i8, ptr %33, i64 32
  %36 = getelementptr inbounds nuw i8, ptr %33, i64 48
  %37 = load <4 x float>, ptr %33, align 4, !tbaa !9
  %38 = load <4 x float>, ptr %34, align 4, !tbaa !9
  %39 = load <4 x float>, ptr %35, align 4, !tbaa !9
  %40 = load <4 x float>, ptr %36, align 4, !tbaa !9
  %41 = fadd <4 x float> %29, %37
  %42 = fadd <4 x float> %30, %38
  %43 = fadd <4 x float> %31, %39
  %44 = fadd <4 x float> %32, %40
  %45 = getelementptr inbounds nuw [4 x i8], ptr %2, i64 %24
  %46 = getelementptr inbounds nuw i8, ptr %45, i64 16
  %47 = getelementptr inbounds nuw i8, ptr %45, i64 32
  %48 = getelementptr inbounds nuw i8, ptr %45, i64 48
  store <4 x float> %41, ptr %45, align 4, !tbaa !9
  store <4 x float> %42, ptr %46, align 4, !tbaa !9
  store <4 x float> %43, ptr %47, align 4, !tbaa !9
  store <4 x float> %44, ptr %48, align 4, !tbaa !9
  %49 = add nuw i64 %24, 16
  %50 = icmp eq i64 %49, %22
  br i1 %50, label %51, label %23, !llvm.loop !24

51:                                               ; preds = %23
  %52 = icmp eq i64 %22, %10
  br i1 %52, label %72, label %53

53:                                               ; preds = %51
  %54 = icmp eq i64 %21, 0
  br i1 %54, label %70, label %55, !prof !15

55:                                               ; preds = %18, %53
  %56 = phi i64 [ %22, %53 ], [ 0, %18 ]
  %57 = and i64 %10, 2147483644
  br label %58

58:                                               ; preds = %58, %55
  %59 = phi i64 [ %56, %55 ], [ %66, %58 ]
  %60 = getelementptr inbounds nuw [4 x i8], ptr %0, i64 %59
  %61 = load <4 x float>, ptr %60, align 4, !tbaa !9
  %62 = getelementptr inbounds nuw [4 x i8], ptr %1, i64 %59
  %63 = load <4 x float>, ptr %62, align 4, !tbaa !9
  %64 = fadd <4 x float> %61, %63
  %65 = getelementptr inbounds nuw [4 x i8], ptr %2, i64 %59
  store <4 x float> %64, ptr %65, align 4, !tbaa !9
  %66 = add nuw i64 %59, 4
  %67 = icmp eq i64 %66, %57
  br i1 %67, label %68, label %58, !llvm.loop !25

68:                                               ; preds = %58
  %69 = icmp eq i64 %57, %10
  br i1 %69, label %72, label %70

70:                                               ; preds = %12, %9, %53, %68
  %71 = phi i64 [ 0, %9 ], [ 0, %12 ], [ %22, %53 ], [ %57, %68 ]
  br label %73

72:                                               ; preds = %73, %51, %68, %4
  ret void

73:                                               ; preds = %70, %73
  %74 = phi i64 [ %81, %73 ], [ %71, %70 ]
  %75 = getelementptr inbounds nuw [4 x i8], ptr %0, i64 %74
  %76 = load float, ptr %75, align 4, !tbaa !9
  %77 = getelementptr inbounds nuw [4 x i8], ptr %1, i64 %74
  %78 = load float, ptr %77, align 4, !tbaa !9
  %79 = fadd float %76, %78
  %80 = getelementptr inbounds nuw [4 x i8], ptr %2, i64 %74
  store float %79, ptr %80, align 4, !tbaa !9
  %81 = add nuw nsw i64 %74, 1
  %82 = icmp eq i64 %81, %10
  br i1 %82, label %72, label %73, !llvm.loop !26
}

; Function Attrs: nofree norecurse nosync nounwind ssp memory(argmem: readwrite) uwtable(sync)
define void @test_interchange(ptr noundef readonly captures(none) %0, ptr noundef writeonly captures(none) %1) local_unnamed_addr #0 {
  br label %3

3:                                                ; preds = %2, %8
  %4 = phi i64 [ 0, %2 ], [ %9, %8 ]
  %5 = getelementptr inbounds nuw [4 x i8], ptr %0, i64 %4
  %6 = getelementptr inbounds nuw [4 x i8], ptr %1, i64 %4
  br label %11

7:                                                ; preds = %8
  ret void

8:                                                ; preds = %11
  %9 = add nuw nsw i64 %4, 1
  %10 = icmp eq i64 %9, 256
  br i1 %10, label %7, label %3, !llvm.loop !27

11:                                               ; preds = %3, %11
  %12 = phi i64 [ 0, %3 ], [ %17, %11 ]
  %13 = getelementptr inbounds nuw [1024 x i8], ptr %5, i64 %12
  %14 = load float, ptr %13, align 4, !tbaa !9
  %15 = fmul float %14, 2.000000e+00
  %16 = getelementptr inbounds nuw [1024 x i8], ptr %6, i64 %12
  store float %15, ptr %16, align 4, !tbaa !9
  %17 = add nuw nsw i64 %12, 1
  %18 = icmp eq i64 %17, 256
  br i1 %18, label %8, label %11, !llvm.loop !28
}

; Function Attrs: nofree norecurse nosync nounwind ssp memory(argmem: readwrite) uwtable(sync)
define void @test_tiling(ptr noundef readonly captures(none) %0, ptr noundef readonly captures(none) %1, ptr noundef captures(none) %2) local_unnamed_addr #0 {
  br label %4

4:                                                ; preds = %3, %14
  %5 = phi i64 [ 0, %3 ], [ %15, %14 ]
  %6 = getelementptr inbounds nuw [1024 x i8], ptr %0, i64 %5
  %7 = getelementptr inbounds nuw [1024 x i8], ptr %2, i64 %5
  br label %9

8:                                                ; preds = %14
  ret void

9:                                                ; preds = %4, %17
  %10 = phi i64 [ 0, %4 ], [ %18, %17 ]
  %11 = getelementptr inbounds nuw [4 x i8], ptr %1, i64 %10
  %12 = getelementptr inbounds nuw [4 x i8], ptr %7, i64 %10
  %13 = load float, ptr %12, align 4, !tbaa !9
  br label %20

14:                                               ; preds = %17
  %15 = add nuw nsw i64 %5, 1
  %16 = icmp eq i64 %15, 256
  br i1 %16, label %8, label %4, !llvm.loop !29

17:                                               ; preds = %20
  %18 = add nuw nsw i64 %10, 1
  %19 = icmp eq i64 %18, 256
  br i1 %19, label %14, label %9, !llvm.loop !30

20:                                               ; preds = %9, %20
  %21 = phi i64 [ 0, %9 ], [ %28, %20 ]
  %22 = phi float [ %13, %9 ], [ %27, %20 ]
  %23 = getelementptr inbounds nuw [4 x i8], ptr %6, i64 %21
  %24 = load float, ptr %23, align 4, !tbaa !9
  %25 = getelementptr inbounds nuw [1024 x i8], ptr %11, i64 %21
  %26 = load float, ptr %25, align 4, !tbaa !9
  %27 = tail call float @llvm.fmuladd.f32(float %24, float %26, float %22)
  store float %27, ptr %12, align 4, !tbaa !9
  %28 = add nuw nsw i64 %21, 1
  %29 = icmp eq i64 %28, 256
  br i1 %29, label %17, label %20, !llvm.loop !31
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind ssp willreturn memory(none) uwtable(sync)
define void @test_deletion(i32 noundef %0) local_unnamed_addr #3 {
  ret void
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind ssp willreturn memory(argmem: readwrite) uwtable(sync)
define void @test_unroll(ptr noundef writeonly captures(none) initializes((0, 32)) %0, ptr noundef readonly captures(none) %1) local_unnamed_addr #4 {
  %3 = load float, ptr %1, align 4, !tbaa !9
  %4 = fmul float %3, 0x40091EB860000000
  store float %4, ptr %0, align 4, !tbaa !9
  %5 = getelementptr inbounds nuw i8, ptr %1, i64 4
  %6 = load float, ptr %5, align 4, !tbaa !9
  %7 = fmul float %6, 0x40091EB860000000
  %8 = getelementptr inbounds nuw i8, ptr %0, i64 4
  store float %7, ptr %8, align 4, !tbaa !9
  %9 = getelementptr inbounds nuw i8, ptr %1, i64 8
  %10 = load float, ptr %9, align 4, !tbaa !9
  %11 = fmul float %10, 0x40091EB860000000
  %12 = getelementptr inbounds nuw i8, ptr %0, i64 8
  store float %11, ptr %12, align 4, !tbaa !9
  %13 = getelementptr inbounds nuw i8, ptr %1, i64 12
  %14 = load float, ptr %13, align 4, !tbaa !9
  %15 = fmul float %14, 0x40091EB860000000
  %16 = getelementptr inbounds nuw i8, ptr %0, i64 12
  store float %15, ptr %16, align 4, !tbaa !9
  %17 = getelementptr inbounds nuw i8, ptr %1, i64 16
  %18 = load float, ptr %17, align 4, !tbaa !9
  %19 = fmul float %18, 0x40091EB860000000
  %20 = getelementptr inbounds nuw i8, ptr %0, i64 16
  store float %19, ptr %20, align 4, !tbaa !9
  %21 = getelementptr inbounds nuw i8, ptr %1, i64 20
  %22 = load float, ptr %21, align 4, !tbaa !9
  %23 = fmul float %22, 0x40091EB860000000
  %24 = getelementptr inbounds nuw i8, ptr %0, i64 20
  store float %23, ptr %24, align 4, !tbaa !9
  %25 = getelementptr inbounds nuw i8, ptr %1, i64 24
  %26 = load float, ptr %25, align 4, !tbaa !9
  %27 = fmul float %26, 0x40091EB860000000
  %28 = getelementptr inbounds nuw i8, ptr %0, i64 24
  store float %27, ptr %28, align 4, !tbaa !9
  %29 = getelementptr inbounds nuw i8, ptr %1, i64 28
  %30 = load float, ptr %29, align 4, !tbaa !9
  %31 = fmul float %30, 0x40091EB860000000
  %32 = getelementptr inbounds nuw i8, ptr %0, i64 28
  store float %31, ptr %32, align 4, !tbaa !9
  ret void
}

; Function Attrs: nofree norecurse nosync nounwind ssp memory(argmem: read) uwtable(sync)
define float @test_reduction(ptr noundef readonly captures(none) %0, i32 noundef %1) local_unnamed_addr #5 {
  %3 = icmp sgt i32 %1, 0
  br i1 %3, label %4, label %50

4:                                                ; preds = %2
  %5 = zext nneg i32 %1 to i64
  %6 = icmp ult i32 %1, 4
  br i1 %6, label %47, label %7

7:                                                ; preds = %4
  %8 = icmp ult i32 %1, 16
  br i1 %8, label %33, label %9

9:                                                ; preds = %7
  %10 = and i64 %5, 12
  %11 = and i64 %5, 2147483632
  br label %12

12:                                               ; preds = %12, %9
  %13 = phi i64 [ 0, %9 ], [ %27, %12 ]
  %14 = phi float [ 0.000000e+00, %9 ], [ %26, %12 ]
  %15 = getelementptr inbounds nuw [4 x i8], ptr %0, i64 %13
  %16 = getelementptr inbounds nuw i8, ptr %15, i64 16
  %17 = getelementptr inbounds nuw i8, ptr %15, i64 32
  %18 = getelementptr inbounds nuw i8, ptr %15, i64 48
  %19 = load <4 x float>, ptr %15, align 4, !tbaa !9
  %20 = load <4 x float>, ptr %16, align 4, !tbaa !9
  %21 = load <4 x float>, ptr %17, align 4, !tbaa !9
  %22 = load <4 x float>, ptr %18, align 4, !tbaa !9
  %23 = tail call float @llvm.vector.reduce.fadd.v4f32(float %14, <4 x float> %19)
  %24 = tail call float @llvm.vector.reduce.fadd.v4f32(float %23, <4 x float> %20)
  %25 = tail call float @llvm.vector.reduce.fadd.v4f32(float %24, <4 x float> %21)
  %26 = tail call float @llvm.vector.reduce.fadd.v4f32(float %25, <4 x float> %22)
  %27 = add nuw i64 %13, 16
  %28 = icmp eq i64 %27, %11
  br i1 %28, label %29, label %12, !llvm.loop !32

29:                                               ; preds = %12
  %30 = icmp eq i64 %11, %5
  br i1 %30, label %50, label %31

31:                                               ; preds = %29
  %32 = icmp eq i64 %10, 0
  br i1 %32, label %47, label %33, !prof !15

33:                                               ; preds = %7, %31
  %34 = phi i64 [ %11, %31 ], [ 0, %7 ]
  %35 = phi float [ %26, %31 ], [ 0.000000e+00, %7 ]
  %36 = and i64 %5, 2147483644
  br label %37

37:                                               ; preds = %37, %33
  %38 = phi i64 [ %34, %33 ], [ %43, %37 ]
  %39 = phi float [ %35, %33 ], [ %42, %37 ]
  %40 = getelementptr inbounds nuw [4 x i8], ptr %0, i64 %38
  %41 = load <4 x float>, ptr %40, align 4, !tbaa !9
  %42 = tail call float @llvm.vector.reduce.fadd.v4f32(float %39, <4 x float> %41)
  %43 = add nuw i64 %38, 4
  %44 = icmp eq i64 %43, %36
  br i1 %44, label %45, label %37, !llvm.loop !33

45:                                               ; preds = %37
  %46 = icmp eq i64 %36, %5
  br i1 %46, label %50, label %47

47:                                               ; preds = %4, %31, %45
  %48 = phi i64 [ 0, %4 ], [ %11, %31 ], [ %36, %45 ]
  %49 = phi float [ 0.000000e+00, %4 ], [ %26, %31 ], [ %42, %45 ]
  br label %52

50:                                               ; preds = %52, %29, %45, %2
  %51 = phi float [ 0.000000e+00, %2 ], [ %42, %45 ], [ %26, %29 ], [ %57, %52 ]
  ret float %51

52:                                               ; preds = %47, %52
  %53 = phi i64 [ %58, %52 ], [ %48, %47 ]
  %54 = phi float [ %57, %52 ], [ %49, %47 ]
  %55 = getelementptr inbounds nuw [4 x i8], ptr %0, i64 %53
  %56 = load float, ptr %55, align 4, !tbaa !9
  %57 = fadd float %54, %56
  %58 = add nuw nsw i64 %53, 1
  %59 = icmp eq i64 %58, %5
  br i1 %59, label %50, label %52, !llvm.loop !34
}

; Function Attrs: nofree norecurse nosync nounwind ssp memory(none) uwtable(sync)
define noundef i32 @main() local_unnamed_addr #6 {
  %1 = alloca [256 x float], align 4
  call void @llvm.lifetime.start.p0(ptr nonnull %1) #8
  br label %2

2:                                                ; preds = %2, %0
  %3 = phi i64 [ 0, %0 ], [ %16, %2 ]
  %4 = getelementptr inbounds nuw [4 x i8], ptr %1, i64 %3
  %5 = getelementptr inbounds nuw i8, ptr %4, i64 16
  %6 = getelementptr inbounds nuw i8, ptr %4, i64 32
  %7 = getelementptr inbounds nuw i8, ptr %4, i64 48
  %8 = load <4 x float>, ptr %4, align 4, !tbaa !9
  %9 = load <4 x float>, ptr %5, align 4, !tbaa !9
  %10 = load <4 x float>, ptr %6, align 4, !tbaa !9
  %11 = load <4 x float>, ptr %7, align 4, !tbaa !9
  %12 = fadd <4 x float> %8, splat (float 6.000000e+00)
  %13 = fadd <4 x float> %9, splat (float 6.000000e+00)
  %14 = fadd <4 x float> %10, splat (float 6.000000e+00)
  %15 = fadd <4 x float> %11, splat (float 6.000000e+00)
  store <4 x float> %12, ptr %4, align 4, !tbaa !9
  store <4 x float> %13, ptr %5, align 4, !tbaa !9
  store <4 x float> %14, ptr %6, align 4, !tbaa !9
  store <4 x float> %15, ptr %7, align 4, !tbaa !9
  %16 = add nuw i64 %3, 16
  %17 = icmp eq i64 %16, 256
  br i1 %17, label %18, label %2, !llvm.loop !35

18:                                               ; preds = %2, %18
  %19 = phi i64 [ %32, %18 ], [ 0, %2 ]
  %20 = getelementptr inbounds nuw [4 x i8], ptr %1, i64 %19
  %21 = getelementptr inbounds nuw i8, ptr %20, i64 16
  %22 = getelementptr inbounds nuw i8, ptr %20, i64 32
  %23 = getelementptr inbounds nuw i8, ptr %20, i64 48
  %24 = load <4 x float>, ptr %20, align 4, !tbaa !9
  %25 = load <4 x float>, ptr %21, align 4, !tbaa !9
  %26 = load <4 x float>, ptr %22, align 4, !tbaa !9
  %27 = load <4 x float>, ptr %23, align 4, !tbaa !9
  %28 = fadd <4 x float> %24, splat (float 2.000000e+00)
  %29 = fadd <4 x float> %25, splat (float 2.000000e+00)
  %30 = fadd <4 x float> %26, splat (float 2.000000e+00)
  %31 = fadd <4 x float> %27, splat (float 2.000000e+00)
  store <4 x float> %28, ptr %20, align 4, !tbaa !9
  store <4 x float> %29, ptr %21, align 4, !tbaa !9
  store <4 x float> %30, ptr %22, align 4, !tbaa !9
  store <4 x float> %31, ptr %23, align 4, !tbaa !9
  %32 = add nuw i64 %19, 16
  %33 = icmp eq i64 %32, 256
  br i1 %33, label %34, label %18, !llvm.loop !36

34:                                               ; preds = %18
  call void @llvm.lifetime.end.p0(ptr nonnull %1) #8
  ret i32 0
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #7

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.vector.reduce.fadd.v4f32(float, <4 x float>) #7

attributes #0 = { nofree norecurse nosync nounwind ssp memory(argmem: readwrite) uwtable(sync) "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" "tune-cpu"="apple-m5" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { mustprogress nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { mustprogress nofree norecurse nosync nounwind ssp willreturn memory(none) uwtable(sync) "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" "tune-cpu"="apple-m5" }
attributes #4 = { mustprogress nofree norecurse nosync nounwind ssp willreturn memory(argmem: readwrite) uwtable(sync) "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" "tune-cpu"="apple-m5" }
attributes #5 = { nofree norecurse nosync nounwind ssp memory(argmem: read) uwtable(sync) "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" "tune-cpu"="apple-m5" }
attributes #6 = { nofree norecurse nosync nounwind ssp memory(none) uwtable(sync) "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" "tune-cpu"="apple-m5" }
attributes #7 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #8 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}
!llvm.errno.tbaa = !{!5}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 15, i32 5]}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 1}
!3 = !{i32 7, !"frame-pointer", i32 4}
!4 = !{!"clang version 23.0.0git (https://github.com/llvm/llvm-project.git 8b5b987cfa7bff5b46bd8b384a52347ab74f6e4c)"}
!5 = !{!6, !6, i64 0}
!6 = !{!"int", !7, i64 0}
!7 = !{!"omnipotent char", !8, i64 0}
!8 = !{!"Simple C/C++ TBAA"}
!9 = !{!10, !10, i64 0}
!10 = !{!"float", !7, i64 0}
!11 = distinct !{!11, !12, !13, !14}
!12 = !{!"llvm.loop.mustprogress"}
!13 = !{!"llvm.loop.isvectorized", i32 1}
!14 = !{!"llvm.loop.unroll.runtime.disable"}
!15 = !{!"branch_weights", i32 4, i32 12}
!16 = distinct !{!16, !12, !13, !14}
!17 = distinct !{!17, !12, !14, !13}
!18 = distinct !{!18, !12, !13, !14}
!19 = distinct !{!19, !12, !13, !14}
!20 = distinct !{!20, !12, !14, !13}
!21 = distinct !{!21, !12, !13, !14}
!22 = distinct !{!22, !12, !13, !14}
!23 = distinct !{!23, !12, !13}
!24 = distinct !{!24, !12, !13, !14}
!25 = distinct !{!25, !12, !13, !14}
!26 = distinct !{!26, !12, !13}
!27 = distinct !{!27, !12}
!28 = distinct !{!28, !12}
!29 = distinct !{!29, !12}
!30 = distinct !{!30, !12}
!31 = distinct !{!31, !12}
!32 = distinct !{!32, !12, !13, !14}
!33 = distinct !{!33, !12, !13, !14}
!34 = distinct !{!34, !12, !14, !13}
!35 = distinct !{!35, !12, !13, !14}
!36 = distinct !{!36, !12, !13, !14}

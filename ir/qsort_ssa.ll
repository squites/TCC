; ModuleID = 'ir/qsort.ll'
source_filename = "llvm-link"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

%struct.my3DVertexStruct = type { i32, i32, i32, double }

@.str = private unnamed_addr constant [15 x i8] c"_finfo_dataset\00", align 1
@.str.1 = private unnamed_addr constant [3 x i8] c"rt\00", align 1
@.str.2 = private unnamed_addr constant [29 x i8] c"\0AError: Can't find dataset!\0A\00", align 1
@.str.3 = private unnamed_addr constant [4 x i8] c"%ld\00", align 1
@__stderrp = external global ptr, align 8
@.str.4 = private unnamed_addr constant [27 x i8] c"Usage: qsort_large <file>\0A\00", align 1
@.str.1.5 = private unnamed_addr constant [2 x i8] c"r\00", align 1
@.str.2.6 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.3.7 = private unnamed_addr constant [57 x i8] c"\0ASorting %d vectors based on distance from the origin.\0A\0A\00", align 1
@.str.4.8 = private unnamed_addr constant [18 x i8] c"sorted_output.dat\00", align 1
@.str.5 = private unnamed_addr constant [3 x i8] c"wt\00", align 1
@.str.6 = private unnamed_addr constant [32 x i8] c"\0AError: Can't open output file\0A\00", align 1
@.str.7 = private unnamed_addr constant [10 x i8] c"%d %d %d\0A\00", align 1

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @main(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i64, align 8
  %4 = call ptr @"\01_fopen"(ptr noundef @.str, ptr noundef @.str.1)
  %5 = icmp eq ptr %4, null
  br i1 %5, label %6, label %9

6:                                                ; preds = %2
  %7 = load ptr, ptr @__stderrp, align 8
  %8 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %7, ptr noundef @.str.2) #5
  br label %24

9:                                                ; preds = %2
  %10 = call i32 (ptr, ptr, ...) @fscanf(ptr noundef %4, ptr noundef @.str.3, ptr noundef %3)
  %11 = call i32 @fclose(ptr noundef %4)
  br label %12

12:                                               ; preds = %21, %9
  %.01 = phi i64 [ 0, %9 ], [ %22, %21 ]
  %13 = load i64, ptr %3, align 8
  %14 = icmp slt i64 %.01, %13
  br i1 %14, label %15, label %23

15:                                               ; preds = %12
  %16 = add nsw i64 %.01, 1
  %17 = load i64, ptr %3, align 8
  %18 = icmp eq i64 %16, %17
  %19 = zext i1 %18 to i32
  %20 = call i32 @main1(i32 noundef %0, ptr noundef %1, i32 noundef %19)
  br label %21

21:                                               ; preds = %15
  %22 = add nsw i64 %.01, 1
  br label %12, !llvm.loop !6

23:                                               ; preds = %12
  br label %24

24:                                               ; preds = %23, %6
  %.0 = phi i32 [ 1, %6 ], [ 0, %23 ]
  ret i32 %.0
}

declare ptr @"\01_fopen"(ptr noundef, ptr noundef) #1

; Function Attrs: nounwind
declare i32 @fprintf(ptr noundef, ptr noundef, ...) #2

declare i32 @fscanf(ptr noundef, ptr noundef, ...) #1

declare i32 @fclose(ptr noundef) #1

; Function Attrs: noinline nounwind ssp uwtable(sync)
define void @qsortx(ptr noundef %0, i32 noundef %1, i32 noundef %2, ptr noundef %3) #0 {
  %5 = alloca [30 x ptr], align 8
  %6 = alloca [30 x ptr], align 8
  %7 = icmp ult i32 %1, 2
  br i1 %7, label %10, label %8

8:                                                ; preds = %4
  %9 = icmp eq i32 %2, 0
  br i1 %9, label %10, label %11

10:                                               ; preds = %8, %4
  br label %115

11:                                               ; preds = %8
  %12 = sub i32 %1, 1
  %13 = mul i32 %2, %12
  %14 = zext i32 %13 to i64
  %15 = getelementptr inbounds nuw i8, ptr %0, i64 %14
  br label %.outer

.outer:                                           ; preds = %.outer.backedge, %11
  %.06.ph = phi ptr [ %0, %11 ], [ %.06.ph.be, %.outer.backedge ]
  %.05.ph = phi ptr [ %15, %11 ], [ %.05.ph.be, %.outer.backedge ]
  %.0.ph = phi i32 [ 0, %11 ], [ %.0.ph.be, %.outer.backedge ]
  br label %16

16:                                               ; preds = %.outer, %98
  %.05 = phi ptr [ %101, %98 ], [ %.05.ph, %.outer ]
  %.0 = phi i32 [ %.4, %98 ], [ %.0.ph, %.outer ]
  %17 = ptrtoint ptr %.05 to i64
  %18 = ptrtoint ptr %.06.ph to i64
  %19 = sub i64 %17, %18
  %20 = zext i32 %2 to i64
  %21 = sdiv i64 %19, %20
  %22 = add nsw i64 %21, 1
  %23 = trunc i64 %22 to i32
  %24 = icmp ule i32 %23, 8
  br i1 %24, label %25, label %26

25:                                               ; preds = %16
  call void @shortsort(ptr noundef %.06.ph, ptr noundef %.05, i32 noundef %2, ptr noundef %3)
  br label %104

26:                                               ; preds = %16
  %27 = udiv i32 %23, 2
  %28 = mul i32 %27, %2
  %29 = zext i32 %28 to i64
  %30 = getelementptr inbounds nuw i8, ptr %.06.ph, i64 %29
  call void @swap(ptr noundef %30, ptr noundef %.06.ph, i32 noundef %2)
  %31 = zext i32 %2 to i64
  %32 = getelementptr inbounds nuw i8, ptr %.05, i64 %31
  br label %33

33:                                               ; preds = %59, %26
  %.03 = phi ptr [ %.06.ph, %26 ], [ %36, %59 ]
  %.01 = phi ptr [ %32, %26 ], [ %48, %59 ]
  br label %34

34:                                               ; preds = %42, %33
  %.14 = phi ptr [ %.03, %33 ], [ %36, %42 ]
  %35 = zext i32 %2 to i64
  %36 = getelementptr inbounds nuw i8, ptr %.14, i64 %35
  br label %37

37:                                               ; preds = %34
  %38 = icmp ule ptr %36, %.05
  br i1 %38, label %39, label %42

39:                                               ; preds = %37
  %40 = call i32 %3(ptr noundef %36, ptr noundef %.06.ph)
  %41 = icmp sle i32 %40, 0
  br label %42

42:                                               ; preds = %39, %37
  %43 = phi i1 [ false, %37 ], [ %41, %39 ]
  br i1 %43, label %34, label %44, !llvm.loop !8

44:                                               ; preds = %42
  br label %45

45:                                               ; preds = %54, %44
  %.12 = phi ptr [ %.01, %44 ], [ %48, %54 ]
  %46 = zext i32 %2 to i64
  %47 = sub i64 0, %46
  %48 = getelementptr inbounds i8, ptr %.12, i64 %47
  br label %49

49:                                               ; preds = %45
  %50 = icmp ugt ptr %48, %.06.ph
  br i1 %50, label %51, label %54

51:                                               ; preds = %49
  %52 = call i32 %3(ptr noundef %48, ptr noundef %.06.ph)
  %53 = icmp sge i32 %52, 0
  br label %54

54:                                               ; preds = %51, %49
  %55 = phi i1 [ false, %49 ], [ %53, %51 ]
  br i1 %55, label %45, label %56, !llvm.loop !9

56:                                               ; preds = %54
  %57 = icmp ult ptr %48, %36
  br i1 %57, label %58, label %59

58:                                               ; preds = %56
  br label %60

59:                                               ; preds = %56
  call void @swap(ptr noundef %36, ptr noundef %48, i32 noundef %2)
  br label %33

60:                                               ; preds = %58
  call void @swap(ptr noundef %.06.ph, ptr noundef %48, i32 noundef %2)
  %61 = getelementptr inbounds i8, ptr %48, i64 -1
  %62 = ptrtoint ptr %61 to i64
  %63 = ptrtoint ptr %.06.ph to i64
  %64 = sub i64 %62, %63
  %65 = ptrtoint ptr %.05 to i64
  %66 = ptrtoint ptr %36 to i64
  %67 = sub i64 %65, %66
  %68 = icmp sge i64 %64, %67
  br i1 %68, label %69, label %86

69:                                               ; preds = %60
  %70 = zext i32 %2 to i64
  %71 = getelementptr inbounds nuw i8, ptr %.06.ph, i64 %70
  %72 = icmp ult ptr %71, %48
  br i1 %72, label %73, label %82

73:                                               ; preds = %69
  %74 = sext i32 %.0 to i64
  %75 = getelementptr inbounds [30 x ptr], ptr %5, i64 0, i64 %74
  store ptr %.06.ph, ptr %75, align 8
  %76 = zext i32 %2 to i64
  %77 = sub i64 0, %76
  %78 = getelementptr inbounds i8, ptr %48, i64 %77
  %79 = sext i32 %.0 to i64
  %80 = getelementptr inbounds [30 x ptr], ptr %6, i64 0, i64 %79
  store ptr %78, ptr %80, align 8
  %81 = add nsw i32 %.0, 1
  br label %82

82:                                               ; preds = %73, %69
  %.2 = phi i32 [ %81, %73 ], [ %.0, %69 ]
  %83 = icmp ult ptr %36, %.05
  br i1 %83, label %84, label %85

84:                                               ; preds = %82
  br label %.outer.backedge

85:                                               ; preds = %82
  br label %103

86:                                               ; preds = %60
  %87 = icmp ult ptr %36, %.05
  br i1 %87, label %88, label %94

88:                                               ; preds = %86
  %89 = sext i32 %.0 to i64
  %90 = getelementptr inbounds [30 x ptr], ptr %5, i64 0, i64 %89
  store ptr %36, ptr %90, align 8
  %91 = sext i32 %.0 to i64
  %92 = getelementptr inbounds [30 x ptr], ptr %6, i64 0, i64 %91
  store ptr %.05, ptr %92, align 8
  %93 = add nsw i32 %.0, 1
  br label %94

94:                                               ; preds = %88, %86
  %.4 = phi i32 [ %93, %88 ], [ %.0, %86 ]
  %95 = zext i32 %2 to i64
  %96 = getelementptr inbounds nuw i8, ptr %.06.ph, i64 %95
  %97 = icmp ult ptr %96, %48
  br i1 %97, label %98, label %102

98:                                               ; preds = %94
  %99 = zext i32 %2 to i64
  %100 = sub i64 0, %99
  %101 = getelementptr inbounds i8, ptr %48, i64 %100
  br label %16

102:                                              ; preds = %94
  br label %103

103:                                              ; preds = %102, %85
  %.3 = phi i32 [ %.2, %85 ], [ %.4, %102 ]
  br label %104

104:                                              ; preds = %103, %25
  %.1 = phi i32 [ %.0, %25 ], [ %.3, %103 ]
  %105 = add nsw i32 %.1, -1
  %106 = icmp sge i32 %105, 0
  br i1 %106, label %107, label %114

107:                                              ; preds = %104
  %108 = sext i32 %105 to i64
  %109 = getelementptr inbounds [30 x ptr], ptr %5, i64 0, i64 %108
  %110 = load ptr, ptr %109, align 8
  %111 = sext i32 %105 to i64
  %112 = getelementptr inbounds [30 x ptr], ptr %6, i64 0, i64 %111
  %113 = load ptr, ptr %112, align 8
  br label %.outer.backedge

.outer.backedge:                                  ; preds = %107, %84
  %.06.ph.be = phi ptr [ %36, %84 ], [ %110, %107 ]
  %.05.ph.be = phi ptr [ %.05, %84 ], [ %113, %107 ]
  %.0.ph.be = phi i32 [ %.2, %84 ], [ %105, %107 ]
  br label %.outer

114:                                              ; preds = %104
  br label %115

115:                                              ; preds = %114, %10
  ret void
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define internal void @shortsort(ptr noundef %0, ptr noundef %1, i32 noundef %2, ptr noundef %3) #0 {
  br label %5

5:                                                ; preds = %20, %4
  %.01 = phi ptr [ %1, %4 ], [ %23, %20 ]
  %6 = icmp ugt ptr %.01, %0
  br i1 %6, label %7, label %24

7:                                                ; preds = %5
  %8 = zext i32 %2 to i64
  %9 = getelementptr inbounds nuw i8, ptr %0, i64 %8
  br label %10

10:                                               ; preds = %17, %7
  %.02 = phi ptr [ %9, %7 ], [ %19, %17 ]
  %.0 = phi ptr [ %0, %7 ], [ %.1, %17 ]
  %11 = icmp ule ptr %.02, %.01
  br i1 %11, label %12, label %20

12:                                               ; preds = %10
  %13 = call i32 %3(ptr noundef %.02, ptr noundef %.0)
  %14 = icmp sgt i32 %13, 0
  br i1 %14, label %15, label %16

15:                                               ; preds = %12
  br label %16

16:                                               ; preds = %15, %12
  %.1 = phi ptr [ %.02, %15 ], [ %.0, %12 ]
  br label %17

17:                                               ; preds = %16
  %18 = zext i32 %2 to i64
  %19 = getelementptr inbounds nuw i8, ptr %.02, i64 %18
  br label %10, !llvm.loop !10

20:                                               ; preds = %10
  call void @swap(ptr noundef %.0, ptr noundef %.01, i32 noundef %2)
  %21 = zext i32 %2 to i64
  %22 = sub i64 0, %21
  %23 = getelementptr inbounds i8, ptr %.01, i64 %22
  br label %5, !llvm.loop !11

24:                                               ; preds = %5
  ret void
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define internal void @swap(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  %4 = icmp ne ptr %0, %1
  br i1 %4, label %5, label %15

5:                                                ; preds = %3
  br label %6

6:                                                ; preds = %9, %5
  %.02 = phi i32 [ %2, %5 ], [ %7, %9 ]
  %.01 = phi ptr [ %1, %5 ], [ %13, %9 ]
  %.0 = phi ptr [ %0, %5 ], [ %12, %9 ]
  %7 = add i32 %.02, -1
  %8 = icmp ne i32 %.02, 0
  br i1 %8, label %9, label %14

9:                                                ; preds = %6
  %10 = load i8, ptr %.0, align 1
  %11 = load i8, ptr %.01, align 1
  %12 = getelementptr inbounds nuw i8, ptr %.0, i32 1
  store i8 %11, ptr %.0, align 1
  %13 = getelementptr inbounds nuw i8, ptr %.01, i32 1
  store i8 %10, ptr %.01, align 1
  br label %6, !llvm.loop !12

14:                                               ; preds = %6
  br label %15

15:                                               ; preds = %14, %3
  ret void
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @compare(ptr noundef %0, ptr noundef %1) #0 {
  %3 = getelementptr inbounds nuw %struct.my3DVertexStruct, ptr %0, i32 0, i32 3
  %4 = load double, ptr %3, align 8
  %5 = getelementptr inbounds nuw %struct.my3DVertexStruct, ptr %1, i32 0, i32 3
  %6 = load double, ptr %5, align 8
  %7 = fcmp ogt double %4, %6
  br i1 %7, label %8, label %9

8:                                                ; preds = %2
  br label %13

9:                                                ; preds = %2
  %10 = fcmp oeq double %4, %6
  %11 = zext i1 %10 to i64
  %12 = select i1 %10, i32 0, i32 -1
  br label %13

13:                                               ; preds = %9, %8
  %14 = phi i32 [ 1, %8 ], [ %12, %9 ]
  ret i32 %14
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @main1(i32 noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  %4 = alloca [60000 x %struct.my3DVertexStruct], align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = icmp slt i32 %0, 2
  br i1 %8, label %9, label %12

9:                                                ; preds = %3
  %10 = load ptr, ptr @__stderrp, align 8
  %11 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %10, ptr noundef @.str.4) #5
  call void @exit(i32 noundef 1) #6
  unreachable

12:                                               ; preds = %3
  %13 = getelementptr inbounds ptr, ptr %1, i64 1
  %14 = load ptr, ptr %13, align 8
  %15 = call ptr @"\01_fopen"(ptr noundef %14, ptr noundef @.str.1.5)
  br label %16

16:                                               ; preds = %29, %12
  %.0 = phi i32 [ 0, %12 ], [ %57, %29 ]
  %17 = call i32 (ptr, ptr, ...) @fscanf(ptr noundef %15, ptr noundef @.str.2.6, ptr noundef %5)
  %18 = icmp eq i32 %17, 1
  br i1 %18, label %19, label %27

19:                                               ; preds = %16
  %20 = call i32 (ptr, ptr, ...) @fscanf(ptr noundef %15, ptr noundef @.str.2.6, ptr noundef %6)
  %21 = icmp eq i32 %20, 1
  br i1 %21, label %22, label %27

22:                                               ; preds = %19
  %23 = call i32 (ptr, ptr, ...) @fscanf(ptr noundef %15, ptr noundef @.str.2.6, ptr noundef %7)
  %24 = icmp eq i32 %23, 1
  br i1 %24, label %25, label %27

25:                                               ; preds = %22
  %26 = icmp slt i32 %.0, 60000
  br label %27

27:                                               ; preds = %25, %22, %19, %16
  %28 = phi i1 [ false, %22 ], [ false, %19 ], [ false, %16 ], [ %26, %25 ]
  br i1 %28, label %29, label %58

29:                                               ; preds = %27
  %30 = load i32, ptr %5, align 4
  %31 = sext i32 %.0 to i64
  %32 = getelementptr inbounds [60000 x %struct.my3DVertexStruct], ptr %4, i64 0, i64 %31
  %33 = getelementptr inbounds nuw %struct.my3DVertexStruct, ptr %32, i32 0, i32 0
  store i32 %30, ptr %33, align 8
  %34 = load i32, ptr %6, align 4
  %35 = sext i32 %.0 to i64
  %36 = getelementptr inbounds [60000 x %struct.my3DVertexStruct], ptr %4, i64 0, i64 %35
  %37 = getelementptr inbounds nuw %struct.my3DVertexStruct, ptr %36, i32 0, i32 1
  store i32 %34, ptr %37, align 4
  %38 = load i32, ptr %7, align 4
  %39 = sext i32 %.0 to i64
  %40 = getelementptr inbounds [60000 x %struct.my3DVertexStruct], ptr %4, i64 0, i64 %39
  %41 = getelementptr inbounds nuw %struct.my3DVertexStruct, ptr %40, i32 0, i32 2
  store i32 %38, ptr %41, align 8
  %42 = load i32, ptr %5, align 4
  %43 = sitofp i32 %42 to double
  %44 = call double @llvm.pow.f64(double %43, double 2.000000e+00)
  %45 = load i32, ptr %6, align 4
  %46 = sitofp i32 %45 to double
  %47 = call double @llvm.pow.f64(double %46, double 2.000000e+00)
  %48 = fadd double %44, %47
  %49 = load i32, ptr %7, align 4
  %50 = sitofp i32 %49 to double
  %51 = call double @llvm.pow.f64(double %50, double 2.000000e+00)
  %52 = fadd double %48, %51
  %53 = call double @llvm.sqrt.f64(double %52)
  %54 = sext i32 %.0 to i64
  %55 = getelementptr inbounds [60000 x %struct.my3DVertexStruct], ptr %4, i64 0, i64 %54
  %56 = getelementptr inbounds nuw %struct.my3DVertexStruct, ptr %55, i32 0, i32 3
  store double %53, ptr %56, align 8
  %57 = add nsw i32 %.0, 1
  br label %16, !llvm.loop !13

58:                                               ; preds = %27
  %59 = call i32 @fclose(ptr noundef %15)
  br label %60

60:                                               ; preds = %58
  %61 = icmp ne i32 %2, 0
  br i1 %61, label %62, label %64

62:                                               ; preds = %60
  %63 = call i32 (ptr, ...) @printf(ptr noundef @.str.3.7, i32 noundef %.0)
  br label %64

64:                                               ; preds = %62, %60
  %65 = getelementptr inbounds [60000 x %struct.my3DVertexStruct], ptr %4, i64 0, i64 0
  call void @qsortx(ptr noundef %65, i32 noundef %.0, i32 noundef 24, ptr noundef @compare)
  %66 = icmp ne i32 %2, 0
  br i1 %66, label %67, label %95

67:                                               ; preds = %64
  %68 = call ptr @"\01_fopen"(ptr noundef @.str.4.8, ptr noundef @.str.5)
  %69 = icmp eq ptr %68, null
  br i1 %69, label %70, label %73

70:                                               ; preds = %67
  %71 = load ptr, ptr @__stderrp, align 8
  %72 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %71, ptr noundef @.str.6) #5
  call void @exit(i32 noundef 1) #6
  unreachable

73:                                               ; preds = %67
  br label %74

74:                                               ; preds = %90, %73
  %.01 = phi i32 [ 0, %73 ], [ %92, %90 ]
  %75 = icmp slt i32 %.01, %.0
  br i1 %75, label %76, label %93

76:                                               ; preds = %74
  %77 = sext i32 %.01 to i64
  %78 = getelementptr inbounds [60000 x %struct.my3DVertexStruct], ptr %4, i64 0, i64 %77
  %79 = getelementptr inbounds nuw %struct.my3DVertexStruct, ptr %78, i32 0, i32 0
  %80 = load i32, ptr %79, align 8
  %81 = sext i32 %.01 to i64
  %82 = getelementptr inbounds [60000 x %struct.my3DVertexStruct], ptr %4, i64 0, i64 %81
  %83 = getelementptr inbounds nuw %struct.my3DVertexStruct, ptr %82, i32 0, i32 1
  %84 = load i32, ptr %83, align 4
  %85 = sext i32 %.01 to i64
  %86 = getelementptr inbounds [60000 x %struct.my3DVertexStruct], ptr %4, i64 0, i64 %85
  %87 = getelementptr inbounds nuw %struct.my3DVertexStruct, ptr %86, i32 0, i32 2
  %88 = load i32, ptr %87, align 8
  %89 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %68, ptr noundef @.str.7, i32 noundef %80, i32 noundef %84, i32 noundef %88) #5
  br label %90

90:                                               ; preds = %76
  %91 = sdiv i32 %.0, 100
  %92 = add nsw i32 %.01, %91
  br label %74, !llvm.loop !14

93:                                               ; preds = %74
  %94 = call i32 @fclose(ptr noundef %68)
  br label %95

95:                                               ; preds = %93, %64
  ret i32 0
}

; Function Attrs: noreturn
declare void @exit(i32 noundef) #3

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.pow.f64(double, double) #4

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.sqrt.f64(double) #4

declare i32 @printf(ptr noundef, ...) #1

attributes #0 = { noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #2 = { nounwind "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #3 = { noreturn "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #4 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #5 = { nounwind }
attributes #6 = { noreturn }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1, !2, !3, !4, !5}

!0 = !{!"Homebrew clang version 22.1.0"}
!1 = !{i32 2, !"SDK Version", [2 x i32] [i32 15, i32 4]}
!2 = !{i32 1, !"wchar_size", i32 4}
!3 = !{i32 8, !"PIC Level", i32 2}
!4 = !{i32 7, !"uwtable", i32 1}
!5 = !{i32 7, !"frame-pointer", i32 4}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
!10 = distinct !{!10, !7}
!11 = distinct !{!11, !7}
!12 = distinct !{!12, !7}
!13 = distinct !{!13, !7}
!14 = distinct !{!14, !7}

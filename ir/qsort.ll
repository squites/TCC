; ModuleID = 'llvm-link'
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
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i64, align 8
  %8 = alloca i64, align 8
  store i32 0, ptr %3, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  store ptr null, ptr %6, align 8
  %9 = call ptr @"\01_fopen"(ptr noundef @.str, ptr noundef @.str.1)
  store ptr %9, ptr %6, align 8
  %10 = icmp eq ptr %9, null
  br i1 %10, label %11, label %14

11:                                               ; preds = %2
  %12 = load ptr, ptr @__stderrp, align 8
  %13 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %12, ptr noundef @.str.2) #5
  store i32 1, ptr %3, align 4
  br label %36

14:                                               ; preds = %2
  %15 = load ptr, ptr %6, align 8
  %16 = call i32 (ptr, ptr, ...) @fscanf(ptr noundef %15, ptr noundef @.str.3, ptr noundef %8)
  %17 = load ptr, ptr %6, align 8
  %18 = call i32 @fclose(ptr noundef %17)
  store i64 0, ptr %7, align 8
  br label %19

19:                                               ; preds = %32, %14
  %20 = load i64, ptr %7, align 8
  %21 = load i64, ptr %8, align 8
  %22 = icmp slt i64 %20, %21
  br i1 %22, label %23, label %35

23:                                               ; preds = %19
  %24 = load i32, ptr %4, align 4
  %25 = load ptr, ptr %5, align 8
  %26 = load i64, ptr %7, align 8
  %27 = add nsw i64 %26, 1
  %28 = load i64, ptr %8, align 8
  %29 = icmp eq i64 %27, %28
  %30 = zext i1 %29 to i32
  %31 = call i32 @main1(i32 noundef %24, ptr noundef %25, i32 noundef %30)
  br label %32

32:                                               ; preds = %23
  %33 = load i64, ptr %7, align 8
  %34 = add nsw i64 %33, 1
  store i64 %34, ptr %7, align 8
  br label %19, !llvm.loop !6

35:                                               ; preds = %19
  store i32 0, ptr %3, align 4
  br label %36

36:                                               ; preds = %35, %11
  %37 = load i32, ptr %3, align 4
  ret i32 %37
}

declare ptr @"\01_fopen"(ptr noundef, ptr noundef) #1

; Function Attrs: nounwind
declare i32 @fprintf(ptr noundef, ptr noundef, ...) #2

declare i32 @fscanf(ptr noundef, ptr noundef, ...) #1

declare i32 @fclose(ptr noundef) #1

; Function Attrs: noinline nounwind ssp uwtable(sync)
define void @qsortx(ptr noundef %0, i32 noundef %1, i32 noundef %2, ptr noundef %3) #0 {
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  %11 = alloca ptr, align 8
  %12 = alloca ptr, align 8
  %13 = alloca ptr, align 8
  %14 = alloca i32, align 4
  %15 = alloca [30 x ptr], align 8
  %16 = alloca [30 x ptr], align 8
  %17 = alloca i32, align 4
  store ptr %0, ptr %5, align 8
  store i32 %1, ptr %6, align 4
  store i32 %2, ptr %7, align 4
  store ptr %3, ptr %8, align 8
  %18 = load i32, ptr %6, align 4
  %19 = icmp ult i32 %18, 2
  br i1 %19, label %23, label %20

20:                                               ; preds = %4
  %21 = load i32, ptr %7, align 4
  %22 = icmp eq i32 %21, 0
  br i1 %22, label %23, label %24

23:                                               ; preds = %20, %4
  br label %203

24:                                               ; preds = %20
  store i32 0, ptr %17, align 4
  %25 = load ptr, ptr %5, align 8
  store ptr %25, ptr %9, align 8
  %26 = load ptr, ptr %5, align 8
  %27 = load i32, ptr %7, align 4
  %28 = load i32, ptr %6, align 4
  %29 = sub i32 %28, 1
  %30 = mul i32 %27, %29
  %31 = zext i32 %30 to i64
  %32 = getelementptr inbounds nuw i8, ptr %26, i64 %31
  store ptr %32, ptr %10, align 8
  br label %33

33:                                               ; preds = %193, %180, %155, %24
  %34 = load ptr, ptr %10, align 8
  %35 = load ptr, ptr %9, align 8
  %36 = ptrtoint ptr %34 to i64
  %37 = ptrtoint ptr %35 to i64
  %38 = sub i64 %36, %37
  %39 = load i32, ptr %7, align 4
  %40 = zext i32 %39 to i64
  %41 = sdiv i64 %38, %40
  %42 = add nsw i64 %41, 1
  %43 = trunc i64 %42 to i32
  store i32 %43, ptr %14, align 4
  %44 = load i32, ptr %14, align 4
  %45 = icmp ule i32 %44, 8
  br i1 %45, label %46, label %51

46:                                               ; preds = %33
  %47 = load ptr, ptr %9, align 8
  %48 = load ptr, ptr %10, align 8
  %49 = load i32, ptr %7, align 4
  %50 = load ptr, ptr %8, align 8
  call void @shortsort(ptr noundef %47, ptr noundef %48, i32 noundef %49, ptr noundef %50)
  br label %188

51:                                               ; preds = %33
  %52 = load ptr, ptr %9, align 8
  %53 = load i32, ptr %14, align 4
  %54 = udiv i32 %53, 2
  %55 = load i32, ptr %7, align 4
  %56 = mul i32 %54, %55
  %57 = zext i32 %56 to i64
  %58 = getelementptr inbounds nuw i8, ptr %52, i64 %57
  store ptr %58, ptr %11, align 8
  %59 = load ptr, ptr %11, align 8
  %60 = load ptr, ptr %9, align 8
  %61 = load i32, ptr %7, align 4
  call void @swap(ptr noundef %59, ptr noundef %60, i32 noundef %61)
  %62 = load ptr, ptr %9, align 8
  store ptr %62, ptr %12, align 8
  %63 = load ptr, ptr %10, align 8
  %64 = load i32, ptr %7, align 4
  %65 = zext i32 %64 to i64
  %66 = getelementptr inbounds nuw i8, ptr %63, i64 %65
  store ptr %66, ptr %13, align 8
  br label %67

67:                                               ; preds = %109, %51
  br label %68

68:                                               ; preds = %83, %67
  %69 = load i32, ptr %7, align 4
  %70 = load ptr, ptr %12, align 8
  %71 = zext i32 %69 to i64
  %72 = getelementptr inbounds nuw i8, ptr %70, i64 %71
  store ptr %72, ptr %12, align 8
  br label %73

73:                                               ; preds = %68
  %74 = load ptr, ptr %12, align 8
  %75 = load ptr, ptr %10, align 8
  %76 = icmp ule ptr %74, %75
  br i1 %76, label %77, label %83

77:                                               ; preds = %73
  %78 = load ptr, ptr %8, align 8
  %79 = load ptr, ptr %12, align 8
  %80 = load ptr, ptr %9, align 8
  %81 = call i32 %78(ptr noundef %79, ptr noundef %80)
  %82 = icmp sle i32 %81, 0
  br label %83

83:                                               ; preds = %77, %73
  %84 = phi i1 [ false, %73 ], [ %82, %77 ]
  br i1 %84, label %68, label %85, !llvm.loop !8

85:                                               ; preds = %83
  br label %86

86:                                               ; preds = %102, %85
  %87 = load i32, ptr %7, align 4
  %88 = load ptr, ptr %13, align 8
  %89 = zext i32 %87 to i64
  %90 = sub i64 0, %89
  %91 = getelementptr inbounds i8, ptr %88, i64 %90
  store ptr %91, ptr %13, align 8
  br label %92

92:                                               ; preds = %86
  %93 = load ptr, ptr %13, align 8
  %94 = load ptr, ptr %9, align 8
  %95 = icmp ugt ptr %93, %94
  br i1 %95, label %96, label %102

96:                                               ; preds = %92
  %97 = load ptr, ptr %8, align 8
  %98 = load ptr, ptr %13, align 8
  %99 = load ptr, ptr %9, align 8
  %100 = call i32 %97(ptr noundef %98, ptr noundef %99)
  %101 = icmp sge i32 %100, 0
  br label %102

102:                                              ; preds = %96, %92
  %103 = phi i1 [ false, %92 ], [ %101, %96 ]
  br i1 %103, label %86, label %104, !llvm.loop !9

104:                                              ; preds = %102
  %105 = load ptr, ptr %13, align 8
  %106 = load ptr, ptr %12, align 8
  %107 = icmp ult ptr %105, %106
  br i1 %107, label %108, label %109

108:                                              ; preds = %104
  br label %113

109:                                              ; preds = %104
  %110 = load ptr, ptr %12, align 8
  %111 = load ptr, ptr %13, align 8
  %112 = load i32, ptr %7, align 4
  call void @swap(ptr noundef %110, ptr noundef %111, i32 noundef %112)
  br label %67

113:                                              ; preds = %108
  %114 = load ptr, ptr %9, align 8
  %115 = load ptr, ptr %13, align 8
  %116 = load i32, ptr %7, align 4
  call void @swap(ptr noundef %114, ptr noundef %115, i32 noundef %116)
  %117 = load ptr, ptr %13, align 8
  %118 = getelementptr inbounds i8, ptr %117, i64 -1
  %119 = load ptr, ptr %9, align 8
  %120 = ptrtoint ptr %118 to i64
  %121 = ptrtoint ptr %119 to i64
  %122 = sub i64 %120, %121
  %123 = load ptr, ptr %10, align 8
  %124 = load ptr, ptr %12, align 8
  %125 = ptrtoint ptr %123 to i64
  %126 = ptrtoint ptr %124 to i64
  %127 = sub i64 %125, %126
  %128 = icmp sge i64 %122, %127
  br i1 %128, label %129, label %158

129:                                              ; preds = %113
  %130 = load ptr, ptr %9, align 8
  %131 = load i32, ptr %7, align 4
  %132 = zext i32 %131 to i64
  %133 = getelementptr inbounds nuw i8, ptr %130, i64 %132
  %134 = load ptr, ptr %13, align 8
  %135 = icmp ult ptr %133, %134
  br i1 %135, label %136, label %151

136:                                              ; preds = %129
  %137 = load ptr, ptr %9, align 8
  %138 = load i32, ptr %17, align 4
  %139 = sext i32 %138 to i64
  %140 = getelementptr inbounds [30 x ptr], ptr %15, i64 0, i64 %139
  store ptr %137, ptr %140, align 8
  %141 = load ptr, ptr %13, align 8
  %142 = load i32, ptr %7, align 4
  %143 = zext i32 %142 to i64
  %144 = sub i64 0, %143
  %145 = getelementptr inbounds i8, ptr %141, i64 %144
  %146 = load i32, ptr %17, align 4
  %147 = sext i32 %146 to i64
  %148 = getelementptr inbounds [30 x ptr], ptr %16, i64 0, i64 %147
  store ptr %145, ptr %148, align 8
  %149 = load i32, ptr %17, align 4
  %150 = add nsw i32 %149, 1
  store i32 %150, ptr %17, align 4
  br label %151

151:                                              ; preds = %136, %129
  %152 = load ptr, ptr %12, align 8
  %153 = load ptr, ptr %10, align 8
  %154 = icmp ult ptr %152, %153
  br i1 %154, label %155, label %157

155:                                              ; preds = %151
  %156 = load ptr, ptr %12, align 8
  store ptr %156, ptr %9, align 8
  br label %33

157:                                              ; preds = %151
  br label %187

158:                                              ; preds = %113
  %159 = load ptr, ptr %12, align 8
  %160 = load ptr, ptr %10, align 8
  %161 = icmp ult ptr %159, %160
  br i1 %161, label %162, label %173

162:                                              ; preds = %158
  %163 = load ptr, ptr %12, align 8
  %164 = load i32, ptr %17, align 4
  %165 = sext i32 %164 to i64
  %166 = getelementptr inbounds [30 x ptr], ptr %15, i64 0, i64 %165
  store ptr %163, ptr %166, align 8
  %167 = load ptr, ptr %10, align 8
  %168 = load i32, ptr %17, align 4
  %169 = sext i32 %168 to i64
  %170 = getelementptr inbounds [30 x ptr], ptr %16, i64 0, i64 %169
  store ptr %167, ptr %170, align 8
  %171 = load i32, ptr %17, align 4
  %172 = add nsw i32 %171, 1
  store i32 %172, ptr %17, align 4
  br label %173

173:                                              ; preds = %162, %158
  %174 = load ptr, ptr %9, align 8
  %175 = load i32, ptr %7, align 4
  %176 = zext i32 %175 to i64
  %177 = getelementptr inbounds nuw i8, ptr %174, i64 %176
  %178 = load ptr, ptr %13, align 8
  %179 = icmp ult ptr %177, %178
  br i1 %179, label %180, label %186

180:                                              ; preds = %173
  %181 = load ptr, ptr %13, align 8
  %182 = load i32, ptr %7, align 4
  %183 = zext i32 %182 to i64
  %184 = sub i64 0, %183
  %185 = getelementptr inbounds i8, ptr %181, i64 %184
  store ptr %185, ptr %10, align 8
  br label %33

186:                                              ; preds = %173
  br label %187

187:                                              ; preds = %186, %157
  br label %188

188:                                              ; preds = %187, %46
  %189 = load i32, ptr %17, align 4
  %190 = add nsw i32 %189, -1
  store i32 %190, ptr %17, align 4
  %191 = load i32, ptr %17, align 4
  %192 = icmp sge i32 %191, 0
  br i1 %192, label %193, label %202

193:                                              ; preds = %188
  %194 = load i32, ptr %17, align 4
  %195 = sext i32 %194 to i64
  %196 = getelementptr inbounds [30 x ptr], ptr %15, i64 0, i64 %195
  %197 = load ptr, ptr %196, align 8
  store ptr %197, ptr %9, align 8
  %198 = load i32, ptr %17, align 4
  %199 = sext i32 %198 to i64
  %200 = getelementptr inbounds [30 x ptr], ptr %16, i64 0, i64 %199
  %201 = load ptr, ptr %200, align 8
  store ptr %201, ptr %10, align 8
  br label %33

202:                                              ; preds = %188
  br label %203

203:                                              ; preds = %202, %23
  ret void
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define internal void @shortsort(ptr noundef %0, ptr noundef %1, i32 noundef %2, ptr noundef %3) #0 {
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  store ptr %0, ptr %5, align 8
  store ptr %1, ptr %6, align 8
  store i32 %2, ptr %7, align 4
  store ptr %3, ptr %8, align 8
  br label %11

11:                                               ; preds = %39, %4
  %12 = load ptr, ptr %6, align 8
  %13 = load ptr, ptr %5, align 8
  %14 = icmp ugt ptr %12, %13
  br i1 %14, label %15, label %48

15:                                               ; preds = %11
  %16 = load ptr, ptr %5, align 8
  store ptr %16, ptr %10, align 8
  %17 = load ptr, ptr %5, align 8
  %18 = load i32, ptr %7, align 4
  %19 = zext i32 %18 to i64
  %20 = getelementptr inbounds nuw i8, ptr %17, i64 %19
  store ptr %20, ptr %9, align 8
  br label %21

21:                                               ; preds = %34, %15
  %22 = load ptr, ptr %9, align 8
  %23 = load ptr, ptr %6, align 8
  %24 = icmp ule ptr %22, %23
  br i1 %24, label %25, label %39

25:                                               ; preds = %21
  %26 = load ptr, ptr %8, align 8
  %27 = load ptr, ptr %9, align 8
  %28 = load ptr, ptr %10, align 8
  %29 = call i32 %26(ptr noundef %27, ptr noundef %28)
  %30 = icmp sgt i32 %29, 0
  br i1 %30, label %31, label %33

31:                                               ; preds = %25
  %32 = load ptr, ptr %9, align 8
  store ptr %32, ptr %10, align 8
  br label %33

33:                                               ; preds = %31, %25
  br label %34

34:                                               ; preds = %33
  %35 = load i32, ptr %7, align 4
  %36 = load ptr, ptr %9, align 8
  %37 = zext i32 %35 to i64
  %38 = getelementptr inbounds nuw i8, ptr %36, i64 %37
  store ptr %38, ptr %9, align 8
  br label %21, !llvm.loop !10

39:                                               ; preds = %21
  %40 = load ptr, ptr %10, align 8
  %41 = load ptr, ptr %6, align 8
  %42 = load i32, ptr %7, align 4
  call void @swap(ptr noundef %40, ptr noundef %41, i32 noundef %42)
  %43 = load i32, ptr %7, align 4
  %44 = load ptr, ptr %6, align 8
  %45 = zext i32 %43 to i64
  %46 = sub i64 0, %45
  %47 = getelementptr inbounds i8, ptr %44, i64 %46
  store ptr %47, ptr %6, align 8
  br label %11, !llvm.loop !11

48:                                               ; preds = %11
  ret void
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define internal void @swap(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i8, align 1
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store i32 %2, ptr %6, align 4
  %8 = load ptr, ptr %4, align 8
  %9 = load ptr, ptr %5, align 8
  %10 = icmp ne ptr %8, %9
  br i1 %10, label %11, label %27

11:                                               ; preds = %3
  br label %12

12:                                               ; preds = %16, %11
  %13 = load i32, ptr %6, align 4
  %14 = add i32 %13, -1
  store i32 %14, ptr %6, align 4
  %15 = icmp ne i32 %13, 0
  br i1 %15, label %16, label %26

16:                                               ; preds = %12
  %17 = load ptr, ptr %4, align 8
  %18 = load i8, ptr %17, align 1
  store i8 %18, ptr %7, align 1
  %19 = load ptr, ptr %5, align 8
  %20 = load i8, ptr %19, align 1
  %21 = load ptr, ptr %4, align 8
  %22 = getelementptr inbounds nuw i8, ptr %21, i32 1
  store ptr %22, ptr %4, align 8
  store i8 %20, ptr %21, align 1
  %23 = load i8, ptr %7, align 1
  %24 = load ptr, ptr %5, align 8
  %25 = getelementptr inbounds nuw i8, ptr %24, i32 1
  store ptr %25, ptr %5, align 8
  store i8 %23, ptr %24, align 1
  br label %12, !llvm.loop !12

26:                                               ; preds = %12
  br label %27

27:                                               ; preds = %26, %3
  ret void
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @compare(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca double, align 8
  %6 = alloca double, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %7 = load ptr, ptr %3, align 8
  %8 = getelementptr inbounds nuw %struct.my3DVertexStruct, ptr %7, i32 0, i32 3
  %9 = load double, ptr %8, align 8
  store double %9, ptr %5, align 8
  %10 = load ptr, ptr %4, align 8
  %11 = getelementptr inbounds nuw %struct.my3DVertexStruct, ptr %10, i32 0, i32 3
  %12 = load double, ptr %11, align 8
  store double %12, ptr %6, align 8
  %13 = load double, ptr %5, align 8
  %14 = load double, ptr %6, align 8
  %15 = fcmp ogt double %13, %14
  br i1 %15, label %16, label %17

16:                                               ; preds = %2
  br label %23

17:                                               ; preds = %2
  %18 = load double, ptr %5, align 8
  %19 = load double, ptr %6, align 8
  %20 = fcmp oeq double %18, %19
  %21 = zext i1 %20 to i64
  %22 = select i1 %20, i32 0, i32 -1
  br label %23

23:                                               ; preds = %17, %16
  %24 = phi i32 [ 1, %16 ], [ %22, %17 ]
  ret i32 %24
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @main1(i32 noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca ptr, align 8
  %8 = alloca [60000 x %struct.my3DVertexStruct], align 8
  %9 = alloca ptr, align 8
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  store i32 %2, ptr %6, align 4
  store ptr null, ptr %7, align 8
  store i32 0, ptr %11, align 4
  %15 = load i32, ptr %4, align 4
  %16 = icmp slt i32 %15, 2
  br i1 %16, label %17, label %20

17:                                               ; preds = %3
  %18 = load ptr, ptr @__stderrp, align 8
  %19 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %18, ptr noundef @.str.4) #5
  call void @exit(i32 noundef 1) #6
  unreachable

20:                                               ; preds = %3
  %21 = load ptr, ptr %5, align 8
  %22 = getelementptr inbounds ptr, ptr %21, i64 1
  %23 = load ptr, ptr %22, align 8
  %24 = call ptr @"\01_fopen"(ptr noundef %23, ptr noundef @.str.1.5)
  store ptr %24, ptr %9, align 8
  br label %25

25:                                               ; preds = %42, %20
  %26 = load ptr, ptr %9, align 8
  %27 = call i32 (ptr, ptr, ...) @fscanf(ptr noundef %26, ptr noundef @.str.2.6, ptr noundef %12)
  %28 = icmp eq i32 %27, 1
  br i1 %28, label %29, label %40

29:                                               ; preds = %25
  %30 = load ptr, ptr %9, align 8
  %31 = call i32 (ptr, ptr, ...) @fscanf(ptr noundef %30, ptr noundef @.str.2.6, ptr noundef %13)
  %32 = icmp eq i32 %31, 1
  br i1 %32, label %33, label %40

33:                                               ; preds = %29
  %34 = load ptr, ptr %9, align 8
  %35 = call i32 (ptr, ptr, ...) @fscanf(ptr noundef %34, ptr noundef @.str.2.6, ptr noundef %14)
  %36 = icmp eq i32 %35, 1
  br i1 %36, label %37, label %40

37:                                               ; preds = %33
  %38 = load i32, ptr %11, align 4
  %39 = icmp slt i32 %38, 60000
  br label %40

40:                                               ; preds = %37, %33, %29, %25
  %41 = phi i1 [ false, %33 ], [ false, %29 ], [ false, %25 ], [ %39, %37 ]
  br i1 %41, label %42, label %76

42:                                               ; preds = %40
  %43 = load i32, ptr %12, align 4
  %44 = load i32, ptr %11, align 4
  %45 = sext i32 %44 to i64
  %46 = getelementptr inbounds [60000 x %struct.my3DVertexStruct], ptr %8, i64 0, i64 %45
  %47 = getelementptr inbounds nuw %struct.my3DVertexStruct, ptr %46, i32 0, i32 0
  store i32 %43, ptr %47, align 8
  %48 = load i32, ptr %13, align 4
  %49 = load i32, ptr %11, align 4
  %50 = sext i32 %49 to i64
  %51 = getelementptr inbounds [60000 x %struct.my3DVertexStruct], ptr %8, i64 0, i64 %50
  %52 = getelementptr inbounds nuw %struct.my3DVertexStruct, ptr %51, i32 0, i32 1
  store i32 %48, ptr %52, align 4
  %53 = load i32, ptr %14, align 4
  %54 = load i32, ptr %11, align 4
  %55 = sext i32 %54 to i64
  %56 = getelementptr inbounds [60000 x %struct.my3DVertexStruct], ptr %8, i64 0, i64 %55
  %57 = getelementptr inbounds nuw %struct.my3DVertexStruct, ptr %56, i32 0, i32 2
  store i32 %53, ptr %57, align 8
  %58 = load i32, ptr %12, align 4
  %59 = sitofp i32 %58 to double
  %60 = call double @llvm.pow.f64(double %59, double 2.000000e+00)
  %61 = load i32, ptr %13, align 4
  %62 = sitofp i32 %61 to double
  %63 = call double @llvm.pow.f64(double %62, double 2.000000e+00)
  %64 = fadd double %60, %63
  %65 = load i32, ptr %14, align 4
  %66 = sitofp i32 %65 to double
  %67 = call double @llvm.pow.f64(double %66, double 2.000000e+00)
  %68 = fadd double %64, %67
  %69 = call double @llvm.sqrt.f64(double %68)
  %70 = load i32, ptr %11, align 4
  %71 = sext i32 %70 to i64
  %72 = getelementptr inbounds [60000 x %struct.my3DVertexStruct], ptr %8, i64 0, i64 %71
  %73 = getelementptr inbounds nuw %struct.my3DVertexStruct, ptr %72, i32 0, i32 3
  store double %69, ptr %73, align 8
  %74 = load i32, ptr %11, align 4
  %75 = add nsw i32 %74, 1
  store i32 %75, ptr %11, align 4
  br label %25, !llvm.loop !13

76:                                               ; preds = %40
  %77 = load ptr, ptr %9, align 8
  %78 = call i32 @fclose(ptr noundef %77)
  br label %79

79:                                               ; preds = %76
  %80 = load i32, ptr %6, align 4
  %81 = icmp ne i32 %80, 0
  br i1 %81, label %82, label %85

82:                                               ; preds = %79
  %83 = load i32, ptr %11, align 4
  %84 = call i32 (ptr, ...) @printf(ptr noundef @.str.3.7, i32 noundef %83)
  br label %85

85:                                               ; preds = %82, %79
  %86 = getelementptr inbounds [60000 x %struct.my3DVertexStruct], ptr %8, i64 0, i64 0
  %87 = load i32, ptr %11, align 4
  call void @qsortx(ptr noundef %86, i32 noundef %87, i32 noundef 24, ptr noundef @compare)
  %88 = load i32, ptr %6, align 4
  %89 = icmp ne i32 %88, 0
  br i1 %89, label %90, label %127

90:                                               ; preds = %85
  %91 = call ptr @"\01_fopen"(ptr noundef @.str.4.8, ptr noundef @.str.5)
  store ptr %91, ptr %7, align 8
  %92 = icmp eq ptr %91, null
  br i1 %92, label %93, label %96

93:                                               ; preds = %90
  %94 = load ptr, ptr @__stderrp, align 8
  %95 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %94, ptr noundef @.str.6) #5
  call void @exit(i32 noundef 1) #6
  unreachable

96:                                               ; preds = %90
  store i32 0, ptr %10, align 4
  br label %97

97:                                               ; preds = %119, %96
  %98 = load i32, ptr %10, align 4
  %99 = load i32, ptr %11, align 4
  %100 = icmp slt i32 %98, %99
  br i1 %100, label %101, label %124

101:                                              ; preds = %97
  %102 = load ptr, ptr %7, align 8
  %103 = load i32, ptr %10, align 4
  %104 = sext i32 %103 to i64
  %105 = getelementptr inbounds [60000 x %struct.my3DVertexStruct], ptr %8, i64 0, i64 %104
  %106 = getelementptr inbounds nuw %struct.my3DVertexStruct, ptr %105, i32 0, i32 0
  %107 = load i32, ptr %106, align 8
  %108 = load i32, ptr %10, align 4
  %109 = sext i32 %108 to i64
  %110 = getelementptr inbounds [60000 x %struct.my3DVertexStruct], ptr %8, i64 0, i64 %109
  %111 = getelementptr inbounds nuw %struct.my3DVertexStruct, ptr %110, i32 0, i32 1
  %112 = load i32, ptr %111, align 4
  %113 = load i32, ptr %10, align 4
  %114 = sext i32 %113 to i64
  %115 = getelementptr inbounds [60000 x %struct.my3DVertexStruct], ptr %8, i64 0, i64 %114
  %116 = getelementptr inbounds nuw %struct.my3DVertexStruct, ptr %115, i32 0, i32 2
  %117 = load i32, ptr %116, align 8
  %118 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %102, ptr noundef @.str.7, i32 noundef %107, i32 noundef %112, i32 noundef %117) #5
  br label %119

119:                                              ; preds = %101
  %120 = load i32, ptr %11, align 4
  %121 = sdiv i32 %120, 100
  %122 = load i32, ptr %10, align 4
  %123 = add nsw i32 %122, %121
  store i32 %123, ptr %10, align 4
  br label %97, !llvm.loop !14

124:                                              ; preds = %97
  %125 = load ptr, ptr %7, align 8
  %126 = call i32 @fclose(ptr noundef %125)
  br label %127

127:                                              ; preds = %124, %85
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

; ModuleID = 'matmul.c'
source_filename = "matmul.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@A = local_unnamed_addr global [32 x [32 x double]] zeroinitializer, align 8
@B = local_unnamed_addr global [32 x [32 x double]] zeroinitializer, align 8
@C = local_unnamed_addr global [32 x [32 x double]] zeroinitializer, align 8
@.str = private unnamed_addr constant [22 x i8] c"Tempo: %.4f segundos\0A\00", align 1
@.str.1 = private unnamed_addr constant [16 x i8] c"C[0][0] = %.6f\0A\00", align 1

; Function Attrs: nofree norecurse nosync nounwind ssp memory(readwrite, argmem: none, inaccessiblemem: none, target_mem0: none, target_mem1: none) uwtable(sync)
define void @matmul() local_unnamed_addr #0 {
  br label %2

1:                                                ; preds = %238
  ret void

2:                                                ; preds = %0, %238
  %3 = phi i64 [ 0, %0 ], [ %239, %238 ]
  %4 = shl nuw nsw i64 %3, 8
  %5 = getelementptr i8, ptr @C, i64 %4
  %6 = shl i64 %3, 8
  %7 = getelementptr i8, ptr @A, i64 %6
  %8 = load double, ptr %7, align 8, !alias.scope !10, !noalias !13
  %9 = getelementptr i8, ptr %7, i64 8
  %10 = load double, ptr %9, align 8, !alias.scope !10, !noalias !13
  %11 = getelementptr i8, ptr %7, i64 16
  %12 = load double, ptr %11, align 8, !alias.scope !10, !noalias !13
  %13 = getelementptr i8, ptr %7, i64 24
  %14 = load double, ptr %13, align 8, !alias.scope !10, !noalias !13
  %15 = getelementptr i8, ptr %7, i64 32
  %16 = load double, ptr %15, align 8, !alias.scope !10, !noalias !13
  %17 = getelementptr i8, ptr %7, i64 40
  %18 = load double, ptr %17, align 8, !alias.scope !10, !noalias !13
  %19 = getelementptr i8, ptr %7, i64 48
  %20 = load double, ptr %19, align 8, !alias.scope !10, !noalias !13
  %21 = getelementptr i8, ptr %7, i64 56
  %22 = load double, ptr %21, align 8, !alias.scope !10, !noalias !13
  %23 = getelementptr i8, ptr %7, i64 64
  %24 = load double, ptr %23, align 8, !alias.scope !10, !noalias !13
  %25 = getelementptr i8, ptr %7, i64 72
  %26 = load double, ptr %25, align 8, !alias.scope !10, !noalias !13
  %27 = getelementptr i8, ptr %7, i64 80
  %28 = load double, ptr %27, align 8, !alias.scope !10, !noalias !13
  %29 = getelementptr i8, ptr %7, i64 88
  %30 = load double, ptr %29, align 8, !alias.scope !10, !noalias !13
  %31 = getelementptr i8, ptr %7, i64 96
  %32 = load double, ptr %31, align 8, !alias.scope !10, !noalias !13
  %33 = getelementptr i8, ptr %7, i64 104
  %34 = load double, ptr %33, align 8, !alias.scope !10, !noalias !13
  %35 = getelementptr i8, ptr %7, i64 112
  %36 = load double, ptr %35, align 8, !alias.scope !10, !noalias !13
  %37 = getelementptr i8, ptr %7, i64 120
  %38 = load double, ptr %37, align 8, !alias.scope !10, !noalias !13
  %39 = getelementptr i8, ptr %7, i64 128
  %40 = load double, ptr %39, align 8, !alias.scope !10, !noalias !13
  %41 = getelementptr i8, ptr %7, i64 136
  %42 = load double, ptr %41, align 8, !alias.scope !10, !noalias !13
  %43 = getelementptr i8, ptr %7, i64 144
  %44 = load double, ptr %43, align 8, !alias.scope !10, !noalias !13
  %45 = getelementptr i8, ptr %7, i64 152
  %46 = load double, ptr %45, align 8, !alias.scope !10, !noalias !13
  %47 = getelementptr i8, ptr %7, i64 160
  %48 = load double, ptr %47, align 8, !alias.scope !10, !noalias !13
  %49 = getelementptr i8, ptr %7, i64 168
  %50 = load double, ptr %49, align 8, !alias.scope !10, !noalias !13
  %51 = getelementptr i8, ptr %7, i64 176
  %52 = load double, ptr %51, align 8, !alias.scope !10, !noalias !13
  %53 = getelementptr i8, ptr %7, i64 184
  %54 = load double, ptr %53, align 8, !alias.scope !10, !noalias !13
  %55 = getelementptr i8, ptr %7, i64 192
  %56 = load double, ptr %55, align 8, !alias.scope !10, !noalias !13
  %57 = getelementptr i8, ptr %7, i64 200
  %58 = load double, ptr %57, align 8, !alias.scope !10, !noalias !13
  %59 = getelementptr i8, ptr %7, i64 208
  %60 = load double, ptr %59, align 8, !alias.scope !10, !noalias !13
  %61 = getelementptr i8, ptr %7, i64 216
  %62 = load double, ptr %61, align 8, !alias.scope !10, !noalias !13
  %63 = getelementptr i8, ptr %7, i64 224
  %64 = load double, ptr %63, align 8, !alias.scope !10, !noalias !13
  %65 = getelementptr i8, ptr %7, i64 232
  %66 = load double, ptr %65, align 8, !alias.scope !10, !noalias !13
  %67 = getelementptr i8, ptr %7, i64 240
  %68 = load double, ptr %67, align 8, !alias.scope !10, !noalias !13
  %69 = getelementptr i8, ptr %7, i64 248
  %70 = load double, ptr %69, align 8, !alias.scope !10, !noalias !13
  %71 = insertelement <2 x double> poison, double %70, i64 0
  %72 = shufflevector <2 x double> %71, <2 x double> poison, <2 x i32> zeroinitializer
  %73 = insertelement <2 x double> poison, double %68, i64 0
  %74 = shufflevector <2 x double> %73, <2 x double> poison, <2 x i32> zeroinitializer
  %75 = insertelement <2 x double> poison, double %66, i64 0
  %76 = shufflevector <2 x double> %75, <2 x double> poison, <2 x i32> zeroinitializer
  %77 = insertelement <2 x double> poison, double %64, i64 0
  %78 = shufflevector <2 x double> %77, <2 x double> poison, <2 x i32> zeroinitializer
  %79 = insertelement <2 x double> poison, double %62, i64 0
  %80 = shufflevector <2 x double> %79, <2 x double> poison, <2 x i32> zeroinitializer
  %81 = insertelement <2 x double> poison, double %60, i64 0
  %82 = shufflevector <2 x double> %81, <2 x double> poison, <2 x i32> zeroinitializer
  %83 = insertelement <2 x double> poison, double %58, i64 0
  %84 = shufflevector <2 x double> %83, <2 x double> poison, <2 x i32> zeroinitializer
  %85 = insertelement <2 x double> poison, double %56, i64 0
  %86 = shufflevector <2 x double> %85, <2 x double> poison, <2 x i32> zeroinitializer
  %87 = insertelement <2 x double> poison, double %54, i64 0
  %88 = shufflevector <2 x double> %87, <2 x double> poison, <2 x i32> zeroinitializer
  %89 = insertelement <2 x double> poison, double %52, i64 0
  %90 = shufflevector <2 x double> %89, <2 x double> poison, <2 x i32> zeroinitializer
  %91 = insertelement <2 x double> poison, double %50, i64 0
  %92 = shufflevector <2 x double> %91, <2 x double> poison, <2 x i32> zeroinitializer
  %93 = insertelement <2 x double> poison, double %48, i64 0
  %94 = shufflevector <2 x double> %93, <2 x double> poison, <2 x i32> zeroinitializer
  %95 = insertelement <2 x double> poison, double %46, i64 0
  %96 = shufflevector <2 x double> %95, <2 x double> poison, <2 x i32> zeroinitializer
  %97 = insertelement <2 x double> poison, double %44, i64 0
  %98 = shufflevector <2 x double> %97, <2 x double> poison, <2 x i32> zeroinitializer
  %99 = insertelement <2 x double> poison, double %42, i64 0
  %100 = shufflevector <2 x double> %99, <2 x double> poison, <2 x i32> zeroinitializer
  %101 = insertelement <2 x double> poison, double %40, i64 0
  %102 = shufflevector <2 x double> %101, <2 x double> poison, <2 x i32> zeroinitializer
  %103 = insertelement <2 x double> poison, double %38, i64 0
  %104 = shufflevector <2 x double> %103, <2 x double> poison, <2 x i32> zeroinitializer
  %105 = insertelement <2 x double> poison, double %36, i64 0
  %106 = shufflevector <2 x double> %105, <2 x double> poison, <2 x i32> zeroinitializer
  %107 = insertelement <2 x double> poison, double %34, i64 0
  %108 = shufflevector <2 x double> %107, <2 x double> poison, <2 x i32> zeroinitializer
  %109 = insertelement <2 x double> poison, double %32, i64 0
  %110 = shufflevector <2 x double> %109, <2 x double> poison, <2 x i32> zeroinitializer
  %111 = insertelement <2 x double> poison, double %30, i64 0
  %112 = shufflevector <2 x double> %111, <2 x double> poison, <2 x i32> zeroinitializer
  %113 = insertelement <2 x double> poison, double %28, i64 0
  %114 = shufflevector <2 x double> %113, <2 x double> poison, <2 x i32> zeroinitializer
  %115 = insertelement <2 x double> poison, double %26, i64 0
  %116 = shufflevector <2 x double> %115, <2 x double> poison, <2 x i32> zeroinitializer
  %117 = insertelement <2 x double> poison, double %24, i64 0
  %118 = shufflevector <2 x double> %117, <2 x double> poison, <2 x i32> zeroinitializer
  %119 = insertelement <2 x double> poison, double %22, i64 0
  %120 = shufflevector <2 x double> %119, <2 x double> poison, <2 x i32> zeroinitializer
  %121 = insertelement <2 x double> poison, double %20, i64 0
  %122 = shufflevector <2 x double> %121, <2 x double> poison, <2 x i32> zeroinitializer
  %123 = insertelement <2 x double> poison, double %18, i64 0
  %124 = shufflevector <2 x double> %123, <2 x double> poison, <2 x i32> zeroinitializer
  %125 = insertelement <2 x double> poison, double %16, i64 0
  %126 = shufflevector <2 x double> %125, <2 x double> poison, <2 x i32> zeroinitializer
  %127 = insertelement <2 x double> poison, double %14, i64 0
  %128 = shufflevector <2 x double> %127, <2 x double> poison, <2 x i32> zeroinitializer
  %129 = insertelement <2 x double> poison, double %12, i64 0
  %130 = shufflevector <2 x double> %129, <2 x double> poison, <2 x i32> zeroinitializer
  %131 = insertelement <2 x double> poison, double %10, i64 0
  %132 = shufflevector <2 x double> %131, <2 x double> poison, <2 x i32> zeroinitializer
  %133 = insertelement <2 x double> poison, double %8, i64 0
  %134 = shufflevector <2 x double> %133, <2 x double> poison, <2 x i32> zeroinitializer
  br label %135

135:                                              ; preds = %135, %2
  %136 = phi i64 [ 0, %2 ], [ %236, %135 ]
  %137 = shl nuw nsw i64 %136, 3
  %138 = getelementptr i8, ptr %5, i64 %137
  %139 = load <2 x double>, ptr %138, align 8, !alias.scope !16, !noalias !17
  %140 = getelementptr i8, ptr @B, i64 %137
  %141 = load <2 x double>, ptr %140, align 8, !alias.scope !18, !noalias !19
  %142 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %134, <2 x double> %141, <2 x double> %139)
  %143 = getelementptr i8, ptr getelementptr inbounds nuw (i8, ptr @B, i64 256), i64 %137
  %144 = load <2 x double>, ptr %143, align 8, !alias.scope !18, !noalias !19
  %145 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %132, <2 x double> %144, <2 x double> %142)
  %146 = getelementptr i8, ptr getelementptr inbounds nuw (i8, ptr @B, i64 512), i64 %137
  %147 = load <2 x double>, ptr %146, align 8, !alias.scope !18, !noalias !19
  %148 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %130, <2 x double> %147, <2 x double> %145)
  %149 = getelementptr i8, ptr getelementptr inbounds nuw (i8, ptr @B, i64 768), i64 %137
  %150 = load <2 x double>, ptr %149, align 8, !alias.scope !18, !noalias !19
  %151 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %128, <2 x double> %150, <2 x double> %148)
  %152 = getelementptr i8, ptr getelementptr inbounds nuw (i8, ptr @B, i64 1024), i64 %137
  %153 = load <2 x double>, ptr %152, align 8, !alias.scope !18, !noalias !19
  %154 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %126, <2 x double> %153, <2 x double> %151)
  %155 = getelementptr i8, ptr getelementptr inbounds nuw (i8, ptr @B, i64 1280), i64 %137
  %156 = load <2 x double>, ptr %155, align 8, !alias.scope !18, !noalias !19
  %157 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %124, <2 x double> %156, <2 x double> %154)
  %158 = getelementptr i8, ptr getelementptr inbounds nuw (i8, ptr @B, i64 1536), i64 %137
  %159 = load <2 x double>, ptr %158, align 8, !alias.scope !18, !noalias !19
  %160 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %122, <2 x double> %159, <2 x double> %157)
  %161 = getelementptr i8, ptr getelementptr inbounds nuw (i8, ptr @B, i64 1792), i64 %137
  %162 = load <2 x double>, ptr %161, align 8, !alias.scope !18, !noalias !19
  %163 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %120, <2 x double> %162, <2 x double> %160)
  %164 = getelementptr i8, ptr getelementptr inbounds nuw (i8, ptr @B, i64 2048), i64 %137
  %165 = load <2 x double>, ptr %164, align 8, !alias.scope !18, !noalias !19
  %166 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %118, <2 x double> %165, <2 x double> %163)
  %167 = getelementptr i8, ptr getelementptr inbounds nuw (i8, ptr @B, i64 2304), i64 %137
  %168 = load <2 x double>, ptr %167, align 8, !alias.scope !18, !noalias !19
  %169 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %116, <2 x double> %168, <2 x double> %166)
  %170 = getelementptr i8, ptr getelementptr inbounds nuw (i8, ptr @B, i64 2560), i64 %137
  %171 = load <2 x double>, ptr %170, align 8, !alias.scope !18, !noalias !19
  %172 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %114, <2 x double> %171, <2 x double> %169)
  %173 = getelementptr i8, ptr getelementptr inbounds nuw (i8, ptr @B, i64 2816), i64 %137
  %174 = load <2 x double>, ptr %173, align 8, !alias.scope !18, !noalias !19
  %175 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %112, <2 x double> %174, <2 x double> %172)
  %176 = getelementptr i8, ptr getelementptr inbounds nuw (i8, ptr @B, i64 3072), i64 %137
  %177 = load <2 x double>, ptr %176, align 8, !alias.scope !18, !noalias !19
  %178 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %110, <2 x double> %177, <2 x double> %175)
  %179 = getelementptr i8, ptr getelementptr inbounds nuw (i8, ptr @B, i64 3328), i64 %137
  %180 = load <2 x double>, ptr %179, align 8, !alias.scope !18, !noalias !19
  %181 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %108, <2 x double> %180, <2 x double> %178)
  %182 = getelementptr i8, ptr getelementptr inbounds nuw (i8, ptr @B, i64 3584), i64 %137
  %183 = load <2 x double>, ptr %182, align 8, !alias.scope !18, !noalias !19
  %184 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %106, <2 x double> %183, <2 x double> %181)
  %185 = getelementptr i8, ptr getelementptr inbounds nuw (i8, ptr @B, i64 3840), i64 %137
  %186 = load <2 x double>, ptr %185, align 8, !alias.scope !18, !noalias !19
  %187 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %104, <2 x double> %186, <2 x double> %184)
  %188 = getelementptr i8, ptr getelementptr inbounds nuw (i8, ptr @B, i64 4096), i64 %137
  %189 = load <2 x double>, ptr %188, align 8, !alias.scope !18, !noalias !19
  %190 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %102, <2 x double> %189, <2 x double> %187)
  %191 = getelementptr i8, ptr getelementptr inbounds nuw (i8, ptr @B, i64 4352), i64 %137
  %192 = load <2 x double>, ptr %191, align 8, !alias.scope !18, !noalias !19
  %193 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %100, <2 x double> %192, <2 x double> %190)
  %194 = getelementptr i8, ptr getelementptr inbounds nuw (i8, ptr @B, i64 4608), i64 %137
  %195 = load <2 x double>, ptr %194, align 8, !alias.scope !18, !noalias !19
  %196 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %98, <2 x double> %195, <2 x double> %193)
  %197 = getelementptr i8, ptr getelementptr inbounds nuw (i8, ptr @B, i64 4864), i64 %137
  %198 = load <2 x double>, ptr %197, align 8, !alias.scope !18, !noalias !19
  %199 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %96, <2 x double> %198, <2 x double> %196)
  %200 = getelementptr i8, ptr getelementptr inbounds nuw (i8, ptr @B, i64 5120), i64 %137
  %201 = load <2 x double>, ptr %200, align 8, !alias.scope !18, !noalias !19
  %202 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %94, <2 x double> %201, <2 x double> %199)
  %203 = getelementptr i8, ptr getelementptr inbounds nuw (i8, ptr @B, i64 5376), i64 %137
  %204 = load <2 x double>, ptr %203, align 8, !alias.scope !18, !noalias !19
  %205 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %92, <2 x double> %204, <2 x double> %202)
  %206 = getelementptr i8, ptr getelementptr inbounds nuw (i8, ptr @B, i64 5632), i64 %137
  %207 = load <2 x double>, ptr %206, align 8, !alias.scope !18, !noalias !19
  %208 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %90, <2 x double> %207, <2 x double> %205)
  %209 = getelementptr i8, ptr getelementptr inbounds nuw (i8, ptr @B, i64 5888), i64 %137
  %210 = load <2 x double>, ptr %209, align 8, !alias.scope !18, !noalias !19
  %211 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %88, <2 x double> %210, <2 x double> %208)
  %212 = getelementptr i8, ptr getelementptr inbounds nuw (i8, ptr @B, i64 6144), i64 %137
  %213 = load <2 x double>, ptr %212, align 8, !alias.scope !18, !noalias !19
  %214 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %86, <2 x double> %213, <2 x double> %211)
  %215 = getelementptr i8, ptr getelementptr inbounds nuw (i8, ptr @B, i64 6400), i64 %137
  %216 = load <2 x double>, ptr %215, align 8, !alias.scope !18, !noalias !19
  %217 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %84, <2 x double> %216, <2 x double> %214)
  %218 = getelementptr i8, ptr getelementptr inbounds nuw (i8, ptr @B, i64 6656), i64 %137
  %219 = load <2 x double>, ptr %218, align 8, !alias.scope !18, !noalias !19
  %220 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %82, <2 x double> %219, <2 x double> %217)
  %221 = getelementptr i8, ptr getelementptr inbounds nuw (i8, ptr @B, i64 6912), i64 %137
  %222 = load <2 x double>, ptr %221, align 8, !alias.scope !18, !noalias !19
  %223 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %80, <2 x double> %222, <2 x double> %220)
  %224 = getelementptr i8, ptr getelementptr inbounds nuw (i8, ptr @B, i64 7168), i64 %137
  %225 = load <2 x double>, ptr %224, align 8, !alias.scope !18, !noalias !19
  %226 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %78, <2 x double> %225, <2 x double> %223)
  %227 = getelementptr i8, ptr getelementptr inbounds nuw (i8, ptr @B, i64 7424), i64 %137
  %228 = load <2 x double>, ptr %227, align 8, !alias.scope !18, !noalias !19
  %229 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %76, <2 x double> %228, <2 x double> %226)
  %230 = getelementptr i8, ptr getelementptr inbounds nuw (i8, ptr @B, i64 7680), i64 %137
  %231 = load <2 x double>, ptr %230, align 8, !alias.scope !18, !noalias !19
  %232 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %74, <2 x double> %231, <2 x double> %229)
  %233 = getelementptr i8, ptr getelementptr inbounds nuw (i8, ptr @B, i64 7936), i64 %137
  %234 = load <2 x double>, ptr %233, align 8, !alias.scope !18, !noalias !19
  %235 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %72, <2 x double> %234, <2 x double> %232)
  store <2 x double> %235, ptr %138, align 8, !alias.scope !16, !noalias !17
  %236 = add nuw i64 %136, 2
  %237 = icmp eq i64 %236, 32
  br i1 %237, label %238, label %135, !llvm.loop !20

238:                                              ; preds = %135
  %239 = add nuw nsw i64 %3, 1
  %240 = icmp eq i64 %239, 32
  br i1 %240, label %1, label %2
}

; Function Attrs: nounwind ssp uwtable(sync)
define void @init() local_unnamed_addr #1 {
  br label %1

1:                                                ; preds = %0, %7
  %2 = phi i64 [ 0, %0 ], [ %8, %7 ]
  %3 = getelementptr inbounds nuw [32 x double], ptr @A, i64 %2
  %4 = getelementptr inbounds nuw [32 x double], ptr @B, i64 %2
  %5 = getelementptr inbounds nuw [32 x double], ptr @C, i64 %2
  br label %10

6:                                                ; preds = %7
  ret void

7:                                                ; preds = %10
  %8 = add nuw nsw i64 %2, 1
  %9 = icmp eq i64 %8, 32
  br i1 %9, label %6, label %1, !llvm.loop !23

10:                                               ; preds = %1, %10
  %11 = phi i64 [ 0, %1 ], [ %21, %10 ]
  %12 = tail call i32 @rand() #5
  %13 = sitofp i32 %12 to double
  %14 = fdiv double %13, 0x41DFFFFFFFC00000
  %15 = getelementptr inbounds nuw double, ptr %3, i64 %11
  store double %14, ptr %15, align 8, !tbaa !25
  %16 = tail call i32 @rand() #5
  %17 = sitofp i32 %16 to double
  %18 = fdiv double %17, 0x41DFFFFFFFC00000
  %19 = getelementptr inbounds nuw double, ptr %4, i64 %11
  store double %18, ptr %19, align 8, !tbaa !25
  %20 = getelementptr inbounds nuw double, ptr %5, i64 %11
  store double 0.000000e+00, ptr %20, align 8, !tbaa !25
  %21 = add nuw nsw i64 %11, 1
  %22 = icmp eq i64 %21, 32
  br i1 %22, label %7, label %10, !llvm.loop !27
}

declare i32 @rand() local_unnamed_addr #2

; Function Attrs: nounwind ssp uwtable(sync)
define noundef i32 @main() local_unnamed_addr #1 {
  tail call void @srand(i32 noundef 42) #5
  br label %1

1:                                                ; preds = %6, %0
  %2 = phi i64 [ 0, %0 ], [ %7, %6 ]
  %3 = getelementptr inbounds nuw [32 x double], ptr @A, i64 %2
  %4 = getelementptr inbounds nuw [32 x double], ptr @B, i64 %2
  %5 = getelementptr inbounds nuw [32 x double], ptr @C, i64 %2
  br label %9

6:                                                ; preds = %9
  %7 = add nuw nsw i64 %2, 1
  %8 = icmp eq i64 %7, 32
  br i1 %8, label %22, label %1, !llvm.loop !23

9:                                                ; preds = %9, %1
  %10 = phi i64 [ 0, %1 ], [ %20, %9 ]
  %11 = tail call i32 @rand() #5
  %12 = sitofp i32 %11 to double
  %13 = fdiv double %12, 0x41DFFFFFFFC00000
  %14 = getelementptr inbounds nuw double, ptr %3, i64 %10
  store double %13, ptr %14, align 8, !tbaa !25
  %15 = tail call i32 @rand() #5
  %16 = sitofp i32 %15 to double
  %17 = fdiv double %16, 0x41DFFFFFFFC00000
  %18 = getelementptr inbounds nuw double, ptr %4, i64 %10
  store double %17, ptr %18, align 8, !tbaa !25
  %19 = getelementptr inbounds nuw double, ptr %5, i64 %10
  store double 0.000000e+00, ptr %19, align 8, !tbaa !25
  %20 = add nuw nsw i64 %10, 1
  %21 = icmp eq i64 %20, 32
  br i1 %21, label %6, label %9, !llvm.loop !27

22:                                               ; preds = %6
  %23 = tail call i64 @"\01_clock"() #5
  tail call void @matmul()
  %24 = tail call i64 @"\01_clock"() #5
  %25 = sub i64 %24, %23
  %26 = uitofp i64 %25 to double
  %27 = fdiv double %26, 1.000000e+06
  %28 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, double noundef %27)
  %29 = load double, ptr @C, align 8, !tbaa !25
  %30 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.1, double noundef %29)
  ret i32 0
}

declare void @srand(i32 noundef) local_unnamed_addr #2

declare i64 @"\01_clock"() local_unnamed_addr #2

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr noundef readonly captures(none), ...) local_unnamed_addr #3

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <2 x double> @llvm.fmuladd.v2f64(<2 x double>, <2 x double>, <2 x double>) #4

attributes #0 = { nofree norecurse nosync nounwind ssp memory(readwrite, argmem: none, inaccessiblemem: none, target_mem0: none, target_mem1: none) uwtable(sync) "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "polly-optimized" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { nounwind ssp uwtable(sync) "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #2 = { "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #3 = { nofree nounwind "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #4 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #5 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}
!llvm.errno.tbaa = !{!6}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 15, i32 4]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 4}
!5 = !{!"Homebrew clang version 22.1.0"}
!6 = !{!7, !7, i64 0}
!7 = !{!"int", !8, i64 0}
!8 = !{!"omnipotent char", !9, i64 0}
!9 = !{!"Simple C/C++ TBAA"}
!10 = !{!11}
!11 = distinct !{!11, !12, !"polly.alias.scope.MemRef0"}
!12 = distinct !{!12, !"polly.alias.scope.domain"}
!13 = !{!14, !15}
!14 = distinct !{!14, !12, !"polly.alias.scope.MemRef33"}
!15 = distinct !{!15, !12, !"polly.alias.scope.MemRef34"}
!16 = !{!14}
!17 = !{!11, !15}
!18 = !{!15}
!19 = !{!11, !14}
!20 = distinct !{!20, !21, !22}
!21 = !{!"llvm.loop.isvectorized", i32 1}
!22 = !{!"llvm.loop.unroll.runtime.disable"}
!23 = distinct !{!23, !24}
!24 = !{!"llvm.loop.mustprogress"}
!25 = !{!26, !26, i64 0}
!26 = !{!"double", !8, i64 0}
!27 = distinct !{!27, !24}

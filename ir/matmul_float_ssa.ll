; ModuleID = 'ir/matmul_float.ll'
source_filename = "matmul/mm_float.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@A = global [1024 x [1024 x float]] zeroinitializer, align 4
@B = global [1024 x [1024 x float]] zeroinitializer, align 4
@C = global [1024 x [1024 x float]] zeroinitializer, align 4
@.str = private unnamed_addr constant [4 x i8] c"%f\0A\00", align 1

; Function Attrs: noinline nounwind ssp uwtable(sync)
define void @init() #0 {
  br label %1

1:                                                ; preds = %26, %0
  %.0 = phi i32 [ 0, %0 ], [ %27, %26 ]
  %2 = icmp slt i32 %.0, 1024
  br i1 %2, label %3, label %28

3:                                                ; preds = %1
  br label %4

4:                                                ; preds = %23, %3
  %.01 = phi i32 [ 0, %3 ], [ %24, %23 ]
  %5 = icmp slt i32 %.01, 1024
  br i1 %5, label %6, label %25

6:                                                ; preds = %4
  %7 = add nsw i32 %.0, %.01
  %8 = sitofp i32 %7 to float
  %9 = sext i32 %.0 to i64
  %10 = getelementptr inbounds [1024 x [1024 x float]], ptr @A, i64 0, i64 %9
  %11 = sext i32 %.01 to i64
  %12 = getelementptr inbounds [1024 x float], ptr %10, i64 0, i64 %11
  store float %8, ptr %12, align 4
  %13 = sub nsw i32 %.0, %.01
  %14 = sitofp i32 %13 to float
  %15 = sext i32 %.0 to i64
  %16 = getelementptr inbounds [1024 x [1024 x float]], ptr @B, i64 0, i64 %15
  %17 = sext i32 %.01 to i64
  %18 = getelementptr inbounds [1024 x float], ptr %16, i64 0, i64 %17
  store float %14, ptr %18, align 4
  %19 = sext i32 %.0 to i64
  %20 = getelementptr inbounds [1024 x [1024 x float]], ptr @C, i64 0, i64 %19
  %21 = sext i32 %.01 to i64
  %22 = getelementptr inbounds [1024 x float], ptr %20, i64 0, i64 %21
  store float 0.000000e+00, ptr %22, align 4
  br label %23

23:                                               ; preds = %6
  %24 = add nsw i32 %.01, 1
  br label %4, !llvm.loop !5

25:                                               ; preds = %4
  br label %26

26:                                               ; preds = %25
  %27 = add nsw i32 %.0, 1
  br label %1, !llvm.loop !7

28:                                               ; preds = %1
  ret void
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define void @matmul() #0 {
  br label %1

1:                                                ; preds = %32, %0
  %.0 = phi i32 [ 0, %0 ], [ %33, %32 ]
  %2 = icmp slt i32 %.0, 1024
  br i1 %2, label %3, label %34

3:                                                ; preds = %1
  br label %4

4:                                                ; preds = %29, %3
  %.01 = phi i32 [ 0, %3 ], [ %30, %29 ]
  %5 = icmp slt i32 %.01, 1024
  br i1 %5, label %6, label %31

6:                                                ; preds = %4
  br label %7

7:                                                ; preds = %26, %6
  %.02 = phi i32 [ 0, %6 ], [ %27, %26 ]
  %8 = icmp slt i32 %.02, 1024
  br i1 %8, label %9, label %28

9:                                                ; preds = %7
  %10 = sext i32 %.0 to i64
  %11 = getelementptr inbounds [1024 x [1024 x float]], ptr @A, i64 0, i64 %10
  %12 = sext i32 %.02 to i64
  %13 = getelementptr inbounds [1024 x float], ptr %11, i64 0, i64 %12
  %14 = load float, ptr %13, align 4
  %15 = sext i32 %.02 to i64
  %16 = getelementptr inbounds [1024 x [1024 x float]], ptr @B, i64 0, i64 %15
  %17 = sext i32 %.01 to i64
  %18 = getelementptr inbounds [1024 x float], ptr %16, i64 0, i64 %17
  %19 = load float, ptr %18, align 4
  %20 = sext i32 %.0 to i64
  %21 = getelementptr inbounds [1024 x [1024 x float]], ptr @C, i64 0, i64 %20
  %22 = sext i32 %.01 to i64
  %23 = getelementptr inbounds [1024 x float], ptr %21, i64 0, i64 %22
  %24 = load float, ptr %23, align 4
  %25 = call float @llvm.fmuladd.f32(float %14, float %19, float %24)
  store float %25, ptr %23, align 4
  br label %26

26:                                               ; preds = %9
  %27 = add nsw i32 %.02, 1
  br label %7, !llvm.loop !8

28:                                               ; preds = %7
  br label %29

29:                                               ; preds = %28
  %30 = add nsw i32 %.01, 1
  br label %4, !llvm.loop !9

31:                                               ; preds = %4
  br label %32

32:                                               ; preds = %31
  %33 = add nsw i32 %.0, 1
  br label %1, !llvm.loop !10

34:                                               ; preds = %1
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.fmuladd.f32(float, float, float) #1

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @main() #0 {
  call void @init()
  call void @matmul()
  %1 = load float, ptr @C, align 4
  %2 = fpext float %1 to double
  %3 = call i32 (ptr, ...) @printf(ptr noundef @.str, double noundef %2)
  ret i32 0
}

declare i32 @printf(ptr noundef, ...) #2

attributes #0 = { noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" "tune-cpu"="apple-m5" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" "tune-cpu"="apple-m5" }

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

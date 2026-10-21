; ModuleID = 'ir/matmul.ll'
source_filename = "benchmarks/matmul.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@a = internal global [512 x [512 x double]] zeroinitializer, align 8
@b = internal global [512 x [512 x double]] zeroinitializer, align 8
@c = internal global [512 x [512 x double]] zeroinitializer, align 8
@.str = private unnamed_addr constant [37 x i8] c"matmul %dx%d: %.3f s (%.2f GFLOP/s)\0A\00", align 1
@.str.1 = private unnamed_addr constant [14 x i8] c"checksum: %f\0A\00", align 1

; Function Attrs: noinline nounwind ssp uwtable(sync)
define void @matmul() #0 {
  br label %1

1:                                                ; preds = %32, %0
  %.0 = phi i32 [ 0, %0 ], [ %33, %32 ]
  %2 = icmp slt i32 %.0, 512
  br i1 %2, label %3, label %34

3:                                                ; preds = %1
  br label %4

4:                                                ; preds = %29, %3
  %.01 = phi i32 [ 0, %3 ], [ %30, %29 ]
  %5 = icmp slt i32 %.01, 512
  br i1 %5, label %6, label %31

6:                                                ; preds = %4
  br label %7

7:                                                ; preds = %26, %6
  %.02 = phi i32 [ 0, %6 ], [ %27, %26 ]
  %8 = icmp slt i32 %.02, 512
  br i1 %8, label %9, label %28

9:                                                ; preds = %7
  %10 = sext i32 %.0 to i64
  %11 = getelementptr inbounds [512 x [512 x double]], ptr @a, i64 0, i64 %10
  %12 = sext i32 %.02 to i64
  %13 = getelementptr inbounds [512 x double], ptr %11, i64 0, i64 %12
  %14 = load double, ptr %13, align 8
  %15 = sext i32 %.02 to i64
  %16 = getelementptr inbounds [512 x [512 x double]], ptr @b, i64 0, i64 %15
  %17 = sext i32 %.01 to i64
  %18 = getelementptr inbounds [512 x double], ptr %16, i64 0, i64 %17
  %19 = load double, ptr %18, align 8
  %20 = sext i32 %.0 to i64
  %21 = getelementptr inbounds [512 x [512 x double]], ptr @c, i64 0, i64 %20
  %22 = sext i32 %.01 to i64
  %23 = getelementptr inbounds [512 x double], ptr %21, i64 0, i64 %22
  %24 = load volatile double, ptr %23, align 8
  %25 = call double @llvm.fmuladd.f64(double %14, double %19, double %24)
  store volatile double %25, ptr %23, align 8
  br label %26

26:                                               ; preds = %9
  %27 = add nsw i32 %.02, 1
  br label %7, !llvm.loop !6

28:                                               ; preds = %7
  br label %29

29:                                               ; preds = %28
  %30 = add nsw i32 %.01, 1
  br label %4, !llvm.loop !8

31:                                               ; preds = %4
  br label %32

32:                                               ; preds = %31
  %33 = add nsw i32 %.0, 1
  br label %1, !llvm.loop !9

34:                                               ; preds = %1
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #1

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @main() #0 {
  call void @srand(i32 noundef 42)
  br label %1

1:                                                ; preds = %24, %0
  %.01 = phi i32 [ 0, %0 ], [ %25, %24 ]
  %2 = icmp slt i32 %.01, 512
  br i1 %2, label %3, label %26

3:                                                ; preds = %1
  br label %4

4:                                                ; preds = %21, %3
  %.0 = phi i32 [ 0, %3 ], [ %22, %21 ]
  %5 = icmp slt i32 %.0, 512
  br i1 %5, label %6, label %23

6:                                                ; preds = %4
  %7 = call i32 @rand()
  %8 = sitofp i32 %7 to double
  %9 = fdiv double %8, 0x41DFFFFFFFC00000
  %10 = sext i32 %.01 to i64
  %11 = getelementptr inbounds [512 x [512 x double]], ptr @a, i64 0, i64 %10
  %12 = sext i32 %.0 to i64
  %13 = getelementptr inbounds [512 x double], ptr %11, i64 0, i64 %12
  store double %9, ptr %13, align 8
  %14 = call i32 @rand()
  %15 = sitofp i32 %14 to double
  %16 = fdiv double %15, 0x41DFFFFFFFC00000
  %17 = sext i32 %.01 to i64
  %18 = getelementptr inbounds [512 x [512 x double]], ptr @b, i64 0, i64 %17
  %19 = sext i32 %.0 to i64
  %20 = getelementptr inbounds [512 x double], ptr %18, i64 0, i64 %19
  store double %16, ptr %20, align 8
  br label %21

21:                                               ; preds = %6
  %22 = add nsw i32 %.0, 1
  br label %4, !llvm.loop !10

23:                                               ; preds = %4
  br label %24

24:                                               ; preds = %23
  %25 = add nsw i32 %.01, 1
  br label %1, !llvm.loop !11

26:                                               ; preds = %1
  %27 = call i64 @"\01_clock"()
  call void @matmul()
  %28 = call i64 @"\01_clock"()
  %29 = sub i64 %28, %27
  %30 = uitofp i64 %29 to double
  %31 = fdiv double %30, 1.000000e+06
  %32 = fdiv double 0x41B0000000000000, %31
  %33 = fdiv double %32, 1.000000e+09
  %34 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef 512, i32 noundef 512, double noundef %31, double noundef %33)
  %35 = load volatile double, ptr getelementptr inbounds ([512 x double], ptr getelementptr inbounds ([512 x [512 x double]], ptr @c, i64 0, i64 256), i64 0, i64 256), align 8
  %36 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, double noundef %35)
  ret i32 0
}

declare void @srand(i32 noundef) #2

declare i32 @rand() #2

declare i64 @"\01_clock"() #2

declare i32 @printf(ptr noundef, ...) #2

attributes #0 = { noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }

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

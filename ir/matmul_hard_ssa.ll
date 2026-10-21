; ModuleID = 'ir/matmul_hard.ll'
source_filename = "benchmarks/matmul_hard.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@.str = private unnamed_addr constant [22 x i8] c"matmul %dx%d: %.3f s\0A\00", align 1
@.str.1 = private unnamed_addr constant [14 x i8] c"checksum: %f\0A\00", align 1

; Function Attrs: noinline nounwind ssp uwtable(sync)
define void @matmul(ptr noalias noundef %0, ptr noalias noundef %1, ptr noalias noundef %2) #0 {
  br label %4

4:                                                ; preds = %35, %3
  %.02 = phi i32 [ 0, %3 ], [ %36, %35 ]
  %5 = icmp slt i32 %.02, 1024
  br i1 %5, label %6, label %37

6:                                                ; preds = %4
  br label %7

7:                                                ; preds = %32, %6
  %.01 = phi i32 [ 0, %6 ], [ %33, %32 ]
  %8 = icmp slt i32 %.01, 1024
  br i1 %8, label %9, label %34

9:                                                ; preds = %7
  br label %10

10:                                               ; preds = %29, %9
  %.0 = phi i32 [ 0, %9 ], [ %30, %29 ]
  %11 = icmp slt i32 %.0, 1024
  br i1 %11, label %12, label %31

12:                                               ; preds = %10
  %13 = mul nsw i32 %.02, 1024
  %14 = add nsw i32 %13, %.0
  %15 = sext i32 %14 to i64
  %16 = getelementptr inbounds double, ptr %0, i64 %15
  %17 = load double, ptr %16, align 8
  %18 = mul nsw i32 %.0, 1024
  %19 = add nsw i32 %18, %.01
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds double, ptr %1, i64 %20
  %22 = load double, ptr %21, align 8
  %23 = mul nsw i32 %.02, 1024
  %24 = add nsw i32 %23, %.01
  %25 = sext i32 %24 to i64
  %26 = getelementptr inbounds double, ptr %2, i64 %25
  %27 = load double, ptr %26, align 8
  %28 = call double @llvm.fmuladd.f64(double %17, double %22, double %27)
  store double %28, ptr %26, align 8
  br label %29

29:                                               ; preds = %12
  %30 = add nsw i32 %.0, 1
  br label %10, !llvm.loop !6

31:                                               ; preds = %10
  br label %32

32:                                               ; preds = %31
  %33 = add nsw i32 %.01, 1
  br label %7, !llvm.loop !8

34:                                               ; preds = %7
  br label %35

35:                                               ; preds = %34
  %36 = add nsw i32 %.02, 1
  br label %4, !llvm.loop !9

37:                                               ; preds = %4
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #1

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @main() #0 {
  %1 = call ptr @malloc(i64 noundef 8388608) #4
  %2 = call ptr @malloc(i64 noundef 8388608) #4
  %3 = call ptr @malloc(i64 noundef 8388608) #4
  call void @srand(i32 noundef 42)
  br label %4

4:                                                ; preds = %19, %0
  %.0 = phi i32 [ 0, %0 ], [ %20, %19 ]
  %5 = icmp slt i32 %.0, 1048576
  br i1 %5, label %6, label %21

6:                                                ; preds = %4
  %7 = call i32 @rand()
  %8 = sitofp i32 %7 to double
  %9 = fdiv double %8, 0x41DFFFFFFFC00000
  %10 = sext i32 %.0 to i64
  %11 = getelementptr inbounds double, ptr %1, i64 %10
  store double %9, ptr %11, align 8
  %12 = call i32 @rand()
  %13 = sitofp i32 %12 to double
  %14 = fdiv double %13, 0x41DFFFFFFFC00000
  %15 = sext i32 %.0 to i64
  %16 = getelementptr inbounds double, ptr %2, i64 %15
  store double %14, ptr %16, align 8
  %17 = sext i32 %.0 to i64
  %18 = getelementptr inbounds double, ptr %3, i64 %17
  store double 0.000000e+00, ptr %18, align 8
  br label %19

19:                                               ; preds = %6
  %20 = add nsw i32 %.0, 1
  br label %4, !llvm.loop !10

21:                                               ; preds = %4
  %22 = call i64 @"\01_clock"()
  call void @matmul(ptr noundef %1, ptr noundef %2, ptr noundef %3)
  %23 = call i64 @"\01_clock"()
  %24 = sub i64 %23, %22
  %25 = uitofp i64 %24 to double
  %26 = fdiv double %25, 1.000000e+06
  %27 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef 1024, i32 noundef 1024, double noundef %26)
  %28 = getelementptr inbounds double, ptr %3, i64 524800
  %29 = load double, ptr %28, align 8
  %30 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, double noundef %29)
  call void @free(ptr noundef %1)
  call void @free(ptr noundef %2)
  call void @free(ptr noundef %3)
  ret i32 0
}

; Function Attrs: allocsize(0)
declare ptr @malloc(i64 noundef) #2

declare void @srand(i32 noundef) #3

declare i32 @rand() #3

declare i64 @"\01_clock"() #3

declare i32 @printf(ptr noundef, ...) #3

declare void @free(ptr noundef) #3

attributes #0 = { noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { allocsize(0) "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #3 = { "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #4 = { allocsize(0) }

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

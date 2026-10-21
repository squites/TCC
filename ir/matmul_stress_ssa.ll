; ModuleID = 'ir/matmul_stress.ll'
source_filename = "benchmarks/matmul_stress.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@.str = private unnamed_addr constant [14 x i8] c"checksum: %f\0A\00", align 1

; Function Attrs: noinline nounwind ssp uwtable(sync)
define void @matmul(ptr noundef %0, ptr noundef %1, ptr noundef %2, ptr noundef %3) #0 {
  br label %5

5:                                                ; preds = %54, %4
  %.02 = phi i32 [ 0, %4 ], [ %55, %54 ]
  %6 = icmp slt i32 %.02, 1024
  br i1 %6, label %7, label %56

7:                                                ; preds = %5
  br label %8

8:                                                ; preds = %51, %7
  %.01 = phi i32 [ 0, %7 ], [ %52, %51 ]
  %9 = icmp slt i32 %.01, 1024
  br i1 %9, label %10, label %53

10:                                               ; preds = %8
  br label %11

11:                                               ; preds = %48, %10
  %.0 = phi i32 [ 0, %10 ], [ %49, %48 ]
  %12 = icmp slt i32 %.0, 1024
  br i1 %12, label %13, label %50

13:                                               ; preds = %11
  %14 = sext i32 %.02 to i64
  %15 = getelementptr inbounds double, ptr %3, i64 %14
  %16 = load double, ptr %15, align 8
  %17 = sext i32 %.01 to i64
  %18 = getelementptr inbounds double, ptr %3, i64 %17
  %19 = load double, ptr %18, align 8
  %20 = fmul double %16, %19
  %21 = sext i32 %.02 to i64
  %22 = getelementptr inbounds double, ptr %3, i64 %21
  %23 = load double, ptr %22, align 8
  %24 = sext i32 %.01 to i64
  %25 = getelementptr inbounds double, ptr %3, i64 %24
  %26 = load double, ptr %25, align 8
  %27 = fadd double %23, %26
  %28 = fmul double %20, %27
  %29 = fadd double %20, %27
  %30 = fadd double %29, %28
  %31 = mul nsw i32 %.02, 1024
  %32 = add nsw i32 %31, %.0
  %33 = sext i32 %32 to i64
  %34 = getelementptr inbounds double, ptr %0, i64 %33
  %35 = load double, ptr %34, align 8
  %36 = mul nsw i32 %.0, 1024
  %37 = add nsw i32 %36, %.01
  %38 = sext i32 %37 to i64
  %39 = getelementptr inbounds double, ptr %1, i64 %38
  %40 = load double, ptr %39, align 8
  %41 = fmul double %35, %40
  %42 = mul nsw i32 %.02, 1024
  %43 = add nsw i32 %42, %.01
  %44 = sext i32 %43 to i64
  %45 = getelementptr inbounds double, ptr %2, i64 %44
  %46 = load double, ptr %45, align 8
  %47 = call double @llvm.fmuladd.f64(double %41, double %30, double %46)
  store double %47, ptr %45, align 8
  br label %48

48:                                               ; preds = %13
  %49 = add nsw i32 %.0, 1
  br label %11, !llvm.loop !5

50:                                               ; preds = %11
  br label %51

51:                                               ; preds = %50
  %52 = add nsw i32 %.01, 1
  br label %8, !llvm.loop !7

53:                                               ; preds = %8
  br label %54

54:                                               ; preds = %53
  %55 = add nsw i32 %.02, 1
  br label %5, !llvm.loop !8

56:                                               ; preds = %5
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #1

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @main() #0 {
  %1 = call ptr @malloc(i64 noundef 8388608) #4
  %2 = call ptr @malloc(i64 noundef 8388608) #4
  %3 = call ptr @malloc(i64 noundef 8388608) #4
  %4 = call ptr @malloc(i64 noundef 8192) #4
  call void @srand(i32 noundef 42)
  br label %5

5:                                                ; preds = %20, %0
  %.01 = phi i32 [ 0, %0 ], [ %21, %20 ]
  %6 = icmp slt i32 %.01, 1048576
  br i1 %6, label %7, label %22

7:                                                ; preds = %5
  %8 = call i32 @rand()
  %9 = sitofp i32 %8 to double
  %10 = fdiv double %9, f0x41DFFFFFFFC00000
  %11 = sext i32 %.01 to i64
  %12 = getelementptr inbounds double, ptr %1, i64 %11
  store double %10, ptr %12, align 8
  %13 = call i32 @rand()
  %14 = sitofp i32 %13 to double
  %15 = fdiv double %14, f0x41DFFFFFFFC00000
  %16 = sext i32 %.01 to i64
  %17 = getelementptr inbounds double, ptr %2, i64 %16
  store double %15, ptr %17, align 8
  %18 = sext i32 %.01 to i64
  %19 = getelementptr inbounds double, ptr %3, i64 %18
  store double 0.000000e+00, ptr %19, align 8
  br label %20

20:                                               ; preds = %7
  %21 = add nsw i32 %.01, 1
  br label %5, !llvm.loop !9

22:                                               ; preds = %5
  br label %23

23:                                               ; preds = %31, %22
  %.0 = phi i32 [ 0, %22 ], [ %32, %31 ]
  %24 = icmp slt i32 %.0, 1024
  br i1 %24, label %25, label %33

25:                                               ; preds = %23
  %26 = call i32 @rand()
  %27 = sitofp i32 %26 to double
  %28 = fdiv double %27, f0x41DFFFFFFFC00000
  %29 = sext i32 %.0 to i64
  %30 = getelementptr inbounds double, ptr %4, i64 %29
  store double %28, ptr %30, align 8
  br label %31

31:                                               ; preds = %25
  %32 = add nsw i32 %.0, 1
  br label %23, !llvm.loop !10

33:                                               ; preds = %23
  call void @matmul(ptr noundef %1, ptr noundef %2, ptr noundef %3, ptr noundef %4)
  %34 = getelementptr inbounds double, ptr %3, i64 524800
  %35 = load double, ptr %34, align 8
  %36 = call i32 (ptr, ...) @printf(ptr noundef @.str, double noundef %35)
  call void @free(ptr noundef %1)
  call void @free(ptr noundef %2)
  call void @free(ptr noundef %3)
  call void @free(ptr noundef %4)
  ret i32 0
}

; Function Attrs: allocsize(0)
declare ptr @malloc(i64 noundef) #2

declare void @srand(i32 noundef) #3

declare i32 @rand() #3

declare i32 @printf(ptr noundef, ...) #3

declare void @free(ptr noundef) #3

attributes #0 = { noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" "tune-cpu"="apple-m5" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { allocsize(0) "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" "tune-cpu"="apple-m5" }
attributes #3 = { "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" "tune-cpu"="apple-m5" }
attributes #4 = { allocsize(0) }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 15, i32 5]}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 1}
!3 = !{i32 7, !"frame-pointer", i32 4}
!4 = !{!"Homebrew clang version 23.1.0"}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.mustprogress"}
!7 = distinct !{!7, !6}
!8 = distinct !{!8, !6}
!9 = distinct !{!9, !6}
!10 = distinct !{!10, !6}

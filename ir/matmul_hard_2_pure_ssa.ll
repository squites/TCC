; ModuleID = 'ir/matmul_hard_2_pure.ll'
source_filename = "benchmarks/matmul_hard_2.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@.str = private unnamed_addr constant [14 x i8] c"checksum: %f\0A\00", align 1

; Function Attrs: noinline nounwind ssp willreturn memory(none) uwtable(sync)
define double @multiplica(double noundef %0, double noundef %1) #0 {
  %3 = fmul double %0, %1
  ret double %3
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define void @matmul(ptr noundef %0, ptr noundef %1, ptr noundef %2) #1 {
  br label %4

4:                                                ; preds = %36, %3
  %.02 = phi i32 [ 0, %3 ], [ %37, %36 ]
  %5 = icmp slt i32 %.02, 1024
  br i1 %5, label %6, label %38

6:                                                ; preds = %4
  br label %7

7:                                                ; preds = %33, %6
  %.01 = phi i32 [ 0, %6 ], [ %34, %33 ]
  %8 = icmp slt i32 %.01, 1024
  br i1 %8, label %9, label %35

9:                                                ; preds = %7
  br label %10

10:                                               ; preds = %30, %9
  %.0 = phi i32 [ 0, %9 ], [ %31, %30 ]
  %11 = icmp slt i32 %.0, 1024
  br i1 %11, label %12, label %32

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
  %23 = call double @multiplica(double noundef %17, double noundef %22) #4
  %24 = mul nsw i32 %.02, 1024
  %25 = add nsw i32 %24, %.01
  %26 = sext i32 %25 to i64
  %27 = getelementptr inbounds double, ptr %2, i64 %26
  %28 = load double, ptr %27, align 8
  %29 = fadd double %28, %23
  store double %29, ptr %27, align 8
  br label %30

30:                                               ; preds = %12
  %31 = add nsw i32 %.0, 1
  br label %10, !llvm.loop !5

32:                                               ; preds = %10
  br label %33

33:                                               ; preds = %32
  %34 = add nsw i32 %.01, 1
  br label %7, !llvm.loop !7

35:                                               ; preds = %7
  br label %36

36:                                               ; preds = %35
  %37 = add nsw i32 %.02, 1
  br label %4, !llvm.loop !8

38:                                               ; preds = %4
  ret void
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @main() #1 {
  %1 = call ptr @malloc(i64 noundef 8388608) #5
  %2 = call ptr @malloc(i64 noundef 8388608) #5
  %3 = call ptr @malloc(i64 noundef 8388608) #5
  call void @srand(i32 noundef 42)
  br label %4

4:                                                ; preds = %19, %0
  %.0 = phi i32 [ 0, %0 ], [ %20, %19 ]
  %5 = icmp slt i32 %.0, 1048576
  br i1 %5, label %6, label %21

6:                                                ; preds = %4
  %7 = call i32 @rand()
  %8 = sitofp i32 %7 to double
  %9 = fdiv double %8, f0x41DFFFFFFFC00000
  %10 = sext i32 %.0 to i64
  %11 = getelementptr inbounds double, ptr %1, i64 %10
  store double %9, ptr %11, align 8
  %12 = call i32 @rand()
  %13 = sitofp i32 %12 to double
  %14 = fdiv double %13, f0x41DFFFFFFFC00000
  %15 = sext i32 %.0 to i64
  %16 = getelementptr inbounds double, ptr %2, i64 %15
  store double %14, ptr %16, align 8
  %17 = sext i32 %.0 to i64
  %18 = getelementptr inbounds double, ptr %3, i64 %17
  store double 0.000000e+00, ptr %18, align 8
  br label %19

19:                                               ; preds = %6
  %20 = add nsw i32 %.0, 1
  br label %4, !llvm.loop !9

21:                                               ; preds = %4
  call void @matmul(ptr noundef %1, ptr noundef %2, ptr noundef %3)
  %22 = getelementptr inbounds double, ptr %3, i64 524800
  %23 = load double, ptr %22, align 8
  %24 = call i32 (ptr, ...) @printf(ptr noundef @.str, double noundef %23)
  call void @free(ptr noundef %1)
  call void @free(ptr noundef %2)
  call void @free(ptr noundef %3)
  ret i32 0
}

; Function Attrs: allocsize(0)
declare ptr @malloc(i64 noundef) #2

declare void @srand(i32 noundef) #3

declare i32 @rand() #3

declare i32 @printf(ptr noundef, ...) #3

declare void @free(ptr noundef) #3

attributes #0 = { noinline nounwind ssp willreturn memory(none) uwtable(sync) "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" "tune-cpu"="apple-m5" }
attributes #1 = { noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" "tune-cpu"="apple-m5" }
attributes #2 = { allocsize(0) "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" "tune-cpu"="apple-m5" }
attributes #3 = { "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" "tune-cpu"="apple-m5" }
attributes #4 = { nounwind willreturn memory(none) }
attributes #5 = { allocsize(0) }

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

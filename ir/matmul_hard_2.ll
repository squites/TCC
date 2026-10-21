; ModuleID = 'benchmarks/matmul_hard_2.c'
source_filename = "benchmarks/matmul_hard_2.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@.str = private unnamed_addr constant [14 x i8] c"checksum: %f\0A\00", align 1

; Function Attrs: noinline nounwind ssp uwtable(sync)
define double @multiplica(double noundef %0, double noundef %1) #0 {
  %3 = alloca double, align 8
  %4 = alloca double, align 8
  store double %0, ptr %3, align 8
  store double %1, ptr %4, align 8
  %5 = load double, ptr %3, align 8
  %6 = load double, ptr %4, align 8
  %7 = fmul double %5, %6
  ret double %7
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define void @matmul(ptr noundef %0, ptr noundef %1, ptr noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  store i32 1024, ptr %7, align 4
  store i32 0, ptr %8, align 4
  br label %11

11:                                               ; preds = %57, %3
  %12 = load i32, ptr %8, align 4
  %13 = icmp slt i32 %12, 1024
  br i1 %13, label %14, label %60

14:                                               ; preds = %11
  store i32 0, ptr %9, align 4
  br label %15

15:                                               ; preds = %53, %14
  %16 = load i32, ptr %9, align 4
  %17 = icmp slt i32 %16, 1024
  br i1 %17, label %18, label %56

18:                                               ; preds = %15
  store i32 0, ptr %10, align 4
  br label %19

19:                                               ; preds = %49, %18
  %20 = load i32, ptr %10, align 4
  %21 = icmp slt i32 %20, 1024
  br i1 %21, label %22, label %52

22:                                               ; preds = %19
  %23 = load ptr, ptr %4, align 8
  %24 = load i32, ptr %8, align 4
  %25 = mul nsw i32 %24, 1024
  %26 = load i32, ptr %10, align 4
  %27 = add nsw i32 %25, %26
  %28 = sext i32 %27 to i64
  %29 = getelementptr inbounds double, ptr %23, i64 %28
  %30 = load double, ptr %29, align 8
  %31 = load ptr, ptr %5, align 8
  %32 = load i32, ptr %10, align 4
  %33 = mul nsw i32 %32, 1024
  %34 = load i32, ptr %9, align 4
  %35 = add nsw i32 %33, %34
  %36 = sext i32 %35 to i64
  %37 = getelementptr inbounds double, ptr %31, i64 %36
  %38 = load double, ptr %37, align 8
  %39 = call double @multiplica(double noundef %30, double noundef %38)
  %40 = load ptr, ptr %6, align 8
  %41 = load i32, ptr %8, align 4
  %42 = mul nsw i32 %41, 1024
  %43 = load i32, ptr %9, align 4
  %44 = add nsw i32 %42, %43
  %45 = sext i32 %44 to i64
  %46 = getelementptr inbounds double, ptr %40, i64 %45
  %47 = load double, ptr %46, align 8
  %48 = fadd double %47, %39
  store double %48, ptr %46, align 8
  br label %49

49:                                               ; preds = %22
  %50 = load i32, ptr %10, align 4
  %51 = add nsw i32 %50, 1
  store i32 %51, ptr %10, align 4
  br label %19, !llvm.loop !5

52:                                               ; preds = %19
  br label %53

53:                                               ; preds = %52
  %54 = load i32, ptr %9, align 4
  %55 = add nsw i32 %54, 1
  store i32 %55, ptr %9, align 4
  br label %15, !llvm.loop !7

56:                                               ; preds = %15
  br label %57

57:                                               ; preds = %56
  %58 = load i32, ptr %8, align 4
  %59 = add nsw i32 %58, 1
  store i32 %59, ptr %8, align 4
  br label %11, !llvm.loop !8

60:                                               ; preds = %11
  ret void
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %6 = call ptr @malloc(i64 noundef 8388608) #3
  store ptr %6, ptr %2, align 8
  %7 = call ptr @malloc(i64 noundef 8388608) #3
  store ptr %7, ptr %3, align 8
  %8 = call ptr @malloc(i64 noundef 8388608) #3
  store ptr %8, ptr %4, align 8
  call void @srand(i32 noundef 42)
  store i32 0, ptr %5, align 4
  br label %9

9:                                                ; preds = %31, %0
  %10 = load i32, ptr %5, align 4
  %11 = icmp slt i32 %10, 1048576
  br i1 %11, label %12, label %34

12:                                               ; preds = %9
  %13 = call i32 @rand()
  %14 = sitofp i32 %13 to double
  %15 = fdiv double %14, f0x41DFFFFFFFC00000
  %16 = load ptr, ptr %2, align 8
  %17 = load i32, ptr %5, align 4
  %18 = sext i32 %17 to i64
  %19 = getelementptr inbounds double, ptr %16, i64 %18
  store double %15, ptr %19, align 8
  %20 = call i32 @rand()
  %21 = sitofp i32 %20 to double
  %22 = fdiv double %21, f0x41DFFFFFFFC00000
  %23 = load ptr, ptr %3, align 8
  %24 = load i32, ptr %5, align 4
  %25 = sext i32 %24 to i64
  %26 = getelementptr inbounds double, ptr %23, i64 %25
  store double %22, ptr %26, align 8
  %27 = load ptr, ptr %4, align 8
  %28 = load i32, ptr %5, align 4
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds double, ptr %27, i64 %29
  store double 0.000000e+00, ptr %30, align 8
  br label %31

31:                                               ; preds = %12
  %32 = load i32, ptr %5, align 4
  %33 = add nsw i32 %32, 1
  store i32 %33, ptr %5, align 4
  br label %9, !llvm.loop !9

34:                                               ; preds = %9
  %35 = load ptr, ptr %2, align 8
  %36 = load ptr, ptr %3, align 8
  %37 = load ptr, ptr %4, align 8
  call void @matmul(ptr noundef %35, ptr noundef %36, ptr noundef %37)
  %38 = load ptr, ptr %4, align 8
  %39 = getelementptr inbounds double, ptr %38, i64 524800
  %40 = load double, ptr %39, align 8
  %41 = call i32 (ptr, ...) @printf(ptr noundef @.str, double noundef %40)
  %42 = load ptr, ptr %2, align 8
  call void @free(ptr noundef %42)
  %43 = load ptr, ptr %3, align 8
  call void @free(ptr noundef %43)
  %44 = load ptr, ptr %4, align 8
  call void @free(ptr noundef %44)
  ret i32 0
}

; Function Attrs: allocsize(0)
declare ptr @malloc(i64 noundef) #1

declare void @srand(i32 noundef) #2

declare i32 @rand() #2

declare i32 @printf(ptr noundef, ...) #2

declare void @free(ptr noundef) #2

attributes #0 = { noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" "tune-cpu"="apple-m5" }
attributes #1 = { allocsize(0) "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" "tune-cpu"="apple-m5" }
attributes #2 = { "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" "tune-cpu"="apple-m5" }
attributes #3 = { allocsize(0) }

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

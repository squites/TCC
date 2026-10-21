; ModuleID = 'benchmarks/matmul_stress.c'
source_filename = "benchmarks/matmul_stress.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@.str = private unnamed_addr constant [14 x i8] c"checksum: %f\0A\00", align 1

; Function Attrs: noinline nounwind ssp uwtable(sync)
define void @matmul(ptr noundef %0, ptr noundef %1, ptr noundef %2, ptr noundef %3) #0 {
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca double, align 8
  %14 = alloca double, align 8
  %15 = alloca double, align 8
  %16 = alloca double, align 8
  store ptr %0, ptr %5, align 8
  store ptr %1, ptr %6, align 8
  store ptr %2, ptr %7, align 8
  store ptr %3, ptr %8, align 8
  store i32 1024, ptr %9, align 4
  store i32 0, ptr %10, align 4
  br label %17

17:                                               ; preds = %94, %4
  %18 = load i32, ptr %10, align 4
  %19 = icmp slt i32 %18, 1024
  br i1 %19, label %20, label %97

20:                                               ; preds = %17
  store i32 0, ptr %11, align 4
  br label %21

21:                                               ; preds = %90, %20
  %22 = load i32, ptr %11, align 4
  %23 = icmp slt i32 %22, 1024
  br i1 %23, label %24, label %93

24:                                               ; preds = %21
  store i32 0, ptr %12, align 4
  br label %25

25:                                               ; preds = %86, %24
  %26 = load i32, ptr %12, align 4
  %27 = icmp slt i32 %26, 1024
  br i1 %27, label %28, label %89

28:                                               ; preds = %25
  %29 = load ptr, ptr %8, align 8
  %30 = load i32, ptr %10, align 4
  %31 = sext i32 %30 to i64
  %32 = getelementptr inbounds double, ptr %29, i64 %31
  %33 = load double, ptr %32, align 8
  %34 = load ptr, ptr %8, align 8
  %35 = load i32, ptr %11, align 4
  %36 = sext i32 %35 to i64
  %37 = getelementptr inbounds double, ptr %34, i64 %36
  %38 = load double, ptr %37, align 8
  %39 = fmul double %33, %38
  store double %39, ptr %13, align 8
  %40 = load ptr, ptr %8, align 8
  %41 = load i32, ptr %10, align 4
  %42 = sext i32 %41 to i64
  %43 = getelementptr inbounds double, ptr %40, i64 %42
  %44 = load double, ptr %43, align 8
  %45 = load ptr, ptr %8, align 8
  %46 = load i32, ptr %11, align 4
  %47 = sext i32 %46 to i64
  %48 = getelementptr inbounds double, ptr %45, i64 %47
  %49 = load double, ptr %48, align 8
  %50 = fadd double %44, %49
  store double %50, ptr %14, align 8
  %51 = load double, ptr %13, align 8
  %52 = load double, ptr %14, align 8
  %53 = fmul double %51, %52
  store double %53, ptr %15, align 8
  %54 = load double, ptr %13, align 8
  %55 = load double, ptr %14, align 8
  %56 = fadd double %54, %55
  %57 = load double, ptr %15, align 8
  %58 = fadd double %56, %57
  store double %58, ptr %16, align 8
  %59 = load ptr, ptr %5, align 8
  %60 = load i32, ptr %10, align 4
  %61 = mul nsw i32 %60, 1024
  %62 = load i32, ptr %12, align 4
  %63 = add nsw i32 %61, %62
  %64 = sext i32 %63 to i64
  %65 = getelementptr inbounds double, ptr %59, i64 %64
  %66 = load double, ptr %65, align 8
  %67 = load ptr, ptr %6, align 8
  %68 = load i32, ptr %12, align 4
  %69 = mul nsw i32 %68, 1024
  %70 = load i32, ptr %11, align 4
  %71 = add nsw i32 %69, %70
  %72 = sext i32 %71 to i64
  %73 = getelementptr inbounds double, ptr %67, i64 %72
  %74 = load double, ptr %73, align 8
  %75 = fmul double %66, %74
  %76 = load double, ptr %16, align 8
  %77 = load ptr, ptr %7, align 8
  %78 = load i32, ptr %10, align 4
  %79 = mul nsw i32 %78, 1024
  %80 = load i32, ptr %11, align 4
  %81 = add nsw i32 %79, %80
  %82 = sext i32 %81 to i64
  %83 = getelementptr inbounds double, ptr %77, i64 %82
  %84 = load double, ptr %83, align 8
  %85 = call double @llvm.fmuladd.f64(double %75, double %76, double %84)
  store double %85, ptr %83, align 8
  br label %86

86:                                               ; preds = %28
  %87 = load i32, ptr %12, align 4
  %88 = add nsw i32 %87, 1
  store i32 %88, ptr %12, align 4
  br label %25, !llvm.loop !5

89:                                               ; preds = %25
  br label %90

90:                                               ; preds = %89
  %91 = load i32, ptr %11, align 4
  %92 = add nsw i32 %91, 1
  store i32 %92, ptr %11, align 4
  br label %21, !llvm.loop !7

93:                                               ; preds = %21
  br label %94

94:                                               ; preds = %93
  %95 = load i32, ptr %10, align 4
  %96 = add nsw i32 %95, 1
  store i32 %96, ptr %10, align 4
  br label %17, !llvm.loop !8

97:                                               ; preds = %17
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #1

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %8 = call ptr @malloc(i64 noundef 8388608) #4
  store ptr %8, ptr %2, align 8
  %9 = call ptr @malloc(i64 noundef 8388608) #4
  store ptr %9, ptr %3, align 8
  %10 = call ptr @malloc(i64 noundef 8388608) #4
  store ptr %10, ptr %4, align 8
  %11 = call ptr @malloc(i64 noundef 8192) #4
  store ptr %11, ptr %5, align 8
  call void @srand(i32 noundef 42)
  store i32 0, ptr %6, align 4
  br label %12

12:                                               ; preds = %34, %0
  %13 = load i32, ptr %6, align 4
  %14 = icmp slt i32 %13, 1048576
  br i1 %14, label %15, label %37

15:                                               ; preds = %12
  %16 = call i32 @rand()
  %17 = sitofp i32 %16 to double
  %18 = fdiv double %17, f0x41DFFFFFFFC00000
  %19 = load ptr, ptr %2, align 8
  %20 = load i32, ptr %6, align 4
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds double, ptr %19, i64 %21
  store double %18, ptr %22, align 8
  %23 = call i32 @rand()
  %24 = sitofp i32 %23 to double
  %25 = fdiv double %24, f0x41DFFFFFFFC00000
  %26 = load ptr, ptr %3, align 8
  %27 = load i32, ptr %6, align 4
  %28 = sext i32 %27 to i64
  %29 = getelementptr inbounds double, ptr %26, i64 %28
  store double %25, ptr %29, align 8
  %30 = load ptr, ptr %4, align 8
  %31 = load i32, ptr %6, align 4
  %32 = sext i32 %31 to i64
  %33 = getelementptr inbounds double, ptr %30, i64 %32
  store double 0.000000e+00, ptr %33, align 8
  br label %34

34:                                               ; preds = %15
  %35 = load i32, ptr %6, align 4
  %36 = add nsw i32 %35, 1
  store i32 %36, ptr %6, align 4
  br label %12, !llvm.loop !9

37:                                               ; preds = %12
  store i32 0, ptr %7, align 4
  br label %38

38:                                               ; preds = %49, %37
  %39 = load i32, ptr %7, align 4
  %40 = icmp slt i32 %39, 1024
  br i1 %40, label %41, label %52

41:                                               ; preds = %38
  %42 = call i32 @rand()
  %43 = sitofp i32 %42 to double
  %44 = fdiv double %43, f0x41DFFFFFFFC00000
  %45 = load ptr, ptr %5, align 8
  %46 = load i32, ptr %7, align 4
  %47 = sext i32 %46 to i64
  %48 = getelementptr inbounds double, ptr %45, i64 %47
  store double %44, ptr %48, align 8
  br label %49

49:                                               ; preds = %41
  %50 = load i32, ptr %7, align 4
  %51 = add nsw i32 %50, 1
  store i32 %51, ptr %7, align 4
  br label %38, !llvm.loop !10

52:                                               ; preds = %38
  %53 = load ptr, ptr %2, align 8
  %54 = load ptr, ptr %3, align 8
  %55 = load ptr, ptr %4, align 8
  %56 = load ptr, ptr %5, align 8
  call void @matmul(ptr noundef %53, ptr noundef %54, ptr noundef %55, ptr noundef %56)
  %57 = load ptr, ptr %4, align 8
  %58 = getelementptr inbounds double, ptr %57, i64 524800
  %59 = load double, ptr %58, align 8
  %60 = call i32 (ptr, ...) @printf(ptr noundef @.str, double noundef %59)
  %61 = load ptr, ptr %2, align 8
  call void @free(ptr noundef %61)
  %62 = load ptr, ptr %3, align 8
  call void @free(ptr noundef %62)
  %63 = load ptr, ptr %4, align 8
  call void @free(ptr noundef %63)
  %64 = load ptr, ptr %5, align 8
  call void @free(ptr noundef %64)
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

; ModuleID = 'benchmarks/nqueens.c'
source_filename = "benchmarks/nqueens.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@count = internal global i64 0, align 8
@col = internal global [14 x i32] zeroinitializer, align 4
@diag1 = internal global [28 x i32] zeroinitializer, align 4
@diag2 = internal global [28 x i32] zeroinitializer, align 4
@.str = private unnamed_addr constant [37 x i8] c"nqueens %d: %ld solutions in %.3f s\0A\00", align 1

; Function Attrs: noinline nounwind ssp uwtable(sync)
define void @solve(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %4 = load i32, ptr %2, align 4
  %5 = icmp eq i32 %4, 14
  br i1 %5, label %6, label %9

6:                                                ; preds = %1
  %7 = load i64, ptr @count, align 8
  %8 = add nsw i64 %7, 1
  store i64 %8, ptr @count, align 8
  br label %74

9:                                                ; preds = %1
  store i32 0, ptr %3, align 4
  br label %10

10:                                               ; preds = %71, %9
  %11 = load i32, ptr %3, align 4
  %12 = icmp slt i32 %11, 14
  br i1 %12, label %13, label %74

13:                                               ; preds = %10
  %14 = load i32, ptr %3, align 4
  %15 = sext i32 %14 to i64
  %16 = getelementptr inbounds [14 x i32], ptr @col, i64 0, i64 %15
  %17 = load i32, ptr %16, align 4
  %18 = icmp ne i32 %17, 0
  br i1 %18, label %37, label %19

19:                                               ; preds = %13
  %20 = load i32, ptr %2, align 4
  %21 = load i32, ptr %3, align 4
  %22 = add nsw i32 %20, %21
  %23 = sext i32 %22 to i64
  %24 = getelementptr inbounds [28 x i32], ptr @diag1, i64 0, i64 %23
  %25 = load i32, ptr %24, align 4
  %26 = icmp ne i32 %25, 0
  br i1 %26, label %37, label %27

27:                                               ; preds = %19
  %28 = load i32, ptr %2, align 4
  %29 = load i32, ptr %3, align 4
  %30 = sub nsw i32 %28, %29
  %31 = add nsw i32 %30, 14
  %32 = sub nsw i32 %31, 1
  %33 = sext i32 %32 to i64
  %34 = getelementptr inbounds [28 x i32], ptr @diag2, i64 0, i64 %33
  %35 = load i32, ptr %34, align 4
  %36 = icmp ne i32 %35, 0
  br i1 %36, label %37, label %38

37:                                               ; preds = %27, %19, %13
  br label %71

38:                                               ; preds = %27
  %39 = load i32, ptr %2, align 4
  %40 = load i32, ptr %3, align 4
  %41 = sub nsw i32 %39, %40
  %42 = add nsw i32 %41, 14
  %43 = sub nsw i32 %42, 1
  %44 = sext i32 %43 to i64
  %45 = getelementptr inbounds [28 x i32], ptr @diag2, i64 0, i64 %44
  store i32 1, ptr %45, align 4
  %46 = load i32, ptr %2, align 4
  %47 = load i32, ptr %3, align 4
  %48 = add nsw i32 %46, %47
  %49 = sext i32 %48 to i64
  %50 = getelementptr inbounds [28 x i32], ptr @diag1, i64 0, i64 %49
  store i32 1, ptr %50, align 4
  %51 = load i32, ptr %3, align 4
  %52 = sext i32 %51 to i64
  %53 = getelementptr inbounds [14 x i32], ptr @col, i64 0, i64 %52
  store i32 1, ptr %53, align 4
  %54 = load i32, ptr %2, align 4
  %55 = add nsw i32 %54, 1
  call void @solve(i32 noundef %55)
  %56 = load i32, ptr %2, align 4
  %57 = load i32, ptr %3, align 4
  %58 = sub nsw i32 %56, %57
  %59 = add nsw i32 %58, 14
  %60 = sub nsw i32 %59, 1
  %61 = sext i32 %60 to i64
  %62 = getelementptr inbounds [28 x i32], ptr @diag2, i64 0, i64 %61
  store i32 0, ptr %62, align 4
  %63 = load i32, ptr %2, align 4
  %64 = load i32, ptr %3, align 4
  %65 = add nsw i32 %63, %64
  %66 = sext i32 %65 to i64
  %67 = getelementptr inbounds [28 x i32], ptr @diag1, i64 0, i64 %66
  store i32 0, ptr %67, align 4
  %68 = load i32, ptr %3, align 4
  %69 = sext i32 %68 to i64
  %70 = getelementptr inbounds [14 x i32], ptr @col, i64 0, i64 %69
  store i32 0, ptr %70, align 4
  br label %71

71:                                               ; preds = %38, %37
  %72 = load i32, ptr %3, align 4
  %73 = add nsw i32 %72, 1
  store i32 %73, ptr %3, align 4
  br label %10, !llvm.loop !6

74:                                               ; preds = %6, %10
  ret void
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i64, align 8
  %3 = alloca i64, align 8
  %4 = alloca double, align 8
  store i32 0, ptr %1, align 4
  %5 = call i64 @"\01_clock"()
  store i64 %5, ptr %2, align 8
  call void @solve(i32 noundef 0)
  %6 = call i64 @"\01_clock"()
  store i64 %6, ptr %3, align 8
  %7 = load i64, ptr %3, align 8
  %8 = load i64, ptr %2, align 8
  %9 = sub i64 %7, %8
  %10 = uitofp i64 %9 to double
  %11 = fdiv double %10, 1.000000e+06
  store double %11, ptr %4, align 8
  %12 = load i64, ptr @count, align 8
  %13 = load double, ptr %4, align 8
  %14 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef 14, i64 noundef %12, double noundef %13)
  ret i32 0
}

declare i64 @"\01_clock"() #1

declare i32 @printf(ptr noundef, ...) #1

attributes #0 = { noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }

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

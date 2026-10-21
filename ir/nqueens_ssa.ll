; ModuleID = 'ir/nqueens.ll'
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
  %2 = icmp eq i32 %0, 14
  br i1 %2, label %3, label %6

3:                                                ; preds = %1
  %4 = load i64, ptr @count, align 8
  %5 = add nsw i64 %4, 1
  store i64 %5, ptr @count, align 8
  br label %53

6:                                                ; preds = %1
  br label %7

7:                                                ; preds = %51, %6
  %.0 = phi i32 [ 0, %6 ], [ %52, %51 ]
  %8 = icmp slt i32 %.0, 14
  br i1 %8, label %9, label %.loopexit

9:                                                ; preds = %7
  %10 = sext i32 %.0 to i64
  %11 = getelementptr inbounds [14 x i32], ptr @col, i64 0, i64 %10
  %12 = load i32, ptr %11, align 4
  %13 = icmp ne i32 %12, 0
  br i1 %13, label %28, label %14

14:                                               ; preds = %9
  %15 = add nsw i32 %0, %.0
  %16 = sext i32 %15 to i64
  %17 = getelementptr inbounds [28 x i32], ptr @diag1, i64 0, i64 %16
  %18 = load i32, ptr %17, align 4
  %19 = icmp ne i32 %18, 0
  br i1 %19, label %28, label %20

20:                                               ; preds = %14
  %21 = sub nsw i32 %0, %.0
  %22 = add nsw i32 %21, 14
  %23 = sub nsw i32 %22, 1
  %24 = sext i32 %23 to i64
  %25 = getelementptr inbounds [28 x i32], ptr @diag2, i64 0, i64 %24
  %26 = load i32, ptr %25, align 4
  %27 = icmp ne i32 %26, 0
  br i1 %27, label %28, label %29

28:                                               ; preds = %20, %14, %9
  br label %51

29:                                               ; preds = %20
  %30 = sub nsw i32 %0, %.0
  %31 = add nsw i32 %30, 14
  %32 = sub nsw i32 %31, 1
  %33 = sext i32 %32 to i64
  %34 = getelementptr inbounds [28 x i32], ptr @diag2, i64 0, i64 %33
  store i32 1, ptr %34, align 4
  %35 = add nsw i32 %0, %.0
  %36 = sext i32 %35 to i64
  %37 = getelementptr inbounds [28 x i32], ptr @diag1, i64 0, i64 %36
  store i32 1, ptr %37, align 4
  %38 = sext i32 %.0 to i64
  %39 = getelementptr inbounds [14 x i32], ptr @col, i64 0, i64 %38
  store i32 1, ptr %39, align 4
  %40 = add nsw i32 %0, 1
  call void @solve(i32 noundef %40)
  %41 = sub nsw i32 %0, %.0
  %42 = add nsw i32 %41, 14
  %43 = sub nsw i32 %42, 1
  %44 = sext i32 %43 to i64
  %45 = getelementptr inbounds [28 x i32], ptr @diag2, i64 0, i64 %44
  store i32 0, ptr %45, align 4
  %46 = add nsw i32 %0, %.0
  %47 = sext i32 %46 to i64
  %48 = getelementptr inbounds [28 x i32], ptr @diag1, i64 0, i64 %47
  store i32 0, ptr %48, align 4
  %49 = sext i32 %.0 to i64
  %50 = getelementptr inbounds [14 x i32], ptr @col, i64 0, i64 %49
  store i32 0, ptr %50, align 4
  br label %51

51:                                               ; preds = %29, %28
  %52 = add nsw i32 %.0, 1
  br label %7, !llvm.loop !6

.loopexit:                                        ; preds = %7
  br label %53

53:                                               ; preds = %.loopexit, %3
  ret void
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @main() #0 {
  %1 = call i64 @"\01_clock"()
  call void @solve(i32 noundef 0)
  %2 = call i64 @"\01_clock"()
  %3 = sub i64 %2, %1
  %4 = uitofp i64 %3 to double
  %5 = fdiv double %4, 1.000000e+06
  %6 = load i64, ptr @count, align 8
  %7 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef 14, i64 noundef %6, double noundef %5)
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

; ModuleID = 'ir/primos.ll'
source_filename = "benchmarks/primos.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@primos = global [100000 x i32] zeroinitializer, align 4
@.str = private unnamed_addr constant [21 x i8] c"Total de primos: %d\0A\00", align 1

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @eh_primo(i32 noundef %0) #0 {
  %2 = icmp slt i32 %0, 2
  br i1 %2, label %3, label %4

3:                                                ; preds = %1
  br label %16

4:                                                ; preds = %1
  br label %5

5:                                                ; preds = %13, %4
  %.01 = phi i32 [ 2, %4 ], [ %14, %13 ]
  %6 = mul nsw i32 %.01, %.01
  %7 = icmp sle i32 %6, %0
  br i1 %7, label %8, label %15

8:                                                ; preds = %5
  %9 = srem i32 %0, %.01
  %10 = icmp eq i32 %9, 0
  br i1 %10, label %11, label %12

11:                                               ; preds = %8
  br label %16

12:                                               ; preds = %8
  br label %13

13:                                               ; preds = %12
  %14 = add nsw i32 %.01, 1
  br label %5, !llvm.loop !6

15:                                               ; preds = %5
  br label %16

16:                                               ; preds = %15, %11, %3
  %.0 = phi i32 [ 0, %3 ], [ 0, %11 ], [ 1, %15 ]
  ret i32 %.0
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @main() #0 {
  br label %1

1:                                                ; preds = %11, %0
  %.01 = phi i32 [ 0, %0 ], [ %.1, %11 ]
  %.0 = phi i32 [ 2, %0 ], [ %12, %11 ]
  %2 = icmp slt i32 %.0, 100000
  br i1 %2, label %3, label %13

3:                                                ; preds = %1
  %4 = call i32 @eh_primo(i32 noundef %.0)
  %5 = icmp ne i32 %4, 0
  br i1 %5, label %6, label %10

6:                                                ; preds = %3
  %7 = add nsw i32 %.01, 1
  %8 = sext i32 %.01 to i64
  %9 = getelementptr inbounds [100000 x i32], ptr @primos, i64 0, i64 %8
  store i32 %.0, ptr %9, align 4
  br label %10

10:                                               ; preds = %6, %3
  %.1 = phi i32 [ %7, %6 ], [ %.01, %3 ]
  br label %11

11:                                               ; preds = %10
  %12 = add nsw i32 %.0, 1
  br label %1, !llvm.loop !8

13:                                               ; preds = %1
  %14 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %.01)
  ret i32 0
}

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
!8 = distinct !{!8, !7}

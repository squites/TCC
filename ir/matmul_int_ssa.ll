; ModuleID = 'ir/matmul_int.ll'
source_filename = "matmul/mm_int.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@A = global [1024 x [1024 x i32]] zeroinitializer, align 4
@B = global [1024 x [1024 x i32]] zeroinitializer, align 4
@C = global [1024 x [1024 x i32]] zeroinitializer, align 4
@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

; Function Attrs: noinline nounwind ssp uwtable(sync)
define void @init() #0 {
  br label %1

1:                                                ; preds = %24, %0
  %.0 = phi i32 [ 0, %0 ], [ %25, %24 ]
  %2 = icmp slt i32 %.0, 1024
  br i1 %2, label %3, label %26

3:                                                ; preds = %1
  br label %4

4:                                                ; preds = %21, %3
  %.01 = phi i32 [ 0, %3 ], [ %22, %21 ]
  %5 = icmp slt i32 %.01, 1024
  br i1 %5, label %6, label %23

6:                                                ; preds = %4
  %7 = add nsw i32 %.0, %.01
  %8 = sext i32 %.0 to i64
  %9 = getelementptr inbounds [1024 x [1024 x i32]], ptr @A, i64 0, i64 %8
  %10 = sext i32 %.01 to i64
  %11 = getelementptr inbounds [1024 x i32], ptr %9, i64 0, i64 %10
  store i32 %7, ptr %11, align 4
  %12 = sub nsw i32 %.0, %.01
  %13 = sext i32 %.0 to i64
  %14 = getelementptr inbounds [1024 x [1024 x i32]], ptr @B, i64 0, i64 %13
  %15 = sext i32 %.01 to i64
  %16 = getelementptr inbounds [1024 x i32], ptr %14, i64 0, i64 %15
  store i32 %12, ptr %16, align 4
  %17 = sext i32 %.0 to i64
  %18 = getelementptr inbounds [1024 x [1024 x i32]], ptr @C, i64 0, i64 %17
  %19 = sext i32 %.01 to i64
  %20 = getelementptr inbounds [1024 x i32], ptr %18, i64 0, i64 %19
  store i32 0, ptr %20, align 4
  br label %21

21:                                               ; preds = %6
  %22 = add nsw i32 %.01, 1
  br label %4, !llvm.loop !5

23:                                               ; preds = %4
  br label %24

24:                                               ; preds = %23
  %25 = add nsw i32 %.0, 1
  br label %1, !llvm.loop !7

26:                                               ; preds = %1
  ret void
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define void @matmul() #0 {
  br label %1

1:                                                ; preds = %33, %0
  %.0 = phi i32 [ 0, %0 ], [ %34, %33 ]
  %2 = icmp slt i32 %.0, 1024
  br i1 %2, label %3, label %35

3:                                                ; preds = %1
  br label %4

4:                                                ; preds = %30, %3
  %.01 = phi i32 [ 0, %3 ], [ %31, %30 ]
  %5 = icmp slt i32 %.01, 1024
  br i1 %5, label %6, label %32

6:                                                ; preds = %4
  br label %7

7:                                                ; preds = %27, %6
  %.02 = phi i32 [ 0, %6 ], [ %28, %27 ]
  %8 = icmp slt i32 %.02, 1024
  br i1 %8, label %9, label %29

9:                                                ; preds = %7
  %10 = sext i32 %.0 to i64
  %11 = getelementptr inbounds [1024 x [1024 x i32]], ptr @A, i64 0, i64 %10
  %12 = sext i32 %.02 to i64
  %13 = getelementptr inbounds [1024 x i32], ptr %11, i64 0, i64 %12
  %14 = load i32, ptr %13, align 4
  %15 = sext i32 %.02 to i64
  %16 = getelementptr inbounds [1024 x [1024 x i32]], ptr @B, i64 0, i64 %15
  %17 = sext i32 %.01 to i64
  %18 = getelementptr inbounds [1024 x i32], ptr %16, i64 0, i64 %17
  %19 = load i32, ptr %18, align 4
  %20 = mul nsw i32 %14, %19
  %21 = sext i32 %.0 to i64
  %22 = getelementptr inbounds [1024 x [1024 x i32]], ptr @C, i64 0, i64 %21
  %23 = sext i32 %.01 to i64
  %24 = getelementptr inbounds [1024 x i32], ptr %22, i64 0, i64 %23
  %25 = load i32, ptr %24, align 4
  %26 = add nsw i32 %25, %20
  store i32 %26, ptr %24, align 4
  br label %27

27:                                               ; preds = %9
  %28 = add nsw i32 %.02, 1
  br label %7, !llvm.loop !8

29:                                               ; preds = %7
  br label %30

30:                                               ; preds = %29
  %31 = add nsw i32 %.01, 1
  br label %4, !llvm.loop !9

32:                                               ; preds = %4
  br label %33

33:                                               ; preds = %32
  %34 = add nsw i32 %.0, 1
  br label %1, !llvm.loop !10

35:                                               ; preds = %1
  ret void
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @main() #0 {
  call void @init()
  call void @matmul()
  %1 = load i32, ptr @C, align 4
  %2 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %1)
  ret i32 0
}

declare i32 @printf(ptr noundef, ...) #1

attributes #0 = { noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" "tune-cpu"="apple-m5" }
attributes #1 = { "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" "tune-cpu"="apple-m5" }

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

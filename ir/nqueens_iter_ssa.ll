; ModuleID = 'ir/nqueens_iter.ll'
source_filename = "benchmarks/nqueens_iter.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@pos = internal global [14 x i32] zeroinitializer, align 4
@count = internal global i64 0, align 8
@.str = private unnamed_addr constant [42 x i8] c"nqueens_iter %d: %ld solutions in %.3f s\0A\00", align 1

; Function Attrs: noinline nounwind ssp uwtable(sync)
define void @solve() #0 {
  store i32 0, ptr @pos, align 4
  br label %1

1:                                                ; preds = %.backedge, %0
  %.0 = phi i32 [ 0, %0 ], [ %.0.be, %.backedge ]
  %2 = icmp sge i32 %.0, 0
  br i1 %2, label %3, label %81

3:                                                ; preds = %1
  %4 = icmp eq i32 %.0, 14
  br i1 %4, label %5, label %13

5:                                                ; preds = %3
  %6 = load i64, ptr @count, align 8
  %7 = add nsw i64 %6, 1
  store i64 %7, ptr @count, align 8
  %8 = add nsw i32 %.0, -1
  %9 = sext i32 %8 to i64
  %10 = getelementptr inbounds [14 x i32], ptr @pos, i64 0, i64 %9
  %11 = load i32, ptr %10, align 4
  %12 = add nsw i32 %11, 1
  store i32 %12, ptr %10, align 4
  br label %.backedge

.backedge:                                        ; preds = %5, %80
  %.0.be = phi i32 [ %8, %5 ], [ %.1, %80 ]
  br label %1, !llvm.loop !6

13:                                               ; preds = %3
  br label %14

14:                                               ; preds = %57, %13
  %15 = sext i32 %.0 to i64
  %16 = getelementptr inbounds [14 x i32], ptr @pos, i64 0, i64 %15
  %17 = load i32, ptr %16, align 4
  %18 = icmp slt i32 %17, 14
  br i1 %18, label %19, label %.loopexit4

19:                                               ; preds = %14
  br label %20

20:                                               ; preds = %51, %19
  %.03 = phi i32 [ 0, %19 ], [ %52, %51 ]
  %21 = icmp slt i32 %.03, %.0
  br i1 %21, label %22, label %.loopexit

22:                                               ; preds = %20
  %23 = sub nsw i32 %.0, %.03
  %24 = sext i32 %.03 to i64
  %25 = getelementptr inbounds [14 x i32], ptr @pos, i64 0, i64 %24
  %26 = load i32, ptr %25, align 4
  %27 = sext i32 %.0 to i64
  %28 = getelementptr inbounds [14 x i32], ptr @pos, i64 0, i64 %27
  %29 = load i32, ptr %28, align 4
  %30 = icmp eq i32 %26, %29
  br i1 %30, label %49, label %31

31:                                               ; preds = %22
  %32 = sext i32 %.03 to i64
  %33 = getelementptr inbounds [14 x i32], ptr @pos, i64 0, i64 %32
  %34 = load i32, ptr %33, align 4
  %35 = sext i32 %.0 to i64
  %36 = getelementptr inbounds [14 x i32], ptr @pos, i64 0, i64 %35
  %37 = load i32, ptr %36, align 4
  %38 = sub nsw i32 %37, %23
  %39 = icmp eq i32 %34, %38
  br i1 %39, label %49, label %40

40:                                               ; preds = %31
  %41 = sext i32 %.03 to i64
  %42 = getelementptr inbounds [14 x i32], ptr @pos, i64 0, i64 %41
  %43 = load i32, ptr %42, align 4
  %44 = sext i32 %.0 to i64
  %45 = getelementptr inbounds [14 x i32], ptr @pos, i64 0, i64 %44
  %46 = load i32, ptr %45, align 4
  %47 = add nsw i32 %46, %23
  %48 = icmp eq i32 %43, %47
  br i1 %48, label %49, label %50

49:                                               ; preds = %40, %31, %22
  br label %53

50:                                               ; preds = %40
  br label %51

51:                                               ; preds = %50
  %52 = add nsw i32 %.03, 1
  br label %20, !llvm.loop !8

.loopexit:                                        ; preds = %20
  br label %53

53:                                               ; preds = %.loopexit, %49
  %.02 = phi i32 [ 0, %49 ], [ 1, %.loopexit ]
  %54 = icmp ne i32 %.02, 0
  br i1 %54, label %55, label %56

55:                                               ; preds = %53
  br label %62

56:                                               ; preds = %53
  br label %57

57:                                               ; preds = %56
  %58 = sext i32 %.0 to i64
  %59 = getelementptr inbounds [14 x i32], ptr @pos, i64 0, i64 %58
  %60 = load i32, ptr %59, align 4
  %61 = add nsw i32 %60, 1
  store i32 %61, ptr %59, align 4
  br label %14, !llvm.loop !9

.loopexit4:                                       ; preds = %14
  br label %62

62:                                               ; preds = %.loopexit4, %55
  %.01 = phi i32 [ 1, %55 ], [ 0, %.loopexit4 ]
  %63 = icmp ne i32 %.01, 0
  br i1 %63, label %64, label %71

64:                                               ; preds = %62
  %65 = add nsw i32 %.0, 1
  %66 = icmp slt i32 %65, 14
  br i1 %66, label %67, label %70

67:                                               ; preds = %64
  %68 = sext i32 %65 to i64
  %69 = getelementptr inbounds [14 x i32], ptr @pos, i64 0, i64 %68
  store i32 0, ptr %69, align 4
  br label %70

70:                                               ; preds = %67, %64
  br label %80

71:                                               ; preds = %62
  %72 = add nsw i32 %.0, -1
  %73 = icmp sge i32 %72, 0
  br i1 %73, label %74, label %79

74:                                               ; preds = %71
  %75 = sext i32 %72 to i64
  %76 = getelementptr inbounds [14 x i32], ptr @pos, i64 0, i64 %75
  %77 = load i32, ptr %76, align 4
  %78 = add nsw i32 %77, 1
  store i32 %78, ptr %76, align 4
  br label %79

79:                                               ; preds = %74, %71
  br label %80

80:                                               ; preds = %79, %70
  %.1 = phi i32 [ %65, %70 ], [ %72, %79 ]
  br label %.backedge

81:                                               ; preds = %1
  ret void
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @main() #0 {
  %1 = call i64 @"\01_clock"()
  call void @solve()
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
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}

; ModuleID = 'benchmarks/nqueens_iter.c'
source_filename = "benchmarks/nqueens_iter.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@pos = internal global [14 x i32] zeroinitializer, align 4
@count = internal global i64 0, align 8
@.str = private unnamed_addr constant [42 x i8] c"nqueens_iter %d: %ld solutions in %.3f s\0A\00", align 1

; Function Attrs: noinline nounwind ssp uwtable(sync)
define void @solve() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i32 0, ptr @pos, align 4
  br label %6

6:                                                ; preds = %112, %12, %0
  %7 = load i32, ptr %1, align 4
  %8 = icmp sge i32 %7, 0
  br i1 %8, label %9, label %113

9:                                                ; preds = %6
  %10 = load i32, ptr %1, align 4
  %11 = icmp eq i32 %10, 14
  br i1 %11, label %12, label %22

12:                                               ; preds = %9
  %13 = load i64, ptr @count, align 8
  %14 = add nsw i64 %13, 1
  store i64 %14, ptr @count, align 8
  %15 = load i32, ptr %1, align 4
  %16 = add nsw i32 %15, -1
  store i32 %16, ptr %1, align 4
  %17 = load i32, ptr %1, align 4
  %18 = sext i32 %17 to i64
  %19 = getelementptr inbounds [14 x i32], ptr @pos, i64 0, i64 %18
  %20 = load i32, ptr %19, align 4
  %21 = add nsw i32 %20, 1
  store i32 %21, ptr %19, align 4
  br label %6, !llvm.loop !6

22:                                               ; preds = %9
  store i32 0, ptr %2, align 4
  br label %23

23:                                               ; preds = %81, %22
  %24 = load i32, ptr %1, align 4
  %25 = sext i32 %24 to i64
  %26 = getelementptr inbounds [14 x i32], ptr @pos, i64 0, i64 %25
  %27 = load i32, ptr %26, align 4
  %28 = icmp slt i32 %27, 14
  br i1 %28, label %29, label %87

29:                                               ; preds = %23
  store i32 1, ptr %3, align 4
  store i32 0, ptr %4, align 4
  br label %30

30:                                               ; preds = %73, %29
  %31 = load i32, ptr %4, align 4
  %32 = load i32, ptr %1, align 4
  %33 = icmp slt i32 %31, %32
  br i1 %33, label %34, label %76

34:                                               ; preds = %30
  %35 = load i32, ptr %1, align 4
  %36 = load i32, ptr %4, align 4
  %37 = sub nsw i32 %35, %36
  store i32 %37, ptr %5, align 4
  %38 = load i32, ptr %4, align 4
  %39 = sext i32 %38 to i64
  %40 = getelementptr inbounds [14 x i32], ptr @pos, i64 0, i64 %39
  %41 = load i32, ptr %40, align 4
  %42 = load i32, ptr %1, align 4
  %43 = sext i32 %42 to i64
  %44 = getelementptr inbounds [14 x i32], ptr @pos, i64 0, i64 %43
  %45 = load i32, ptr %44, align 4
  %46 = icmp eq i32 %41, %45
  br i1 %46, label %71, label %47

47:                                               ; preds = %34
  %48 = load i32, ptr %4, align 4
  %49 = sext i32 %48 to i64
  %50 = getelementptr inbounds [14 x i32], ptr @pos, i64 0, i64 %49
  %51 = load i32, ptr %50, align 4
  %52 = load i32, ptr %1, align 4
  %53 = sext i32 %52 to i64
  %54 = getelementptr inbounds [14 x i32], ptr @pos, i64 0, i64 %53
  %55 = load i32, ptr %54, align 4
  %56 = load i32, ptr %5, align 4
  %57 = sub nsw i32 %55, %56
  %58 = icmp eq i32 %51, %57
  br i1 %58, label %71, label %59

59:                                               ; preds = %47
  %60 = load i32, ptr %4, align 4
  %61 = sext i32 %60 to i64
  %62 = getelementptr inbounds [14 x i32], ptr @pos, i64 0, i64 %61
  %63 = load i32, ptr %62, align 4
  %64 = load i32, ptr %1, align 4
  %65 = sext i32 %64 to i64
  %66 = getelementptr inbounds [14 x i32], ptr @pos, i64 0, i64 %65
  %67 = load i32, ptr %66, align 4
  %68 = load i32, ptr %5, align 4
  %69 = add nsw i32 %67, %68
  %70 = icmp eq i32 %63, %69
  br i1 %70, label %71, label %72

71:                                               ; preds = %59, %47, %34
  store i32 0, ptr %3, align 4
  br label %76

72:                                               ; preds = %59
  br label %73

73:                                               ; preds = %72
  %74 = load i32, ptr %4, align 4
  %75 = add nsw i32 %74, 1
  store i32 %75, ptr %4, align 4
  br label %30, !llvm.loop !8

76:                                               ; preds = %71, %30
  %77 = load i32, ptr %3, align 4
  %78 = icmp ne i32 %77, 0
  br i1 %78, label %79, label %80

79:                                               ; preds = %76
  store i32 1, ptr %2, align 4
  br label %87

80:                                               ; preds = %76
  br label %81

81:                                               ; preds = %80
  %82 = load i32, ptr %1, align 4
  %83 = sext i32 %82 to i64
  %84 = getelementptr inbounds [14 x i32], ptr @pos, i64 0, i64 %83
  %85 = load i32, ptr %84, align 4
  %86 = add nsw i32 %85, 1
  store i32 %86, ptr %84, align 4
  br label %23, !llvm.loop !9

87:                                               ; preds = %79, %23
  %88 = load i32, ptr %2, align 4
  %89 = icmp ne i32 %88, 0
  br i1 %89, label %90, label %100

90:                                               ; preds = %87
  %91 = load i32, ptr %1, align 4
  %92 = add nsw i32 %91, 1
  store i32 %92, ptr %1, align 4
  %93 = load i32, ptr %1, align 4
  %94 = icmp slt i32 %93, 14
  br i1 %94, label %95, label %99

95:                                               ; preds = %90
  %96 = load i32, ptr %1, align 4
  %97 = sext i32 %96 to i64
  %98 = getelementptr inbounds [14 x i32], ptr @pos, i64 0, i64 %97
  store i32 0, ptr %98, align 4
  br label %99

99:                                               ; preds = %95, %90
  br label %112

100:                                              ; preds = %87
  %101 = load i32, ptr %1, align 4
  %102 = add nsw i32 %101, -1
  store i32 %102, ptr %1, align 4
  %103 = load i32, ptr %1, align 4
  %104 = icmp sge i32 %103, 0
  br i1 %104, label %105, label %111

105:                                              ; preds = %100
  %106 = load i32, ptr %1, align 4
  %107 = sext i32 %106 to i64
  %108 = getelementptr inbounds [14 x i32], ptr @pos, i64 0, i64 %107
  %109 = load i32, ptr %108, align 4
  %110 = add nsw i32 %109, 1
  store i32 %110, ptr %108, align 4
  br label %111

111:                                              ; preds = %105, %100
  br label %112

112:                                              ; preds = %111, %99
  br label %6, !llvm.loop !6

113:                                              ; preds = %6
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
  call void @solve()
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
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}

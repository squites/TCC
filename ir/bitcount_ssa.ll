; ModuleID = 'ir/bitcount.ll'
source_filename = "llvm-link"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

%union.anon = type { i64 }
%struct.bfile = type { ptr, i8, i8, i8, i8 }

@bits = internal global [256 x i8] c"\00\01\01\02\01\02\02\03\01\02\02\03\02\03\03\04\01\02\02\03\02\03\03\04\02\03\03\04\03\04\04\05\01\02\02\03\02\03\03\04\02\03\03\04\03\04\04\05\02\03\03\04\03\04\04\05\03\04\04\05\04\05\05\06\01\02\02\03\02\03\03\04\02\03\03\04\03\04\04\05\02\03\03\04\03\04\04\05\03\04\04\05\04\05\05\06\02\03\03\04\03\04\04\05\03\04\04\05\04\05\05\06\03\04\04\05\04\05\05\06\04\05\05\06\05\06\06\07\01\02\02\03\02\03\03\04\02\03\03\04\03\04\04\05\02\03\03\04\03\04\04\05\03\04\04\05\04\05\05\06\02\03\03\04\03\04\04\05\03\04\04\05\04\05\05\06\03\04\04\05\04\05\05\06\04\05\05\06\05\06\06\07\02\03\03\04\03\04\04\05\03\04\04\05\04\05\05\06\03\04\04\05\04\05\05\06\04\05\05\06\05\06\06\07\03\04\04\05\04\05\05\06\04\05\05\06\05\06\06\07\04\05\05\06\05\06\06\07\05\06\06\07\06\07\07\08", align 1
@bits.1 = internal global [256 x i8] c"\00\01\01\02\01\02\02\03\01\02\02\03\02\03\03\04\01\02\02\03\02\03\03\04\02\03\03\04\03\04\04\05\01\02\02\03\02\03\03\04\02\03\03\04\03\04\04\05\02\03\03\04\03\04\04\05\03\04\04\05\04\05\05\06\01\02\02\03\02\03\03\04\02\03\03\04\03\04\04\05\02\03\03\04\03\04\04\05\03\04\04\05\04\05\05\06\02\03\03\04\03\04\04\05\03\04\04\05\04\05\05\06\03\04\04\05\04\05\05\06\04\05\05\06\05\06\06\07\01\02\02\03\02\03\03\04\02\03\03\04\03\04\04\05\02\03\03\04\03\04\04\05\03\04\04\05\04\05\05\06\02\03\03\04\03\04\04\05\03\04\04\05\04\05\05\06\03\04\04\05\04\05\05\06\04\05\05\06\05\06\06\07\02\03\03\04\03\04\04\05\03\04\04\05\04\05\05\06\03\04\04\05\04\05\05\06\04\05\05\06\05\06\06\07\03\04\04\05\04\05\05\06\04\05\05\06\05\06\06\07\04\05\05\06\05\06\06\07\05\06\06\07\06\07\07\08", align 1
@main1.pBitCntFunc = internal global [7 x ptr] [ptr @bit_count, ptr @bitcount, ptr @ntbl_bitcnt, ptr @ntbl_bitcount, ptr @BW_btbl_bitcount, ptr @AR_btbl_bitcount, ptr @bit_shifter], align 8
@main1.text = internal global [7 x ptr] [ptr @.str, ptr @.str.1, ptr @.str.2, ptr @.str.3, ptr @.str.4, ptr @.str.5, ptr @.str.6], align 8
@.str = private unnamed_addr constant [29 x i8] c"Optimized 1 bit/loop counter\00", align 1
@.str.1 = private unnamed_addr constant [26 x i8] c"Ratko's mystery algorithm\00", align 1
@.str.2 = private unnamed_addr constant [31 x i8] c"Recursive bit count by nybbles\00", align 1
@.str.3 = private unnamed_addr constant [35 x i8] c"Non-recursive bit count by nybbles\00", align 1
@.str.4 = private unnamed_addr constant [38 x i8] c"Non-recursive bit count by bytes (BW)\00", align 1
@.str.5 = private unnamed_addr constant [38 x i8] c"Non-recursive bit count by bytes (AR)\00", align 1
@.str.6 = private unnamed_addr constant [21 x i8] c"Shift and count bits\00", align 1
@.str.7 = private unnamed_addr constant [29 x i8] c"Usage: bitcnts <iterations>\0A\00", align 1
@.str.8 = private unnamed_addr constant [33 x i8] c"Bit counter algorithm benchmark\0A\00", align 1
@.str.9 = private unnamed_addr constant [18 x i8] c"%-38s> Bits: %ld\0A\00", align 1
@.str.10 = private unnamed_addr constant [3 x i8] c"01\00", align 1
@.str.11 = private unnamed_addr constant [15 x i8] c"_finfo_dataset\00", align 1
@.str.1.12 = private unnamed_addr constant [3 x i8] c"rt\00", align 1
@__stderrp = external global ptr, align 8
@.str.2.13 = private unnamed_addr constant [29 x i8] c"\0AError: Can't find dataset!\0A\00", align 1
@.str.3.14 = private unnamed_addr constant [4 x i8] c"%ld\00", align 1

; Function Attrs: noinline nounwind ssp uwtable(sync)
define ptr @alloc_bit_array(i64 noundef %0) #0 {
  %2 = add i64 %0, 8
  %3 = sub i64 %2, 1
  %4 = udiv i64 %3, 8
  %5 = call ptr @calloc(i64 noundef %4, i64 noundef 1) #6
  ret ptr %5
}

; Function Attrs: allocsize(0,1)
declare ptr @calloc(i64 noundef, i64 noundef) #1

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @getbit(ptr noundef %0, i32 noundef %1) #0 {
  %3 = sdiv i32 %1, 8
  %4 = sext i32 %3 to i64
  %5 = getelementptr inbounds i8, ptr %0, i64 %4
  %6 = load i8, ptr %5, align 1
  %7 = sext i8 %6 to i32
  %8 = srem i32 %1, 8
  %9 = shl i32 1, %8
  %10 = and i32 %7, %9
  %11 = icmp ne i32 %10, 0
  %12 = zext i1 %11 to i32
  ret i32 %12
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define void @setbit(ptr noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = sdiv i32 %1, 8
  %5 = sext i32 %4 to i64
  %6 = getelementptr inbounds i8, ptr %0, i64 %5
  %7 = icmp ne i32 %2, 0
  br i1 %7, label %8, label %15

8:                                                ; preds = %3
  %9 = srem i32 %1, 8
  %10 = shl i32 1, %9
  %11 = load i8, ptr %6, align 1
  %12 = sext i8 %11 to i32
  %13 = or i32 %12, %10
  %14 = trunc i32 %13 to i8
  store i8 %14, ptr %6, align 1
  br label %23

15:                                               ; preds = %3
  %16 = srem i32 %1, 8
  %17 = shl i32 1, %16
  %18 = xor i32 %17, -1
  %19 = load i8, ptr %6, align 1
  %20 = sext i8 %19 to i32
  %21 = and i32 %20, %18
  %22 = trunc i32 %21 to i8
  store i8 %22, ptr %6, align 1
  br label %23

23:                                               ; preds = %15, %8
  ret void
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define void @flipbit(ptr noundef %0, i32 noundef %1) #0 {
  %3 = sdiv i32 %1, 8
  %4 = sext i32 %3 to i64
  %5 = getelementptr inbounds i8, ptr %0, i64 %4
  %6 = srem i32 %1, 8
  %7 = shl i32 1, %6
  %8 = load i8, ptr %5, align 1
  %9 = sext i8 %8 to i32
  %10 = xor i32 %9, %7
  %11 = trunc i32 %10 to i8
  store i8 %11, ptr %5, align 1
  ret void
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @bit_count(i64 noundef %0) #0 {
  %2 = icmp ne i64 %0, 0
  br i1 %2, label %3, label %11

3:                                                ; preds = %1
  br label %4

4:                                                ; preds = %6, %3
  %.1 = phi i32 [ 0, %3 ], [ %5, %6 ]
  %.0 = phi i64 [ %0, %3 ], [ %8, %6 ]
  %5 = add nsw i32 %.1, 1
  br label %6

6:                                                ; preds = %4
  %7 = sub nsw i64 %.0, 1
  %8 = and i64 %.0, %7
  %9 = icmp ne i64 0, %8
  br i1 %9, label %4, label %10, !llvm.loop !6

10:                                               ; preds = %6
  br label %11

11:                                               ; preds = %10, %1
  %.01 = phi i32 [ %5, %10 ], [ 0, %1 ]
  ret i32 %.01
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @bitcount(i64 noundef %0) #0 {
  %2 = and i64 %0, 2863311530
  %3 = ashr i64 %2, 1
  %4 = and i64 %0, 1431655765
  %5 = add nsw i64 %3, %4
  %6 = and i64 %5, 3435973836
  %7 = ashr i64 %6, 2
  %8 = and i64 %5, 858993459
  %9 = add nsw i64 %7, %8
  %10 = and i64 %9, 4042322160
  %11 = ashr i64 %10, 4
  %12 = and i64 %9, 252645135
  %13 = add nsw i64 %11, %12
  %14 = and i64 %13, 4278255360
  %15 = ashr i64 %14, 8
  %16 = and i64 %13, 16711935
  %17 = add nsw i64 %15, %16
  %18 = and i64 %17, 4294901760
  %19 = ashr i64 %18, 16
  %20 = and i64 %17, 65535
  %21 = add nsw i64 %19, %20
  %22 = trunc i64 %21 to i32
  ret i32 %22
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @ntbl_bitcount(i64 noundef %0) #0 {
  %2 = and i64 %0, 15
  %3 = trunc i64 %2 to i32
  %4 = sext i32 %3 to i64
  %5 = getelementptr inbounds [256 x i8], ptr @bits, i64 0, i64 %4
  %6 = load i8, ptr %5, align 1
  %7 = sext i8 %6 to i32
  %8 = and i64 %0, 240
  %9 = lshr i64 %8, 4
  %10 = trunc i64 %9 to i32
  %11 = sext i32 %10 to i64
  %12 = getelementptr inbounds [256 x i8], ptr @bits, i64 0, i64 %11
  %13 = load i8, ptr %12, align 1
  %14 = sext i8 %13 to i32
  %15 = add nsw i32 %7, %14
  %16 = and i64 %0, 3840
  %17 = lshr i64 %16, 8
  %18 = trunc i64 %17 to i32
  %19 = sext i32 %18 to i64
  %20 = getelementptr inbounds [256 x i8], ptr @bits, i64 0, i64 %19
  %21 = load i8, ptr %20, align 1
  %22 = sext i8 %21 to i32
  %23 = add nsw i32 %15, %22
  %24 = and i64 %0, 61440
  %25 = lshr i64 %24, 12
  %26 = trunc i64 %25 to i32
  %27 = sext i32 %26 to i64
  %28 = getelementptr inbounds [256 x i8], ptr @bits, i64 0, i64 %27
  %29 = load i8, ptr %28, align 1
  %30 = sext i8 %29 to i32
  %31 = add nsw i32 %23, %30
  %32 = and i64 %0, 983040
  %33 = lshr i64 %32, 16
  %34 = trunc i64 %33 to i32
  %35 = sext i32 %34 to i64
  %36 = getelementptr inbounds [256 x i8], ptr @bits, i64 0, i64 %35
  %37 = load i8, ptr %36, align 1
  %38 = sext i8 %37 to i32
  %39 = add nsw i32 %31, %38
  %40 = and i64 %0, 15728640
  %41 = lshr i64 %40, 20
  %42 = trunc i64 %41 to i32
  %43 = sext i32 %42 to i64
  %44 = getelementptr inbounds [256 x i8], ptr @bits, i64 0, i64 %43
  %45 = load i8, ptr %44, align 1
  %46 = sext i8 %45 to i32
  %47 = add nsw i32 %39, %46
  %48 = and i64 %0, 251658240
  %49 = lshr i64 %48, 24
  %50 = trunc i64 %49 to i32
  %51 = sext i32 %50 to i64
  %52 = getelementptr inbounds [256 x i8], ptr @bits, i64 0, i64 %51
  %53 = load i8, ptr %52, align 1
  %54 = sext i8 %53 to i32
  %55 = add nsw i32 %47, %54
  %56 = and i64 %0, 4026531840
  %57 = lshr i64 %56, 28
  %58 = trunc i64 %57 to i32
  %59 = sext i32 %58 to i64
  %60 = getelementptr inbounds [256 x i8], ptr @bits, i64 0, i64 %59
  %61 = load i8, ptr %60, align 1
  %62 = sext i8 %61 to i32
  %63 = add nsw i32 %55, %62
  ret i32 %63
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @BW_btbl_bitcount(i64 noundef %0) #0 {
  %2 = alloca %union.anon, align 8
  store i64 %0, ptr %2, align 8
  %3 = getelementptr inbounds [4 x i8], ptr %2, i64 0, i64 0
  %4 = load i8, ptr %3, align 8
  %5 = zext i8 %4 to i64
  %6 = getelementptr inbounds nuw [256 x i8], ptr @bits, i64 0, i64 %5
  %7 = load i8, ptr %6, align 1
  %8 = sext i8 %7 to i32
  %9 = getelementptr inbounds [4 x i8], ptr %2, i64 0, i64 1
  %10 = load i8, ptr %9, align 1
  %11 = zext i8 %10 to i64
  %12 = getelementptr inbounds nuw [256 x i8], ptr @bits, i64 0, i64 %11
  %13 = load i8, ptr %12, align 1
  %14 = sext i8 %13 to i32
  %15 = add nsw i32 %8, %14
  %16 = getelementptr inbounds [4 x i8], ptr %2, i64 0, i64 3
  %17 = load i8, ptr %16, align 1
  %18 = zext i8 %17 to i64
  %19 = getelementptr inbounds nuw [256 x i8], ptr @bits, i64 0, i64 %18
  %20 = load i8, ptr %19, align 1
  %21 = sext i8 %20 to i32
  %22 = add nsw i32 %15, %21
  %23 = getelementptr inbounds [4 x i8], ptr %2, i64 0, i64 2
  %24 = load i8, ptr %23, align 2
  %25 = zext i8 %24 to i64
  %26 = getelementptr inbounds nuw [256 x i8], ptr @bits, i64 0, i64 %25
  %27 = load i8, ptr %26, align 1
  %28 = sext i8 %27 to i32
  %29 = add nsw i32 %22, %28
  ret i32 %29
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @AR_btbl_bitcount(i64 noundef %0) #0 {
  %2 = alloca i64, align 8
  store i64 %0, ptr %2, align 8
  %3 = getelementptr inbounds nuw i8, ptr %2, i32 1
  %4 = load i8, ptr %2, align 1
  %5 = zext i8 %4 to i64
  %6 = getelementptr inbounds nuw [256 x i8], ptr @bits, i64 0, i64 %5
  %7 = load i8, ptr %6, align 1
  %8 = sext i8 %7 to i32
  %9 = getelementptr inbounds nuw i8, ptr %3, i32 1
  %10 = load i8, ptr %3, align 1
  %11 = zext i8 %10 to i64
  %12 = getelementptr inbounds nuw [256 x i8], ptr @bits, i64 0, i64 %11
  %13 = load i8, ptr %12, align 1
  %14 = sext i8 %13 to i32
  %15 = add nsw i32 %8, %14
  %16 = getelementptr inbounds nuw i8, ptr %9, i32 1
  %17 = load i8, ptr %9, align 1
  %18 = zext i8 %17 to i64
  %19 = getelementptr inbounds nuw [256 x i8], ptr @bits, i64 0, i64 %18
  %20 = load i8, ptr %19, align 1
  %21 = sext i8 %20 to i32
  %22 = add nsw i32 %15, %21
  %23 = load i8, ptr %16, align 1
  %24 = zext i8 %23 to i64
  %25 = getelementptr inbounds nuw [256 x i8], ptr @bits, i64 0, i64 %24
  %26 = load i8, ptr %25, align 1
  %27 = sext i8 %26 to i32
  %28 = add nsw i32 %22, %27
  ret i32 %28
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @ntbl_bitcnt(i64 noundef %0) #0 {
  %2 = and i64 %0, 15
  %3 = trunc i64 %2 to i32
  %4 = sext i32 %3 to i64
  %5 = getelementptr inbounds [256 x i8], ptr @bits.1, i64 0, i64 %4
  %6 = load i8, ptr %5, align 1
  %7 = sext i8 %6 to i32
  %8 = ashr i64 %0, 4
  %9 = icmp ne i64 0, %8
  br i1 %9, label %10, label %13

10:                                               ; preds = %1
  %11 = call i32 @ntbl_bitcnt(i64 noundef %8)
  %12 = add nsw i32 %7, %11
  br label %13

13:                                               ; preds = %10, %1
  %.0 = phi i32 [ %12, %10 ], [ %7, %1 ]
  ret i32 %.0
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @btbl_bitcnt(i64 noundef %0) #0 {
  %2 = alloca i64, align 8
  store i64 %0, ptr %2, align 8
  %3 = getelementptr inbounds i8, ptr %2, i64 0
  %4 = load i8, ptr %3, align 8
  %5 = sext i8 %4 to i32
  %6 = and i32 %5, 255
  %7 = sext i32 %6 to i64
  %8 = getelementptr inbounds [256 x i8], ptr @bits.1, i64 0, i64 %7
  %9 = load i8, ptr %8, align 1
  %10 = sext i8 %9 to i32
  %11 = load i64, ptr %2, align 8
  %12 = ashr i64 %11, 8
  store i64 %12, ptr %2, align 8
  %13 = icmp ne i64 0, %12
  br i1 %13, label %14, label %18

14:                                               ; preds = %1
  %15 = load i64, ptr %2, align 8
  %16 = call i32 @btbl_bitcnt(i64 noundef %15)
  %17 = add nsw i32 %10, %16
  br label %18

18:                                               ; preds = %14, %1
  %.0 = phi i32 [ %17, %14 ], [ %10, %1 ]
  ret i32 %.0
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @main1(i32 noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  %4 = icmp slt i32 %0, 2
  br i1 %4, label %5, label %8

5:                                                ; preds = %3
  %6 = load ptr, ptr @__stderrp, align 8
  %7 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %6, ptr noundef @.str.7) #7
  call void @exit(i32 noundef 1) #8
  unreachable

8:                                                ; preds = %3
  %9 = getelementptr inbounds ptr, ptr %1, i64 1
  %10 = load ptr, ptr %9, align 8
  %11 = call i32 @atoi(ptr noundef %10)
  %12 = icmp ne i32 %2, 0
  br i1 %12, label %13, label %15

13:                                               ; preds = %8
  %14 = call i32 @puts(ptr noundef @.str.8)
  br label %15

15:                                               ; preds = %13, %8
  br label %16

16:                                               ; preds = %40, %15
  %.03 = phi i32 [ 0, %15 ], [ %41, %40 ]
  %17 = icmp slt i32 %.03, 7
  br i1 %17, label %18, label %42

18:                                               ; preds = %16
  br label %19

19:                                               ; preds = %29, %18
  %.02 = phi i64 [ 0, %18 ], [ %30, %29 ]
  %.01 = phi i64 [ 0, %18 ], [ %28, %29 ]
  %.0 = phi i64 [ 1, %18 ], [ %31, %29 ]
  %20 = sext i32 %11 to i64
  %21 = icmp slt i64 %.02, %20
  br i1 %21, label %22, label %32

22:                                               ; preds = %19
  %23 = sext i32 %.03 to i64
  %24 = getelementptr inbounds [7 x ptr], ptr @main1.pBitCntFunc, i64 0, i64 %23
  %25 = load ptr, ptr %24, align 8
  %26 = call i32 %25(i64 noundef %.0)
  %27 = sext i32 %26 to i64
  %28 = add nsw i64 %.01, %27
  br label %29

29:                                               ; preds = %22
  %30 = add nsw i64 %.02, 1
  %31 = add nsw i64 %.0, 13
  br label %19, !llvm.loop !8

32:                                               ; preds = %19
  %33 = icmp ne i32 %2, 0
  br i1 %33, label %34, label %39

34:                                               ; preds = %32
  %35 = sext i32 %.03 to i64
  %36 = getelementptr inbounds [7 x ptr], ptr @main1.text, i64 0, i64 %35
  %37 = load ptr, ptr %36, align 8
  %38 = call i32 (ptr, ...) @printf(ptr noundef @.str.9, ptr noundef %37, i64 noundef %.01)
  br label %39

39:                                               ; preds = %34, %32
  br label %40

40:                                               ; preds = %39
  %41 = add nsw i32 %.03, 1
  br label %16, !llvm.loop !9

42:                                               ; preds = %16
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @fprintf(ptr noundef, ptr noundef, ...) #2

; Function Attrs: noreturn
declare void @exit(i32 noundef) #3

declare i32 @atoi(ptr noundef) #4

declare i32 @puts(ptr noundef) #4

declare i32 @printf(ptr noundef, ...) #4

; Function Attrs: noinline nounwind ssp uwtable(sync)
define internal i32 @bit_shifter(i64 noundef %0) #0 {
  br label %2

2:                                                ; preds = %13, %1
  %.02 = phi i32 [ 0, %1 ], [ %12, %13 ]
  %.01 = phi i32 [ 0, %1 ], [ %14, %13 ]
  %.0 = phi i64 [ %0, %1 ], [ %15, %13 ]
  %3 = icmp ne i64 %.0, 0
  br i1 %3, label %4, label %7

4:                                                ; preds = %2
  %5 = sext i32 %.01 to i64
  %6 = icmp ult i64 %5, 64
  br label %7

7:                                                ; preds = %4, %2
  %8 = phi i1 [ false, %2 ], [ %6, %4 ]
  br i1 %8, label %9, label %16

9:                                                ; preds = %7
  %10 = and i64 %.0, 1
  %11 = trunc i64 %10 to i32
  %12 = add nsw i32 %.02, %11
  br label %13

13:                                               ; preds = %9
  %14 = add nsw i32 %.01, 1
  %15 = ashr i64 %.0, 1
  br label %2, !llvm.loop !10

16:                                               ; preds = %7
  ret i32 %.02
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define ptr @bfopen(ptr noundef %0, ptr noundef %1) #0 {
  %3 = call ptr @malloc(i64 noundef 16) #9
  %4 = icmp eq ptr null, %3
  br i1 %4, label %5, label %6

5:                                                ; preds = %2
  br label %16

6:                                                ; preds = %2
  %7 = call ptr @"\01_fopen"(ptr noundef %0, ptr noundef %1)
  %8 = getelementptr inbounds nuw %struct.bfile, ptr %3, i32 0, i32 0
  store ptr %7, ptr %8, align 8
  %9 = getelementptr inbounds nuw %struct.bfile, ptr %3, i32 0, i32 0
  %10 = load ptr, ptr %9, align 8
  %11 = icmp eq ptr null, %10
  br i1 %11, label %12, label %13

12:                                               ; preds = %6
  call void @free(ptr noundef %3)
  br label %16

13:                                               ; preds = %6
  %14 = getelementptr inbounds nuw %struct.bfile, ptr %3, i32 0, i32 2
  store i8 0, ptr %14, align 1
  %15 = getelementptr inbounds nuw %struct.bfile, ptr %3, i32 0, i32 4
  store i8 0, ptr %15, align 1
  br label %16

16:                                               ; preds = %13, %12, %5
  %.0 = phi ptr [ null, %5 ], [ null, %12 ], [ %3, %13 ]
  ret ptr %.0
}

; Function Attrs: allocsize(0)
declare ptr @malloc(i64 noundef) #5

declare ptr @"\01_fopen"(ptr noundef, ptr noundef) #4

declare void @free(ptr noundef) #4

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @bfread(ptr noundef %0) #0 {
  %2 = getelementptr inbounds nuw %struct.bfile, ptr %0, i32 0, i32 2
  %3 = load i8, ptr %2, align 1
  %4 = sext i8 %3 to i32
  %5 = icmp eq i32 0, %4
  br i1 %5, label %6, label %13

6:                                                ; preds = %1
  %7 = getelementptr inbounds nuw %struct.bfile, ptr %0, i32 0, i32 0
  %8 = load ptr, ptr %7, align 8
  %9 = call i32 @fgetc(ptr noundef %8)
  %10 = trunc i32 %9 to i8
  %11 = getelementptr inbounds nuw %struct.bfile, ptr %0, i32 0, i32 1
  store i8 %10, ptr %11, align 8
  %12 = getelementptr inbounds nuw %struct.bfile, ptr %0, i32 0, i32 2
  store i8 8, ptr %12, align 1
  br label %13

13:                                               ; preds = %6, %1
  %14 = getelementptr inbounds nuw %struct.bfile, ptr %0, i32 0, i32 2
  %15 = load i8, ptr %14, align 1
  %16 = add i8 %15, -1
  store i8 %16, ptr %14, align 1
  %17 = getelementptr inbounds nuw %struct.bfile, ptr %0, i32 0, i32 1
  %18 = load i8, ptr %17, align 8
  %19 = sext i8 %18 to i32
  %20 = getelementptr inbounds nuw %struct.bfile, ptr %0, i32 0, i32 2
  %21 = load i8, ptr %20, align 1
  %22 = sext i8 %21 to i32
  %23 = shl i32 1, %22
  %24 = and i32 %19, %23
  %25 = icmp ne i32 %24, 0
  %26 = zext i1 %25 to i32
  ret i32 %26
}

declare i32 @fgetc(ptr noundef) #4

; Function Attrs: noinline nounwind ssp uwtable(sync)
define void @bfwrite(i32 noundef %0, ptr noundef %1) #0 {
  %3 = getelementptr inbounds nuw %struct.bfile, ptr %1, i32 0, i32 4
  %4 = load i8, ptr %3, align 1
  %5 = sext i8 %4 to i32
  %6 = icmp eq i32 8, %5
  br i1 %6, label %7, label %15

7:                                                ; preds = %2
  %8 = getelementptr inbounds nuw %struct.bfile, ptr %1, i32 0, i32 3
  %9 = load i8, ptr %8, align 2
  %10 = sext i8 %9 to i32
  %11 = getelementptr inbounds nuw %struct.bfile, ptr %1, i32 0, i32 0
  %12 = load ptr, ptr %11, align 8
  %13 = call i32 @fputc(i32 noundef %10, ptr noundef %12)
  %14 = getelementptr inbounds nuw %struct.bfile, ptr %1, i32 0, i32 4
  store i8 0, ptr %14, align 1
  br label %15

15:                                               ; preds = %7, %2
  %16 = getelementptr inbounds nuw %struct.bfile, ptr %1, i32 0, i32 4
  %17 = load i8, ptr %16, align 1
  %18 = add i8 %17, 1
  store i8 %18, ptr %16, align 1
  %19 = getelementptr inbounds nuw %struct.bfile, ptr %1, i32 0, i32 3
  %20 = load i8, ptr %19, align 2
  %21 = sext i8 %20 to i32
  %22 = shl i32 %21, 1
  %23 = trunc i32 %22 to i8
  store i8 %23, ptr %19, align 2
  %24 = and i32 %0, 1
  %25 = getelementptr inbounds nuw %struct.bfile, ptr %1, i32 0, i32 3
  %26 = load i8, ptr %25, align 2
  %27 = sext i8 %26 to i32
  %28 = or i32 %27, %24
  %29 = trunc i32 %28 to i8
  store i8 %29, ptr %25, align 2
  ret void
}

declare i32 @fputc(i32 noundef, ptr noundef) #4

; Function Attrs: noinline nounwind ssp uwtable(sync)
define void @bfclose(ptr noundef %0) #0 {
  %2 = getelementptr inbounds nuw %struct.bfile, ptr %0, i32 0, i32 0
  %3 = load ptr, ptr %2, align 8
  %4 = call i32 @fclose(ptr noundef %3)
  call void @free(ptr noundef %0)
  ret void
}

declare i32 @fclose(ptr noundef) #4

; Function Attrs: noinline nounwind ssp uwtable(sync)
define void @bitstring(ptr noundef %0, i64 noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = ashr i32 %2, 2
  %6 = add nsw i32 %2, %5
  %7 = srem i32 %2, 4
  %8 = icmp ne i32 %7, 0
  %9 = zext i1 %8 to i64
  %10 = select i1 %8, i32 0, i32 1
  %11 = sub nsw i32 %6, %10
  %12 = sub nsw i32 %3, %11
  br label %13

13:                                               ; preds = %17, %4
  %.01 = phi i32 [ 0, %4 ], [ %18, %17 ]
  %.0 = phi ptr [ %0, %4 ], [ %16, %17 ]
  %14 = icmp slt i32 %.01, %12
  br i1 %14, label %15, label %19

15:                                               ; preds = %13
  %16 = getelementptr inbounds nuw i8, ptr %.0, i32 1
  store i8 32, ptr %.0, align 1
  br label %17

17:                                               ; preds = %15
  %18 = add nsw i32 %.01, 1
  br label %13, !llvm.loop !11

19:                                               ; preds = %13
  br label %20

20:                                               ; preds = %36, %19
  %.02 = phi i32 [ %2, %19 ], [ %21, %36 ]
  %.1 = phi ptr [ %.0, %19 ], [ %.2, %36 ]
  %21 = add nsw i32 %.02, -1
  %22 = icmp sge i32 %21, 0
  br i1 %22, label %23, label %37

23:                                               ; preds = %20
  %24 = zext i32 %21 to i64
  %25 = ashr i64 %1, %24
  %26 = and i64 %25, 1
  %27 = add nsw i64 %26, 48
  %28 = trunc i64 %27 to i8
  %29 = getelementptr inbounds nuw i8, ptr %.1, i32 1
  store i8 %28, ptr %.1, align 1
  %30 = srem i32 %21, 4
  %31 = icmp ne i32 %30, 0
  br i1 %31, label %36, label %32

32:                                               ; preds = %23
  %33 = icmp ne i32 %21, 0
  br i1 %33, label %34, label %36

34:                                               ; preds = %32
  %35 = getelementptr inbounds nuw i8, ptr %29, i32 1
  store i8 32, ptr %29, align 1
  br label %36

36:                                               ; preds = %34, %32, %23
  %.2 = phi ptr [ %29, %23 ], [ %35, %34 ], [ %29, %32 ]
  br label %20, !llvm.loop !12

37:                                               ; preds = %20
  store i8 0, ptr %.1, align 1
  ret void
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @bstr_i(ptr noundef %0) #0 {
  br label %2

2:                                                ; preds = %15, %1
  %.01 = phi i32 [ 0, %1 ], [ %22, %15 ]
  %.0 = phi ptr [ %0, %1 ], [ %16, %15 ]
  %3 = icmp ne ptr %.0, null
  br i1 %3, label %4, label %13

4:                                                ; preds = %2
  %5 = load i8, ptr %.0, align 1
  %6 = sext i8 %5 to i32
  %7 = icmp ne i32 %6, 0
  br i1 %7, label %8, label %13

8:                                                ; preds = %4
  %9 = load i8, ptr %.0, align 1
  %10 = sext i8 %9 to i32
  %11 = call ptr @strchr(ptr noundef @.str.10, i32 noundef %10) #7
  %12 = icmp ne ptr %11, null
  br label %13

13:                                               ; preds = %8, %4, %2
  %14 = phi i1 [ false, %4 ], [ false, %2 ], [ %12, %8 ]
  br i1 %14, label %15, label %23

15:                                               ; preds = %13
  %16 = getelementptr inbounds nuw i8, ptr %.0, i32 1
  %17 = load i8, ptr %.0, align 1
  %18 = sext i8 %17 to i32
  %19 = sub nsw i32 %18, 48
  %20 = shl i32 %.01, 1
  %21 = and i32 %19, 1
  %22 = or i32 %20, %21
  br label %2, !llvm.loop !13

23:                                               ; preds = %13
  ret i32 %.01
}

; Function Attrs: nounwind
declare ptr @strchr(ptr noundef, i32 noundef) #2

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @main(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i64, align 8
  %4 = call ptr @"\01_fopen"(ptr noundef @.str.11, ptr noundef @.str.1.12)
  %5 = icmp eq ptr %4, null
  br i1 %5, label %6, label %9

6:                                                ; preds = %2
  %7 = load ptr, ptr @__stderrp, align 8
  %8 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %7, ptr noundef @.str.2.13) #7
  br label %24

9:                                                ; preds = %2
  %10 = call i32 (ptr, ptr, ...) @fscanf(ptr noundef %4, ptr noundef @.str.3.14, ptr noundef %3)
  %11 = call i32 @fclose(ptr noundef %4)
  br label %12

12:                                               ; preds = %21, %9
  %.01 = phi i64 [ 0, %9 ], [ %22, %21 ]
  %13 = load i64, ptr %3, align 8
  %14 = icmp slt i64 %.01, %13
  br i1 %14, label %15, label %23

15:                                               ; preds = %12
  %16 = add nsw i64 %.01, 1
  %17 = load i64, ptr %3, align 8
  %18 = icmp eq i64 %16, %17
  %19 = zext i1 %18 to i32
  %20 = call i32 @main1(i32 noundef %0, ptr noundef %1, i32 noundef %19)
  br label %21

21:                                               ; preds = %15
  %22 = add nsw i64 %.01, 1
  br label %12, !llvm.loop !14

23:                                               ; preds = %12
  br label %24

24:                                               ; preds = %23, %6
  %.0 = phi i32 [ 1, %6 ], [ 0, %23 ]
  ret i32 %.0
}

declare i32 @fscanf(ptr noundef, ptr noundef, ...) #4

attributes #0 = { noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { allocsize(0,1) "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #2 = { nounwind "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #3 = { noreturn "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #4 = { "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #5 = { allocsize(0) "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #6 = { allocsize(0,1) }
attributes #7 = { nounwind }
attributes #8 = { noreturn }
attributes #9 = { allocsize(0) }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1, !2, !3, !4, !5}

!0 = !{!"Homebrew clang version 22.1.0"}
!1 = !{i32 2, !"SDK Version", [2 x i32] [i32 15, i32 4]}
!2 = !{i32 1, !"wchar_size", i32 4}
!3 = !{i32 8, !"PIC Level", i32 2}
!4 = !{i32 7, !"uwtable", i32 1}
!5 = !{i32 7, !"frame-pointer", i32 4}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
!10 = distinct !{!10, !7}
!11 = distinct !{!11, !7}
!12 = distinct !{!12, !7}
!13 = distinct !{!13, !7}
!14 = distinct !{!14, !7}

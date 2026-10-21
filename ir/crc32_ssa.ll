; ModuleID = 'ir/crc32.ll'
source_filename = "llvm-link"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@crc_32_tab = internal global [256 x i64] [i64 0, i64 1996959894, i64 3993919788, i64 2567524794, i64 124634137, i64 1886057615, i64 3915621685, i64 2657392035, i64 249268274, i64 2044508324, i64 3772115230, i64 2547177864, i64 162941995, i64 2125561021, i64 3887607047, i64 2428444049, i64 498536548, i64 1789927666, i64 4089016648, i64 2227061214, i64 450548861, i64 1843258603, i64 4107580753, i64 2211677639, i64 325883990, i64 1684777152, i64 4251122042, i64 2321926636, i64 335633487, i64 1661365465, i64 4195302755, i64 2366115317, i64 997073096, i64 1281953886, i64 3579855332, i64 2724688242, i64 1006888145, i64 1258607687, i64 3524101629, i64 2768942443, i64 901097722, i64 1119000684, i64 3686517206, i64 2898065728, i64 853044451, i64 1172266101, i64 3705015759, i64 2882616665, i64 651767980, i64 1373503546, i64 3369554304, i64 3218104598, i64 565507253, i64 1454621731, i64 3485111705, i64 3099436303, i64 671266974, i64 1594198024, i64 3322730930, i64 2970347812, i64 795835527, i64 1483230225, i64 3244367275, i64 3060149565, i64 1994146192, i64 31158534, i64 2563907772, i64 4023717930, i64 1907459465, i64 112637215, i64 2680153253, i64 3904427059, i64 2013776290, i64 251722036, i64 2517215374, i64 3775830040, i64 2137656763, i64 141376813, i64 2439277719, i64 3865271297, i64 1802195444, i64 476864866, i64 2238001368, i64 4066508878, i64 1812370925, i64 453092731, i64 2181625025, i64 4111451223, i64 1706088902, i64 314042704, i64 2344532202, i64 4240017532, i64 1658658271, i64 366619977, i64 2362670323, i64 4224994405, i64 1303535960, i64 984961486, i64 2747007092, i64 3569037538, i64 1256170817, i64 1037604311, i64 2765210733, i64 3554079995, i64 1131014506, i64 879679996, i64 2909243462, i64 3663771856, i64 1141124467, i64 855842277, i64 2852801631, i64 3708648649, i64 1342533948, i64 654459306, i64 3188396048, i64 3373015174, i64 1466479909, i64 544179635, i64 3110523913, i64 3462522015, i64 1591671054, i64 702138776, i64 2966460450, i64 3352799412, i64 1504918807, i64 783551873, i64 3082640443, i64 3233442989, i64 3988292384, i64 2596254646, i64 62317068, i64 1957810842, i64 3939845945, i64 2647816111, i64 81470997, i64 1943803523, i64 3814918930, i64 2489596804, i64 225274430, i64 2053790376, i64 3826175755, i64 2466906013, i64 167816743, i64 2097651377, i64 4027552580, i64 2265490386, i64 503444072, i64 1762050814, i64 4150417245, i64 2154129355, i64 426522225, i64 1852507879, i64 4275313526, i64 2312317920, i64 282753626, i64 1742555852, i64 4189708143, i64 2394877945, i64 397917763, i64 1622183637, i64 3604390888, i64 2714866558, i64 953729732, i64 1340076626, i64 3518719985, i64 2797360999, i64 1068828381, i64 1219638859, i64 3624741850, i64 2936675148, i64 906185462, i64 1090812512, i64 3747672003, i64 2825379669, i64 829329135, i64 1181335161, i64 3412177804, i64 3160834842, i64 628085408, i64 1382605366, i64 3423369109, i64 3138078467, i64 570562233, i64 1426400815, i64 3317316542, i64 2998733608, i64 733239954, i64 1555261956, i64 3268935591, i64 3050360625, i64 752459403, i64 1541320221, i64 2607071920, i64 3965973030, i64 1969922972, i64 40735498, i64 2617837225, i64 3943577151, i64 1913087877, i64 83908371, i64 2512341634, i64 3803740692, i64 2075208622, i64 213261112, i64 2463272603, i64 3855990285, i64 2094854071, i64 198958881, i64 2262029012, i64 4057260610, i64 1759359992, i64 534414190, i64 2176718541, i64 4139329115, i64 1873836001, i64 414664567, i64 2282248934, i64 4279200368, i64 1711684554, i64 285281116, i64 2405801727, i64 4167216745, i64 1634467795, i64 376229701, i64 2685067896, i64 3608007406, i64 1308918612, i64 956543938, i64 2808555105, i64 3495958263, i64 1231636301, i64 1047427035, i64 2932959818, i64 3654703836, i64 1088359270, i64 936918000, i64 2847714899, i64 3736837829, i64 1202900863, i64 817233897, i64 3183342108, i64 3401237130, i64 1404277552, i64 615818150, i64 3134207493, i64 3453421203, i64 1423857449, i64 601450431, i64 3009837614, i64 3294710456, i64 1567103746, i64 711928724, i64 3020668471, i64 3272380065, i64 1510334235, i64 755167117], align 8
@.str = private unnamed_addr constant [2 x i8] c"r\00", align 1
@.str.1 = private unnamed_addr constant [15 x i8] c"%08lX %7ld %s\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"_finfo_dataset\00", align 1
@.str.1.3 = private unnamed_addr constant [3 x i8] c"rt\00", align 1
@__stderrp = external global ptr, align 8
@.str.2.4 = private unnamed_addr constant [29 x i8] c"\0AError: Can't find dataset!\0A\00", align 1
@.str.3 = private unnamed_addr constant [4 x i8] c"%ld\00", align 1

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i64 @updateCRC32(i8 noundef zeroext %0, i64 noundef %1) #0 {
  %3 = zext i8 %0 to i64
  %4 = xor i64 %1, %3
  %5 = and i64 %4, 255
  %6 = getelementptr inbounds nuw [256 x i64], ptr @crc_32_tab, i64 0, i64 %5
  %7 = load i64, ptr %6, align 8
  %8 = lshr i64 %1, 8
  %9 = xor i64 %7, %8
  ret i64 %9
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @crc32file(ptr noundef %0, ptr noundef %1, ptr noundef %2) #0 {
  store i64 0, ptr %2, align 8
  %4 = call ptr @"\01_fopen"(ptr noundef %0, ptr noundef @.str)
  %5 = icmp eq ptr %4, null
  br i1 %5, label %6, label %7

6:                                                ; preds = %3
  call void @perror(ptr noundef %0) #4
  br label %29

7:                                                ; preds = %3
  br label %8

8:                                                ; preds = %11, %7
  %.01 = phi i64 [ 4294967295, %7 ], [ %21, %11 ]
  %9 = call i32 @getc(ptr noundef %4)
  %10 = icmp ne i32 %9, -1
  br i1 %10, label %11, label %22

11:                                               ; preds = %8
  %12 = load i64, ptr %2, align 8
  %13 = add nsw i64 %12, 1
  store i64 %13, ptr %2, align 8
  %14 = trunc i32 %9 to i8
  %15 = zext i8 %14 to i64
  %16 = xor i64 %.01, %15
  %17 = and i64 %16, 255
  %18 = getelementptr inbounds nuw [256 x i64], ptr @crc_32_tab, i64 0, i64 %17
  %19 = load i64, ptr %18, align 8
  %20 = lshr i64 %.01, 8
  %21 = xor i64 %19, %20
  br label %8, !llvm.loop !6

22:                                               ; preds = %8
  %23 = call i32 @ferror(ptr noundef %4)
  %24 = icmp ne i32 %23, 0
  br i1 %24, label %25, label %26

25:                                               ; preds = %22
  call void @perror(ptr noundef %0) #4
  store i64 -1, ptr %2, align 8
  br label %26

26:                                               ; preds = %25, %22
  %27 = call i32 @fclose(ptr noundef %4)
  %28 = xor i64 %.01, -1
  store i64 %28, ptr %1, align 8
  br label %29

29:                                               ; preds = %26, %6
  %.0 = phi i32 [ -1, %6 ], [ 0, %26 ]
  ret i32 %.0
}

declare ptr @"\01_fopen"(ptr noundef, ptr noundef) #1

; Function Attrs: cold
declare void @perror(ptr noundef) #2

declare i32 @getc(ptr noundef) #1

declare i32 @ferror(ptr noundef) #1

declare i32 @fclose(ptr noundef) #1

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i64 @crc32buf(ptr noundef %0, i64 noundef %1) #0 {
  br label %3

3:                                                ; preds = %14, %2
  %.02 = phi i64 [ 4294967295, %2 ], [ %13, %14 ]
  %.01 = phi i64 [ %1, %2 ], [ %15, %14 ]
  %.0 = phi ptr [ %0, %2 ], [ %16, %14 ]
  %4 = icmp ne i64 %.01, 0
  br i1 %4, label %5, label %17

5:                                                ; preds = %3
  %6 = load i8, ptr %.0, align 1
  %7 = zext i8 %6 to i64
  %8 = xor i64 %.02, %7
  %9 = and i64 %8, 255
  %10 = getelementptr inbounds nuw [256 x i64], ptr @crc_32_tab, i64 0, i64 %9
  %11 = load i64, ptr %10, align 8
  %12 = lshr i64 %.02, 8
  %13 = xor i64 %11, %12
  br label %14

14:                                               ; preds = %5
  %15 = add i64 %.01, -1
  %16 = getelementptr inbounds nuw i8, ptr %.0, i32 1
  br label %3, !llvm.loop !8

17:                                               ; preds = %3
  %18 = xor i64 %.02, -1
  ret i64 %18
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @main1(i32 noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  %4 = alloca i64, align 8
  %5 = alloca i64, align 8
  br label %6

6:                                                ; preds = %20, %3
  %.02 = phi i32 [ 0, %3 ], [ %13, %20 ]
  %.01 = phi ptr [ %1, %3 ], [ %10, %20 ]
  %.0 = phi i32 [ %0, %3 ], [ %7, %20 ]
  %7 = add nsw i32 %.0, -1
  %8 = icmp sgt i32 %7, 0
  br i1 %8, label %9, label %21

9:                                                ; preds = %6
  %10 = getelementptr inbounds nuw ptr, ptr %.01, i32 1
  %11 = load ptr, ptr %10, align 8
  %12 = call i32 @crc32file(ptr noundef %11, ptr noundef %4, ptr noundef %5)
  %13 = or i32 %.02, %12
  %14 = icmp ne i32 %2, 0
  br i1 %14, label %15, label %20

15:                                               ; preds = %9
  %16 = load i64, ptr %4, align 8
  %17 = load i64, ptr %5, align 8
  %18 = load ptr, ptr %10, align 8
  %19 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, i64 noundef %16, i64 noundef %17, ptr noundef %18)
  br label %20

20:                                               ; preds = %15, %9
  br label %6, !llvm.loop !9

21:                                               ; preds = %6
  %22 = icmp ne i32 %.02, 0
  %23 = zext i1 %22 to i32
  ret i32 %23
}

declare i32 @printf(ptr noundef, ...) #1

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @main(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i64, align 8
  %4 = call ptr @"\01_fopen"(ptr noundef @.str.2, ptr noundef @.str.1.3)
  %5 = icmp eq ptr %4, null
  br i1 %5, label %6, label %9

6:                                                ; preds = %2
  %7 = load ptr, ptr @__stderrp, align 8
  %8 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %7, ptr noundef @.str.2.4) #5
  br label %24

9:                                                ; preds = %2
  %10 = call i32 (ptr, ptr, ...) @fscanf(ptr noundef %4, ptr noundef @.str.3, ptr noundef %3)
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
  br label %12, !llvm.loop !10

23:                                               ; preds = %12
  br label %24

24:                                               ; preds = %23, %6
  %.0 = phi i32 [ 1, %6 ], [ 0, %23 ]
  ret i32 %.0
}

; Function Attrs: nounwind
declare i32 @fprintf(ptr noundef, ptr noundef, ...) #3

declare i32 @fscanf(ptr noundef, ptr noundef, ...) #1

attributes #0 = { noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #2 = { cold "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #3 = { nounwind "frame-pointer"="non-leaf-no-reserve" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #4 = { cold }
attributes #5 = { nounwind }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1, !2, !3, !4, !5}

!0 = !{!"Homebrew clang version 22.1.0"}
!1 = !{i32 2, !"SDK Version", [2 x i32] [i32 15, i32 5]}
!2 = !{i32 1, !"wchar_size", i32 4}
!3 = !{i32 8, !"PIC Level", i32 2}
!4 = !{i32 7, !"uwtable", i32 1}
!5 = !{i32 7, !"frame-pointer", i32 4}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
!10 = distinct !{!10, !7}

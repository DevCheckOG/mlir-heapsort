module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<i128, dense<128> : vector<2xi32>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>>} {
  
  llvm.mlir.global private unnamed_addr constant @first_format("%d \00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.mlir.global private unnamed_addr constant @second_format("\0A\00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.mlir.global private unnamed_addr constant @unsorted_format("Unsorted array: \0A\00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.mlir.global private unnamed_addr constant @sorted_format("Sorted array: \0A\00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.mlir.global private unnamed_addr constant @unsorted_array_data(dense<[1, 12, 9, 5, 6, 10]> : tensor<6xi32>) {addr_space = 0 : i32, alignment = 4 : i64, dso_local} : !llvm.array<6 x i32>
  
  llvm.func @swap(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.ptr {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.alloca %0 x !llvm.ptr {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store %arg0, %1 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.store %arg1, %2 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    %4 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %5 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.store %5, %3 {alignment = 4 : i64} : i32, !llvm.ptr
    %6 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32
    %8 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.store %7, %8 {alignment = 4 : i64} : i32, !llvm.ptr
    %9 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    %10 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.store %9, %10 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  
  llvm.func @heapify(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.alloca %0 x !llvm.ptr {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %4 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %5 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %6 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %7 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store %arg0, %2 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.store %arg1, %3 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %arg2, %4 {alignment = 4 : i64} : i32, !llvm.ptr
    %8 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.store %8, %5 {alignment = 4 : i64} : i32, !llvm.ptr
    %9 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> i32
    %10 = llvm.mul %1, %9  : i32
    %11 = llvm.add %10, %0  : i32
    llvm.store %11, %6 {alignment = 4 : i64} : i32, !llvm.ptr
    %12 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> i32
    %13 = llvm.mul %1, %12  : i32
    %14 = llvm.add %13, %1  : i32
    llvm.store %14, %7 {alignment = 4 : i64} : i32, !llvm.ptr
    %15 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32
    %16 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    %17 = llvm.icmp "slt" %15, %16 : i32
    llvm.cond_br %17, ^bb1, ^bb3
  ^bb1:  
    %18 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %19 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32
    %20 = llvm.sext %19 : i32 to i64
    %21 = llvm.getelementptr inbounds %18[%20] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %22 = llvm.load %21 {alignment = 4 : i64} : !llvm.ptr -> i32
    %23 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %24 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> i32
    %25 = llvm.sext %24 : i32 to i64
    %26 = llvm.getelementptr inbounds %23[%25] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %27 = llvm.load %26 {alignment = 4 : i64} : !llvm.ptr -> i32
    %28 = llvm.icmp "sgt" %22, %27 : i32
    llvm.cond_br %28, ^bb2, ^bb3
  ^bb2: 
    %29 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.store %29, %5 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb3
  ^bb3: 
    %30 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> i32
    %31 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    %32 = llvm.icmp "slt" %30, %31 : i32
    llvm.cond_br %32, ^bb4, ^bb6
  ^bb4:  
    %33 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %34 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> i32
    %35 = llvm.sext %34 : i32 to i64
    %36 = llvm.getelementptr inbounds %33[%35] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %37 = llvm.load %36 {alignment = 4 : i64} : !llvm.ptr -> i32
    %38 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %39 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> i32
    %40 = llvm.sext %39 : i32 to i64
    %41 = llvm.getelementptr inbounds %38[%40] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %42 = llvm.load %41 {alignment = 4 : i64} : !llvm.ptr -> i32
    %43 = llvm.icmp "sgt" %37, %42 : i32
    llvm.cond_br %43, ^bb5, ^bb6
  ^bb5:  
    %44 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.store %44, %5 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb6
  ^bb6: 
    %45 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> i32
    %46 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> i32
    %47 = llvm.icmp "ne" %45, %46 : i32
    llvm.cond_br %47, ^bb7, ^bb8
  ^bb7: 
    %48 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %49 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> i32
    %50 = llvm.sext %49 : i32 to i64
    %51 = llvm.getelementptr inbounds %48[%50] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %52 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %53 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> i32
    %54 = llvm.sext %53 : i32 to i64
    %55 = llvm.getelementptr inbounds %52[%54] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.call @swap(%51, %55) : (!llvm.ptr, !llvm.ptr) -> ()
    %56 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %57 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    %58 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.call @heapify(%56, %57, %58) : (!llvm.ptr, i32, i32) -> ()
    llvm.br ^bb8
  ^bb8:  
    llvm.return
  }
  
  llvm.func @heapSort(%arg0: !llvm.ptr, %arg1: i32) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.constant(-1 : i32) : i32
    %5 = llvm.alloca %0 x !llvm.ptr {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %6 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %7 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %8 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store %arg0, %5 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.store %arg1, %6 {alignment = 4 : i64} : i32, !llvm.ptr
    %9 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32
    %10 = llvm.sdiv %9, %1  : i32
    %11 = llvm.sub %10, %0  : i32
    llvm.store %11, %7 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb1
  ^bb1: 
    %12 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> i32
    %13 = llvm.icmp "sge" %12, %2 : i32
    llvm.cond_br %13, ^bb2, ^bb4
  ^bb2: 
    %14 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %15 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32
    %16 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.call @heapify(%14, %15, %16) : (!llvm.ptr, i32, i32) -> ()
    llvm.br ^bb3
  ^bb3:  
    %17 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> i32
    %18 = llvm.add %17, %4  : i32
    llvm.store %18, %7 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb1
  ^bb4:  
    %19 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32
    %20 = llvm.sub %19, %0  : i32
    llvm.store %20, %8 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb5
  ^bb5:  
    %21 = llvm.load %8 {alignment = 4 : i64} : !llvm.ptr -> i32
    %22 = llvm.icmp "sge" %21, %2 : i32
    llvm.cond_br %22, ^bb6, ^bb8
  ^bb6:  
    %23 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %24 = llvm.getelementptr inbounds %23[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %25 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %26 = llvm.load %8 {alignment = 4 : i64} : !llvm.ptr -> i32
    %27 = llvm.sext %26 : i32 to i64
    %28 = llvm.getelementptr inbounds %25[%27] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.call @swap(%24, %28) : (!llvm.ptr, !llvm.ptr) -> ()
    %29 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %30 = llvm.load %8 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.call @heapify(%29, %30, %2) : (!llvm.ptr, i32, i32) -> ()
    llvm.br ^bb7
  ^bb7: 
    %31 = llvm.load %8 {alignment = 4 : i64} : !llvm.ptr -> i32
    %32 = llvm.add %31, %4  : i32
    llvm.store %32, %8 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb5
  ^bb8:  
    llvm.return
  }
  
  llvm.func @printArray(%arg0: !llvm.ptr, %arg1: i32) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant("\0A\00") : !llvm.array<2 x i8>
    %3 = llvm.mlir.addressof @second_format : !llvm.ptr
    %4 = llvm.mlir.constant("%d \00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.addressof @first_format : !llvm.ptr
    %6 = llvm.alloca %0 x !llvm.ptr {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %7 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %8 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store %arg0, %6 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.store %arg1, %7 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %1, %8 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb1
  ^bb1: 
    %9 = llvm.load %8 {alignment = 4 : i64} : !llvm.ptr -> i32
    %10 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> i32
    %11 = llvm.icmp "slt" %9, %10 : i32
    llvm.cond_br %11, ^bb2, ^bb4
  ^bb2:  
    %12 = llvm.load %6 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %13 = llvm.load %8 {alignment = 4 : i64} : !llvm.ptr -> i32
    %14 = llvm.sext %13 : i32 to i64
    %15 = llvm.getelementptr inbounds %12[%14] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %16 = llvm.load %15 {alignment = 4 : i64} : !llvm.ptr -> i32
    %17 = llvm.call @printf(%5, %16) : (!llvm.ptr, i32) -> i32
    llvm.br ^bb3
  ^bb3:  
    %18 = llvm.load %8 {alignment = 4 : i64} : !llvm.ptr -> i32
    %19 = llvm.add %18, %0  : i32
    llvm.store %19, %8 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb1
  ^bb4: 
    %20 = llvm.call @printf(%3) : (!llvm.ptr) -> i32
    llvm.return
  }

  llvm.func @printf(!llvm.ptr, ...) -> i32
  
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(dense<[1, 12, 9, 5, 6, 10]> : tensor<6xi32>) : !llvm.array<6 x i32>
    %2 = llvm.mlir.addressof @unsorted_array_data : !llvm.ptr
    %3 = llvm.mlir.constant(24 : i64) : i64
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.mlir.constant("Unsorted array: \0A\00") : !llvm.array<18 x i8>
    %6 = llvm.mlir.addressof @unsorted_format : !llvm.ptr
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.mlir.constant(6 : i32) : i32
    %9 = llvm.mlir.constant("Sorted array: \0A\00") : !llvm.array<16 x i8>
    %10 = llvm.mlir.addressof @sorted_format : !llvm.ptr
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.alloca %0 x !llvm.array<6 x i32> {alignment = 4 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%12, %2, %3) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    %13 = llvm.call @printf(%6) : (!llvm.ptr) -> i32
    %14 = llvm.getelementptr inbounds %12[%7, %7] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<6 x i32>
    llvm.call @printArray(%14, %8) : (!llvm.ptr, i32) -> ()
    %15 = llvm.getelementptr inbounds %12[%7, %7] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<6 x i32>
    llvm.call @heapSort(%15, %8) : (!llvm.ptr, i32) -> ()
    %16 = llvm.call @printf(%10) : (!llvm.ptr) -> i32
    %17 = llvm.getelementptr inbounds %12[%7, %7] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<6 x i32>
    llvm.call @printArray(%17, %8) : (!llvm.ptr, i32) -> ()
    llvm.return %11 : i32
  }

}

import 'package:quan_ly_thu_vien_flutter/model/Sinh_vien.dart';

class BorrowBooks {
  // class quan lý sinh vien nào mươn sach
  int id_book_muon;
  int so_luong_sach_muon;
  late DateTime time_muon_sach;
  BorrowBooks(
      {required this.id_book_muon,
      required this.so_luong_sach_muon}){
      this.time_muon_sach = DateTime.now();
     }
}

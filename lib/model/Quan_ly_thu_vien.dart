import 'package:flutter/material.dart';
import 'package:quan_ly_thu_vien_flutter/model/Sinh_vien.dart';
import 'package:quan_ly_thu_vien_flutter/model/sach_muon.dart';
import './book.dart';

class LibraryManager extends ChangeNotifier {
  List<Book> listBook = [
    // quản lý tổng sách trong thư viện 
    Book(
      id: 123456,
      name_book: "quang",
      so_luong: 2,
    ),
    Book(id: 1, name_book: "truyện kiểu", so_luong: 2),
    Book(id: 2, name_book: "doremon", so_luong: 2),
    Book(id: 3, name_book: "kiến trúc máy tính", so_luong: 2),
    Book(id: 4, name_book: "ngữ văn 1", so_luong: 2),
  ];
  // thông tin sinh viên 
  List<Sinh_vien> list_sinh_vien = [
    Sinh_vien(
        id_sinh_vien: 111111, name_sinh_vien: "đào xuân quang", khoa: "CNTT"),
    Sinh_vien(  
        id_sinh_vien: 222222, name_sinh_vien: "nguyễn hồng hạnh", khoa: "CNTT"),
    Sinh_vien(
        id_sinh_vien: 333333, name_sinh_vien: "le xuan vinh", khoa: "CNTT"),
  ];
  // lưu thông tin mượn trả sách 
  Map<int, List<BorrowBooks>> quan_ly_muon = {};
  // Hàm hiển thị dialog thông báo lỗi
  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Lỗi"),
          content: Text(message),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
// Hàm hiển thị dialog thông báo thành công 
  void showSuccessMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Success"),
          backgroundColor: Colors.green,
          content: Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

// lay sinh vien tu id sinh vien
  Sinh_vien? select_sinhvien(int id) {
    for (int i = 0; i < list_sinh_vien.length; i++) {
      if (id == list_sinh_vien[i].id_sinh_vien) {
        return list_sinh_vien[i];
      }
    }
    return null;
  }

  // lay book tu id book
  Book? select_book(int id) {
    for (int i = 0; i < listBook.length; i++) {
      if (id == listBook[i].id) {
        return listBook[i];
      }
    }

    return null;
  }

// ham them sach moi vao thu vien
  void addBook(BuildContext context, Book book) {
    bool isID = listBook.any((element) {
      return element.id == book.id;
    });

    if (isID == false) {
      listBook.add(book);
      notifyListeners();
    } else {
      // Hiển thị thông báo lỗi không sử dụng thêm thư viện
      showErrorDialog(context, "Sách với ID ${book.id} đã tồn tại.");
    }
  }
  // hàm xóa sách khỏi thư viện 

  void deleteBook(BuildContext context, int index) {
    if (listBook[index].so_luong_da_muon == 0) {
      final removedBook = listBook.removeAt(index);
      showSuccessMessage(context, "đã xóa sách có id: ${removedBook.id}");
      notifyListeners();
    } else {
      showErrorDialog(context, "đang có người mượn sách, không thể xóa");
    }
  }
// hàm chỉnh sửa sách trong thư viện 
  void editBook(BuildContext context, int index, Book book) {
    listBook[index] = book;
    if (book.so_luong_da_muon < listBook[index].so_luong) {
      if (listBook[index].co_the_muon == false) {
        listBook[index].co_the_muon = true;
      }
      showSuccessMessage(context, "đã sửa sách có id: ${listBook[index].id}");
      notifyListeners();
    } else if (book.so_luong_da_muon == listBook[index].so_luong) {
      listBook[index].co_the_muon = false;
      showSuccessMessage(context, "đã sửa sách có id: ${listBook[index].id}");
      notifyListeners();
    }
  }
// hàm mượn sách
  void addBorrowBooks(int id_sv, int id_book, int so_sach_muon) {
    if (quan_ly_muon.containsKey(id_sv)) {
      BorrowBooks new_BorrowBooks =
          BorrowBooks(id_book_muon: id_book, so_luong_sach_muon: so_sach_muon);
      quan_ly_muon[id_sv]!.add(new_BorrowBooks);
      select_book(id_book)!.so_luong_da_muon =
          select_book(id_book)!.so_luong_da_muon + so_sach_muon;
      if (select_book(id_book)!.soLuongConLai() == 0) {
        select_book(id_book)!.co_the_muon = false;
      }
      notifyListeners();
    } else {
      // Nếu sinh viên chưa tồn tại trong quản lý mượn
      List<BorrowBooks> borrowList = [
        BorrowBooks(id_book_muon: id_book, so_luong_sach_muon: so_sach_muon)
      ];
      quan_ly_muon[id_sv] = borrowList;
      select_book(id_book)!.so_luong_da_muon +=
          so_sach_muon; // Cập nhật số lượng sách đã mượn
      if (select_book(id_book)!.soLuongConLai() == 0) {
        select_book(id_book)!.co_the_muon = false;
      }
    }
    notifyListeners();
  }
// hàm trả sách
  void tra_sach(int id_sinh_vien) {
    List<BorrowBooks>? list_sach_tra = [];
    list_sach_tra = quan_ly_muon[id_sinh_vien];
    for (int i = 0; i < list_sach_tra!.length; i++) {
      select_book(list_sach_tra[i].id_book_muon)!.so_luong_da_muon =
          select_book(list_sach_tra[i].id_book_muon)!.so_luong_da_muon -
              list_sach_tra[i].so_luong_sach_muon;
      if (select_book(list_sach_tra[i].id_book_muon)!.co_the_muon == false) {
        select_book(list_sach_tra[i].id_book_muon)!.co_the_muon = true;
      }
    }
    quan_ly_muon.remove(id_sinh_vien);
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import './book.dart';

class LibraryManager extends ChangeNotifier {
  List<Book> listBook = [ // quan lý tong sách trong thư viện
    Book(id: 123456, name_book: "quang", so_luong: 2),
    Book(id: 123454, name_book: "quaavng", so_luong: 2),
    Book(id: 123452, name_book: "quanag", so_luong: 2),
  ];
  // Hàm hiển thị dialog thông báo lỗi
  void _showErrorDialog(BuildContext context, String message) {
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
// ham them sach moi vao thu vien
  void addBook(BuildContext context, Book book) {
    bool isID = listBook.any((element) {
      return element.id == book.id;
    });

    if (isID == false) {
      listBook.add(book);
      notifyListeners();
      print("object");
      for (int i = 0; i < listBook.length; i++) {
        print(listBook[i].id);
      }
    } else {
      // Hiển thị thông báo lỗi không sử dụng thêm thư viện
      _showErrorDialog(context, "Sách với ID ${book.id} đã tồn tại.");
    }
  }

  void deleteBook(BuildContext context, int index) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("đã xóa sách có id: ${listBook[index].id}")));
    listBook.removeAt(index);
    notifyListeners();
  }

  void editBook(BuildContext context, int index, Book book) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text("đã sửa sách có id: ${listBook[index].id}")));
    listBook[index] = book;
    notifyListeners();
  }
}

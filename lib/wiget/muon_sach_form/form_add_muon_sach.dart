import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:quan_ly_thu_vien_flutter/model/Quan_ly_thu_vien.dart';

class Form_add_muon_sach extends StatelessWidget {
  TextEditingController id_sinhvien_controller = TextEditingController();
  TextEditingController name_sv_controller = TextEditingController();
  TextEditingController khoa_controller = TextEditingController();
  TextEditingController id_book_controller = TextEditingController();
  TextEditingController name_book_controller = TextEditingController();
  TextEditingController so_luong_book_controller = TextEditingController();
  bool isButtonDisabled = true;

  void form_add_muon_sach(BuildContext context) {
    final thu_vien = Provider.of<LibraryManager>(context, listen: false);

    void updateButtonState() {
      // Kiểm tra xem có trường nào trống thông tin không
      bool anyFieldEmpty = id_sinhvien_controller.text.isEmpty ||
          name_sv_controller.text.isEmpty ||
          khoa_controller.text.isEmpty ||
          id_book_controller.text.isEmpty ||
          name_book_controller.text.isEmpty ||
          so_luong_book_controller.text.isEmpty;

      // Kiểm tra xem so_luong_book_controller có bằng 0 hay không
      bool isQuantityZero = so_luong_book_controller.text == "0";

      // Cập nhật giá trị của biến kiểm tra điều kiện
      isButtonDisabled = anyFieldEmpty || isQuantityZero;
    }

    // update TextField khi nhap dung id sinh vien
    void updateSinhvienDetails() {
      updateButtonState();
      bool foundMatch = false; //tồn tại sinh viên có id đc nhập hay k
      for (int i = 0; i < thu_vien.list_sinh_vien.length; i++) {
        if (int.tryParse(id_sinhvien_controller.text) ==
            thu_vien.list_sinh_vien[i].id_sinh_vien) {
          print("true");
          name_sv_controller.text = thu_vien
              .select_sinhvien(int.parse(id_sinhvien_controller.text))!
              .name_sinh_vien;
          khoa_controller.text = thu_vien
              .select_sinhvien(int.parse(id_sinhvien_controller.text))!
              .khoa;
          foundMatch = true; // Đặt cờ thành true khi tìm thấy sự khớp
          break; // Thoát khỏi vòng lặp vì chúng ta đã tìm thấy sự khớp
        }
      }

      // Xóa các trường chỉ nếu không có sự khớp được tìm thấy
      if (!foundMatch) {
        name_sv_controller.text = '';
        khoa_controller.text = '';
      }
    }

// update TextField khi nhap dung id book
    void updateBookDetails() {
      updateButtonState();
      bool foundMatch = false; //tồn tại sinh viên có id đc nhập hay k
      print("jrhoawhgwagoagoaoahggwag");
      for (int i = 0; i < thu_vien.list_sinh_vien.length; i++) {
        if (int.tryParse(id_book_controller.text) == thu_vien.listBook[i].id) {
          print("true");
          name_book_controller.text = thu_vien
              .select_book(int.parse(id_book_controller.text))!
              .name_book;
          foundMatch = true; // Đặt cờ thành true khi tìm thấy sự khớp
          break; // Thoát khỏi vòng lặp vì chúng ta đã tìm thấy sự khớp
        }
      }

      // Xóa các trường chỉ nếu không có sự khớp được tìm thấy
      if (!foundMatch) {
        name_book_controller.text = '';
      }
    }

    // giới han số lượng sách đc mượn
    void soLuongMax() {
      updateButtonState();
      try {
        updateButtonState();
        // Kiểm tra xem chuỗi nhập liệu có giá trị hay không
        if (so_luong_book_controller.text.isNotEmpty) {
          int? so_luong_con_lai = thu_vien
              .select_book(int.parse(id_book_controller.text))!
              .soLuongConLai();

          int? enteredQuantity = int.tryParse(so_luong_book_controller.text);

          // Kiểm tra giá trị nhập liệu có phải là số nguyên hay không
          if (enteredQuantity != null) {
            if (enteredQuantity > so_luong_con_lai!) {
              so_luong_book_controller.text = thu_vien
                  .select_book(int.parse(id_book_controller.text))!
                  .soLuongConLai()
                  .toString();
            }
          } else {
            // Xử lý khi giá trị nhập liệu không phải là số nguyên
            so_luong_book_controller.text = '';
          }
        }
      } catch (e) {
        // Xử lý khi xảy ra lỗi khác
        so_luong_book_controller.text = '';
      }
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Builder(
          builder: (context) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.8,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          keyboardType: TextInputType.number,
                          controller: id_sinhvien_controller,
                          decoration: InputDecoration(
                            labelText: "ID sinh viên",
                          ),
                          onChanged: (value) {
                            updateSinhvienDetails();
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: TextField(
                      controller: name_sv_controller,
                      decoration: InputDecoration(
                        labelText: "ten sinh vien",
                        // errorText: inputError['name'] ?? false
                        //     ? "Vui lòng nhập tên sách"
                        //     : null,
                      ),
                      enabled: false,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: TextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      keyboardType: TextInputType.number,
                      controller: khoa_controller,
                      decoration: InputDecoration(
                        labelText: "khoa",
                        // errorText: inputError['soluong'] ?? false
                        //     ? "Vui lòng nhập số lượng"
                        //     : null,
                      ),
                      enabled: false,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          keyboardType: TextInputType.number,
                          controller: id_book_controller,
                          decoration: InputDecoration(
                            labelText: "ID sach:",
                          ),
                          onChanged: (value) {
                            updateBookDetails();
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: TextField(
                      controller: name_book_controller,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: "ten sach:",
                        // errorText: inputError['name'] ?? false
                        //     ? "Vui lòng nhập tên sách"
                        //     : null,
                      ),
                      enabled: false,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: TextField(
                      controller: so_luong_book_controller,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "so luong muon:",
                        errorText: (() {
                          try {
                            int? bookId = int.tryParse(id_book_controller.text);
                            if (bookId != null) {
                              var selectedBook = thu_vien.select_book(bookId);

                              if (selectedBook != null) {
                                if (selectedBook.co_the_muon) {
                                  return "số lượng sách còn lại là ${selectedBook.soLuongConLai()}";
                                } else {
                                  return "Đã hết sách trong thư viện";
                                }
                              } else {
                                return "Không tìm thấy sách với ID này";
                              }
                            } else {
                              return "vui lòng nhâp id sách";
                            }
                          } catch (e) {
                            return "Đã xảy ra lỗi";
                          }
                        })(),
                        enabled: (() {
                          try {
                            int? bookId = int.tryParse(id_book_controller.text);
                            if (bookId != null) {
                              var selectedBook = thu_vien.select_book(bookId);
                              if (selectedBook != null) {
                                if (selectedBook.co_the_muon) {
                                  return true;
                                } else {
                                  return false;
                                }
                              } else {
                                return false;
                              }
                            } else {
                              return false;
                            }
                          } catch (e) {
                            return false;
                          }
                        })(),
                      ),
                      onChanged: (value) {
                        soLuongMax();
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: isButtonDisabled
                        ? null
                        : () {
                            thu_vien.addBorrowBooks(
                                int.parse(id_sinhvien_controller.text),
                                int.parse(id_book_controller.text),
                                int.parse(so_luong_book_controller.text));
                            Navigator.of(context).pop();
                            thu_vien.showSuccessMessage(context,
                                "sinh viên có có id ${id_sinhvien_controller.text} mượn sách thành công");
                            id_sinhvien_controller.text = name_sv_controller.text =
                                khoa_controller.text = id_book_controller.text =
                                    name_book_controller.text =
                                        so_luong_book_controller.text = "";
                          },
                    child: Text("mượn sách"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // throw UnimplementedError();
    return FloatingActionButton(
      onPressed: () {
        form_add_muon_sach(context);
      },
      child: Icon(Icons.add),
    );
  }
}

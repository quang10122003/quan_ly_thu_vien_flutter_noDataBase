import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:quan_ly_thu_vien_flutter/model/Quan_ly_thu_vien.dart';
import 'package:quan_ly_thu_vien_flutter/model/book.dart';

class Addbook extends StatelessWidget {
  Map<String, bool> inputError = {
    'id': false,
    'name': false,
    'soluong': false,
  };
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController soluongController = TextEditingController();

  void formAddBookformat(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Builder(
          builder: (context) {
            return Consumer<LibraryManager>(
              builder: (context, value, child) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: TextInputType.number,
                              controller: idController,
                              decoration: InputDecoration(
                                labelText: "ID sách",
                                errorText: inputError['id'] ?? false
                                    ? "Vui lòng nhập ID"
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: "Tên sách",
                            errorText: inputError['name'] ?? false
                                ? "Vui lòng nhập tên sách"
                                : null,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: TextField(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          keyboardType: TextInputType.number,
                          controller: soluongController,
                          decoration: InputDecoration(
                            labelText: "Số lượng",
                            errorText: inputError['soluong'] ?? false
                                ? "Vui lòng nhập số lượng"
                                : null,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          inputError['id'] = idController.text.isEmpty;
                          inputError['name'] = nameController.text.isEmpty;
                          inputError['soluong'] =
                              soluongController.text.isEmpty;

                          if (!(inputError['id'] ?? false) &&
                              !(inputError['name'] ?? false) &&
                              !(inputError['soluong'] ?? false)) {
                            Book newBook = Book(
                              id: int.parse(idController.text),
                              name_book: nameController.text,
                              so_luong: int.parse(soluongController.text),
                            );
                            Navigator.of(context).pop();
                            value.addBook(context, newBook);
                            idController.text = "";
                            nameController.text = "";
                            soluongController.text = "";
                          }
                          value.notifyListeners();
                        },
                        child: Text("Thêm sách vào thư viện"),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        formAddBookformat(context);
      },
      child: Icon(Icons.add),
    );
  }
}

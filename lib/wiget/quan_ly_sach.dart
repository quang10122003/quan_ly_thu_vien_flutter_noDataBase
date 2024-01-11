import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quan_ly_thu_vien/model/book.dart';
import 'package:quan_ly_thu_vien/model/trang_thi.dart';
import '../model/Quan_ly_thu_vien.dart';
import 'package:flutter/services.dart';

class Quan_ly_sach extends StatelessWidget {
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController soluongController = TextEditingController();

  Map<String, bool> inputError = {
    'id': false,
    'name': false,
    'soluong': false,
  };
  Map<String, bool> inputError2 = {
    'id': false,
    'name': false,
    'soluong': false,
  };

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
                                labelText: "id sách",
                                errorText:
                                    // nếu inputid = false tức là == null thì lấy giá trị flase, => biểu thức inputError['id'] ?? false ==true => errorText = "Vui lòng nhập ID" nếu inputid == true => biểu thức inputError['id'] ?? false == false => errorText = null
                                    inputError['id'] ?? false
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
                            labelText: "tên sách",
                            errorText:
                                // nếu inputid = false tức là == null thì lấy giá trị flase, => biểu thức inputError['id'] ?? false ==true => errorText = "Vui lòng nhập ID" nếu inputid == true => biểu thức inputError['id'] ?? false == false => errorText = null
                                inputError['name'] ?? false
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
                            labelText: "số lượng",
                            errorText:
                                // nếu inputid = false tức là == null thì lấy giá trị flase, => biểu thức inputError['id'] ?? false ==true => errorText = "Vui lòng nhập ID" nếu inputid == true => biểu thức inputError['id'] ?? false == false => errorText = null
                                inputError['soluong'] ?? false
                                    ? "Vui lòng nhập số lượng"
                                    : null,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Kiểm tra và cập nhật trạng thái inputError
                          // idController.text ko trống tức là inputError['id'] = true khác null
                          inputError['id'] = idController.text.isEmpty;
                          inputError['name'] = nameController.text.isEmpty;
                          inputError['soluong'] =
                              soluongController.text.isEmpty;
                          // nếu inputError['id'] = true tức là khác null v.v thì thì inputError['id'] ?? false == false (!inputError['id'] ?? false) == true
                          if (!(inputError['id'] ?? false) &&
                              !(inputError['name'] ?? false) &&
                              !(inputError['soluong'] ?? false)) {
                            // Nếu không có lỗi, thực hiện hàm addBook
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
                          // Thông báo cho người nghe sau khi dữ liệu đã được cập nhật
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

  void editBookformat(BuildContext context, int index) {
    TextEditingController idEditcontroler = TextEditingController();
    TextEditingController nameEditcontroler = TextEditingController();
    TextEditingController soluongEditcontroler = TextEditingController();

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Builder(builder: (context) {
            return Consumer<LibraryManager>(
              builder: (context, value, child) {
                // gán giá trị mặc định cho editting controller
                idEditcontroler.text = value.listBook[index].id.toString();
                nameEditcontroler.text =
                    value.listBook[index].name_book.toString();
                soluongEditcontroler.text =
                    value.listBook[index].so_luong.toString();
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
                              controller: idEditcontroler,
                              decoration: InputDecoration(
                                labelText: "id sách",
                                errorText:
                                    // nếu inputid = false tức là == null thì lấy giá trị flase, => biểu thức inputError['id'] ?? false ==true => errorText = "Vui lòng nhập ID" nếu inputid == true => biểu thức inputError['id'] ?? false == false => errorText = null
                                    inputError2['id'] ?? false
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
                          controller: nameEditcontroler,
                          decoration: InputDecoration(
                            labelText: "tên sách",
                            errorText:
                                // nếu inputid = false tức là == null thì lấy giá trị flase, => biểu thức inputError['id'] ?? false ==true => errorText = "Vui lòng nhập ID" nếu inputid == true => biểu thức inputError['id'] ?? false == false => errorText = null
                                inputError2['name'] ?? false
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
                          controller: soluongEditcontroler,
                          decoration: InputDecoration(
                            labelText: "số lượng",
                            errorText:
                                // nếu inputid = false tức là == null thì lấy giá trị flase, => biểu thức inputError['id'] ?? false ==true => errorText = "Vui lòng nhập ID" nếu inputid == true => biểu thức inputError['id'] ?? false == false => errorText = null
                                inputError2['soluong'] ?? false
                                    ? "Vui lòng nhập số lượng"
                                    : null,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Kiểm tra và cập nhật trạng thái inputError
                              // idController.text ko trống tức là inputError['id'] = true khác null
                              inputError2['id'] = idEditcontroler.text.isEmpty;
                              inputError2['name'] =
                                  nameEditcontroler.text.isEmpty;
                              inputError2['soluong'] =
                                  soluongEditcontroler.text.isEmpty;
                              // nếu inputError['id'] = true tức là khác null v.v thì thì inputError['id'] ?? false == false (!inputError['id'] ?? false) == true
                              // Kiểm tra nếu giá trị của TextEditingController không thay đổi
                              bool idNotChanged = idEditcontroler.text ==
                                  "${value.listBook[index].id}";
                              bool nameNotChanged = nameEditcontroler.text ==
                                  "${value.listBook[index].name_book}";
                              bool soluongNotChanged =
                                  soluongEditcontroler.text ==
                                      "${value.listBook[index].so_luong}";
                              if (idNotChanged &&
                                  nameNotChanged &&
                                  soluongNotChanged) {
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "vui lòng thay đổi thông tin")));
                                // kiểm tra có ít nhất 1 trường thông tin tay đổi và k trường thông tin nào trống
                              } else if ((idNotChanged ||
                                      nameNotChanged ||
                                      soluongNotChanged) &&
                                  !(inputError2['id'] ?? false) &&
                                  !(inputError2['name'] ?? false) &&
                                  !(inputError2['soluong'] ?? false)) {
                                // Nếu không có lỗi, thực hiện hàm edit
                                Book book = Book(
                                    id: int.parse(idEditcontroler.text),
                                    name_book: '${nameEditcontroler.text}',
                                    so_luong:
                                        int.parse(soluongEditcontroler.text));
                                value.editBook(context, index, book);
                                Navigator.of(context).pop();
                              }
                              // Thông báo cho người nghe sau khi dữ liệu đã được cập nhật
                              value.notifyListeners();
                            },
                            child: Text("Sửa"),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Hủy"))
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final thu_vien = Provider.of<LibraryManager>(context);
    return Scaffold(
      appBar: AppBar(title: Text("quan_ly_sach")),
      body: SafeArea(
        minimum: const EdgeInsets.only(right: 20, left: 20),
        child: Container(
          margin: EdgeInsets.only(top: 10),
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: thu_vien.listBook.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      color: (index) % 2 == 0 ? Colors.blue : Colors.red,
                      child: ListTile(
                        leading: Icon(Icons.menu_book_outlined),
                        title: Text(
                          "Tên sách: ${thu_vien.listBook[index].name_book}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "ID: ${thu_vien.listBook[index].id}",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              "Số lượng: ${thu_vien.listBook[index].so_luong}",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        onTap: () {
                          SnackBar snackBar = SnackBar(
                            content: Column(
                              children: [
                                Text("ID: ${thu_vien.listBook[index].id}"),
                                Text(
                                    "ID: ${thu_vien.listBook[index].name_book}"),
                                Text(
                                    "ID: ${thu_vien.listBook[index].so_luong}"),
                              ],
                            ),
                            duration: Duration(seconds: 3),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        trailing: PopupMenuButton<String>(
                          onSelected: (value) {
                            switch (value) {
                              case 'edit':
                                editBookformat(context, index);
                                break;
                              case 'delete':
                                thu_vien.deleteBook(context, index);
                                break;
                            }
                          },
                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem<String>(
                                value: 'edit',
                                child: Text('Sửa'),
                              ),
                              PopupMenuItem<String>(
                                value: 'delete',
                                child: Text('Xóa'),
                              ),
                            ];
                          },
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          formAddBookformat(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

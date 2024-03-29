import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quan_ly_thu_vien_flutter/model/Quan_ly_thu_vien.dart';
import 'package:quan_ly_thu_vien_flutter/model/book.dart';
import 'package:quan_ly_thu_vien_flutter/model/trang_thai.dart';

class editBook extends StatelessWidget {
  var index;
  editBook(this.index);
  Map<String, bool> inputError2 = {
    'id': false,
    'name': false,
    'soluong': false,
  };
  void editBookformat(BuildContext context, int index) {
    TextEditingController idEditcontroler = TextEditingController();
    TextEditingController nameEditcontroler = TextEditingController();
    TextEditingController soluongEditcontroler = TextEditingController();
    final setting = Provider.of<Trang_thai>(context, listen: false);
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
                                labelText: setting.getlanguage() == 'Vietnamese'
                                    ? "ID sách"
                                    : "Book id",
                                labelStyle: TextStyle(
                                    fontSize: (() {
                                  try {
                                    if (setting.getfontsize1() == "nhỏ") {
                                      return 16.0;
                                    } else if (setting.getfontsize1() ==
                                        "vừa") {
                                      return 18.0;
                                    } else {
                                      return 20.0;
                                    }
                                  } catch (e) {
                                    return 16.0;
                                  }
                                }())),
                                errorText: inputError2['id'] ?? false
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
                            labelText: setting.getlanguage() == 'Vietnamese'
                                ? "Tên sách"
                                : "Name book",
                            labelStyle: TextStyle(
                                fontSize: (() {
                              try {
                                if (setting.getfontsize1() == "nhỏ") {
                                  return 16.0;
                                } else if (setting.getfontsize1() == "vừa") {
                                  return 18.0;
                                } else {
                                  return 20.0;
                                }
                              } catch (e) {
                                return 16.0;
                              }
                            }())),
                            errorText: inputError2['name'] ?? false
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
                            labelText: setting.getlanguage() == 'Vietnamese'
                                ? "Số lượng"
                                : "Quantity",
                            labelStyle: TextStyle(
                                fontSize: (() {
                              try {
                                if (setting.getfontsize1() == "nhỏ") {
                                  return 16.0;
                                } else if (setting.getfontsize1() == "vừa") {
                                  return 18.0;
                                } else {
                                  return 20.0;
                                }
                              } catch (e) {
                                return 16.0;
                              }
                            }())),
                            errorText: inputError2['soluong'] ?? false
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
                                inputError2['id'] =
                                    idEditcontroler.text.isEmpty;
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
                                Book book = Book(
                                  id: int.parse(idEditcontroler.text),
                                  name_book: '${nameEditcontroler.text}',
                                  so_luong:
                                      int.parse(soluongEditcontroler.text),
                                  so_luong_da_muon:
                                      value.listBook[index].so_luong_da_muon,
                                );
                                if (idNotChanged &&
                                    nameNotChanged &&
                                    soluongNotChanged) {
                                  Navigator.of(context).pop();
                                  value.showErrorDialog(
                                      context, "vui lòng thay đổi thông tin");
                                  // kiểm tra có ít nhất 1 trường thông tin tay đổi và k trường thông tin nào trống
                                } else if ((idNotChanged ||
                                        nameNotChanged ||
                                        soluongNotChanged) &&
                                    !(inputError2['id'] ?? false) &&
                                    !(inputError2['name'] ?? false) &&
                                    !(inputError2['soluong'] ?? false) &&
                                    (book.so_luong_da_muon <=
                                        int.parse(soluongEditcontroler.text))) {
                                  if (value
                                          .select_book(
                                              int.parse(idEditcontroler.text))
                                          ?.id !=
                                      null) {
                                    Navigator.of(context).pop();
                                    value.showErrorDialog(context,
                                        "id đã tồn tại vui lòng thử lại ");
                                  } else if (value.listBook[index].id !=
                                          int.parse(idEditcontroler.text) &&
                                      value.listBook[index].so_luong_da_muon !=
                                          0) {
                                    value.showErrorDialog(context,
                                        'sách có người mượn ko thể thay đổi thông tin');
                                  } else {
                                    Navigator.of(context).pop();
                                    value.editBook(context, index, book);
                                  }
                                  // Nếu không có lỗi, thực hiện hàm edit
                                } else {
                                  Navigator.of(context).pop();
                                  value.showErrorDialog(context,
                                      "số lượng sách đã mượn =${value.listBook[index].so_luong_da_muon} tổng sách ko thể nhỏ hơn");
                                }
                                // Thông báo cho người nghe sau khi dữ liệu đã được cập nhật
                                value.notifyListeners();
                              },
                              child: Text(
                                setting.getlanguage() == 'Vietnamese'
                                    ? "Sửa thông tin sách"
                                    : "Edit book information",
                                style: TextStyle(fontSize: (() {
                                  try {
                                    if (setting.getfontsize1() == "nhỏ") {
                                      return 16.0;
                                    } else if (setting.getfontsize1() ==
                                        "vừa") {
                                      return 18.0;
                                    } else {
                                      return 20.0;
                                    }
                                  } catch (e) {
                                    return 16.0;
                                  }
                                })()),
                              )),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                setting.getlanguage() == 'Vietnamese'
                                    ? "Hủy"
                                    : "Cancel",
                                style: TextStyle(fontSize: (() {
                                  try {
                                    if (setting.getfontsize1() == "nhỏ") {
                                      return 16.0;
                                    } else if (setting.getfontsize1() ==
                                        "vừa") {
                                      return 18.0;
                                    } else {
                                      return 19.0;
                                    }
                                  } catch (e) {
                                    return 16.0;
                                  }
                                })()),
                              )),
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
    // TODO: implement build
    // throw UnimplementedError();
    final thu_vien = Provider.of<LibraryManager>(context);
    final setting = Provider.of<Trang_thai>(context);
    return PopupMenuButton<String>(
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
            child: Text((() {
              if (setting.getlanguage() == "Vietnamese") {
                return "sửa";
              } else {
                return "edit";
              }
            })()),
          ),
          PopupMenuItem<String>(
            value: 'delete',
            child: Text((() {
              if (setting.getlanguage() == "Vietnamese") {
                return "xóa";
              } else {
                return "delete";
              }
            })()),
          ),
        ];
      },
    );
  }
}

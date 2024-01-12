import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quan_ly_thu_vien_flutter/model/trang_thai.dart';
import 'package:quan_ly_thu_vien_flutter/model/Quan_ly_thu_vien.dart';
import 'package:flutter/services.dart';
import 'package:quan_ly_thu_vien_flutter/wiget/component/Component.dart';
import 'package:quan_ly_thu_vien_flutter/wiget/quan_ly_sach_form/edit_book_from.dart';
import 'package:quan_ly_thu_vien_flutter/wiget/quan_ly_sach_form/form_add_book.dart';

class Quan_ly_sach_form extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final thu_vien = Provider.of<LibraryManager>(context);
    return Scaffold(
      appBar: buildAppBar(context),
      body: SafeArea(
        minimum: const EdgeInsets.only(right: 20, left: 20),
        child: Container(
          margin: EdgeInsets.only(top: 10),
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              buildNavButton(),
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
                        trailing: editBook(index),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Addbook(),
    );
  }
}

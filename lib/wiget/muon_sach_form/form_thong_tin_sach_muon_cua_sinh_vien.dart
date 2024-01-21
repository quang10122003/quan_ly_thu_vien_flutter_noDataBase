import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quan_ly_thu_vien_flutter/model/Quan_ly_thu_vien.dart';
import 'package:quan_ly_thu_vien_flutter/model/sach_muon.dart';
import 'package:quan_ly_thu_vien_flutter/model/trang_thai.dart';

class BorrowBooksScreen extends StatelessWidget {
  final List<BorrowBooks>? borrowBooks;
  int id_sinh_vien;
  BorrowBooksScreen({required this.borrowBooks, required this.id_sinh_vien});
  @override
  Widget build(BuildContext context) {
    final thu_vien = Provider.of<LibraryManager>(context);
    final setting = Provider.of<Trang_thai>(context);
    return Scaffold(
      appBar: AppBar(
          flexibleSpace: Container(
        padding: EdgeInsets.only(left: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              setting.getlanguage() == 'Vietnamese'
                  ? 'Sách mượn của sinh viên'
                  : 'Books borrowed from students',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
              ),
            ),
            Text(
              '${thu_vien.select_sinhvien(id_sinh_vien)!.name_sinh_vien}',
              style: TextStyle(
                fontSize: 20.0, // Kích thước chữ mặc định
                // Độ đậm của chữ mặc định
                color: Colors.black, // Màu chữ mặc định
              ),
            )
          ],
        ),
      )),
      body: SafeArea(
        minimum: const EdgeInsets.only(right: 20, left: 20),
        child: ListView.builder(
          itemCount: borrowBooks!.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              color: (index) % 2 == 0 ? Colors.blue : Colors.red,
              child: ListTile(
                leading: Icon(Icons.menu_book_outlined),
                title:
                    // Text(
                    //   "id sách:${borrowBooks![index].id_book_muon}",
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //     fontSize: 17,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    Text(
                  setting.getlanguage() == 'Vietnamese'
                      ? "ID sách: ${borrowBooks![index].id_book_muon}"
                      : "Book ID: ${borrowBooks![index].id_book_muon}",
                  style: TextStyle(
                    fontSize: (() {
                      try {
                        if (setting.getfontsize1() == "nhỏ") {
                          return 17.0;
                        } else if (setting.getfontsize1() == "vừa") {
                          return 19.0;
                        } else {
                          return 21.0;
                        }
                      } catch (e) {
                        return 16.0;
                      }
                    })(),
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   "tên sách: ${thu_vien.select_book(borrowBooks![index].id_book_muon)!.name_book}",
                    //   style: TextStyle(color: Colors.white),
                    // ),
                    Text(
                      setting.getlanguage() == 'Vietnamese'
                          ? "Tên sách: ${thu_vien.select_book(borrowBooks![index].id_book_muon)!.name_book}"
                          : "Book name: ${thu_vien.select_book(borrowBooks![index].id_book_muon)!.name_book}",
                      style: TextStyle(
                        fontSize: (() {
                          try {
                            if (setting.getfontsize1() == "nhỏ") {
                              return 15.0;
                            } else if (setting.getfontsize1() == "vừa") {
                              return 17.0;
                            } else {
                              return 19.0;
                            }
                          } catch (e) {
                            return 16.0;
                          }
                        })(),
                        color: Colors.white,
                      ),
                    ),
                    // Text(
                    //   "số lượng mượn: ${borrowBooks![index].so_luong_sach_muon}",
                    //   style: TextStyle(color: Colors.white),
                    // ),
                    Text(
                      setting.getlanguage() == 'Vietnamese'
                          ? "Số lượng mượn: ${borrowBooks![index].so_luong_sach_muon}"
                          : "Borrowed quantity: ${borrowBooks![index].so_luong_sach_muon}",
                      style: TextStyle(
                        fontSize: (() {
                          try {
                            if (setting.getfontsize1() == "nhỏ") {
                              return 15.0;
                            } else if (setting.getfontsize1() == "vừa") {
                              return 17.0;
                            } else {
                              return 19.0;
                            }
                          } catch (e) {
                            return 16.0;
                          }
                        })(),
                        color: Colors.white,
                      ),
                    ),
                    // Text(
                    //   "thời gian mượn: ${DateFormat('dd-MM-yyyy HH:mm').format(borrowBooks![index].time_muon_sach)}",
                    //   style: TextStyle(color: Colors.white),
                    // ),
                    Text(
                      setting.getlanguage() == 'Vietnamese'
                          ? "Thời gian mượn: ${DateFormat('dd-MM-yyyy HH:mm').format(borrowBooks![index].time_muon_sach)}"
                          : "Borrowed time: ${DateFormat('dd-MM-yyyy HH:mm').format(borrowBooks![index].time_muon_sach)}",
                      style: TextStyle(
                        fontSize: (() {
                          try {
                            if (setting.getfontsize1() == "nhỏ") {
                              return 15.0;
                            } else if (setting.getfontsize1() == "vừa") {
                              return 17.0;
                            } else {
                              return 19.0;
                            }
                          } catch (e) {
                            return 16.0;
                          }
                        })(),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

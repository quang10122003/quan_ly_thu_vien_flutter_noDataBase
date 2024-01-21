import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quan_ly_thu_vien_flutter/model/Quan_ly_thu_vien.dart';
import 'package:quan_ly_thu_vien_flutter/model/sach_muon.dart';
import 'package:quan_ly_thu_vien_flutter/model/trang_thai.dart';
import 'package:quan_ly_thu_vien_flutter/wiget/component/Component.dart';

class Tra_sach extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final thu_vien = Provider.of<LibraryManager>(context);
    List<int> all_sinh_vien = thu_vien.quan_ly_muon.keys.toList();
    final setting = Provider.of<Trang_thai>(context);
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
                  itemCount: all_sinh_vien.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      color: (index) % 2 == 0 ? Colors.blue : Colors.red,
                      child: ListTile(
                        leading: Icon(Icons.account_box_rounded),
                        title:
                            // Text(
                            //   "id sinh viên: ${thu_vien.select_sinhvien(all_sinh_vien[index])!.id_sinh_vien}",
                            //   style: TextStyle(
                            //     color: Colors.white,
                            //     fontSize: 17,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                            Text(
                          setting.getlanguage() == 'Vietnamese'
                              ? "ID sinh viên: ${thu_vien.select_sinhvien(all_sinh_vien[index])!.id_sinh_vien}"
                              : "Student ID: ${thu_vien.select_sinhvien(all_sinh_vien[index])!.id_sinh_vien}",
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
                            //   "tên sinh viên: ${thu_vien.select_sinhvien(all_sinh_vien[index])!.name_sinh_vien}",
                            //   style: TextStyle(color: Colors.white),
                            // ),
                            Text(
                              setting.getlanguage() == 'Vietnamese'
                                  ? "Tên sinh viên: ${thu_vien.select_sinhvien(all_sinh_vien[index])!.name_sinh_vien}"
                                  : "Student name: ${thu_vien.select_sinhvien(all_sinh_vien[index])!.name_sinh_vien}",
                              style: TextStyle(
                                fontSize: (() {
                                  try {
                                    if (setting.getfontsize1() == "nhỏ") {
                                      return 15.0;
                                    } else if (setting.getfontsize1() ==
                                        "vừa") {
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
                            //   "khoa: ${thu_vien.select_sinhvien(all_sinh_vien[index])!.khoa}",
                            //   style: TextStyle(color: Colors.white),
                            // ),
                            Text(
                              setting.getlanguage() == 'Vietnamese'
                                  ? "Khoa: ${thu_vien.select_sinhvien(all_sinh_vien[index])!.khoa}"
                                  : "Department: ${thu_vien.select_sinhvien(all_sinh_vien[index])!.khoa}",
                              style: TextStyle(
                                fontSize: (() {
                                  try {
                                    if (setting.getfontsize1() == "nhỏ") {
                                      return 15.0;
                                    } else if (setting.getfontsize1() ==
                                        "vừa") {
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
                        onTap: () {},
                        trailing: ElevatedButton(
                          style: ButtonStyle(maximumSize: MaterialStateProperty.all(Size(100, 50))),
                          child: Text(
                            setting.getlanguage() == 'Vietnamese'
                                ? "Trả sách"
                                : "Give book",
                            style: TextStyle(fontSize: 16),
                          ),
                          onPressed: () {
                            thu_vien.tra_sach(all_sinh_vien[index]);
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
    );
  }
}

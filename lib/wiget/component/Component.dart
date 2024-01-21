import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quan_ly_thu_vien_flutter/model/trang_thai.dart';

// app bar
PreferredSizeWidget buildAppBar(BuildContext context) {
  final setting = Provider.of<Trang_thai>(context);
  return AppBar(
    title: Text((() {
      try {
        if (setting.getlanguage() == "Vietnamese") {
          return "quản lý sinh viên";
        } else {
          return 'student management';
        }
      } catch (e) {
        return "loi";
      }
    })(),
        style: TextStyle(
            fontSize: (() {
          try {
            if (setting.getfontsize1() == "nhỏ") {
              return 22.0;
            } else if (setting.getfontsize1() == "vừa") {
              return 25.0;
            } else {
              return 27.0;
            }
          } catch (e) {
            return 16.0;
          }
        }()))),
    actions: [
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          // Xử lý khi người dùng nhấn nút tìm kiếm
        },
      ),
      IconButton(
        icon: Icon(Icons.settings),
        onPressed: () {
          Navigator.of(context).pushNamed('/setting');
        },
      ),
      // Thêm các icon hoặc chức năng khác ở đây
    ],
  );
}

// thanh điều hướng app
class buildNavButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final setting = Provider.of<Trang_thai>(context);
    // TODO: implement build
    // throw UnimplementedError();
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).popAndPushNamed("/");
                },
                child: Text(
                  (() {
                    try {
                      if (setting.getlanguage() == "Vietnamese") {
                        return "Quản lý sách";
                      } else {
                        return 'Book management';
                      }
                    } catch (e) {
                      return "loi";
                    }
                  })(),
                  style: TextStyle(fontSize: (() {
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
                  })()),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  // Xử lý khi người dùng nhấn nút mượn sách
                  Navigator.of(context).popAndPushNamed("/muon_sach");
                },
                child: Text(
                  (() {
                    try {
                      if (setting.getlanguage() == "Vietnamese") {
                        return "Mượn sách";
                      } else {
                        return 'Borrow books';
                      }
                    } catch (e) {
                      return "loi";
                    }
                  })(),
                  style: TextStyle(fontSize: (() {
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
                  })()),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  // Xử lý khi người dùng nhấn nút trả sách
                  Navigator.of(context).popAndPushNamed('/tra_sach');
                },
                child: Text(
                  (() {
                    try {
                      if (setting.getlanguage() == "Vietnamese") {
                        return "Trả sách";
                      } else {
                        return 'Give book back';
                      }
                    } catch (e) {
                      return "loi";
                    }
                  })(),
                  style: TextStyle(fontSize: (() {
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
                  })()),
                ),
              ),
              SizedBox(
                width: 15,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

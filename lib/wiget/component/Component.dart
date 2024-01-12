import 'package:flutter/material.dart';

// app bar
PreferredSizeWidget buildAppBar(BuildContext context) {
  return AppBar(
    title: Text("quan_ly_sach"),
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
                child: Text("Quản lý sách"),
              ),
              SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  // Xử lý khi người dùng nhấn nút mượn sách
                  Navigator.of(context).popAndPushNamed("/muon_sach");
                },
                child: Text("Mượn sách"),
              ),
              SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  // Xử lý khi người dùng nhấn nút trả sách
                  Navigator.of(context).popAndPushNamed('/tra_sach');
                },
                child: Text("Trả sách"),
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

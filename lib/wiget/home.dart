  import 'package:flutter/material.dart';
  import 'package:provider/provider.dart';
  import '../model/trang_thi.dart';

  class Home_Page extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text("Quản lý thư viện")),
        body:  Column(
            children: [
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("/quan_ly_sach");
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Đặt thành 0 để có nút vuông
                        ),
                        backgroundColor: Colors.white,
                        fixedSize: Size.fromWidth(
                            130) // Đặt màu nền của nút là trong suốt
                        ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "images/quan_ly_thu_vien.webp",
                          height:
                              50, // Điều chỉnh chiều cao để làm cho hình ảnh nhỏ hơn
                        ),
                        Text(
                          "Quản lý sách thư viện",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
      );
    }
  }

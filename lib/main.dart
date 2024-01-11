import 'package:flutter/material.dart';
import 'package:quan_ly_thu_vien/model/Quan_ly_thu_vien.dart';
import 'package:quan_ly_thu_vien/model/trang_thi.dart';
import 'package:quan_ly_thu_vien/wiget/quan_ly_sach.dart';
import './wiget/home.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // throw UnimplementedError();
     return MultiProvider(providers: [
      ChangeNotifierProvider<LibraryManager>(create: (context)=>LibraryManager()),
      ChangeNotifierProvider<Trang_thai>(create: (context)=>Trang_thai())
    ],
    child: MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Home_Page(),
        '/quan_ly_sach': (context) => Quan_ly_sach()
      },
    ),);
  }
}

void main() {
  runApp(MyApp());
}

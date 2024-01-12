import 'package:flutter/material.dart';
import 'package:quan_ly_thu_vien_flutter/wiget/setting_form/setting.dart';
import 'package:quan_ly_thu_vien_flutter/wiget/tra_sach_form/tra_sach.dart';
import './model/Quan_ly_thu_vien.dart';
import './model/trang_thai.dart';
import './wiget/quan_ly_sach_form/quan_ly_sach_form.dart';
import 'package:provider/provider.dart';
import './wiget/muon_sach_form/muon_sach.dart';

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
        '/': (context) => Quan_ly_sach_form(),
        // '/muon_sach': (context) => Muon_sach(),
        // '/tra_sach':(context) => Tra_sach(),
        '/setting':(context) => Setting(),
      },
    ),);
  }
}

void main() {
  runApp(MyApp());
}

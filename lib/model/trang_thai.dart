import 'package:flutter/material.dart';

class Trang_thai extends ChangeNotifier {
  static List<String> languageList = <String>["Vietnamese", "English"];
  String Language = "Vietnamese";

  void setLanguage(String language) {
    Language = language;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  String getlanguage() {
    return Language;
  }

  static List<String> Co_chu_Vietnamese = <String>["nhỏ", "vừa", "lớn"];
  static List<String> Co_chu_English = <String>["low ", "medium", "high"];
  String co_chu = "nhỏ";
  String co_chu2 = "low";

  void setfontsize1(String font1) {
    co_chu = font1;
    // hàm call back sử dụng nó để trì hoãn việc gọi notifyListeners() cho đến sau khi frame hiện tại đã được xây dựng.
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  String getfontsize1() {
    return co_chu;
  }

  void setfontsize2(String font2) {
    co_chu2 = font2;
    // hàm call back sử dụng nó để trì hoãn việc gọi notifyListeners() cho đến sau khi frame hiện tại đã được xây dựng.
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  String getfontsize2() {
    return co_chu2;
  }
}

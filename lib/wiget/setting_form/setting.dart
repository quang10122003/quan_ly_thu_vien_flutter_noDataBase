import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quan_ly_thu_vien_flutter/model/trang_thai.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final setting = Provider.of<Trang_thai>(context);

    return Scaffold(
      appBar: AppBar(
          title: Text(
              setting.getlanguage() == 'Vietnamese' ? "Cài đặt" : "Setting", style: TextStyle(
                      fontSize: (() {
                    try {
                      if (setting.getfontsize1() == "nhỏ") {
                        return 24.0;
                      } else if (setting.getfontsize1() == "vừa") {
                        return 26.0;
                      } else {
                        return 28.0;
                      }
                    } catch (e) {
                      return 16.0;
                    }
                  }())),)),
      body: SafeArea(
        minimum: const EdgeInsets.only(right: 20, left: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  (() {
                    try {
                      if (setting.getlanguage() == "Vietnamese") {
                        return "Cài đặt";
                      } else {
                        return "Setting";
                      }
                    } catch (e) {
                      return "Lỗi";
                    }
                  })(),
                  style: TextStyle(
                      fontSize: (() {
                    try {
                      if (setting.getfontsize1() == "nhỏ") {
                        return 18.0;
                      } else if (setting.getfontsize1() == "vừa") {
                        return 20.0;
                      } else {
                        return 22.0;
                      }
                    } catch (e) {
                      return 16.0;
                    }
                  }())),
                ),
                DropdownButton<String>(
                  value: setting.getlanguage(),
                  items: Trang_thai.languageList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? language) {
                    setting.setLanguage(language!);
                  },
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  (() {
                    try {
                      if (setting.getlanguage() == "Vietnamese") {
                        return "Cỡ chữ";
                      } else {
                        return "Font size";
                      }
                    } catch (e) {
                      return "Lỗi";
                    }
                  })(), style: TextStyle(
                      fontSize: (() {
                    try {
                      if (setting.getfontsize1() == "nhỏ") {
                        return 18.0;
                      } else if (setting.getfontsize1() == "vừa") {
                        return 20.0;
                      } else {
                        return 22.0;
                      }
                    } catch (e) {
                      return 16.0;
                    }
                  }())),
                ),
                DropdownButton<String>(
                  value: (() {
                    try {
                      if (setting.getlanguage() == "Vietnamese") {
                        String currentFontSize = setting.getfontsize1();

                        // Kiểm tra xem giá trị hiện tại có tồn tại trong danh sách mới không
                        if (Trang_thai.Co_chu_Vietnamese.indexOf(
                                currentFontSize) ==
                            -1) {
                          currentFontSize = Trang_thai.Co_chu_Vietnamese.first;
                          setting.setfontsize1(currentFontSize);
                        }

                        return currentFontSize;
                      } else {
                        String currentFontSize = setting.getfontsize2();

                        // Kiểm tra xem giá trị hiện tại có tồn tại trong danh sách mới không
                        if (Trang_thai.Co_chu_English.indexOf(
                                currentFontSize) ==
                            -1) {
                          currentFontSize = Trang_thai.Co_chu_English.first;
                          setting.setfontsize2(currentFontSize);
                        }

                        return currentFontSize;
                      }
                    } catch (e) {
                      return null;
                    }
                  })(),
                  items: (() {
                    try {
                      if (setting.getlanguage() == "Vietnamese") {
                        return Trang_thai.Co_chu_Vietnamese.map<
                            DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList();
                      } else {
                        return Trang_thai.Co_chu_English.map<
                            DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList();
                      }
                    } catch (e) {
                      return null;
                    }
                  })(),
                  onChanged: (String? fontSize) {
                    if (setting.getlanguage() == "Vietnamese") {
                      setting.setfontsize1(fontSize!);
                      // chỉnh cho 2 fon_size 2 ngôn ngữ cái đồng bộ
                      setting.setfontsize2(Trang_thai.Co_chu_English[
                          Trang_thai.Co_chu_Vietnamese.indexOf(fontSize)]);
                    } else {
                      setting.setfontsize2(fontSize!);
                      // chỉnh cho 2 fon_size 2 ngôn ngữ cái đồng bộ
                      setting.setfontsize1(Trang_thai.Co_chu_Vietnamese[
                          Trang_thai.Co_chu_English.indexOf(fontSize)]);
                    }
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

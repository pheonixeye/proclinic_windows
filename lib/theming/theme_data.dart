import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'theme_config.dart';

class ThemeChanger with ChangeNotifier {
  static bool isDark = true;

  ThemeChanger() {
    if (box.containsKey('themestore')) {
      isDark = box.get('themestore');
    } else {
      box.put('themestore', isDark);
    }
  }

  ThemeMode currentTheme() {
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void switchTheme() {
    isDark = !isDark;
    box.put('themestore', isDark);
    notifyListeners();
  }
}

ThemeData modedDarkTheme = ThemeData.light().copyWith(
    primaryColor: Colors.grey,
    accentColor: Colors.red,
    textTheme: TextTheme(
      headline6: TextStyle(color: Colors.black87),
      headline5: TextStyle(color: Colors.black87),
      headline4: TextStyle(color: Colors.black87),
      headline3: TextStyle(color: Colors.black87),
      headline2: TextStyle(color: Colors.black87),
      headline1: TextStyle(color: Colors.black87),
      subtitle2: TextStyle(color: Colors.black87),
      subtitle1: TextStyle(color: Colors.black87),
      bodyText1: TextStyle(color: Colors.black87),
      bodyText2: TextStyle(color: Colors.black87),
    ),
    appBarTheme: AppBarTheme(color: Colors.grey[700]));

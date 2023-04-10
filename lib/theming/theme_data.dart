import 'package:flutter/material.dart';
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
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: Colors.black87),
      headlineSmall: TextStyle(color: Colors.black87),
      headlineMedium: TextStyle(color: Colors.black87),
      displaySmall: TextStyle(color: Colors.black87),
      displayMedium: TextStyle(color: Colors.black87),
      displayLarge: TextStyle(color: Colors.black87),
      titleSmall: TextStyle(color: Colors.black87),
      titleMedium: TextStyle(color: Colors.black87),
      bodyLarge: TextStyle(color: Colors.black87),
      bodyMedium: TextStyle(color: Colors.black87),
    ),
    appBarTheme: AppBarTheme(color: Colors.grey[700]),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.red));

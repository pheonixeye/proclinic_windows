// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';

class BookKeepingProvider extends ChangeNotifier {
  int _allOrOne = 0;
  int get allOrOne => _allOrOne;

  void setAllOrOne(int val) {
    _allOrOne = val;
    notifyListeners();
  }

  int _dayDuration = 0;
  int get dayDuration => _dayDuration;

  void setDayDuration(int val) {
    _dayDuration = val;
    notifyListeners();
  }

  int _day = DateTime.now().day;
  int get day => _day;

  void adjustDay(int val) {
    _day = val;
    notifyListeners();
  }

  int _month = DateTime.now().month;
  int get month => _month;

  void adjustMonth(int val) {
    _month = val;
    notifyListeners();
  }

  int _year = DateTime.now().year;
  int get year => _year;

  void adjustYear(int val) {
    _year = val;
    notifyListeners();
  }
}

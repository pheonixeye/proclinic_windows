// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:proclinic_windows/_const/_strings.dart';

class BookKeepingProvider extends ChangeNotifier {
  int? _allOrOne;
  int? get allOrOne => _allOrOne;

  void setAllOrOne(int? val) {
    _allOrOne = val;
    notifyListeners();
  }

  int? _dayDuration;
  int? get dayDuration => _dayDuration;

  void setDayDuration(int? val) {
    _dayDuration = val;
    notifyListeners();
  }

  int _day = DAYS[0];
  int get day => _day;

  void adjustDay(int val) {
    _day = DAYS[val];
    notifyListeners();
  }

  int _month = MONTHS[0];
  int get month => _month;

  void adjustMonth(int val) {
    _month = MONTHS[val];
    notifyListeners();
  }

  int _year = YEARS[0];
  int get year => _year;

  void adjustYear(int val) {
    _year = YEARS[val];
    notifyListeners();
  }
}

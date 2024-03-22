import 'package:flutter/cupertino.dart';

class SearchValueProvider extends ChangeNotifier {
  int _groupValue = 0;
  int get groupValue => _groupValue;

  void adjust(int val) {
    _groupValue = val;
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

  String? _phone;
  String? get phone => _phone;

  void adjustPhone(String val) {
    _phone = val;
    notifyListeners();
  }
}

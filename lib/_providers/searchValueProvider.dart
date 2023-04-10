import 'package:flutter/cupertino.dart';
import 'package:proclinic_windows/_const/_strings.dart';

class SearchValueProvider extends ChangeNotifier {
  int _groupValue = 0;
  int get groupValue => _groupValue;

  void adjust(int val) {
    _groupValue = val;
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

  String? _phone;
  String? get phone => _phone;

  void adjustPhone(String val) {
    _phone = val;
    notifyListeners();
  }
}

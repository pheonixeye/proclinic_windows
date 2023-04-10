// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';

class ProcedureVisibilityProvider extends ChangeNotifier {
  bool _visible = false;
  bool get visible => _visible;

  void showProcPicker() {
    _visible = true;
    notifyListeners();
  }

  void hideProcPicker() {
    _visible = false;
    notifyListeners();
  }
}

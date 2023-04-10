import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';
import 'package:proclinic_windows/_const/_strings.dart';

class SettingsProvider extends ChangeNotifier {
  String? _dbpath;
  String? _printfilepath;
  String? _scanscriptpath;

  String? get dbpath => _dbpath;
  String? get printfilepath => _printfilepath;
  String? get scanscriptpath => _scanscriptpath;

  Future setDbPath() async {
    final LocalStorage _storagedb = LocalStorage('$DBPATH.json');
    await _storagedb.ready;
    _dbpath = await _storagedb.getItem(DBPATH);
    notifyListeners();
  }

  Future setPrintFilePath() async {
    final LocalStorage _storagedb = LocalStorage('$PRINTFILEPATH.json');
    await _storagedb.ready;
    _printfilepath = await _storagedb.getItem(PRINTFILEPATH);
    notifyListeners();
  }

  Future setScanScriptPath() async {
    final LocalStorage _storagedb = LocalStorage('$SCANSCRIPTPATH.json');
    await _storagedb.ready;
    _scanscriptpath = await _storagedb.getItem(SCANSCRIPTPATH);
    notifyListeners();
  }
}

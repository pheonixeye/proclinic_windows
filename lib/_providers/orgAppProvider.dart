// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:proclinic_windows/Mongo_db/Mongo_db.dart';
import 'package:proclinic_windows/_models/orgAppModel.dart';

class OrgAppProvider extends ChangeNotifier {
  String? _ptname;
  String? _phone;
  String? _docnameEN;
  String? _docnameAR;
  String? _clinicEN;
  String? _clinicAR;
  int? _docid;
  String? _visitDate;
  int? _day;
  int? _month;
  int? _year;
  int? _hour;
  int? _minute;

  OrgAppointement? _orgAppointement;
  OrgAppointement? get app => _orgAppointement;

  String? get ptname => _ptname;
  String? get phone => _phone;
  String? get docnameEN => _docnameEN;
  String? get docnameAR => _docnameAR;
  String? get clinicEN => _clinicEN;
  String? get clinicAR => _clinicAR;
  String? get visitDate => _visitDate;
  int? get docid => _docid;
  int? get day => _day;
  int? get month => _month;
  int? get year => _year;
  int? get hour => _hour;
  int? get minute => _minute;

  void rApp() {
    _orgAppointement = OrgAppointement(
        ptname: ptname!,
        phone: phone!,
        docnameEN: docnameEN!,
        docnameAR: docnameAR!,
        clinicEN: clinicEN!,
        clinicAR: clinicAR!,
        dateTime: visitDate!,
        docid: docid!);
  }

  void rPtname(String val) {
    _ptname = val;
    notifyListeners();
  }

  void rPhone(String val) {
    _phone = val;
    notifyListeners();
  }

  void rDocnameEN(String val) {
    _docnameEN = val;
    notifyListeners();
  }

  void rDocnameAR(String val) {
    _docnameAR = val;
    notifyListeners();
  }

  void rClinicEN(String val) {
    _clinicEN = val;
    notifyListeners();
  }

  void rClinicAR(String val) {
    _clinicAR = val;
    notifyListeners();
  }

  void rDocid(int val) {
    _docid = val;
    notifyListeners();
  }

  void rDay(int val) {
    _day = val;
    notifyListeners();
  }

  void rMonth(int val) {
    _month = val;
    notifyListeners();
  }

  void rYear(int val) {
    _year = val;
    notifyListeners();
  }

  void rHour(int val) {
    _hour = val;
    notifyListeners();
  }

  void rMinute(int val) {
    _minute = val;
    notifyListeners();
  }

  void rVisitDate() {
    DateTime d = DateTime(_year!, _month!, _day!, _hour!, _minute!);
    _visitDate = d.toIso8601String();
    notifyListeners();
  }

  List<OrgAppointement>? _appList;
  List<OrgAppointement>? get appointements => _appList;

  Future fetchAppointements() async {
    var a = await MongoDB.appOrganizer
        .find(where.sortBy(SxOrgApp.DATETIME, descending: true))
        .toList();

    _appList = OrgAppointement.makeList(a);
    notifyListeners();
  }

  Future addAppointement() async {
    await MongoDB.appOrganizer.insert(_orgAppointement!.toJson());
  }

  Future removeAppointement(OrgAppointement app) async {
    await MongoDB.appOrganizer.deleteOne(where
        .eq(SxOrgApp.PHONE, app.phone)
        .eq(SxOrgApp.DATETIME, app.dateTime)
        .eq(SxOrgApp.DOCID, app.docid)
        .eq(SxOrgApp.PTNAME, app.ptname));
  }
}

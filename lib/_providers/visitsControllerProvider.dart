import 'package:flutter/cupertino.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:proclinic_windows/Mongo_db/Mongo_db.dart';
import 'package:proclinic_windows/_models/doctorModel.dart';
import 'package:proclinic_windows/_models/visitModel.dart';

class VisitsSearchController extends ChangeNotifier {
  List<Visit>? _visits;
  List<Visit>? get visits => _visits;

  Future initializeVisits() async {
    var _v = await MongoDB.PATIENTS.find().toList();
    _v.sort((a, b) {
      var aDateString = a[SxVisit.VISITDATE];
      var bDateString = b[SxVisit.VISITDATE];
      DateTime adate = DateTime.parse(aDateString);
      DateTime bdate = DateTime.parse(bDateString);
      return bdate.compareTo(adate);
    });
    _visits = Visit.visitList(_v);
    notifyListeners();
  }

  Future searchVisitsbyPhoneNumber(String phone) async {
    var _v =
        await MongoDB.PATIENTS.find(where.eq(SxVisit.PHONE, phone)).toList();
    _v.sort((a, b) {
      var aDateString = a[SxVisit.VISITDATE];
      var bDateString = b[SxVisit.VISITDATE];
      DateTime adate = DateTime.parse(aDateString);
      DateTime bdate = DateTime.parse(bDateString);
      return bdate.compareTo(adate);
    });
    _visits = Visit.visitList(_v);
    notifyListeners();
  }

  // TODO :mod to src by doc id
  Future searchVisitsbyDoctorName(int id) async {
    var _v = await MongoDB.PATIENTS.find(where.eq(SxVisit.DOCID, id)).toList();
    _v.sort((a, b) {
      var aDateString = a[SxVisit.VISITDATE];
      var bDateString = b[SxVisit.VISITDATE];
      DateTime adate = DateTime.parse(aDateString);
      DateTime bdate = DateTime.parse(bDateString);
      return bdate.compareTo(adate);
    });
    _visits = Visit.visitList(_v);
    notifyListeners();
  }

  Future searchVisitsbyDate(int month, year) async {
    var _v = await MongoDB.PATIENTS.find().toList();
    var _dateV = [];
    _v.sort((a, b) {
      var aDateString = a[SxVisit.VISITDATE];
      var bDateString = b[SxVisit.VISITDATE];
      DateTime adate = DateTime.parse(aDateString);
      DateTime bdate = DateTime.parse(bDateString);
      return bdate.compareTo(adate);
    });
    _v.map((e) {
      String stringdate = e[SxVisit.VISITDATE];
      DateTime date = DateTime.parse(stringdate);
      if (date.month == month && date.year == year) {
        _dateV.add(e);
      }
    }).toList();
    _visits = Visit.visitList(_dateV);
    notifyListeners();
  }

  //bookkeeping requests
  Future parametrizedRequest({
    required int allOrOne,
    required int dayDuration,
    required int day,
    required int month,
    required int year,
    required Doctor? doctor,
  }) async {
    List<Map<String, dynamic>>? _v;
    List<Map<String, dynamic>>? _x;
    List<Map<String, dynamic>> data = [];
    _v = await MongoDB.PATIENTS.find().toList();
    _v.sort((a, b) {
      var aDateString = a[SxVisit.VISITDATE];
      var bDateString = b[SxVisit.VISITDATE];
      DateTime adate = DateTime.parse(aDateString);
      DateTime bdate = DateTime.parse(bDateString);
      return bdate.compareTo(adate);
    });
    //TODO: modifiy to use doc id

    //search patterns
    if (allOrOne == 0 && dayDuration == 0) {
      _v = await MongoDB.PATIENTS.find().toList();
      _v.sort((a, b) {
        var aDateString = a[SxVisit.VISITDATE];
        var bDateString = b[SxVisit.VISITDATE];
        DateTime adate = DateTime.parse(aDateString);
        DateTime bdate = DateTime.parse(bDateString);
        return bdate.compareTo(adate);
      });
      _v.map((e) {
        var date = e[SxVisit.VISITDATE] as String;
        final dt = DateTime.parse(date);
        if (dt.day == day && dt.month == month && dt.year == year) {
          data.add(e);
        }
      }).toList();
    } else if (allOrOne == 0 && dayDuration == 1) {
      _v = await MongoDB.PATIENTS.find().toList();
      _v.sort((a, b) {
        var aDateString = a[SxVisit.VISITDATE];
        var bDateString = b[SxVisit.VISITDATE];
        DateTime adate = DateTime.parse(aDateString);
        DateTime bdate = DateTime.parse(bDateString);
        return bdate.compareTo(adate);
      });
      _v.map((e) {
        var date = e[SxVisit.VISITDATE] as String;
        final dt = DateTime.parse(date);
        if (dt.month == month && dt.year == year) {
          data.add(e);
        }
      }).toList();
    } else if (allOrOne == 1 && dayDuration == 0) {
      _v = await MongoDB.PATIENTS
          .find(where.eq(SxVisit.DOCID, doctor?.id))
          .toList();
      _v.sort((a, b) {
        var aDateString = a[SxVisit.VISITDATE];
        var bDateString = b[SxVisit.VISITDATE];
        DateTime adate = DateTime.parse(aDateString);
        DateTime bdate = DateTime.parse(bDateString);
        return bdate.compareTo(adate);
      });
      _v.map((e) {
        var date = e[SxVisit.VISITDATE] as String;
        final dt = DateTime.parse(date);
        if (dt.month == month && dt.year == year && dt.day == day) {
          data.add(e);
        }
      }).toList();
    } else if (allOrOne == 1 && dayDuration == 1) {
      _v = await MongoDB.PATIENTS
          .find(where.eq(SxVisit.DOCID, doctor?.id))
          .toList();
      _v.sort((a, b) {
        var aDateString = a[SxVisit.VISITDATE];
        var bDateString = b[SxVisit.VISITDATE];
        DateTime adate = DateTime.parse(aDateString);
        DateTime bdate = DateTime.parse(bDateString);
        return bdate.compareTo(adate);
      });
      _v.map((e) {
        var date = e[SxVisit.VISITDATE] as String;
        final dt = DateTime.parse(date);
        if (dt.month == month && dt.year == year) {
          data.add(e);
        }
      }).toList();
    }

    _visits = Visit.visitList(data);

    notifyListeners();
  }

  Future searchVisitsByPatientPhone(String phone) async {
    var _v =
        await MongoDB.PATIENTS.find(where.eq(SxVisit.PHONE, phone)).toList();
    _v.sort((a, b) {
      var aDateString = a[SxVisit.VISITDATE];
      var bDateString = b[SxVisit.VISITDATE];
      DateTime adate = DateTime.parse(aDateString);
      DateTime bdate = DateTime.parse(bDateString);
      return bdate.compareTo(adate);
    });
    _visits = Visit.visitList(_v);
    notifyListeners();
  }
}

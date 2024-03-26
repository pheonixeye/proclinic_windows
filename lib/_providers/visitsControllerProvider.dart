import 'package:flutter/cupertino.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:proclinic_windows/Mongo_db/Mongo_db.dart';
import 'package:proclinic_windows/_models/doctorModel.dart';
import 'package:proclinic_windows/_models/visitModel.dart';

class VisitsSearchController extends ChangeNotifier {
  List<Visit>? _visits;
  List<Visit>? get visits => _visits;

  Future<void> initializeVisits() async {
    final _v = await MongoDB.visits
        .find(where.sortBy(SxVisit.VISITDATE, descending: true).limit(25))
        .toList();
    _visits = Visit.visitList(_v);
    notifyListeners();
  }

  Future<void> searchVisitsbyPhoneNumber(String phone) async {
    var _v = await MongoDB.visits
        .find(where
            .eq(SxVisit.PHONE, phone)
            .sortBy(SxVisit.VISITDATE, descending: true))
        .toList();
    _visits = Visit.visitList(_v);
    notifyListeners();
  }

  // todo :mod to src by doc id
  Future<void> searchVisitsbyDoctorId(int id) async {
    var _v = await MongoDB.visits
        .find(where
            .eq(SxVisit.DOCID, id)
            .sortBy(SxVisit.VISITDATE, descending: true))
        .toList();

    _visits = Visit.visitList(_v);
    notifyListeners();
  }

  Future<void> searchVisitsbyDate(int month, int year) async {
    final upperBound = DateTime(year, month + 1).toIso8601String();
    final lowerBound = DateTime(year, month).toIso8601String();
    var _v = await MongoDB.visits
        .find(where
            .gt(SxVisit.VISITDATE, lowerBound)
            .lt(SxVisit.VISITDATE, upperBound)
            .sortBy(SxVisit.VISITDATE, descending: true))
        .toList();
    // var _dateV = [];

    // _v.map((e) {
    //   String stringdate = e[SxVisit.VISITDATE];
    //   DateTime date = DateTime.parse(stringdate);
    //   if (date.month == month && date.year == year) {
    //     _dateV.add(e);
    //   }
    // }).toList();
    _visits = Visit.visitList(_v);
    notifyListeners();
  }

  //bookkeeping requests
  Future<void> parametrizedRequest({
    required int allOrOne,
    required int dayDuration,
    required int day,
    required int month,
    required int year,
    required Doctor? doctor,
  }) async {
    List<Map<String, dynamic>>? _v;
    // List<Map<String, dynamic>>? _x;
    List<Map<String, dynamic>> data = [];
    _v = await MongoDB.visits
        .find(where.sortBy(SxVisit.VISITDATE, descending: true))
        .toList();

    //todo: modifiy to use doc id

    //search patterns
    if (allOrOne == 0 && dayDuration == 0) {
      _v.map((e) {
        var date = e[SxVisit.VISITDATE] as String;
        final dt = DateTime.parse(date);
        if (dt.day == day && dt.month == month && dt.year == year) {
          data.add(e);
        }
      }).toList();
    } else if (allOrOne == 0 && dayDuration == 1) {
      _v.map((e) {
        var date = e[SxVisit.VISITDATE] as String;
        final dt = DateTime.parse(date);
        if (dt.month == month && dt.year == year) {
          data.add(e);
        }
      }).toList();
    } else if (allOrOne == 1 && dayDuration == 0) {
      _v = await MongoDB.visits
          .find(where
              .eq(SxVisit.DOCID, doctor?.id)
              .sortBy(SxVisit.VISITDATE, descending: true))
          .toList();

      _v.map((e) {
        var date = e[SxVisit.VISITDATE] as String;
        final dt = DateTime.parse(date);
        if (dt.month == month && dt.year == year && dt.day == day) {
          data.add(e);
        }
      }).toList();
    } else if (allOrOne == 1 && dayDuration == 1) {
      _v = await MongoDB.visits
          .find(where
              .eq(SxVisit.DOCID, doctor?.id)
              .sortBy(SxVisit.VISITDATE, descending: true))
          .toList();
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

  Future<void> searchVisitsByPatientPhone(String phone) async {
    var _v = await MongoDB.visits
        .find(where
            .eq(SxVisit.PHONE, phone)
            .sortBy(SxVisit.VISITDATE, descending: true))
        .toList();
    _visits = Visit.visitList(_v);
    notifyListeners();
  }
}

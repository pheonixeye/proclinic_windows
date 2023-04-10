// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:proclinic_windows/Mongo_db/Mongo_db.dart';
import 'package:proclinic_windows/_models/doctorModel.dart';

class DoctorListProvider extends ChangeNotifier {
  List<Doctor>? _doctorList;
  List<Doctor>? get doctorList => _doctorList;

  Future fetchAllDoctors() async {
    var variable = await MongoDB.allDoctors
        .find(where.eq(SxDoctor.PUBLISHED, true))
        .toList();
    _doctorList = Doctor.doctorList(variable);
    notifyListeners();
  }
}

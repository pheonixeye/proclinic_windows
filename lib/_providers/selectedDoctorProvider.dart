// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:proclinic_windows/Mongo_db/Mongo_db.dart';
import 'package:proclinic_windows/_models/doctorModel.dart';

class SelectedDoctor extends ChangeNotifier {
  Doctor? _doctor;
  Doctor? get doctor => _doctor;

  void selectDoctor(int id) async {
    var doc = await MongoDB.allDoctors.findOne(where.eq(SxDoctor.ID, id));
    _doctor = Doctor.fromJson(doc);
    print('doc selected ==>> ${_doctor!.docnameEN}');
    notifyListeners();
  }

  void nullifyDoctor() {
    _doctor = null;
    notifyListeners();
  }

  Future unpublishDoctor(int id) async {
    var doc = await MongoDB.allDoctors.findOne(where.eq(SxDoctor.ID, id));
    await MongoDB.allDoctors.updateOne(doc, {
      r'$set': {
        SxDoctor.PUBLISHED: false,
      },
    });
  }
}

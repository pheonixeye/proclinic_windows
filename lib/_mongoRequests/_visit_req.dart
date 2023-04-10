// ignore_for_file: avoid_print

import 'package:mongo_dart/mongo_dart.dart';
import 'package:proclinic_windows/Mongo_db/Mongo_db.dart';
import 'package:proclinic_windows/_models/visitModel.dart';

class VisitRequests {
  // add new visit to db
  static Future addNewVisitToDb(Visit visit) async {
    await MongoDB.PATIENTS.insert(visit.toJson());
  }

  // update visit
  static Future updateVisitData(Visit oldVis, Visit newVis) async {
    var foundVisit = await MongoDB.PATIENTS
        .findOne(where.eq(SxVisit.VISITDATE, oldVis.visitDate));
    print(foundVisit);
    if (foundVisit != null) {
      await MongoDB.PATIENTS.deleteOne(foundVisit);
      await MongoDB.PATIENTS.insertOne(newVis.toJson());
    }
  }

  //delete visit
  static Future deleteOneVisit(Visit visit) async {
    var foundVisit = await MongoDB.PATIENTS
        .findOne(where.eq(SxVisit.VISITDATE, visit.visitDate));
    print(foundVisit);

    if (foundVisit != null) {
      await MongoDB.PATIENTS.deleteOne(foundVisit);
    }
  }
}

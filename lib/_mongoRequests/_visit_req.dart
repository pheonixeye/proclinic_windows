// ignore_for_file: avoid_print

import 'package:mongo_dart/mongo_dart.dart';
import 'package:proclinic_windows/Mongo_db/Mongo_db.dart';
import 'package:proclinic_windows/_models/visitModel.dart';
import 'package:proclinic_windows/_models/visit_data/visit_data.dart';

class VisitRequests {
  // add new visit to db
  static Future addNewVisitToDb(Visit visit) async {
    await MongoDB.PATIENTS.insert(visit.toJson());
    final data = VisitData(
      docid: visit.docid!,
      visitid: visit.id,
      ptname: visit.ptName,
      phone: visit.phone,
      visittype: visit.visitType,
      visitdate: visit.visitDate,
      data: {},
      labs: [],
      rads: [],
      drugs: [],
      sheetpapers: [],
      labpapers: [],
      radpapers: [],
      drugpapers: [],
      commentspapers: [],
    );
    print(data.toString());
    await MongoDB.visitData.insert(data.toJson());
  }

  // update visit
  static Future updateVisitData(Visit oldVis, Visit newVis) async {
    var foundVisit = await MongoDB.PATIENTS.findOne(where.eq("_id", oldVis.id));
    print(foundVisit);
    if (foundVisit != null) {
      await MongoDB.PATIENTS.deleteOne(foundVisit);
      await MongoDB.PATIENTS.insertOne(newVis.toJson());
    }
  }

  //delete visit
  static Future deleteOneVisit(Visit visit) async {
    var foundVisit = await MongoDB.PATIENTS.findOne(where.eq("_id", visit.id));
    print(foundVisit);

    if (foundVisit != null) {
      await MongoDB.PATIENTS.deleteOne(foundVisit);
    }
  }
}

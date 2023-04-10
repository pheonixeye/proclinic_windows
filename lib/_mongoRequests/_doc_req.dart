import 'package:mongo_dart/mongo_dart.dart';
import 'package:proclinic_windows/Mongo_db/Mongo_db.dart';
import 'package:proclinic_windows/_models/doctorModel.dart';

class DoctorRequests {
  //new add doc to mongo db
  static Future newAddDoctorToMongoDB({required Doctor doctor}) async {
    await MongoDB.allDoctors.insert(doctor.toJson());
  }

  // push item into list field
  static Future pushToList(
      {required int id, required String parameter, value}) async {
    final doctor = await MongoDB.allDoctors.findOne(where.eq('_id', id));
    await MongoDB.allDoctors.updateOne(doctor, {
      r'$push': {parameter: value}
    });
  }

  // remove item from list field
  static Future pullFromList(
      {required int id, required String parameter, value}) async {
    final doctor = await MongoDB.allDoctors.findOne(where.eq('_id', id));
    await MongoDB.allDoctors.updateOne(doctor, {
      r'$pull': {parameter: value}
    });
  }

  // modify a field
  static Future modifyField({
    required int id,
    required String parameter,
    required dynamic value,
  }) async {
    final doctor = await MongoDB.allDoctors.findOne(where.eq('_id', id));
    await MongoDB.allDoctors.updateOne(doctor, {
      r'$set': {parameter: value}
    });
  }
}

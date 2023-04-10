// ignore_for_file: non_constant_identifier_names, avoid_print, file_names

library mymongo;

import 'package:mongo_dart/mongo_dart.dart';

class MongoDB {
  //*atlas database
  // static late Db mongo;
  // static var uri =
  //     "mongodb+srv://guestUser:kareemzaher@cluster0.dxhos.mongodb.net:27017";
  // static Future connect() async {
  //   mongo = await Db.create(uri);
  //   // await mongo.open();
  // }

//*local database
  // static Db mongo = Db('mongodb://localhost:27017/proclinic');
  static Db mongo = Db('mongodb://127.0.0.1:27017/proclinic');

//*my remote database
// static Db mongo = Db('mongodb://procliniccosmosurge.ddns.net:5555/proclinic');

  static DbCollection allPatients = mongo.collection('allpatients');
  static DbCollection PATIENTS = mongo.collection('patients');
  static DbCollection allDoctors = mongo.collection('allDoctors');
  static DbCollection appOrganizer = mongo.collection('apporganizer');
  static DbCollection onlineusers = mongo.collection('onlineusers');
  static DbCollection onlineAppointements =
      mongo.collection('onlineappointements');
  static DbCollection onlineOffers = mongo.collection('onlineoffers');
  static DbCollection reservedoffers = mongo.collection('reservedoffers');
  static Future openYaMongo() async {
    await mongo.open();
    mongo.isConnected;
    mongo.masterConnection.connected;
    if (!mongo.masterConnection.connected) {
      mongo.masterConnection.connect();
    }

    print('shobeek lobeek El mongo been eidek, totlob eih??');
  }
}

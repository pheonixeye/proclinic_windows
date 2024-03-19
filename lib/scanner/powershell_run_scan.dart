// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:localstorage/localstorage.dart';
import 'package:proclinic_windows/Mongo_db/Mongo_db.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:proclinic_windows/_const/_strings.dart';
import 'package:proclinic_windows/_models/documentModel.dart';
import 'package:proclinic_windows/_models/visitModel.dart';

class PowerShellScanRunner {
  static Future runScanAndSave({
    required String sclrp,
    required Visit visit,
  }) async {
    final LocalStorage _storageps1 = LocalStorage('$SCANSCRIPTPATH.json');
    final LocalStorage _storagedb = LocalStorage('$DBPATH.json');

    await _storageps1.ready;
    await _storagedb.ready;

    String scriptpath = await _storageps1.getItem(SCANSCRIPTPATH);
    String dbpath = await _storagedb.getItem(DBPATH);

    DbCollection patientNamedCollection = MongoDB.mongo.collection(visit.phone);

    //srlcp = sheet-rad-lab-comment-prescription
    Directory dir = await Directory('${dbpath}').create(recursive: true);

    DateTime d = DateTime.parse(visit.visitDate);

    String filename =
        '${visit.phone}_${d.day}${d.month}${d.year}${d.hour}${d.minute}_${visit.docid}_${sclrp}.jpeg';

    //N.B. scriptPath = target.exe
    //todo: check scan script algorhithm...
    //todo: no need ??

    final scan = await Process.run('$scriptpath', ["${dir.path}\\${filename}"]);
    print(scan.stdout);
    print(scan.stderr);

    // await loading;
    File imgFile = File('${dir.path}\\${filename}');

    Uint8List imgfilebyteslist = await imgFile.readAsBytes();

    String imgstring = base64Encode(imgfilebyteslist);

    print('-----Constructing Document-----');
    Document doc = _makedoc(
      visit.visitDate,
      DateTime.now().toIso8601String(),
      visit.docid!,
      sclrp,
      imgstring,
    );

    print('-----adding image data to db-----');

    await patientNamedCollection.insert(doc.toJson());

    print('image added');

    // await imgFile.delete(recursive: true);

    // print('scanned image deleted...');
  }
}

Document _makedoc(String visitDate, String scanTime, int docid, String sclrp,
    String sclrpVal) {
  Document? doc;
  switch (sclrp) {
    case SHEETS:
      doc = Document(
        scanTime: scanTime,
        visitDate: visitDate,
        docid: docid,
        sheets: sclrpVal,
      );
      break;
    case LABS:
      doc = Document(
        scanTime: scanTime,
        visitDate: visitDate,
        docid: docid,
        labs: sclrpVal,
      );
      break;
    case RADS:
      doc = Document(
        scanTime: scanTime,
        visitDate: visitDate,
        docid: docid,
        rads: sclrpVal,
      );
      break;
    case PRESCRIPTIONS:
      doc = Document(
        scanTime: scanTime,
        visitDate: visitDate,
        docid: docid,
        prescriptions: sclrpVal,
      );
      break;
    case COMMENTS:
      doc = Document(
        scanTime: scanTime,
        visitDate: visitDate,
        docid: docid,
        comments: sclrpVal,
      );
      break;
  }
  return doc!;
}

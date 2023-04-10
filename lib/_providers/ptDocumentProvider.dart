import 'package:flutter/cupertino.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:proclinic_windows/Mongo_db/Mongo_db.dart';
import 'package:proclinic_windows/_models/documentModel.dart';

class PatientDocumentProvider extends ChangeNotifier {
  List<Document>? _docs;

  List<Document>? get documents => _docs;

  Future setDocuments(String phone, String visitDate, String sclrp) async {
    final ptCollection = DbCollection(MongoDB.mongo, phone);
    var docs = await ptCollection
        .find(where.eq(SxDocument.VISITDATE, visitDate).ne(sclrp, null))
        .toList();
    docs.sort((a, b) {
      var aDateString = a[SxDocument.VISITDATE];
      var bDateString = b[SxDocument.VISITDATE];
      DateTime adate = DateTime.parse(aDateString);
      DateTime bdate = DateTime.parse(bDateString);
      return bdate.compareTo(adate);
    });
    _docs = Document.docsList(docs);
    notifyListeners();
  }
}

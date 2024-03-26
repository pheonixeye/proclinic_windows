// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:proclinic_windows/Mongo_db/Mongo_db.dart';
import 'package:proclinic_windows/_models/orgAppModel.dart';

class OrgAppProvider extends ChangeNotifier {
  OrgAppointement _orgAppointement = OrgAppointement.initial();
  OrgAppointement get app => _orgAppointement;

  List<OrgAppointement>? _appList;
  List<OrgAppointement>? get appointements => _appList;

  void setOrgAppointment({
    String? ptname,
    String? phone,
    String? docnameEN,
    String? docnameAR,
    String? clinicEN,
    String? clinicAR,
    String? dateTime,
    String? dob,
    int? docid,
  }) {
    _orgAppointement = OrgAppointement(
      ptname: ptname ?? _orgAppointement.ptname,
      phone: phone ?? _orgAppointement.phone,
      docnameEN: docnameEN ?? _orgAppointement.docnameEN,
      docnameAR: docnameAR ?? _orgAppointement.docnameAR,
      clinicEN: clinicEN ?? _orgAppointement.clinicEN,
      clinicAR: clinicAR ?? _orgAppointement.clinicAR,
      dateTime: dateTime ?? _orgAppointement.dateTime,
      dob: dob ?? _orgAppointement.dob,
      docid: docid ?? _orgAppointement.docid,
    );
    notifyListeners();
  }

  Future<void> fetchAppointements() async {
    var result = await MongoDB.appOrganizer
        .find(where.sortBy(SxOrgApp.DATETIME, descending: true))
        .toList();

    _appList = result.map((e) => OrgAppointement.fromMap(e)).toList();
    notifyListeners();
  }

  Future<void> addAppointement() async {
    await MongoDB.appOrganizer.insert(_orgAppointement.toMap());
    await fetchAppointements();
  }

  Future<void> removeAppointement(OrgAppointement app) async {
    await MongoDB.appOrganizer.deleteOne(where
        .eq("phone", app.phone)
        .eq("dateTime", app.dateTime)
        .eq("docid", app.docid)
        .eq("ptname", app.ptname));
    await fetchAppointements();
  }
}

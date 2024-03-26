// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:mongo_dart/mongo_dart.dart' show ObjectId;
import 'package:proclinic_windows/_models/visitModel.dart';

class NewVisitProvider extends ChangeNotifier {
  //values
  String? _ptName;
  ObjectId? _ptId;
  String? _docNameEN;
  String? _docNameAR;
  String? _clinicEN;
  String? _clinicAR;
  String? _phone;
  String? _visitType;
  String? _procedureEN;
  String? _procedureAR;
  String? _visitDate;
  String? _dob;
  String? _cashType;
  String? _affiliationEN;
  String? _affiliationAR;
  int? _amount;
  int? _docid = 0;
  int? _remaining = 0;
  //visit
  Visit? _visit;
  //getters
  String? get ptName => _ptName;
  ObjectId? get ptId => _ptId;
  String? get docNameEN => _docNameEN;
  String? get docNameAR => _docNameAR;
  String? get clinicEN => _clinicEN;
  String? get clinicAR => _clinicAR;
  String? get phone => _phone;
  String? get visitType => _visitType;
  String? get procedureEN => _procedureEN;
  String? get procedureAR => _procedureAR;
  String? get visitDate => _visitDate;
  String? get dob => _dob;
  String? get cashType => _cashType;
  String? get affiliationEN => _affiliationEN;
  String? get affiliationAR => _affiliationAR;
  int? get amount => _amount;
  int? get remaining => _remaining;
  int? get docid => _docid;
  Visit? get visit => _visit;
  //setters
  void setPtName(String value) {
    _ptName = value;
    notifyListeners();
  }

  void setDocNameEN(String value) {
    _docNameEN = value;
    notifyListeners();
  }

  void setDocNameAR(String value) {
    _docNameAR = value;
    notifyListeners();
  }

  void setPhone(String value) {
    _phone = value;
    notifyListeners();
  }

  void setVisitDate(String value) {
    _visitDate = value;
    notifyListeners();
  }

  void setVisitType(String value) {
    _visitType = value;
    notifyListeners();
  }

  void setClinicEN(String value) {
    _clinicEN = value;
    notifyListeners();
  }

  void setClinicAR(String value) {
    _clinicAR = value;
    notifyListeners();
  }

  void setProcedureEN(String? value) {
    _procedureEN = value;
    notifyListeners();
  }

  void setProcedureAR(String? value) {
    _procedureAR = value;
    notifyListeners();
  }

  void setCashType(String value) {
    _cashType = value;
    notifyListeners();
  }

  void setAffiliationEN(String value) {
    _affiliationEN = value;
    notifyListeners();
  }

  void setAffiliationAR(String value) {
    _affiliationAR = value;
    notifyListeners();
  }

  void setAmount(int value) {
    _amount = value;
    notifyListeners();
  }

  void setDocId(int? value) {
    _docid = value;
    notifyListeners();
  }

  void setRemaining(int value) {
    _remaining = value;
    notifyListeners();
  }

  void setDob(String value) {
    _dob = value;
    notifyListeners();
  }

  void setptId(ObjectId value) {
    _ptId = value;
    notifyListeners();
  }

  void setVISIT([ObjectId? ptId]) {
    _visit = Visit(
      ptName: ptName!,
      ptId: ptId ?? this.ptId!,
      docNameEN: docNameEN!,
      docNameAR: docNameAR!,
      clinicEN: clinicEN!,
      clinicAR: clinicAR!,
      phone: phone!,
      visitType: visitType!,
      procedureEN: visitType != 'procedure' ? null : procedureEN,
      procedureAR: visitType != 'procedure' ? null : procedureAR,
      visitDate: visitDate!,
      dob: dob!,
      cashType: cashType!,
      affiliationEN: affiliationEN!,
      affiliationAR: affiliationAR!,
      amount: amount!,
      remaining: remaining!,
      docid: docid,
    );
    notifyListeners();
  }

  void setVisitFromVisit(Visit? newVisit) {
    if (newVisit != null) {
      var json = newVisit.toJson();
      _visit = Visit(
        ptId: json[SxVisit.PTID],
        ptName: json[SxVisit.PTNAME],
        docNameEN: json[SxVisit.DOCNAME_E],
        docNameAR: json[SxVisit.DOCNAME_A],
        clinicEN: json[SxVisit.CLINIC_E],
        clinicAR: json[SxVisit.CLINIC_A],
        phone: json[SxVisit.PHONE],
        visitType: json[SxVisit.VISITTYPE],
        procedureEN: json[SxVisit.PROCEDURE_E],
        procedureAR: json[SxVisit.PROCEDURE_A],
        visitDate: json[SxVisit.VISITDATE],
        dob: json[SxVisit.DOB],
        cashType: json[SxVisit.CASHTYPE],
        affiliationEN: json[SxVisit.AFFILIATION_E],
        affiliationAR: json[SxVisit.AFFILIATION_A],
        amount: json[SxVisit.AMOUNT],
        remaining: json[SxVisit.REMAINING],
        docid: json[SxVisit.DOCID],
      );
      notifyListeners();
    } else {
      _visit = null;
      notifyListeners();
    }
    print(_visit!.docNameEN);
  }

  void nullifyVisit() {
    _visit = null;
    notifyListeners();
  }
}

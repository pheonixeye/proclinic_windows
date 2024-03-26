// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: constant_identifier_names, file_names

import 'dart:convert';

import 'package:equatable/equatable.dart';

class OrgAppointement extends Equatable {
  final String ptname;
  final String phone;
  final String docnameEN;
  final String docnameAR;
  final String clinicEN;
  final String clinicAR;
  final String dateTime;
  final String dob;
  final int docid;

  const OrgAppointement({
    required this.ptname,
    required this.phone,
    required this.docnameEN,
    required this.docnameAR,
    required this.clinicEN,
    required this.clinicAR,
    required this.dateTime,
    required this.dob,
    required this.docid,
  });

  factory OrgAppointement.initial() {
    return const OrgAppointement(
      ptname: '',
      phone: '',
      docnameEN: '',
      docnameAR: '',
      clinicEN: '',
      clinicAR: '',
      dateTime: '',
      dob: '',
      docid: 0,
    );
  }

  OrgAppointement copyWith({
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
    return OrgAppointement(
      ptname: ptname ?? this.ptname,
      phone: phone ?? this.phone,
      docnameEN: docnameEN ?? this.docnameEN,
      docnameAR: docnameAR ?? this.docnameAR,
      clinicEN: clinicEN ?? this.clinicEN,
      clinicAR: clinicAR ?? this.clinicAR,
      dateTime: dateTime ?? this.dateTime,
      dob: dob ?? this.dob,
      docid: docid ?? this.docid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ptname': ptname,
      'phone': phone,
      'docnameEN': docnameEN,
      'docnameAR': docnameAR,
      'clinicEN': clinicEN,
      'clinicAR': clinicAR,
      'dateTime': dateTime,
      'dob': dob,
      'docid': docid,
    };
  }

  factory OrgAppointement.fromMap(Map<String, dynamic> map) {
    return OrgAppointement(
      ptname: map['ptname'] as String,
      phone: map['phone'] as String,
      docnameEN: map['docnameEN'] as String,
      docnameAR: map['docnameAR'] as String,
      clinicEN: map['clinicEN'] as String,
      clinicAR: map['clinicAR'] as String,
      dateTime: map['dateTime'] as String,
      dob: map['dob'] as String,
      docid: map['docid'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrgAppointement.fromJson(String source) =>
      OrgAppointement.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      ptname,
      phone,
      docnameEN,
      docnameAR,
      clinicEN,
      clinicAR,
      dateTime,
      dob,
      docid,
    ];
  }
}

class SxOrgApp {
  static const String PTNAME = 'ptname';
  static const String PHONE = 'phone';
  static const String DOCNAMEEN = 'docname_en';
  static const String DOCNAMEAR = 'docname_ar';
  static const String CLINICEN = 'clinic_en';
  static const String CLINICAR = 'clinic_ar';
  static const String DATETIME = 'datetime';
  static const String DOCID = 'docid';
}

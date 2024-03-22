// ignore_for_file: constant_identifier_names, file_names

class OrgAppointement {
  final String ptname;
  final String phone;
  final String docnameEN;
  final String docnameAR;
  final String clinicEN;
  final String clinicAR;
  final String dateTime;
  final int docid;

  OrgAppointement({
    required this.ptname,
    required this.phone,
    required this.docnameEN,
    required this.docnameAR,
    required this.clinicEN,
    required this.clinicAR,
    required this.dateTime,
    required this.docid,
  });
  factory OrgAppointement.fromJson(dynamic json) {
    return OrgAppointement(
      ptname: json[SxOrgApp.PTNAME],
      phone: json[SxOrgApp.PHONE],
      docnameEN: json[SxOrgApp.DOCNAMEEN],
      docnameAR: json[SxOrgApp.DOCNAMEAR],
      clinicEN: json[SxOrgApp.CLINICEN],
      clinicAR: json[SxOrgApp.CLINICAR],
      dateTime: json[SxOrgApp.DATETIME],
      docid: json[SxOrgApp.DOCID],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      SxOrgApp.PTNAME: ptname,
      SxOrgApp.PHONE: phone,
      SxOrgApp.DOCNAMEEN: docnameEN,
      SxOrgApp.DOCNAMEAR: docnameAR,
      SxOrgApp.CLINICEN: clinicEN,
      SxOrgApp.CLINICAR: clinicAR,
      SxOrgApp.DATETIME: dateTime,
      SxOrgApp.DOCID: docid,
    };
  }

  static List<OrgAppointement> makeList(List<dynamic> list) {
    List<OrgAppointement> li = list.map((json) {
      return OrgAppointement(
        ptname: json[SxOrgApp.PTNAME],
        phone: json[SxOrgApp.PHONE],
        docnameEN: json[SxOrgApp.DOCNAMEEN],
        docnameAR: json[SxOrgApp.DOCNAMEAR],
        clinicEN: json[SxOrgApp.CLINICEN],
        clinicAR: json[SxOrgApp.CLINICAR],
        dateTime: json[SxOrgApp.DATETIME],
        docid: json[SxOrgApp.DOCID],
      );
    }).toList();
    return li;
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

// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:pretty_qr_code/pretty_qr_code.dart';

const double textfieldheight = 60.0;
const double textfieldwidth = 350.0;

final List<int> MONTHS = List.generate(12, (index) => index + 1);
final List<int> YEARS =
    List.generate(10, (index) => (DateTime.now().year - 5) + index);
final List<int> DAYS = List.generate(31, (index) => index + 1);

const String UUID = '4C4C4544-0039-4610-804A-B9C04F445331';

final qrCode = QrCode.fromData(
  data: UUID,
  errorCorrectLevel: QrErrorCorrectLevel.H,
);

const String DBPATH = 'db';
const String PRINTFILEPATH = 'print';
const String SCANSCRIPTPATH = 'scan';

const String SHEETS = 'sheets';
const String LABS = 'labs';
const String RADS = 'rads';
const String PRESCRIPTIONS = 'prescriptions';
const String COMMENTS = 'comments';

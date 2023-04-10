// ignore_for_file: file_names
//mod db entries
  // Future _modDB() async {
  //   var list = await MongoDB.allPatients.find().toList();
  //   list.map((e) async {
  //     DateTime visDate = DateTime(
  //         int.parse(e['year']), int.parse(e['month']), int.parse(e['day']));
  //     DateTime dob = DateTime.parse(e['dob']);
  //     int amount = int.parse(e['amount']);
  //     int remaining = e['remaining'] == '' ? 0 : int.parse(e['remaining']);
  //     Visit vis = Visit(
  //       ptName: e['ptname'],
  //       docName: e['docname'],
  //       clinic: e['clinic'],
  //       phone: e['phone'],
  //       visitType: e['visit'],
  //       procedure: (e['procedure'] == null || e['procedure'] == '')
  //           ? null
  //           : e['procedure'],
  //       visitDate: visDate.toIso8601String(),
  //       dob: dob.toIso8601String(),
  //       cashType: e['cashtype'] == null ? 'cash' : e['cashtype'],
  //       affiliation: 'unknown',
  //       amount: amount,
  //       remaining: remaining,
  //     );
  //     await MongoDB.PATIENTS.insert(vis.toJson());
  //     print('vis added ${list[list.indexOf(e)]}');
  //   }).toList();
  // }
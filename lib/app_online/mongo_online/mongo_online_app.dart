// import 'dart:async';

// import 'package:mongo_dart/mongo_dart.dart';
// import 'package:proclinic_windows/Mongo_db/Mongo_db.dart';

// class OnlineUsers {
//   OnlineUsers() {
//     onlineusersmongo.listen((list) => _onlineusersfromdb.add(list));
//   }

//   Stream<List<Map<String, dynamic>>> get onlineusersmongo async* {
//     List<Map<String, dynamic>> onlineusersfromdb =
//         await MongoDB.onlineusers.find().toList();
//     yield onlineusersfromdb;
//   }

//   StreamController<List<Map<String, dynamic>>> _onlineusersfromdb =
//       StreamController.broadcast();

//   Stream<List<Map<String, dynamic>>> get onlineusersfromdb =>
//       _onlineusersfromdb.stream;
// }

// class OnlineUsersSearchable {
//   final String username;
//   final String phone;
//   OnlineUsersSearchable({required this.username, required this.phone}) {
//     onlineusersmongo.listen((list) => _onlineusersfromdb.add(list));
//   }

//   Stream<List<Map<String, dynamic>>> get onlineusersmongo async* {
//     List<Map<String, dynamic>> onlineusersfromdb = await MongoDB.onlineusers
//         .find(where.match('username', username).or(where.match('phone', phone)))
//         .toList();
//     yield onlineusersfromdb;
//   }

//   StreamController<List<Map<String, dynamic>>> _onlineusersfromdb =
//       StreamController.broadcast();

//   Stream<List<Map<String, dynamic>>> get onlineusersfromdb =>
//       _onlineusersfromdb.stream;
// }

// //upcoming appointements stream class
// class OnlineAppointementsUpcoming {
//   OnlineAppointementsUpcoming() {
//     onlineAppsmongo.listen((list) => _onlineAppsfromdb.add(list));
//   }

//   static Future deleteEntryFromAppointmentsCollection({
//     required String docname,
//     required String clinic,
//     required String ptname,
//     required String phone,
//     required String weekday,
//     required int start,
//     required int end,
//     required String dob,
//     required int day,
//     required int month,
//     required int year,
//   }) async {
//     Map<String, dynamic> appToDelete = await MongoDB.onlineAppointements.remove(
//       where
//           .eq('docname', docname)
//           .eq('clinic', clinic)
//           .eq('day', weekday)
//           .eq('start', start)
//           .eq('end', end)
//           .eq('sday', day)
//           .eq('smonth', month)
//           .eq('syear', year)
//           .eq('username', ptname)
//           .eq('phone', phone)
//           .eq('dob', dob),
//     );
//     return appToDelete;
//   }

//   static Future updateEntryDayMonthYearFromAppointmentsCollection({
//     required String docname,
//     required String clinic,
//     required String ptname,
//     required String phone,
//     required String weekday,
//     required int start,
//     required int end,
//     required String dob,
//     required int day,
//     required int month,
//     required int year,
//     required int newsday,
//     required int newsmonth,
//     required int newsyear,
//   }) async {
//     Map<String, dynamic> appToDelete = await MongoDB.onlineAppointements.update(
//         where
//             .eq('docname', docname)
//             .eq('clinic', clinic)
//             .eq('day', weekday)
//             .eq('start', start)
//             .eq('end', end)
//             .eq('sday', day)
//             .eq('smonth', month)
//             .eq('syear', year)
//             .eq('username', ptname)
//             .eq('phone', phone)
//             .eq('dob', dob),
//         {
//           r'$set': {'sday': newsday, 'smonth': newsmonth, 'syear': newsyear}
//         });
//     return appToDelete;
//   }

//   Stream<List<Map<String, dynamic>>> get onlineAppsmongo async* {
//     List<Map<String, dynamic>> onlineappsfromdb = await MongoDB
//         .onlineAppointements
//         .find(where
//             .sortBy('syear', descending: true)
//             .sortBy('smonth', descending: false)
//             .sortBy('sday', descending: false))
//         .toList();
//     yield onlineappsfromdb;
//   }

//   StreamController<List<Map<String, dynamic>>> _onlineAppsfromdb =
//       StreamController.broadcast();

//   Stream<List<Map<String, dynamic>>> get onlineAppsfromdb =>
//       _onlineAppsfromdb.stream;
// }

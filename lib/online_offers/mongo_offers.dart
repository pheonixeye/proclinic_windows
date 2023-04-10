// import 'dart:async';

// import 'package:mongo_dart/mongo_dart.dart';
// import 'package:proclinic_windows/Mongo_db/Mongo_db.dart';
// import 'package:proclinic_windows/online_offers/offer_model.dart';

// class OnlineOffersMongodb {
//   OnlineOffersMongodb() {
//     offersOfMongo.listen((list) {
//       _allMongoOffers.add(list);
//     });
//   }
//   //add offer to mongo
//   static Future addOffer(
//       {required int percentage,
//       required String docname,
//       required String docname_a,
//       required String procedure,
//       required String procedure_a,
//       required String description,
//       required String description_a,
//       required bool available}) async {
//     await MongoDB.onlineOffers.insert({
//       Offer.PERCENTAGE: percentage,
//       Offer.PROCEDURE: procedure,
//       Offer.PROCEDURE_A: procedure_a,
//       Offer.DOCNAME: docname,
//       Offer.DOCNAME_A: docname_a,
//       Offer.DESCRIPTION: description,
//       Offer.DESCRIPTION_A: description_a,
//       Offer.AVAILABLE: available
//     });
//   }

//   //update offer to mongo available true/false
//   static Future updateOffer(
//       {required int percentage,
//       required String docname,
//       required String docname_a,
//       required String procedure,
//       required String procedure_a,
//       required String description,
//       required String description_a,
//       required bool newavailable,
//       required bool oldavailable}) async {
//     await MongoDB.onlineOffers.update(
//         where
//             .eq(Offer.PERCENTAGE, percentage)
//             .eq(Offer.PROCEDURE, procedure)
//             .eq(Offer.PROCEDURE_A, procedure_a)
//             .eq(Offer.DOCNAME, docname)
//             .eq(Offer.DOCNAME_A, docname_a)
//             .eq(Offer.DESCRIPTION, description)
//             .eq(Offer.DESCRIPTION_A, description_a)
//             .eq(Offer.AVAILABLE, oldavailable),
//         {
//           Offer.PERCENTAGE: percentage,
//           Offer.PROCEDURE: procedure,
//           Offer.PROCEDURE_A: procedure_a,
//           Offer.DOCNAME: docname,
//           Offer.DOCNAME_A: docname_a,
//           Offer.DESCRIPTION: description,
//           Offer.DESCRIPTION_A: description_a,
//           Offer.AVAILABLE: newavailable,
//         });
//   }

//   static Future deleteOffer(
//       {required int percentage,
//       required String docname,
//       required String docname_a,
//       required String procedure,
//       required String procedure_a,
//       required String description,
//       required String description_a,
//       required bool available}) async {
//     await MongoDB.onlineOffers.remove({
//       Offer.PERCENTAGE: percentage,
//       Offer.PROCEDURE: procedure,
//       Offer.PROCEDURE_A: procedure_a,
//       Offer.DOCNAME: docname,
//       Offer.DOCNAME_A: docname_a,
//       Offer.DESCRIPTION: description,
//       Offer.DESCRIPTION_A: description_a,
//       Offer.AVAILABLE: available
//     });
//   }

//   static Stream get offersOfMongo async* {
//     List<Map<String, dynamic>> allOffers =
//         await MongoDB.onlineOffers.find().toList();
//     yield allOffers;
//   }

//   StreamController<List<Map<String, dynamic>>> _allMongoOffers =
//       StreamController.broadcast();

//   Stream<List<Map<String, dynamic>>> get allMongoOffers =>
//       _allMongoOffers.stream;
// }

// //-------------------------------
// //reserved offers stream class---
// //-------------------------------
// class ReservedOffersOnlineMongoDb {
//   ReservedOffersOnlineMongoDb() {
//     offersOfMongo.listen((list) {
//       _allMongoOffers.add(list);
//     });
//   }

//   static Stream get offersOfMongo async* {
//     List<Map<String, dynamic>> allOffers = await MongoDB.reservedoffers
//         .find(where.sortBy('year').sortBy('month').sortBy('day'))
//         .toList();
//     yield allOffers;
//   }

//   StreamController<List<Map<String, dynamic>>> _allMongoOffers =
//       StreamController.broadcast();

//   Stream<List<Map<String, dynamic>>> get allMongoOffers =>
//       _allMongoOffers.stream;
// }

// //-----------------------------------
// ///////////////////////////////////
// ///////////////////////////////////
// ///----------------------------------
// class ReservedOffersOnlineMongoDbSearchable {
//   String docname;
//   String userphone;
//   String weekday;

//   ReservedOffersOnlineMongoDbSearchable(
//       {required this.docname, required this.userphone, required this.weekday}) {
//     offersOfMongo.listen((list) {
//       _allMongoOffers.add(list);
//     });
//   }

//   Stream get offersOfMongo async* {
//     List<Map<String, dynamic>> allOffers = await MongoDB.reservedoffers
//         .find(where
//             .match('docname', docname)
//             .or(where
//                 .match('phone', userphone)
//                 .or(where.match('weekday', weekday)))
//             .sortBy('year')
//             .sortBy('month')
//             .sortBy('day'))
//         .toList();
//     yield allOffers;
//   }

//   StreamController<List<Map<String, dynamic>>> _allMongoOffers =
//       StreamController.broadcast();

//   Stream<List<Map<String, dynamic>>> get allMongoOffers =>
//       _allMongoOffers.stream;
// }

// //--------------------------------------
// ///////////////////////////////////-----
// //////////////////////////////////------
// //--------------------------------------

// class ReservedOffersAndOffersOfUsers {
//   static Future deleteOfferFromUser(
//       {required String phone,
//       required String docname,
//       required String procedure,
//       required String description,
//       required String docname_a,
//       required String procedure_a,
//       required String description_a,
//       required String weekday,
//       required bool available,
//       required int start,
//       required int end,
//       required int day,
//       required int month,
//       required int year,
//       required int percentage}) async {
//     final Map<String, dynamic>? userObject =
//         await MongoDB.onlineusers.findOne(where.eq('phone', phone));
//     final deletedOffer = await MongoDB.onlineusers.update(await userObject, {
//       r'$pull': {
//         'offers': {
//           "available": available,
//           "docname": docname,
//           "procedure": procedure,
//           "description": description,
//           "docname_a": docname_a,
//           "procedure_a": procedure_a,
//           "description_a": description_a,
//           "percentage": percentage,
//           "weekday": weekday,
//           "start": start,
//           "end": end,
//           "day": day,
//           "month": month,
//           "year": year
//         }
//       }
//     });
//     return deletedOffer;
//   }

//   static Future deleteOfferFromReservedOffers(
//       {required String username,
//       required String dob,
//       required String phone,
//       required String docname,
//       required String procedure,
//       required String description,
//       required String docname_a,
//       required String procedure_a,
//       required String description_a,
//       required String weekday,
//       required bool available,
//       required int start,
//       required int end,
//       required int day,
//       required int month,
//       required int year,
//       required int percentage}) async {
//     final Map<String, dynamic> deletedreservedoffer =
//         await MongoDB.reservedoffers.remove(where
//             .eq('username', username)
//             .eq('dob', dob)
//             .eq('phone', phone)
//             .eq('docname', docname)
//             .eq('procedure', procedure)
//             .eq('description', description)
//             .eq('docname_a', docname_a)
//             .eq('procedure_a', procedure_a)
//             .eq('description_a', description_a)
//             .eq('weekday', weekday)
//             .eq('available', available)
//             .eq('start', start)
//             .eq('end', end)
//             .eq('percentage', percentage)
//             .eq('day', day)
//             .eq('month', month)
//             .eq('year', year));
//     return deletedreservedoffer;
//   }
// }

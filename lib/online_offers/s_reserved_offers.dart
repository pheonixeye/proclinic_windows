// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:proclinic_windows/EntryPage/entry_page.dart';
// import 'package:proclinic_windows/online_offers/mongo_offers.dart';
// import 'package:proclinic_windows/online_offers/offers_custom_widgets.dart';

// class ReservedOffersSection extends StatefulWidget {
//   @override
//   _ReservedOffersSectionState createState() => _ReservedOffersSectionState();
// }

// class _ReservedOffersSectionState extends State<ReservedOffersSection> {
//   TextEditingController searchController = TextEditingController();
//   void setstateinofferspage() {
//     setState(() {
//       print('setstate in offers called...');
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     ReservedOffersOnlineMongoDbSearchable
//         reservedOffersOnlineMongoDbSearchable =
//         ReservedOffersOnlineMongoDbSearchable(
//             userphone: searchController.text,
//             docname: searchController.text,
//             weekday: searchController.text);
//     return Column(
//       children: [
//         //title appbar
//         Expanded(
//           flex: 1,
//           child: OfferPageTitles(
//             title: 'Reserved Online Offers',
//           ),
//         ),
//         //search bar
//         Expanded(
//           flex: 1,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               decoration: thispagedecorationOUT,
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
//                 child: TextField(
//                   onChanged: (String value) {
//                     setState(() {});
//                   },
//                   controller: searchController,
//                   decoration: InputDecoration(
//                     hintText: 'Search by doctor / Weekday / phone',
//                     icon: Icon(Icons.search),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         //list of reserved offers
//         Expanded(
//           flex: 6,
//           child: StreamBuilder(
//               stream: searchController.text.isEmpty
//                   ? ReservedOffersOnlineMongoDb.offersOfMongo
//                   : reservedOffersOnlineMongoDbSearchable.offersOfMongo,
//               builder: (context, AsyncSnapshot snapshot) {
//                 List data = !snapshot.hasData ? [] : snapshot.data;
//                 return snapshot.connectionState == ConnectionState.waiting
//                     ? Center(
//                         child: CircularProgressIndicator.adaptive(),
//                       )
//                     : ListView.builder(
//                         itemBuilder: (context, index) {
//                           return ReservedOffersListTile(
//                             username: data[index]['username'],
//                             procedure: data[index]['procedure'],
//                             procedure_a: data[index]['procedure_a'],
//                             available: data[index]['available'],
//                             description: data[index]['description'],
//                             description_a: data[index]['description_a'],
//                             phone: data[index]['phone'],
//                             day: data[index]['sday'] as int,
//                             month: data[index]['smonth'] as int,
//                             year: data[index]['syear'] as int,
//                             docname: data[index]['docname'],
//                             docname_a: data[index]['docname_a'],
//                             weekday: data[index]['day'],
//                             start: data[index]['start'] as int,
//                             end: data[index]['end'] as int,
//                             percentage: data[index]['percentage'] as int,
//                             dob: data[index]['dob'],
//                             mysetstate: setstateinofferspage,
//                             index: index,
//                           );
//                         },
//                         itemCount: !snapshot.hasData ? 0 : data.length,
//                       );
//               }),
//         ),
//       ],
//     );
//   }
// }

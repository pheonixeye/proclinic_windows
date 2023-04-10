// import 'package:flutter/material.dart';
// import 'package:proclinic_windows/EntryPage/_widgets/doctors_dropdownmenubutton.dart';
// import 'package:proclinic_windows/online_offers/mongo_offers.dart';
// import 'package:proclinic_windows/online_offers/offers_custom_widgets.dart';
// import 'package:proclinic_windows/online_offers/s_add_offer.dart';
// import 'package:proclinic_windows/online_offers/s_available_offers.dart';
// import 'package:proclinic_windows/online_offers/s_reserved_offers.dart';

// class OnlineOffersPageUI extends StatefulWidget {
//   @override
//   _OnlineOffersPageUIState createState() => _OnlineOffersPageUIState();
// }

// class _OnlineOffersPageUIState extends State<OnlineOffersPageUI> {
//   mysetstate() {
//     setState(() {
//       print('mysetstate called');
//     });
//   }

//   TextEditingController descriptionControllerEnglish = TextEditingController();
//   TextEditingController descriptionControllerArabic = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Online Offers',
//           textScaleFactor: 2,
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           decoration: thispagedecorationOUT,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               decoration: thispagedecorationIN,
//               child: Row(
//                 children: [
//                   //creat an offer
//                   Expanded(
//                     flex: 1,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
//                         decoration: thispagedecorationIN,
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: AddOfferSection(
//                             descriptionControllerEnglish:
//                                 descriptionControllerEnglish,
//                             descriptionControllerArabic:
//                                 descriptionControllerArabic,
//                             mysetstate: mysetstate,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   //available offers
//                   Expanded(
//                     flex: 1,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
//                         decoration: thispagedecorationIN,
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: AvailableOffersSection(
//                             mysetstate: mysetstate,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   //reserved online offers
//                   Expanded(
//                     flex: 1,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
//                         decoration: thispagedecorationIN,
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: ReservedOffersSection(),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

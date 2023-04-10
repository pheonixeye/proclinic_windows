// import 'package:flutter/material.dart';
// import 'package:proclinic_windows/EntryPage/_widgets/doctors_dropdownmenubutton.dart';
// import 'package:proclinic_windows/online_offers/mongo_offers.dart';
// import 'package:proclinic_windows/online_offers/offers_custom_widgets.dart';

// class AddOfferSection extends StatefulWidget {
//   final Function mysetstate;
//   final TextEditingController descriptionControllerEnglish;
//   final TextEditingController descriptionControllerArabic;

//   const AddOfferSection(
//       {Key? key,
//       required this.mysetstate,
//       required this.descriptionControllerArabic,
//       required this.descriptionControllerEnglish})
//       : super(key: key);
//   @override
//   _AddOfferSectionState createState() => _AddOfferSectionState();
// }

// class _AddOfferSectionState extends State<AddOfferSection> {
//   final SnackBar snackbar = SnackBar(
//       content: Row(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       Text(
//         'Offer Added',
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: 24,
//         ),
//       ),
//       SizedBox(
//         width: 20,
//       ),
//       Icon(
//         Icons.thumb_up_alt,
//         color: Colors.green,
//       )
//     ],
//   ));
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: [
//         //title appbar
//         OfferPageTitles(
//           title: 'Create an Offer',
//         ),
//         //percentage dropdown
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             children: [
//               Expanded(
//                 flex: 1,
//                 child: Text('Percentage % :'),
//               ),
//               Expanded(
//                 flex: 3,
//                 child: PercentageDropDownButton(
//                   mysetstate: widget.mysetstate,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         //doctor dropdown
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text('Select Clinic :'),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: NewlyFormatedDoctorsDropDownButton(),
//         ),
//         //procedure selector english
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text('Select Procedure :'),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: ProcedurePickerInOffersPageFromDb(
//             english: true,
//           ),
//         ),
//         //procedure selector arabic
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text('اختر الإجراء الطبي'),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: ProcedurePickerInOffersPageFromDb(
//             english: false,
//           ),
//         ),
//         //description textfield english
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text('Offer Description :'),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Container(
//             decoration: thispagedecorationOUT,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8.0),
//               child: TextField(
//                 controller: widget.descriptionControllerEnglish,
//                 decoration: InputDecoration(
//                   hintText: 'Create an offer description...',
//                   icon: Icon(Icons.local_offer),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         //description textfield english
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text('تفاصيل العرض'),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Container(
//             decoration: thispagedecorationOUT,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8.0),
//               child: TextField(
//                 controller: widget.descriptionControllerArabic,
//                 decoration: InputDecoration(
//                   hintText: 'وصف تفصيلي للعرض المطروح',
//                   icon: Icon(Icons.local_offer),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         //center ==>> button for add to db

//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text('Finalize :'),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: ElevatedButton.icon(
//             style: ElevatedButton.styleFrom(
//               primary: Theme.of(context).primaryColor,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//             ),
//             onPressed: () async {
//               //TODO: add offer to db
//               await OnlineOffersMongodb.addOffer(
//                   docname: '',
//                   docname_a: '',
//                   procedure: offersProcedure!,
//                   procedure_a: offersProcedure_a!,
//                   percentage: globalvaluepercentageonoffer!,
//                   description: widget.descriptionControllerEnglish.text,
//                   description_a: widget.descriptionControllerArabic.text,
//                   available: true);
//               ScaffoldMessenger.of(context).showSnackBar(snackbar);
//               setState(() {});
//               widget.mysetstate();
//             },
//             icon: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Icon(Icons.add_business_rounded),
//             ),
//             label: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text('Add Offer...'),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

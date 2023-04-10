// // ignore_for_file: avoid_print

// import 'dart:math';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:proclinic_windows/EntryPage/entry_page.dart';
// import 'package:proclinic_windows/online_offers/mongo_offers.dart';

// final BoxDecoration thispagedecorationIN = BoxDecoration(
//   boxShadow: <BoxShadow>[
//     BoxShadow(
//       offset: const Offset(0.0, 0.0),
//       blurRadius: 2,
//       spreadRadius: 2,
//       color: Colors.primaries[Random.secure().nextInt(Colors.primaries.length)],
//     ),
//   ],
//   color: Colors.white,
//   borderRadius: BorderRadius.circular(10),
// );

// final BoxDecoration thispagedecorationOUT = BoxDecoration(
//   boxShadow: <BoxShadow>[
//     BoxShadow(
//       offset: const Offset(5.0, 5.0),
//       blurRadius: 5,
//       spreadRadius: 5,
//       color: Colors.primaries[Random.secure().nextInt(Colors.primaries.length)],
//     ),
//   ],
//   color: Colors.grey[300],
//   borderRadius: BorderRadius.circular(10),
// );

// class OfferPageTitles extends StatelessWidget {
//   final String title;
//   const OfferPageTitles({
//     Key? key,
//     required this.title,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: AppBar(
//         elevation: 20,
//         title: Text(title),
//         automaticallyImplyLeading: false,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadiusDirectional.only(
//             bottomStart: Radius.circular(15),
//             topEnd: Radius.circular(15),
//           ),
//         ),
//         centerTitle: true,
//       ),
//     );
//   }
// }

// const List<int> percent = [5, 10, 25, 30, 40, 50];
// int? globalvaluepercentageonoffer;

// class PercentageDropDownButton extends StatefulWidget {
//   final Function mysetstate;
//   const PercentageDropDownButton({Key? key, required this.mysetstate})
//       : super(key: key);
//   @override
//   _PercentageDropDownButtonState createState() =>
//       _PercentageDropDownButtonState();
// }

// class _PercentageDropDownButtonState extends State<PercentageDropDownButton> {
//   int? selectedvalue;

//   final List<DropdownMenuItem<int>> _items = percent.map((e) {
//     return DropdownMenuItem<int>(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//             child: Text(
//               '$e %',
//               textAlign: TextAlign.center,
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ),
//         ],
//       ),
//       value: percent.indexOf(e),
//     );
//   }).toList();

//   @override
//   void initState() {
//     super.initState();
//     selectedvalue = percent[0];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 150,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           decoration: thispagedecorationOUT,
//           child: DropdownButton<int>(
//             isExpanded: true,
//             hint: const Text('Select Percentage...'),
//             value: selectedvalue,
//             onChanged: (value) {
//               setState(() {
//                 selectedvalue = value;
//                 globalvaluepercentageonoffer = percent[value!];
//                 print(selectedvalue);
//                 print(value);
//               });
//               widget.mysetstate();
//             },
//             items: _items,
//             underline: Container(
//               height: 2,
//               color: Theme.of(context).primaryColor,
//             ),
//             icon: Icon(
//               Icons.arrow_drop_down_circle_rounded,
//               color: Theme.of(context).primaryColor,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// String? offersProcedure;
// String? offersProcedure_a;

// class ProcedurePickerInOffersPageFromDb extends StatefulWidget {
//   final bool english;

//   const ProcedurePickerInOffersPageFromDb({Key? key, required this.english})
//       : super(key: key);
//   @override
//   ProcedurePickerInOffersPageFromDbState createState() =>
//       ProcedurePickerInOffersPageFromDbState();
// }

// class ProcedurePickerInOffersPageFromDbState
//     extends State<ProcedurePickerInOffersPageFromDb> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//         height: 50.0,
//         child: Container(
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             boxShadow: const [
//               BoxShadow(
//                 offset: Offset(4.0, 4.0),
//                 blurRadius: 4.0,
//               ),
//             ],
//             color: Colors.grey[300],
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: StreamBuilder(
//             stream: null,
//             builder: (context, AsyncSnapshot snapshot) {
//               List data = !snapshot.hasData ? [] : snapshot.data;
//               // List data = snapshot.data;
//               if (!snapshot.hasData) {
//                 return CircularProgressIndicator();
//               } else {
//                 return ListTile(
//                   title: CupertinoPicker(
//                     looping: true,
//                     itemExtent: 30.0,
//                     onSelectedItemChanged: (int item) {
//                       setState(() {
//                         print(data[item]);

//                         if (widget.english) {
//                           offersProcedure = data[item];
//                           print(offersProcedure);
//                         } else if (!widget.english) {
//                           offersProcedure_a = data[item];
//                           print(offersProcedure_a);
//                         }
//                         // widget.english
//                         //     ? offersProcedure = data[item]
//                         //     : print(offersProcedure);
//                         // !widget.english
//                         //     ? offersProcedure_a = data[item]
//                         //     : print(offersProcedure_a);
//                       });
//                     },
//                     children: data.map((e) {
//                       return Text(
//                           data.isEmpty ? 'No Proceduers' : e.toString());
//                     }).toList(),
//                   ),
//                   trailing: Icon(
//                     Icons.unfold_more,
//                     color: Colors.black,
//                   ),
//                 );
//               }
//             },
//           ),
//         ));
//   }
// }

// //
// //----------------------
// //
// class CustomPopUpMenuButtonForOffersListTile extends StatefulWidget {
//   final Function mysetstate;
//   final Function(BuildContext) attendPatient;
//   final Function(BuildContext) deleteEntry;

//   const CustomPopUpMenuButtonForOffersListTile(
//       {Key? key,
//       required this.mysetstate,
//       required this.attendPatient,
//       required this.deleteEntry})
//       : super(key: key);
//   @override
//   _CustomPopUpMenuButtonForOffersListTileState createState() =>
//       _CustomPopUpMenuButtonForOffersListTileState();
// }

// class _CustomPopUpMenuButtonForOffersListTileState
//     extends State<CustomPopUpMenuButtonForOffersListTile> {
//   static List<int> _items = [0, 1];
//   static List<String> _stringitems = ['Attend Patient', 'Delete Entry'];
//   static List<IconData> _iconDataitems = [Icons.edit, Icons.delete_forever];
//   static List<MaterialColor> _colors = [Colors.green, Colors.red];

//   static List<PopupMenuItem<int>> _itemList = _items.map((e) {
//     return PopupMenuItem(
//       value: e,
//       child: Row(
//         children: [
//           Icon(
//             _iconDataitems[e],
//             color: _colors[e],
//           ),
//           SizedBox(
//             width: 10,
//           ),
//           Text('${_stringitems[e]}'),
//         ],
//       ),
//     );
//   }).toList();
//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton(
//       onSelected: (int value) async {
//         switch (value) {
//           case 0:
//             await widget.attendPatient(context);
//             break;
//           case 1:
//             await widget.deleteEntry(context);
//             break;
//           default:
//         }
//         widget.mysetstate();
//       },
//       itemBuilder: (context) {
//         return _itemList;
//       },
//       icon: Icon(
//         Icons.menu_open,
//         color: Colors.white,
//       ),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//     );
//   }
// }

// //--------------------------
// ////////////////////////////
// ///------------------------------

// class ReservedOffersListTile extends StatelessWidget {
//   final String username;
//   final String dob;
//   final String phone;
//   final String procedure;
//   final String procedure_a;
//   final String docname;
//   final String docname_a;
//   final String description;
//   final String description_a;
//   final String weekday;
//   final int start;
//   final int end;
//   final int day;
//   final int month;
//   final int year;
//   final int index;
//   final int percentage;
//   final bool available;
//   final Function mysetstate;

//   const ReservedOffersListTile(
//       {Key? key,
//       required this.username,
//       required this.phone,
//       required this.procedure,
//       required this.docname,
//       required this.description,
//       required this.weekday,
//       required this.start,
//       required this.end,
//       required this.day,
//       required this.month,
//       required this.year,
//       required this.percentage,
//       required this.available,
//       required this.dob,
//       required this.mysetstate,
//       required this.index,
//       required this.procedure_a,
//       required this.docname_a,
//       required this.description_a})
//       : super(key: key);

//   deleteOffer(BuildContext context) async {
//     return showDialog(
//         context: context,
//         builder: (context) {
//           return Padding(
//             padding: EdgeInsets.symmetric(
//                 vertical: MediaQuery.of(context).size.height * 0.3,
//                 horizontal: MediaQuery.of(context).size.width * 0.3),
//             child: AlertDialog(
//               title: Center(
//                   child: Text(
//                 'Delete Entry...',
//                 textAlign: TextAlign.center,
//               )),
//               content: Center(
//                 child: Text(
//                   'Deleting This Entry Will Make It UnAvailable...\nAre You Sure??',
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               actions: [
//                 ElevatedButton.icon(
//                   style: ElevatedButton.styleFrom(
//                       primary: Theme.of(context).primaryColor,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       )),
//                   onPressed: () async {
//                     await collectiveDelete();
//                     Navigator.pop(context);
//                   },
//                   icon: Icon(Icons.check, color: Colors.green),
//                   label: Text('Confirm'),
//                 ),
//                 Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: MediaQuery.of(context).size.width * 0.05)),
//                 ElevatedButton.icon(
//                   style: ElevatedButton.styleFrom(
//                       primary: Theme.of(context).primaryColor,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       )),
//                   onPressed: () async {
//                     Navigator.pop(context);
//                   },
//                   icon: Icon(Icons.close, color: Colors.red),
//                   label: Text('Cancel'),
//                 ),
//               ],
//             ),
//           );
//         });
//   }

//   Future collectiveDelete() async {
//     await ReservedOffersAndOffersOfUsers.deleteOfferFromUser(
//         docname: docname,
//         docname_a: docname_a,
//         procedure_a: procedure_a,
//         description_a: description_a,
//         percentage: percentage,
//         phone: phone,
//         procedure: procedure,
//         description: description,
//         day: day,
//         month: month,
//         year: year,
//         weekday: weekday,
//         start: start,
//         end: end,
//         available: available);
//     await ReservedOffersAndOffersOfUsers.deleteOfferFromReservedOffers(
//         username: username,
//         dob: dob,
//         docname: docname,
//         docname_a: docname_a,
//         procedure_a: procedure_a,
//         description_a: description_a,
//         percentage: percentage,
//         phone: phone,
//         procedure: procedure,
//         description: description,
//         day: day,
//         month: month,
//         year: year,
//         weekday: weekday,
//         start: start,
//         end: end,
//         available: available);
//   }

//   attendPatient(BuildContext context) {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//           builder: (context) => HomePageWithTabView(),
//           settings: RouteSettings(arguments: {
//             'date':
//                 '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}',
//             'ptname': username,
//             'phone': phone,
//             'dob': dob
//           })),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: CircleAvatar(
//         backgroundColor:
//             Colors.primaries[Random.secure().nextInt(Colors.primaries.length)],
//         child: Text(
//           '$index',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       title: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           CardItemOfOfferItem(
//             item: 'Doctor',
//             value: docname,
//           ),
//           CardItemOfOfferItem(
//             item: 'Doctor_a',
//             value: docname_a,
//           ),
//           CardItemOfOfferItem(
//             item: 'Username',
//             value: username,
//           ),
//           CardItemOfOfferItem(
//             item: 'Phone',
//             value: phone,
//           ),
//           CardItemOfOfferItem(
//             item: 'Date',
//             value: '${day}-${month}-${year}',
//           ),
//           CardItemOfOfferItem(
//             item: 'Weekday',
//             value: '$weekday',
//           ),
//           CardItemOfOfferItem(
//             item: 'Time',
//             value: '$start - $end',
//           ),
//           CardItemOfOfferItem(
//             item: 'Procedure',
//             value: procedure,
//           ),
//           CardItemOfOfferItem(
//             item: 'Procedure_a',
//             value: procedure_a,
//           ),
//           CardItemOfOfferItem(
//             item: 'Description',
//             value: description,
//           ),
//           CardItemOfOfferItem(
//             item: 'Description_a',
//             value: description_a,
//           ),
//           CardItemOfOfferItem(
//             item: 'Discount',
//             value: '$percentage %',
//           ),
//           CardItemOfOfferItem(
//             item: 'Available',
//             value: '$available',
//           ),
//         ],
//       ),
//       subtitle: Divider(
//         color: Theme.of(context).primaryColor,
//         thickness: 5,
//         height: 5,
//       ),
//       trailing: CircleAvatar(
//           backgroundColor: Colors.orange,
//           child: CustomPopUpMenuButtonForOffersListTile(
//             deleteEntry: deleteOffer,
//             mysetstate: mysetstate,
//             attendPatient: attendPatient,
//           )),
//     );
//   }
// }

// class CardItemOfOfferItem extends StatelessWidget {
//   final String item;
//   final String value;
//   const CardItemOfOfferItem({
//     Key? key,
//     required this.item,
//     required this.value,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Card(
//         child: Row(
//           children: [
//             CircleAvatar(
//               radius: 10,
//             ),
//             SizedBox(
//               width: 10,
//             ),
//             SizedBox(
//               width: item.length * 10.floorToDouble(),
//               child: Text(
//                 '$item',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ),
//             Text('$value'),
//           ],
//         ),
//       ),
//     );
//   }
// }

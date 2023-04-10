// // ignore_for_file: avoid_function_literals_in_foreach_calls, unnecessary_brace_in_string_interps, file_names

// import 'dart:math';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:proclinic_windows/EntryPage/_widgets/doctors_dropdownmenubutton.dart';
// import 'package:proclinic_windows/send_msg_to_pt/allpts_onedoc_dropdown.dart';
// import 'package:proclinic_windows/send_msg_to_pt/patients_list.dart';
// import 'package:proclinic_windows/send_msg_to_pt/smseg.dart';

// class SendMessagePage extends StatefulWidget {
//   const SendMessagePage({Key? key}) : super(key: key);

//   @override
//   _SendMessagePageState createState() => _SendMessagePageState();
// }

// class _SendMessagePageState extends State<SendMessagePage> {
//   final _scrollcontroller = ScrollController();
//   // PingGoogle ping = PingGoogle();
//   TextEditingController msgcontroller = TextEditingController();
//   // SMS sms = SMS();
//   // bool docvis = false;
//   Map<String, String> balance = {};
//   void callsetstate() {
//     setState(() {});
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     CreditSMSEG creditSMSEG = CreditSMSEG();

//     // print(balanceStream);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Patient Messenger',
//           textScaleFactor: 2.0,
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         actions: [
//           StreamBuilder(
//             stream: creditSMSEG.credit,
//             builder: (context, AsyncSnapshot snapshot) {
//               Map data;
//               String balance;
//               String points;
//               if (snapshot.data == 'error') {
//                 balance = 'Error !!';
//                 points = 'Error !!';
//               } else {
//                 data = !snapshot.hasData ? {} : snapshot.data;
//                 balance =
//                     !snapshot.hasData ? '' : data['data']['balance'].toString();
//                 points =
//                     !snapshot.hasData ? '' : data['data']['points'].toString();
//               }

//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Center(
//                     child: Text('BALANCE : ${balance} L.E.\nSMS : ${points}')),
//               );
//             },
//           )
//         ],
//         centerTitle: true,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(20.0),
//             bottomRight: Radius.circular(20.0),
//           ),
//         ),
//       ),
//       backgroundColor: Colors.grey[400],
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors
//                       .primaries[Random().nextInt(Colors.primaries.length)],
//                   offset: const Offset(4.0, 4.0),
//                   blurRadius: 4.0,
//                 ),
//               ]),
//           child: Row(
//             children: [
//               //patient selection side
//               Expanded(
//                 flex: 1,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: Colors.white,
//                         boxShadow: [
//                           BoxShadow(
//                               color: Colors.primaries[
//                                   Random().nextInt(Colors.primaries.length)],
//                               offset: const Offset(0, 0),
//                               blurRadius: 4.0,
//                               spreadRadius: 4.0),
//                         ]),
//                     //patient selection pane
//                     child: Column(
//                       children: [
//                         //one doc or all pts
//                         Expanded(
//                           flex: 1,
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 flex: 1,
//                                 child: AllPtsOneDoctorDropDown(
//                                   // docvis: docvis,
//                                   callsetstate: callsetstate,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         //doc selection dropdown
//                         Visibility(
//                           visible: AllPtsOneDoctorDropDown.docvis != null
//                               ? AllPtsOneDoctorDropDown.docvis!
//                               : false,
//                           child: Expanded(
//                             flex: 1,
//                             child: Row(
//                               children: const [
//                                 Expanded(
//                                   flex: 1,
//                                   child: Padding(
//                                     padding: EdgeInsets.all(12.0),
//                                     child: NewlyFormatedDoctorsDropDownButton(),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         //patient list stream
//                         Expanded(
//                           flex: 6,
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               width: MediaQuery.of(context).size.width * 0.3,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: Colors.white,
//                                 boxShadow: [
//                                   BoxShadow(
//                                       color: Colors.primaries[Random()
//                                           .nextInt(Colors.primaries.length)],
//                                       offset: const Offset(0, 0),
//                                       blurRadius: 4.0,
//                                       spreadRadius: 4.0),
//                                 ],
//                               ),
//                               child: ContactsSelector(
//                                 callsetstate: callsetstate,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               const VerticalDivider(
//                 color: Colors.blueGrey,
//                 thickness: 5,
//                 width: 15,
//                 indent: 10,
//                 endIndent: 10,
//               ),
//               //messages side
//               Expanded(
//                 flex: 2,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: Colors.white,
//                         boxShadow: [
//                           BoxShadow(
//                               color: Colors.primaries[
//                                   Random().nextInt(Colors.primaries.length)],
//                               offset: const Offset(0, 0),
//                               blurRadius: 4.0,
//                               spreadRadius: 4.0),
//                         ]),
//                     child: Column(
//                       children: [
//                         //selected contacts side & progress
//                         Expanded(
//                           flex: 8,
//                           child: Padding(
//                             padding: const EdgeInsets.all(12.0),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: Colors.white,
//                                   boxShadow: [
//                                     BoxShadow(
//                                         color: Colors.primaries[Random()
//                                             .nextInt(Colors.primaries.length)],
//                                         offset: const Offset(0, 0),
//                                         blurRadius: 4.0,
//                                         spreadRadius: 4.0),
//                                   ]),
//                               child: CupertinoScrollbar(
//                                 thickness: 20,
//                                 isAlwaysShown: true,
//                                 controller: _scrollcontroller,
//                                 child: GridView.builder(
//                                   controller: _scrollcontroller,
//                                   itemCount:
//                                       ContactsSelector.selectednos.length,
//                                   itemBuilder: (context, index) {
//                                     return ListTile(
//                                       leading: CircleAvatar(
//                                         child: Text('${index + 1}'),
//                                       ),
//                                       title: Text(
//                                           '${ContactsSelector.selectednos[index]['ptname']}'),
//                                       subtitle: Text(
//                                           '${ContactsSelector.selectednos[index]['phone']}'),
//                                       trailing: IconButton(
//                                         icon: const Icon(Icons.delete_forever),
//                                         onPressed: () {
//                                           setState(() {
//                                             ContactsSelector.selectednos.remove(
//                                                 ContactsSelector
//                                                     .selectednos[index]);
//                                           });
//                                         },
//                                       ),
//                                     );
//                                   },
//                                   gridDelegate:
//                                       const SliverGridDelegateWithFixedCrossAxisCount(
//                                           crossAxisCount: 3,
//                                           childAspectRatio: 5),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           child: Row(
//                             children: [
//                               const Expanded(
//                                 flex: 10,
//                                 child: Divider(
//                                   color: Colors.blueGrey,
//                                   thickness: 5,
//                                   height: 15,
//                                   indent: 10,
//                                   endIndent: 10,
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 2,
//                                 child: Text(
//                                     'Selected Contacts : ${ContactsSelector.selectednos.length}'),
//                               ),
//                               Expanded(
//                                 flex: 1,
//                                 child: IconButton(
//                                   tooltip: 'Clear Selection',
//                                   icon: const Icon(Icons.clear_all_rounded),
//                                   onPressed: () {
//                                     ContactsSelector.selectednos.clear();
//                                     setState(() {});
//                                   },
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         //message body and sender button
//                         Expanded(
//                           flex: 3,
//                           child: Padding(
//                             padding: const EdgeInsets.all(12.0),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: Colors.white,
//                                   boxShadow: [
//                                     BoxShadow(
//                                         color: Colors.primaries[Random()
//                                             .nextInt(Colors.primaries.length)],
//                                         offset: const Offset(0, 0),
//                                         blurRadius: 4.0,
//                                         spreadRadius: 4.0),
//                                   ]),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     flex: 9,
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(12.0),
//                                       child: TextField(
//                                         maxLength: 160,
//                                         onChanged: (String txt) {
//                                           setState(() {});
//                                         },
//                                         decoration: InputDecoration(
//                                           prefixIcon: const Icon(Icons.message),
//                                           border: const OutlineInputBorder(),
//                                           labelText: 'Input Message...',
//                                           counter: Text(
//                                             'English SMS : ${msgcontroller.text.length} / 140 - Arabic SMS : ${msgcontroller.text.length} / 70 ',
//                                             textAlign: TextAlign.center,
//                                           ),
//                                           // counterText: ' / 160',
//                                         ),
//                                         controller: msgcontroller,
//                                         style: const TextStyle(fontSize: 24),
//                                         maxLines: null,
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 2,
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: ElevatedButton.icon(
//                                             style: ElevatedButton.styleFrom(
//                                               shape: RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           10)),
//                                               primary: Theme.of(context)
//                                                   .primaryColor,
//                                             ),
//                                             icon: const Icon(Icons.send),
//                                             label: const Text('SMS'),
//                                             onPressed: () async {
//                                               //TODO: modify logic
//                                               if (ContactsSelector
//                                                       .selectednos.isEmpty ||
//                                                   msgcontroller.text.isEmpty) {
//                                                 // showAlertDialogMISSINGptsORsms(
//                                                 //     context);
//                                                 setState(() {});
//                                               } else {
//                                                 var abdo;
//                                                 ContactsSelector.selectednos
//                                                     .forEach((e) async {
//                                                   await makesmsrequest(
//                                                     message: msgcontroller.text,
//                                                     mobile: '2${e['phone']}',
//                                                   ).then((response) {
//                                                     abdo = response ??
//                                                         response.toString();
//                                                   });
//                                                   // showdialogsendmsgresult(
//                                                   //     context: context,
//                                                   //     message: abdo.toString(),
//                                                   //     number: e['phone'],
//                                                   //     name: e['ptname']
//                                                   //         .toString()
//                                                   //         .toUpperCase());
//                                                 });
//                                                 setState(() {});
//                                                 await Future.delayed(
//                                                     const Duration(seconds: 1));
//                                                 setState(() {});
//                                                 msgcontroller.clear();
//                                                 setState(() {});

//                                                 ContactsSelector.selectednos
//                                                     .clear();

//                                                 setState(() {});
//                                               }
//                                             },
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

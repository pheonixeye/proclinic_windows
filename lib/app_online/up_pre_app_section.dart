// import 'dart:math';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:proclinic_windows/EntryPage/entry_page.dart';
// import 'package:proclinic_windows/app_online/app_page_online.dart';
// import 'package:proclinic_windows/app_online/mongo_online/mongo_online_app.dart';
// import 'package:proclinic_windows/app_online/selector_button.dart';

// class UpcomingAppointementsSection extends StatefulWidget {
//   @override
//   _UpcomingAppointementsSectionState createState() =>
//       _UpcomingAppointementsSectionState();
// }

// class _UpcomingAppointementsSectionState
//     extends State<UpcomingAppointementsSection> {
//   OnlineAppointementsUpcoming onlineAppointementsUpcoming =
//       OnlineAppointementsUpcoming();
//   ScrollController scrollController = ScrollController();

//   _mysetstate() {
//     setState(() {
//       print('setstate autofired');
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         decoration: onlineAppfixedboxdecoration2,
//         child: StreamBuilder(
//           stream: onlineAppointementsUpcoming.onlineAppsmongo,
//           builder: (context, AsyncSnapshot snapshot) {
//             List data = snapshot.hasData ? snapshot.data : [];
//             return CupertinoScrollbar(
//               controller: scrollController,
//               thickness: 20,
//               thicknessWhileDragging: 20,
//               isAlwaysShown: true,
//               radius: Radius.circular(10),
//               child: ListView.builder(
//                 controller: scrollController,
//                 itemCount: data.length,
//                 itemBuilder: (context, index) {
//                   int sday = data[index]['sday'];
//                   int smonth = data[index]['smonth'];
//                   int syear = data[index]['syear'];
//                   DateTime dateOfAppointement = DateTime(syear, smonth, sday);
//                   print(dateOfAppointement);
//                   return dateOfAppointement.isBefore(DateTime(
//                           DateTime.now().year,
//                           DateTime.now().month,
//                           DateTime.now().day))
//                       ? SizedBox()
//                       : OnlineListTile(
//                           docname: data[index]['docname'],
//                           clinic: data[index]['clinic'],
//                           phone: data[index]['phone'],
//                           ptname: data[index]['username'],
//                           weekday: data[index]['day'],
//                           time: '${data[index]['start']}-${data[index]['end']}',
//                           start: data[index]['start'],
//                           end: data[index]['end'],
//                           date:
//                               '${data[index]['sday']}-${data[index]['smonth']}-${data[index]['syear']}',
//                           dob: data[index]['dob'],
//                           day: data[index]['sday'],
//                           month: data[index]['smonth'],
//                           year: data[index]['syear'],
//                           mysetstate: _mysetstate,
//                         );
//                 },
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class PreviousAppointementsSection extends StatefulWidget {
//   @override
//   _PreviousAppointementsSectionState createState() =>
//       _PreviousAppointementsSectionState();
// }

// class _PreviousAppointementsSectionState
//     extends State<PreviousAppointementsSection> {
//   _mysetstate() {
//     setState(() {});
//   }

//   OnlineAppointementsUpcoming onlineAppointementsUpcoming =
//       OnlineAppointementsUpcoming();
//   ScrollController scrollController = ScrollController();
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         decoration: onlineAppfixedboxdecoration2,
//         child: StreamBuilder(
//           stream: onlineAppointementsUpcoming.onlineAppsmongo,
//           builder: (context, AsyncSnapshot snapshot) {
//             List data = snapshot.hasData ? snapshot.data : [];
//             return CupertinoScrollbar(
//               controller: scrollController,
//               thickness: 20,
//               thicknessWhileDragging: 20,
//               isAlwaysShown: true,
//               radius: Radius.circular(10),
//               child: ListView.builder(
//                 controller: scrollController,
//                 itemCount: data.length,
//                 itemBuilder: (context, index) {
//                   int sday = data[index]['sday'];
//                   int smonth = data[index]['smonth'];
//                   int syear = data[index]['syear'];
//                   DateTime dateOfAppointement = DateTime(syear, smonth, sday);
//                   print(dateOfAppointement);
//                   return dateOfAppointement.isBefore(DateTime(
//                           DateTime.now().year,
//                           DateTime.now().month,
//                           DateTime.now().day))
//                       ? OnlineListTile(
//                           docname: data[index]['docname'],
//                           clinic: data[index]['clinic'],
//                           phone: data[index]['phone'],
//                           ptname: data[index]['username'],
//                           weekday: data[index]['day'],
//                           time: '${data[index]['start']}-${data[index]['end']}',
//                           start: data[index]['start'],
//                           end: data[index]['end'],
//                           date:
//                               '${data[index]['sday']}-${data[index]['smonth']}-${data[index]['syear']}',
//                           dob: data[index]['dob'],
//                           day: data[index]['sday'],
//                           month: data[index]['smonth'],
//                           year: data[index]['syear'],
//                           mysetstate: _mysetstate,
//                         )
//                       : SizedBox();
//                 },
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class OnlineListTile extends StatelessWidget {
//   final String docname;
//   final String clinic;
//   final String ptname;
//   final String phone;
//   final String weekday;
//   final String date;
//   final String time;
//   final int start;
//   final int end;
//   final String dob;
//   final int day;
//   final int month;
//   final int year;
//   final Function mysetstate;

//   OnlineListTile(
//       {Key? key,
//       required this.docname,
//       required this.ptname,
//       required this.phone,
//       required this.weekday,
//       required this.date,
//       required this.time,
//       required this.dob,
//       required this.mysetstate,
//       required this.day,
//       required this.month,
//       required this.year,
//       required this.start,
//       required this.end,
//       required this.clinic})
//       : super(key: key);
//   SnackBar showinfosnackbar({required String message}) {
//     final SnackBar snkbr = SnackBar(
//         content: Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text('$message'),
//         SizedBox(
//           width: 20,
//         ),
//         Icon(
//           Icons.thumb_up,
//           color: Colors.green,
//         )
//       ],
//     ));
//     return snkbr;
//   }

//   _attendPatient(BuildContext context) {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//           builder: (context) => HomePageWithTabView(),
//           settings: RouteSettings(arguments: {
//             'date':
//                 '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}',
//             'ptname': ptname,
//             'phone': phone,
//             'dob': dob
//           })),
//     );
//   }

//   _deleteEntry(BuildContext context) async {
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
//                     await _collectiveDelete();
//                     await ScaffoldMessenger.of(context).showSnackBar(
//                         showinfosnackbar(message: 'Entry Deleted...'));
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

//   _collectiveDelete() async {
//     print('collective delete called');
//     await OnlineAppointementsUpcoming.deleteEntryFromAppointmentsCollection(
//         day: day,
//         clinic: clinic,
//         dob: dob,
//         docname: docname,
//         phone: phone,
//         ptname: ptname,
//         start: start,
//         end: end,
//         month: month,
//         year: year,
//         weekday: weekday);
//   }

//   _reschedule(BuildContext context) async {
//     final DateTime? abdo = await showDatePicker(
//       context: context,
//       initialDate: DateTime(
//           DateTime.now().year, DateTime.now().month, DateTime.now().day),
//       firstDate: DateTime(
//           DateTime.now().year, DateTime.now().month, DateTime.now().day),
//       lastDate: DateTime(
//           DateTime.now().year, DateTime.now().month, DateTime.now().day + 28),
//     );

//     await OnlineAppointementsUpcoming
//         .updateEntryDayMonthYearFromAppointmentsCollection(
//       day: day,
//       clinic: clinic,
//       dob: dob,
//       docname: docname,
//       phone: phone,
//       ptname: ptname,
//       start: start,
//       end: end,
//       month: month,
//       year: year,
//       weekday: weekday,
//       newsday: abdo!.day,
//       newsmonth: abdo.month,
//       newsyear: abdo.year,
//     );
//     await ScaffoldMessenger.of(context)
//         .showSnackBar(showinfosnackbar(message: 'Date Updated...'));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       tileColor: Colors.grey[350],
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       leading: CircleAvatar(),
//       title: Card(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: SizedBox(
//                     width: 30,
//                     child: Icon(Icons.person),
//                   ),
//                 ),
//                 Text(
//                   'Name : ',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 Text('${ptname.toUpperCase()}'),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: SizedBox(
//                     width: 30,
//                     child: Icon(Icons.phone),
//                   ),
//                 ),
//                 Text(
//                   'Phone : ',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 Text('$phone'),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: SizedBox(
//                     width: 30,
//                     child: Icon(Icons.child_friendly),
//                   ),
//                 ),
//                 Text(
//                   'DoB : ',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 Text('$dob'),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: SizedBox(
//                     width: 30,
//                     child: Icon(Icons.medical_services),
//                   ),
//                 ),
//                 Text(
//                   'Clinic : ',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 Text('$clinic'),
//               ],
//             ),
//           ),
//         ),
//       ),
//       subtitle: Card(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: SizedBox(
//                     width: 30,
//                     child: Icon(Icons.local_hospital_sharp),
//                   ),
//                 ),
//                 Text(
//                   'Doctor : ',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 Text('${docname.toUpperCase()}'),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: SizedBox(
//                     width: 30,
//                     child: Icon(Icons.calendar_today_outlined),
//                   ),
//                 ),
//                 Text(
//                   'Date : ',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 Text('$date'),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: SizedBox(
//                     width: 30,
//                     child: Icon(Icons.date_range_outlined),
//                   ),
//                 ),
//                 Text(
//                   'Weekday : ',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 Text('$weekday'),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: SizedBox(
//                     width: 30,
//                     child: Icon(Icons.alarm),
//                   ),
//                 ),
//                 Text(
//                   'Time : ',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 Text('$time'),
//               ],
//             ),
//           ),
//         ),
//       ),
//       trailing: CircleAvatar(
//         radius: 20,
//         backgroundColor: Colors.orange,
//         child: CustomPopUpMenuButtonForAppointementsListTile(
//           mysetstate: mysetstate,
//           attendPatient: _attendPatient,
//           deleteEntry: _deleteEntry,
//           reschedule: _reschedule,
//         ),
//       ),
//     );
//   }
// }

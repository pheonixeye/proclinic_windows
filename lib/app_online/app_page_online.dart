// import 'dart:math';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:proclinic_windows/app_online/mongo_online/mongo_online_app.dart';
// import 'package:proclinic_windows/app_online/onlineUsersSection.dart';
// import 'package:proclinic_windows/app_online/up_pre_app_section.dart';

// final BoxDecoration onlineAppfixedboxdecoration1 = BoxDecoration(
//   color: Colors.grey[400],
//   borderRadius: BorderRadius.circular(10),
//   boxShadow: [
//     BoxShadow(
//       offset: Offset(0, 0),
//       blurRadius: 3.0,
//       spreadRadius: 3.0,
//       color: const Color(4278190080),
//     ),
//   ],
// );
// final BoxDecoration onlineAppfixedboxdecoration2 = BoxDecoration(
//   color: Colors.white,
//   borderRadius: BorderRadius.circular(10),
//   boxShadow: [
//     BoxShadow(
//       offset: Offset(0, 0),
//       blurRadius: 3.0,
//       spreadRadius: 3.0,
//       color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
//     ),
//   ],
// );

// class OnlineAppointementsPage extends StatefulWidget {
//   ScrollController scrollController = ScrollController();
//   @override
//   _OnlineAppointementsPageState createState() =>
//       _OnlineAppointementsPageState();
// }

// class _OnlineAppointementsPageState extends State<OnlineAppointementsPage>
//     with SingleTickerProviderStateMixin {
//   TextEditingController searchcontroller = TextEditingController();
//   TabController? tabController;
//   OnlineAppointementsUpcoming onlineAppointementsAll =
//       OnlineAppointementsUpcoming();
//   @override
//   void initState() {
//     super.initState();
//     tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Online Panel',
//           textScaleFactor: 2.0,
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Container(
//           decoration: onlineAppfixedboxdecoration1,
//           child: Row(
//             children: [
//               OnlineUsersSection(
//                 scrollController: widget.scrollController,
//                 searchController: searchcontroller,
//               ),
//               SizedBox(
//                 width: 5,
//               ),
//               Expanded(
//                 flex: 3,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     decoration: onlineAppfixedboxdecoration2,
//                     child: Column(
//                       children: [
//                         Expanded(
//                           flex: 2,
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: AppBar(
//                               centerTitle: true,
//                               title: Text(
//                                 'Online Appointements',
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                               automaticallyImplyLeading: false,
//                               bottom: TabBar(
//                                 controller: tabController,
//                                 tabs: [
//                                   Tab(
//                                     text: 'Previous Appointements',
//                                     icon: Icon(Icons.date_range),
//                                   ),
//                                   Tab(
//                                     text: 'Upcoming Appointements',
//                                     icon: Icon(Icons.calendar_today),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         //tabsbarview
//                         Expanded(
//                           flex: 8,
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: TabBarView(
//                               controller: tabController,
//                               children: [
//                                 //previous apps
//                                 PreviousAppointementsSection(),
//                                 //upcoming apps
//                                 UpcomingAppointementsSection(),
//                               ],
//                             ),
//                           ),
//                         )
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

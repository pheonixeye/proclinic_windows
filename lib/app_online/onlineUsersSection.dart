// import 'dart:math';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:proclinic_windows/app_online/mongo_online/mongo_online_app.dart';

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

// class OnlineUsersSection extends StatefulWidget {
//   final ScrollController scrollController;
//   final TextEditingController searchController;

//   OnlineUsersSection({
//     Key? key,
//     required this.scrollController,
//     required this.searchController,
//   }) : super(key: key);
//   @override
//   _OnlineUsersSectionState createState() => _OnlineUsersSectionState();
// }

// class _OnlineUsersSectionState extends State<OnlineUsersSection> {
//   @override
//   Widget build(BuildContext context) {
//     OnlineUsers onlineUsers = OnlineUsers();
//     OnlineUsersSearchable onlineUsersSearchable = OnlineUsersSearchable(
//         username: widget.searchController.text,
//         phone: widget.searchController.text);
//     return Expanded(
//       flex: 1,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           decoration: onlineAppfixedboxdecoration2,
//           child: Column(
//             children: [
//               //title appbar
//               Expanded(
//                 flex: 1,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: AppBar(
//                     title: Text(
//                       'Online Users',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     centerTitle: true,
//                     automaticallyImplyLeading: false,
//                   ),
//                 ),
//               ),
//               //search bar
//               Expanded(
//                 flex: 1,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 8.0, vertical: 4.0),
//                   child: SizedBox(
//                     width: 350.0,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: [
//                           BoxShadow(
//                               color: Colors.primaries[
//                                   Random().nextInt(Colors.primaries.length)],
//                               offset: Offset(3, 3),
//                               blurRadius: 3.0,
//                               spreadRadius: 3.0),
//                         ],
//                       ),
//                       child: Container(
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10),
//                             boxShadow: [
//                               BoxShadow(
//                                   color: Colors.primaries[Random()
//                                       .nextInt(Colors.primaries.length)],
//                                   offset: Offset(3, 3),
//                                   blurRadius: 3.0,
//                                   spreadRadius: 3.0)
//                             ]),
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                           child: Tooltip(
//                             message: 'Search by name or phone',
//                             child: TextField(
//                               onChanged: (String txt) {
//                                 setState(() {});
//                               },
//                               controller: widget.searchController,
//                               decoration: InputDecoration(
//                                 labelText: 'Search',
//                                 prefixIcon: Icon(Icons.search),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               //listview of users
//               Expanded(
//                 flex: 8,
//                 child: StreamBuilder<Object>(
//                   stream: widget.searchController.text.isNotEmpty
//                       ? onlineUsersSearchable.onlineusersmongo
//                       : onlineUsers.onlineusersmongo,
//                   builder: (context, AsyncSnapshot snapshot) {
//                     List data = snapshot.hasData ? snapshot.data : [];
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
//                         decoration: onlineAppfixedboxdecoration2,
//                         child: CupertinoScrollbar(
//                           controller: widget.scrollController,
//                           thickness: 20,
//                           thicknessWhileDragging: 20,
//                           isAlwaysShown: true,
//                           radius: Radius.circular(10),
//                           radiusWhileDragging: Radius.circular(10),
//                           child: ListView.builder(
//                             controller: widget.scrollController,
//                             itemCount: data.length,
//                             itemBuilder: (context, index) {
//                               return ListTile(
//                                 isThreeLine: true,
//                                 leading: CircleAvatar(
//                                   child: Text('${index + 1}'),
//                                 ),
//                                 title: Text(data[index]['username']),
//                                 subtitle: Text(
//                                     'Phone: ${data[index]['phone']}\nDoB: ${data[index]['dob']}'),
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

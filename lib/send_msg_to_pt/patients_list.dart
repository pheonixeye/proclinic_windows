// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:proclinic_windows/send_msg_to_pt/allpts_onedoc_dropdown.dart';

// class ContactsSelector extends StatefulWidget {
//   static List<Map<String, dynamic>> selectednos = [];
//   Function callsetstate;

//   ContactsSelector({required this.callsetstate});
//   @override
//   _ContactsSelectorState createState() => _ContactsSelectorState();
// }

// class _ContactsSelectorState extends State<ContactsSelector> {
//   TextEditingController searchController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   List<bool> selindex = [];
//   bool selected = true;
//   @override
//   Widget build(BuildContext context) {
//     Stream? selectionStream;

//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Builder(builder: (context) {
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: SizedBox(
//             height: 350,
//             child: StreamBuilder(
//                 stream: selectionStream,
//                 builder: (context, AsyncSnapshot snapshot) {
//                   List<Map<String, dynamic>> data = snapshot.data;
//                   // print(data);
//                   return !snapshot.hasData
//                       ? const Center(child: CircularProgressIndicator())
//                       : Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             const SizedBox(
//                               height: 5,
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     flex: 5,
//                                     child: TextField(
//                                       onChanged: (String value) {
//                                         setState(() {});
//                                       },
//                                       controller: searchController,
//                                       obscureText: false,
//                                       decoration: const InputDecoration(
//                                         border: OutlineInputBorder(),
//                                         labelText: 'Search by Name / Phone',
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 1,
//                                     child: Tooltip(
//                                       message: 'Add All',
//                                       child: IconButton(
//                                         visualDensity: VisualDensity
//                                             .adaptivePlatformDensity,
//                                         splashColor: Colors.blue,
//                                         splashRadius: 20,
//                                         onPressed: () {
//                                           setState(() {
//                                             ContactsSelector.selectednos
//                                                 .addAll(data);
//                                           });
//                                           widget.callsetstate();
//                                         },
//                                         icon: const Icon(Icons.done_all),
//                                         // value: selected,
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: SizedBox(
//                                 height: AllPtsOneDoctorDropDown.alloneselval ==
//                                         0
//                                     ? MediaQuery.of(context).size.height * 0.55
//                                     : MediaQuery.of(context).size.height * 0.46,
//                                 width: 550,
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(15),
//                                     color: Colors.white,
//                                     boxShadow: const [
//                                       BoxShadow(
//                                         offset: Offset(2, 2),
//                                         blurRadius: 2,
//                                         spreadRadius: 2,
//                                       ),
//                                     ],
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: CupertinoScrollbar(
//                                       controller: _scrollController,
//                                       thickness: 10,
//                                       isAlwaysShown: true,
//                                       child: ListView.builder(
//                                         controller: _scrollController,
//                                         itemCount:
//                                             !snapshot.hasData ? 0 : data.length,
//                                         itemExtent: 60,
//                                         itemBuilder: (context, index) {
//                                           // data.forEach((item) {
//                                           //   selindex.add(false);
//                                           // });
//                                           return Card(
//                                             color: Colors.grey[300],
//                                             child: ListTile(
//                                               leading: CircleAvatar(
//                                                 child: Text(
//                                                   '${index + 1}',
//                                                   textScaleFactor: 1.8,
//                                                 ),
//                                               ),
//                                               title:
//                                                   Text(data[index]['ptname']),
//                                               subtitle:
//                                                   Text(data[index]['phone']),
//                                               onTap: () {},
//                                               trailing: IconButton(
//                                                 icon: const Icon(Icons.add),
//                                                 onPressed: () {
//                                                   setState(() {
//                                                     ContactsSelector.selectednos
//                                                         .add({
//                                                       'phone': data[index]
//                                                           ['phone'],
//                                                       'ptname': data[index]
//                                                           ['ptname']
//                                                     });

//                                                     widget.callsetstate();
//                                                   });
//                                                 },
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             )
//                           ],
//                         );
//                 }),
//           ),
//         );
//       }),
//     );
//   }
// }

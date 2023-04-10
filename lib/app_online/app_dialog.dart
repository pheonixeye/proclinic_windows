// import 'dart:math';

// import 'package:flutter/material.dart';

// final BoxDecoration fixedboxdecoration = BoxDecoration(
//   color: Colors.grey[400],
//   borderRadius: BorderRadius.circular(10),
//   boxShadow: [
//     BoxShadow(offset: Offset(3, 3), blurRadius: 3.0, spreadRadius: 3.0)
//   ],
// );

// Widget showAppDialogForNavigation(
//     {required BuildContext context,
//     required Widget oldOrg,
//     required Widget newOrg}) {
//   return AlertDialog(
//     content: Container(
//       decoration: fixedboxdecoration,
//       child: Row(
//         children: [
//           Container(
//             decoration: fixedboxdecoration,
//             child: IconButton(
//               icon: Icon(Icons.offline_bolt),
//               onPressed: () {
//                 //
//                 Navigator.push(
//                     context, MaterialPageRoute(builder: (context) => oldOrg));
//               },
//               tooltip: 'Appointment Organizer - ترتيب المواعيد',
//               hoverColor: Colors
//                   .primaries[Random.secure().nextInt(Colors.primaries.length)],
//               focusColor: Colors.yellow[100],
//               iconSize: 400.0,
//             ),
//           ),
//           SizedBox(
//             width: 50,
//           ),
//           Container(
//             decoration: fixedboxdecoration,
//             child: IconButton(
//               icon: Icon(Icons.flash_on_outlined),
//               onPressed: () {
//                 //
//                 Navigator.push(
//                     context, MaterialPageRoute(builder: (context) => newOrg));
//               },
//               tooltip: 'Online Appointements',
//               hoverColor: Colors
//                   .primaries[Random.secure().nextInt(Colors.primaries.length)],
//               focusColor: Colors.blue[100],
//               iconSize: 400.0,
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

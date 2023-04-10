// import 'dart:math';

// import 'package:flutter/material.dart';

// class AllPtsOneDoctorDropDown extends StatefulWidget {
//   Function callsetstate;
//   static bool? docvis;
//   static int? alloneselval;
//   AllPtsOneDoctorDropDown({Key? key, required this.callsetstate})
//       : super(key: key);

//   @override
//   _AllPtsOneDoctorDropDownState createState() =>
//       _AllPtsOneDoctorDropDownState();
// }

// class _AllPtsOneDoctorDropDownState extends State<AllPtsOneDoctorDropDown> {
//   late int selectedvalue;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(12.0),
//       child: Container(
//         decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//               offset: Offset(4.0, 4.0),
//               blurRadius: 4.0,
//             ),
//           ],
//           color: Colors.grey[300],
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: DropdownButton<int>(
//           isExpanded: true,
//           icon: Icon(
//             Icons.arrow_drop_down_circle,
//             color: Colors.blue,
//           ),
//           underline: Container(
//             color: Colors.blue,
//             height: 2,
//           ),
//           hint: Center(
//             child: Text('All Patients / One Doctor'),
//           ),
//           items: [
//             DropdownMenuItem(
//               value: 0,
//               child: Center(
//                 child: Text('All Patients'),
//               ),
//             ),
//             DropdownMenuItem(
//               value: 1,
//               child: Center(
//                 child: Text('One Doctor'),
//               ),
//             ),
//           ],
//           value: selectedvalue,
//           onChanged: (value) {
//             setState(() {
//               selectedvalue = value!;
//               AllPtsOneDoctorDropDown.alloneselval = value;
//               widget.callsetstate();
//               if (selectedvalue == 0) {
//                 AllPtsOneDoctorDropDown.docvis = false;
//               } else if (selectedvalue == 1) {
//                 AllPtsOneDoctorDropDown.docvis = true;
//               }
//             });
//           },
//         ),
//       ),
//     );
//   }
// }

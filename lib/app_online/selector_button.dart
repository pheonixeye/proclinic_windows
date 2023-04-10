// import 'package:flutter/material.dart';

// class CustomPopUpMenuButtonForAppointementsListTile extends StatefulWidget {
//   final Function mysetstate;
//   final Function(BuildContext) attendPatient;
//   final Function(BuildContext) deleteEntry;
//   final Function(BuildContext) reschedule;

//   CustomPopUpMenuButtonForAppointementsListTile({
//     Key? key,
//     required this.mysetstate,
//     required this.attendPatient,
//     required this.deleteEntry,
//     required this.reschedule,
//   }) : super(key: key);
//   @override
//   _CustomPopUpMenuButtonForAppointementsListTileState createState() =>
//       _CustomPopUpMenuButtonForAppointementsListTileState();
// }

// class _CustomPopUpMenuButtonForAppointementsListTileState
//     extends State<CustomPopUpMenuButtonForAppointementsListTile> {
//   static List<int> _items = [0, 1, 2];
//   static List<String> _stringitems = [
//     'Attend Patient',
//     'Delete Entry',
//     'Re-schedule'
//   ];
//   static List<IconData> _iconDataitems = [
//     Icons.edit,
//     Icons.delete_forever,
//     Icons.schedule
//   ];
//   static List<MaterialColor> _colors = [Colors.green, Colors.red, Colors.amber];

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
//           case 2:
//             await widget.reschedule(context);
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

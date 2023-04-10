// import 'package:flutter/material.dart';
// import 'package:proclinic_windows/online_offers/mongo_offers.dart';
// import 'package:proclinic_windows/online_offers/offers_custom_widgets.dart';

// class AvailableOffersSection extends StatefulWidget {
//   final Function mysetstate;

//   AvailableOffersSection({Key? key, required this.mysetstate})
//       : super(key: key);
//   @override
//   _AvailableOffersSectionState createState() => _AvailableOffersSectionState();
// }

// class _AvailableOffersSectionState extends State<AvailableOffersSection> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//           flex: 1,
//           child: OfferPageTitles(
//             title: 'Available Offers',
//           ),
//         ),
//         Expanded(
//           flex: 7,
//           child: StreamBuilder(
//             stream: OnlineOffersMongodb.offersOfMongo,
//             builder: (context, AsyncSnapshot snapshot) {
//               List data = snapshot.hasData ? snapshot.data : [];
//               return snapshot.connectionState == ConnectionState.waiting
//                   ? Center(child: CircularProgressIndicator())
//                   : ListView.separated(
//                       separatorBuilder: (context, index) {
//                         return Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Divider(
//                             color: Theme.of(context).primaryColor,
//                             thickness: 5,
//                             height: 5,
//                           ),
//                         );
//                       },
//                       itemCount: data.length,
//                       itemBuilder: (context, index) {
//                         return CheckboxListTile(
//                           isThreeLine: true,
//                           value: data[index]['available'],
//                           secondary: CircleAvatar(
//                             child: Text(
//                               '${data[index]['percentage']} %',
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           title: Card(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             elevation: 10,
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Icon(Icons.local_hospital_rounded),
//                                       SizedBox(
//                                         width: 20,
//                                       ),
//                                       Text(data[index]['docname']
//                                           .toString()
//                                           .toUpperCase()),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       Icon(Icons.local_hospital_rounded),
//                                       SizedBox(
//                                         width: 20,
//                                       ),
//                                       Text(data[index]['docname_a']
//                                           .toString()
//                                           .toUpperCase()),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       Icon(Icons.local_offer_outlined),
//                                       SizedBox(
//                                         width: 20,
//                                       ),
//                                       Text(data[index]['procedure']
//                                           .toString()
//                                           .toUpperCase()),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       Icon(Icons.local_offer_outlined),
//                                       SizedBox(
//                                         width: 20,
//                                       ),
//                                       Text(data[index]['procedure_a']
//                                           .toString()
//                                           .toUpperCase()),
//                                       Spacer(),
//                                       IconButton(
//                                           icon: Icon(
//                                             Icons.delete_forever,
//                                             color: Colors.red,
//                                           ),
//                                           onPressed: () async {
//                                             //TODO: delete offer from db
//                                             await OnlineOffersMongodb
//                                                 .deleteOffer(
//                                               percentage: data[index]
//                                                   ['percentage'],
//                                               procedure: data[index]
//                                                   ['procedure'],
//                                               procedure_a: data[index]
//                                                   ['procedure_a'],
//                                               description: data[index]
//                                                   ['description'],
//                                               description_a: data[index]
//                                                   ['description_a'],
//                                               docname: data[index]['docname'],
//                                               docname_a: data[index]
//                                                   ['docname_a'],
//                                               available: data[index]
//                                                   ['available'],
//                                             );
//                                             setState(() {});
//                                             widget.mysetstate();
//                                           })
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           subtitle: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               children: [
//                                 Text(
//                                   data[index]['description'].toString(),
//                                   maxLines: null,
//                                   overflow: TextOverflow.clip,
//                                 ),
//                                 Text(
//                                   data[index]['description_a'].toString(),
//                                   maxLines: null,
//                                   overflow: TextOverflow.clip,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           onChanged: (value) async {
//                             await OnlineOffersMongodb.updateOffer(
//                                 percentage: data[index]['percentage'],
//                                 procedure: data[index]['procedure'],
//                                 procedure_a: data[index]['procedure_a'],
//                                 description: data[index]['description'],
//                                 description_a: data[index]['description_a'],
//                                 docname: data[index]['docname'],
//                                 docname_a: data[index]['docname_a'],
//                                 oldavailable: data[index]['available'],
//                                 newavailable: !data[index]['available']);
//                             setState(() {});
//                             widget.mysetstate();
//                           },
//                         );
//                       },
//                     );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

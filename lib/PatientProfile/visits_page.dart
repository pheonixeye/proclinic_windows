import 'dart:math';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_windows/_const/_constWidgets.dart';
import 'package:proclinic_windows/_localization/_localization.dart';
import 'package:proclinic_windows/_models/visitModel.dart';
import 'package:proclinic_windows/_providers/visitsControllerProvider.dart';
import 'package:proclinic_windows/printReciept/reciept_page_UI.dart';
import 'package:provider/provider.dart';

class VisitsPage extends StatefulWidget {
  const VisitsPage({Key? key}) : super(key: key);

  @override
  _VisitsPageState createState() => _VisitsPageState();
}

class _VisitsPageState extends State<VisitsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: Consumer<VisitsSearchController>(
        builder: (context, visits, child) {
          while (visits.visits == null) {
            return const WhileValueEqualNullWidget();
          }
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: Colors.grey[300],
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 40,
                      ),
                      Text(visits.visits!.first.ptName.toUpperCase()),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 5,
                  thickness: 5,
                  color: Colors.black,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: ListView.separated(
                    itemCount: visits.visits!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return VisitInfoTile(
                        index: index,
                        visit: visits.visits![index],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        height: 3,
                        thickness: 3,
                        color: Colors.blueGrey,
                      );
                    },
                  ),
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 5,
                  height: 5,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class VisitInfoTile extends StatelessWidget {
  const VisitInfoTile({Key? key, required this.visit, required this.index})
      : super(key: key);
  final Visit visit;
  final int index;

  @override
  Widget build(BuildContext context) {
    String date = visit.visitDate;
    DateTime d = DateTime.parse(date);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(15)),
        elevation: 20,
        shadowColor:
            Colors.primaries[Random().nextInt(Colors.primaries.length)],
        child: ListTile(
          tileColor: Colors.white70,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          leading: CircleAvatar(
            child: Text('${index + 1}'.toString()),
            backgroundColor:
                Colors.primaries[Random().nextInt(Colors.primaries.length)],
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                english(context)
                    ? visit.clinicEN.toString().toUpperCase()
                    : visit.clinicAR,
              ),
              const SizedBox(
                width: 20,
              ),
              Text('${d.day} - ${d.month} - ${d.year}'),
            ],
          ),
          subtitle:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Text(english(context)
                ? visit.docNameEN.toString().toUpperCase()
                : visit.docNameAR),
            const SizedBox(
              width: 20,
            ),
            Text(visit.visitType.tr()),
            const SizedBox(
              width: 20,
            ),
            Text(visit.procedureEN == null
                ? ''
                : english(context)
                    ? visit.procedureEN!
                    : visit.procedureAR!),
            const SizedBox(
              width: 20,
            ),
            CircleAvatar(
                backgroundColor:
                    Colors.primaries[Random().nextInt(Colors.primaries.length)],
                child: Text(visit.amount.toString())),
          ]),
          dense: true,
          trailing: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecieptPage(
                      visit: visit,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.print),
              label: Text('Print Reciept'.tr())),
        ),
      ),
    );
  }
}

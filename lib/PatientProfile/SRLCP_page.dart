// ignore_for_file: avoid_print, file_names

import 'dart:math';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_windows/PatientProfile/show_scanned_images.dart';
import 'package:proclinic_windows/_const/_constWidgets.dart';
import 'package:proclinic_windows/_localization/_localization.dart';
import 'package:proclinic_windows/_models/visitModel.dart';
import 'package:proclinic_windows/_providers/visitsControllerProvider.dart';
import 'package:proclinic_windows/scanner/powershell_run_scan.dart';
import 'package:provider/provider.dart';

class SRLCP extends StatefulWidget {
  final String scrlp;

  const SRLCP({Key? key, required this.scrlp}) : super(key: key);
  @override
  _SRLCPState createState() => _SRLCPState();
}

class _SRLCPState extends State<SRLCP> {
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
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
                  child: Center(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return SclrpTile(
                            index: index,
                            visit: visits.visits![index],
                            sclrp: widget.scrlp,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                            color: Colors.blueGrey,
                            thickness: 5,
                            height: 5,
                          );
                        },
                        itemCount: visits.visits!.length),
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

class SclrpTile extends StatelessWidget {
  const SclrpTile({
    Key? key,
    required this.visit,
    required this.index,
    required this.sclrp,
  }) : super(key: key);
  final Visit visit;
  final int index;
  final String sclrp;

  @override
  Widget build(BuildContext context) {
    String date = visit.visitDate;
    DateTime d = DateTime.parse(date);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 20,
        shadowColor:
            Colors.primaries[Random().nextInt(Colors.primaries.length)],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.grey[200],
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor:
                Colors.primaries[Random().nextInt(Colors.primaries.length)],
            child: Text('${index + 1}'),
          ),
          title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(english(context)
                ? visit.clinicEN.toUpperCase()
                : visit.clinicAR),
            const SizedBox(
              width: 150,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  backgroundColor: Colors
                      .primaries[Random().nextInt(Colors.primaries.length)],
                ),
                onPressed: () async {
                  await EasyLoading.show(status: 'SCANNING...'.tr());
                  await PowerShellScanRunner.runScanAndSave(
                    sclrp: sclrp,
                    visit: visit,
                  );
                  await EasyLoading.dismiss();
                },
                icon: const Icon(Icons.scanner),
                label: Text(
                  '${'Add'.tr()} ${sclrp.tr().toUpperCase()}',
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ]),
          subtitle: Text('${d.day}-${d.month}-${d.year}'),
          trailing: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              backgroundColor:
                  Colors.primaries[Random().nextInt(Colors.primaries.length)],
            ),
            icon: const Icon(Icons.poll),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScannedImagesWidget(
                    visit: visit,
                    sclrp: sclrp,
                  ),
                ),
              );
            },
            label: Text(
              'Show'.tr() + sclrp.tr().toUpperCase(),
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

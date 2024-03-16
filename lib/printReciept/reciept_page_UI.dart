// ignore_for_file: avoid_print

import 'dart:io';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:proclinic_windows/_const/_constWidgets.dart';
import 'package:proclinic_windows/_const/_strings.dart';
import 'package:proclinic_windows/_localization/_localization.dart';
import 'package:proclinic_windows/_models/visitModel.dart';
import 'package:proclinic_windows/_providers/new_visit_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

class RecieptPage extends StatefulWidget {
  const RecieptPage({Key? key, required this.visit}) : super(key: key);
  final Visit? visit;

  @override
  _RecieptPageState createState() => _RecieptPageState();
}

class _RecieptPageState extends State<RecieptPage> {
  late ScreenshotController sscontroller;
  final LocalStorage _db = LocalStorage('$DBPATH.json');
  @override
  void initState() {
    sscontroller = ScreenshotController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    while (widget.visit == null) {
      return const WhileValueEqualNullWidget();
    }
    return Consumer<NewVisitProvider>(
      builder: (context, visit, child) {
        String visitDate = widget.visit!.visitDate;
        String dob = widget.visit!.dob;
        DateTime d = DateTime.parse(visitDate);
        DateTime db = DateTime.parse(dob);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Print Reciept'.tr(),
              textScaler: const TextScaler.linear(2.0),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: Align(
            alignment: Alignment.center,
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.height * 0.9,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(4, 4),
                    blurRadius: 4,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 9,
                      child: Screenshot(
                        controller: sscontroller,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // const Spacer(),
                                Text('${'Date'.tr()} : '),
                                const Spacer(),
                                Text('${d.day}-${d.month}-${d.year}'),
                                const Spacer(),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // const Spacer(),
                                Text('${'Time'.tr()} : '),
                                const Spacer(),
                                Text('${d.hour} : ${d.minute}'),
                                const Spacer(),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // const Spacer(),
                                Text('${'Name'.tr()} : '),
                                const Spacer(),
                                Text(widget.visit!.ptName.toUpperCase()),
                                const Spacer(),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // const Spacer(),
                                Text('${'Clinic'.tr()} : '),
                                const Spacer(),
                                Text(english(context)
                                    ? widget.visit!.clinicEN.toUpperCase()
                                    : widget.visit!.clinicAR),
                                const Spacer(),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // const Spacer(),
                                Text('${'Doctor'.tr()} : '),
                                const Spacer(),
                                Text(english(context)
                                    ? widget.visit!.docNameEN.toUpperCase()
                                    : widget.visit!.docNameAR),
                                const Spacer(),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // const Spacer(),
                                Text('${'Phone'.tr()} : '),
                                const Spacer(),
                                Text(widget.visit!.phone),
                                const Spacer(),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // const Spacer(),
                                Text('${'Date of Birth'.tr()} : '),
                                const Spacer(),
                                Text('${db.day}-${db.month}-${db.year}'),
                                const Spacer(),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // const Spacer(),
                                Text('${'Visit Type'.tr()} : '),
                                const Spacer(),
                                Text(widget.visit!.visitType.tr()),
                                const Spacer(),
                              ],
                            ),
                            SizedBox(
                              height:
                                  widget.visit!.procedureEN == null ? 0 : 10,
                            ),
                            widget.visit!.procedureEN == null
                                ? const SizedBox()
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // const Spacer(),
                                      Text('${'Procedure'.tr()} : '),
                                      const Spacer(),
                                      Text(english(context)
                                          ? widget.visit!.procedureEN!
                                          : widget.visit!.procedureAR!),
                                      const Spacer(),
                                    ],
                                  ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // const Spacer(),
                                Text('${'Amount'.tr()} : '),
                                const Spacer(),
                                Text('${widget.visit!.amount} ${'L.E.'.tr()}'),
                                const Spacer(),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // const Spacer(),
                                Text('${'Remaining'.tr()} : '),
                                const Spacer(),
                                Text(
                                  '${widget.visit!.remaining} ${'L.E.'.tr()}',
                                ),
                                const Spacer(),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // const Spacer(),
                                Text('${'Affiliation'.tr()} : '),
                                const Spacer(),
                                Text(english(context)
                                    ? widget.visit!.affiliationEN
                                    : widget.visit!.affiliationAR),
                                const Spacer(),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // const Spacer(),
                                Text('${'Payment Type'.tr()} : '),
                                const Spacer(),
                                Text(widget.visit!.cashType),
                                const Spacer(),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '${'Thank You for Your Visit'.tr()}\n${'Phone'.tr()} : 010091966224\n${'Landline'.tr()} : 0225165064\nwww.CosmoSurgeCairo.com\nCosmosurgeCairo@gmail.com',
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Tooltip(
                      message: 'طباعة ايصال',
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.print),
                        label: Text('Print Reciept'.tr()),
                        onPressed: () async {
                          await _db.ready;
                          String? path = await _db.getItem(DBPATH);
                          if (path != null) {
                            var ulist = await sscontroller.captureAndSave(path,
                                fileName: 'reciept.png');
                            if (ulist != null) {
                              await Process.run('$path\\reciept.png', [],
                                  runInShell: true);
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

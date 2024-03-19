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
  final _style = const TextStyle(
    color: Colors.black,
  );
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
              textScaler: const TextScaler.linear(1.4),
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
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 9,
                      child: Screenshot(
                        controller: sscontroller,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // const Spacer(),
                                  Text(
                                    '${'Date'.tr()} : ',
                                    style: _style,
                                  ),
                                  const Spacer(),
                                  Text(
                                    '${d.day}-${d.month}-${d.year}',
                                    style: _style,
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
                                  Text(
                                    '${'Name'.tr()} : ',
                                    style: _style,
                                  ),
                                  const Spacer(),
                                  Text(
                                    widget.visit!.ptName.toUpperCase(),
                                    style: _style,
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
                                  Text(
                                    '${'Clinic'.tr()} : ',
                                    style: _style,
                                  ),
                                  const Spacer(),
                                  Text(
                                    english(context)
                                        ? widget.visit!.clinicEN.toUpperCase()
                                        : widget.visit!.clinicAR,
                                    style: _style,
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
                                  Text(
                                    '${'Doctor'.tr()} : ',
                                    style: _style,
                                  ),
                                  const Spacer(),
                                  Text(
                                    english(context)
                                        ? widget.visit!.docNameEN.toUpperCase()
                                        : widget.visit!.docNameAR,
                                    style: _style,
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
                                  Text(
                                    '${'Phone'.tr()} : ',
                                    style: _style,
                                  ),
                                  const Spacer(),
                                  Text(
                                    widget.visit!.phone,
                                    style: _style,
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
                                  Text(
                                    '${'Date of Birth'.tr()} : ',
                                    style: _style,
                                  ),
                                  const Spacer(),
                                  Text(
                                    '${db.day}-${db.month}-${db.year}',
                                    style: _style,
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
                                  Text(
                                    '${'Visit Type'.tr()} : ',
                                    style: _style,
                                  ),
                                  const Spacer(),
                                  Text(
                                    widget.visit!.visitType.tr(),
                                    style: _style,
                                  ),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // const Spacer(),
                                        Text(
                                          '${'Procedure'.tr()} : ',
                                          style: _style,
                                        ),
                                        const Spacer(),
                                        Text(
                                          english(context)
                                              ? widget.visit!.procedureEN!
                                              : widget.visit!.procedureAR!,
                                          style: _style,
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
                                  Text(
                                    '${'Amount'.tr()} : ',
                                    style: _style,
                                  ),
                                  const Spacer(),
                                  Text(
                                    '${widget.visit!.amount} ${'L.E.'.tr()}',
                                    style: _style,
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
                                  Text(
                                    '${'Remaining'.tr()} : ',
                                    style: _style,
                                  ),
                                  const Spacer(),
                                  Text(
                                    '${widget.visit!.remaining} ${'L.E.'.tr()}',
                                    style: _style,
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
                                  Text(
                                    '${'Affiliation'.tr()} : ',
                                    style: _style,
                                  ),
                                  const Spacer(),
                                  Text(
                                    english(context)
                                        ? widget.visit!.affiliationEN
                                        : widget.visit!.affiliationAR,
                                    style: _style,
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
                                  Text(
                                    '${'Payment Type'.tr()} : ',
                                    style: _style,
                                  ),
                                  const Spacer(),
                                  Text(
                                    widget.visit!.cashType,
                                    style: _style,
                                  ),
                                  const Spacer(),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Divider(
                                height: 10,
                                thickness: 2,
                                color: Colors.black,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    //TODO: change per user
                                    '\n${'Thank You for Your Visit'.tr()}\n\n${'Phone'.tr()} : {{01012345678}}\n\n${'Landline'.tr()} : {{023456789}}\n\n{{https://website.com}}\n\n{{email@gmail.com}}',
                                    style: _style,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ],
                          ),
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

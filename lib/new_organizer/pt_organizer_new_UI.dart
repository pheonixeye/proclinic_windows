import 'dart:async';
import 'dart:math';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_windows/_const/_constWidgets.dart';
import 'package:proclinic_windows/_providers/orgAppProvider.dart';
import 'package:proclinic_windows/new_organizer/_widgets.dart';
import 'package:proclinic_windows/new_organizer/_widgets2.dart';
import 'package:provider/provider.dart';

class PatientOrganizer extends StatefulWidget {
  const PatientOrganizer({Key? key}) : super(key: key);

  @override
  _PatientOrganizerState createState() => _PatientOrganizerState();
}

class _PatientOrganizerState extends State<PatientOrganizer> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _initApps();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _initApps() async {
    await context.read<OrgAppProvider>().fetchAppointements();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Appointment Organizer'.tr(),
                textScaleFactor: 2.0,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            centerTitle: true,
          ),
          body: Builder(
            builder: (context) {
              return Container(
                padding: const EdgeInsets.all(10.0),
                constraints: const BoxConstraints.expand(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(3, 3),
                          blurRadius: 3.0,
                          spreadRadius: 3.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      const OrganizerControllerMenu(),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.primaries[Random()
                                        .nextInt(Colors.primaries.length)],
                                    offset: const Offset(3, 3),
                                    blurRadius: 3.0,
                                    spreadRadius: 3.0),
                              ],
                            ),
                            child: Consumer<OrgAppProvider>(
                                builder: (context, apps, child) {
                              while (apps.appointements == null) {
                                return const WhileValueEqualNullWidget();
                              }
                              return CupertinoScrollbar(
                                controller: _scrollController,
                                isAlwaysShown: true,
                                thickness: 20,
                                child: ListView.separated(
                                  controller: _scrollController,
                                  itemCount: apps.appointements!.length,
                                  itemBuilder: (context, index) {
                                    return OrgInfoCard(
                                      app: apps.appointements![index],
                                      index: index,
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const Divider(
                                      color: Colors.blueGrey,
                                      height: 5.0,
                                      thickness: 5.0,
                                    );
                                  },
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

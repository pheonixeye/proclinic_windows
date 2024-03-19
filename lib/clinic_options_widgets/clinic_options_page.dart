// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_windows/_const/_constWidgets.dart';
import 'package:proclinic_windows/_localization/_localization.dart';
import 'package:proclinic_windows/_models/doctorModel.dart';
import 'package:proclinic_windows/_providers/selectedDoctorProvider.dart';
import 'package:proclinic_windows/clinic_options_widgets/c_options_phones.dart';
import 'package:proclinic_windows/doctorsAndClinics/_widgets.dart';
import 'package:provider/src/provider.dart';

import '_widgets.dart';

class DoctorClinicOptionsPage extends StatefulWidget {
  const DoctorClinicOptionsPage({
    Key? key,
    required this.initDoctors,
    required this.doctor,
  }) : super(key: key);
  final Function initDoctors;
  final Doctor doctor;
  @override
  _DoctorClinicOptionsPageState createState() =>
      _DoctorClinicOptionsPageState();
}

class _DoctorClinicOptionsPageState extends State<DoctorClinicOptionsPage> {
  void setstatehere() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var doctor = context.read<SelectedDoctor>().doctor;
    while (doctor == null) {
      return const WhileValueEqualNullWidget();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          english(context) ? doctor.docnameEN : doctor.docnameAR,
          textScaler: const TextScaler.linear(1.4),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(3, 3),
                    blurRadius: 3.0,
                    spreadRadius: 3.0,
                  ),
                ],
              ),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  //procedure list tile
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: AddRemoveListWidget(
                          rebuildParent: setstatehere,
                          param: PARAMETER.PROCEDURES_EN,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: AddRemoveListWidget(
                          rebuildParent: setstatehere,
                          param: PARAMETER.PROCEDURES_AR,
                        ),
                      ),
                    ],
                  ),
                  // end of procedure list tile

                  const MyDivider(),

                  //beginning of doctor titles list tile
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: AddRemoveListWidget(
                          rebuildParent: setstatehere,
                          param: PARAMETER.TITLES_EN,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: AddRemoveListWidget(
                          rebuildParent: setstatehere,
                          param: PARAMETER.TITLES_AR,
                        ),
                      ),
                    ],
                  ),
                  // end of titles list tile
                  const MyDivider(),
                  //beginning of phones  list tile
                  PhoneEditingSection(
                    rebuildParent: setstatehere,
                  ),
                  //end of phones list tile
                  const MyDivider(),

                  //beginning of doctor affiliates list tile
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: AddRemoveListWidget(
                          rebuildParent: setstatehere,
                          param: PARAMETER.AFFILIATES_EN,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: AddRemoveListWidget(
                          rebuildParent: setstatehere,
                          param: PARAMETER.AFFILIATES_AR,
                        ),
                      ),
                    ],
                  ),
                  const MyDivider(),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          style:
                              ElevatedButton.styleFrom(shape: cardbuttonstyle),
                          onPressed: () async {
                            await showDialog(
                              context: context,
                              builder: (context) => DeleteDoctorAlertDialog(
                                doctor: doctor,
                              ),
                            ).then((value) {
                              Navigator.pop(context);
                            });
                          },
                          icon: const Icon(
                            Icons.delete_forever,
                            color: Colors.red,
                          ),
                          label: Text('Delete Doctor Profile...'.tr()),
                        ),
                      ),
                    ],
                  ),
                  const MyDivider(),

                  // end of affiliates list tile
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

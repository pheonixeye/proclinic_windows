import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_windows/_localization/_localization.dart';
import 'package:proclinic_windows/_providers/new_visit_provider.dart';
import 'package:proclinic_windows/_providers/procedureVisibilityProvider.dart';
import 'package:proclinic_windows/_providers/selectedDoctorProvider.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class ProceduresDropDown extends StatefulWidget {
  const ProceduresDropDown({Key? key}) : super(key: key);

  @override
  ProceduresDropDownState createState() => ProceduresDropDownState();
}

class ProceduresDropDownState extends State<ProceduresDropDown> {
  String? groupValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProcedureVisibilityProvider>(
      builder: (context, visibility, child) {
        return Visibility(
          visible: visibility.visible,
          child: Consumer<SelectedDoctor>(
            builder: (context, doctor, child) {
              while (doctor.doctor == null) {
                return const SizedBox();
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150.0,
                    child: Tooltip(
                      message: 'اختر الإجراء الطبي',
                      child: Text('Select Procedure'.tr()),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  SizedBox(
                    width: 350,
                    height: 50.0,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(4.0, 4.0),
                                blurRadius: 4.0,
                              ),
                            ],
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: doctor.doctor!.proceduersEN.map((e) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Radio<String>(
                                        value: e,
                                        groupValue: groupValue,
                                        onChanged: (val) {
                                          setState(() {
                                            groupValue = val;
                                          });
                                          context
                                              .read<NewVisitProvider>()
                                              .setProcedureEN(e);
                                          context
                                              .read<NewVisitProvider>()
                                              .setProcedureEN(doctor
                                                  .doctor!.proceduersAR
                                                  .elementAt(doctor
                                                      .doctor!.proceduersEN
                                                      .indexOf(e)));
                                        },
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        english(context)
                                            ? e
                                            : doctor.doctor!.proceduersAR
                                                .elementAt(doctor
                                                    .doctor!.proceduersEN
                                                    .indexOf(e)),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        //blue line
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Container(
                              height: 2,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

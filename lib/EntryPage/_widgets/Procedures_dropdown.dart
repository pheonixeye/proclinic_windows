import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_windows/_localization/_localization.dart';
import 'package:proclinic_windows/_providers/new_visit_provider.dart';
import 'package:proclinic_windows/_providers/procedureVisibilityProvider.dart';
import 'package:proclinic_windows/_providers/selectedDoctorProvider.dart';
import 'package:provider/provider.dart';

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
    return Consumer2<ProcedureVisibilityProvider, SelectedDoctor>(
      builder: (context, v, d, _) {
        while (d.doctor == null) {
          return const SizedBox();
        }
        return Visibility(
          visible: v.visible,
          child: Row(
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
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Card(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        icon: const Icon(Icons.arrow_drop_down_circle),
                        isExpanded: true,
                        items: d.doctor!.proceduersEN.map((e) {
                          return DropdownMenuItem<String>(
                            value: e,
                            alignment: Alignment.center,
                            child: Text(english(context)
                                ? e
                                : d.doctor!.proceduersAR.elementAt(
                                    d.doctor!.proceduersEN.indexOf(e))),
                          );
                        }).toList(),
                        value: context.watch<NewVisitProvider>().procedureEN,
                        onChanged: (val) {
                          if (val != null) {
                            context
                                .read<NewVisitProvider>()
                                .setProcedureEN(val);
                            context.read<NewVisitProvider>().setProcedureAR(
                                d.doctor!.proceduersAR.elementAt(
                                    d.doctor!.proceduersEN.indexOf(val)));
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

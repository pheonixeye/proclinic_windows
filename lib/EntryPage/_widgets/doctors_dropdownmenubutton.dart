// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:proclinic_windows/_const/_constWidgets.dart';
import 'package:proclinic_windows/_localization/_localization.dart';
import 'package:proclinic_windows/_providers/doctorListProvider.dart';
import 'package:proclinic_windows/_providers/new_visit_provider.dart';
import 'package:proclinic_windows/_providers/orgAppProvider.dart';
import 'package:proclinic_windows/_providers/selectedDoctorProvider.dart';
import 'package:provider/src/provider.dart';

class NewlyFormatedDoctorsDropDownButton extends StatefulWidget {
  const NewlyFormatedDoctorsDropDownButton({
    Key? key,
  }) : super(key: key);
  @override
  _NewlyFormatedDoctorsDropDownButtonState createState() =>
      _NewlyFormatedDoctorsDropDownButtonState();
}

class _NewlyFormatedDoctorsDropDownButtonState
    extends State<NewlyFormatedDoctorsDropDownButton> {
  int? intselval;

  @override
  void initState() {
    initDoctors();
    super.initState();
  }

  initDoctors() async {
    await context.read<DoctorListProvider>().fetchAllDoctors();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final doctors = context.read<DoctorListProvider>().doctorList;
    while (doctors == null) {
      return WhileValueEqualNullWidget();
    }
    return Builder(
      builder: (context) {
        List<DropdownMenuItem<int>> _items = [];
        for (int i = 0; i < doctors.length; i++) {
          _items.add(
            DropdownMenuItem<int>(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    english(context)
                        ? doctors[i].docnameEN.toUpperCase()
                        : doctors[i].docnameAR.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    english(context)
                        ? doctors[i].clinicEN
                        : doctors[i].clinicAR,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              value: i,
            ),
          );
        }
        return SizedBox(
          height: 50.0,
          width: 200,
          child: Container(
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
            child: DropdownButton<int>(
              itemHeight: 50,
              hint: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    english(context) ? 'Select Clinic . . .' : 'اختر العيادة',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              value: intselval,
              items: _items,
              onChanged: (value) async {
                setState(() {
                  intselval = value!;
                });

                context
                    .read<SelectedDoctor>()
                    .selectDoctor(doctors[intselval!].id);
                context
                    .read<NewVisitProvider>()
                    .setDocNameEN(doctors[intselval!].docnameEN);
                context
                    .read<NewVisitProvider>()
                    .setClinicEN(doctors[intselval!].clinicEN);
                context
                    .read<NewVisitProvider>()
                    .setDocNameAR(doctors[intselval!].docnameAR);
                context
                    .read<NewVisitProvider>()
                    .setClinicAR(doctors[intselval!].clinicAR);
                context
                    .read<NewVisitProvider>()
                    .setDocId(doctors[intselval!].id);
                // for organizer
                context
                    .read<OrgAppProvider>()
                    .rClinic(doctors[intselval!].clinicEN);
                context
                    .read<OrgAppProvider>()
                    .rDocname(doctors[intselval!].docnameEN);
                context.read<OrgAppProvider>().rDocid(doctors[intselval!].id);
              },
              underline: Container(
                height: 2,
                color: Colors.blue,
              ),
              icon: Icon(
                Icons.arrow_drop_down_circle,
                color: Colors.blue,
              ),
              isExpanded: true,
            ),
          ),
        );
      },
    );
  }
}

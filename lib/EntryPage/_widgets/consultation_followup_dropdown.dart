// ignore_for_file: camel_case_types, avoid_print

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_windows/_localization/_localization.dart';
import 'package:proclinic_windows/_providers/new_visit_provider.dart';
import 'package:proclinic_windows/_providers/procedureVisibilityProvider.dart';
import 'package:provider/src/provider.dart';

class TypeofVisitDropdown extends StatefulWidget {
  const TypeofVisitDropdown({
    Key? key,
  }) : super(key: key);
  static const List<String> typeofvisit = [
    'Consultation',
    'Follow Up',
    'Procedure'
  ];
  static const List<String> arabictypeofvisit = ['كشف', 'استشارة', 'اجراء طبي'];
  @override
  _TypeofVisitDropdownState createState() => _TypeofVisitDropdownState();
}

class _TypeofVisitDropdownState extends State<TypeofVisitDropdown> {
  String? typeofvisitstring;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _items = TypeofVisitDropdown.typeofvisit.map(
      (item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Tooltip(
                message: TypeofVisitDropdown.arabictypeofvisit[
                    TypeofVisitDropdown.typeofvisit.indexOf(item)],
                child: Text(
                  english(context)
                      ? item
                      : TypeofVisitDropdown.arabictypeofvisit[
                          TypeofVisitDropdown.typeofvisit.indexOf(item)],
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    ).toList();
    return Container(
      width: 350,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Card(
        child: DropdownButton<String>(
          underline: Container(
            height: 2,
          ),
          icon: const Icon(
            Icons.arrow_drop_down_circle,
          ),
          isExpanded: true,
          hint: Tooltip(
            message: 'اختر نوع الزيارة',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Select Visit Type'.tr(),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          value: typeofvisitstring,
          items: _items,
          onChanged: (value) {
            setState(() {
              typeofvisitstring = value;
            });
            context.read<NewVisitProvider>().setVisitType(value!);
            if (value == TypeofVisitDropdown.typeofvisit[2]) {
              //make vis true
              context.read<ProcedureVisibilityProvider>().showProcPicker();
            } else {
              context.read<ProcedureVisibilityProvider>().hideProcPicker();
            }
          },
        ),
      ),
    );
  }
}

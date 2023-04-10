import 'package:after_layout/after_layout.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_windows/_providers/bookKeepingProvider.dart';
import 'package:provider/src/provider.dart';

class AllOrOneClinicDropDown extends StatefulWidget {
  const AllOrOneClinicDropDown({Key? key}) : super(key: key);

  @override
  _AllOrOneClinicDropDownState createState() => _AllOrOneClinicDropDownState();
}

class _AllOrOneClinicDropDownState extends State<AllOrOneClinicDropDown>
    with AfterLayoutMixin {
  int? selval;
  @override
  void afterFirstLayout(BuildContext context) {
    context.read<BookKeepingProvider>().setAllOrOne(null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        underline: Container(
          height: 2.0,
          color: Colors.blue,
        ),
        isExpanded: true,
        hint: Center(
          child: Text(
            'All / Single Clinic'.tr(),
            textAlign: TextAlign.center,
          ),
        ),
        value: selval,
        items: <DropdownMenuItem<int>>[
          DropdownMenuItem(
            child: Center(child: Text('All Clinics'.tr())),
            value: 0,
          ),
          DropdownMenuItem(
            child: Center(child: Text('One Clinic'.tr())),
            value: 1,
          ),
        ],
        onChanged: (index) {
          setState(() {
            selval = index!;
          });
          context.read<BookKeepingProvider>().setAllOrOne(selval);
        },
      ),
    );
  }
}

class DayDurationDropDown extends StatefulWidget {
  const DayDurationDropDown({Key? key}) : super(key: key);

  @override
  _DayDurationDropDownState createState() => _DayDurationDropDownState();
}

class _DayDurationDropDownState extends State<DayDurationDropDown>
    with AfterLayoutMixin {
  int? selvalduration;
  @override
  void afterFirstLayout(BuildContext context) {}
  @override
  Widget build(BuildContext context) {
    return Container(
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
        underline: Container(
          height: 2.0,
          color: Colors.blue,
        ),
        isExpanded: true,
        hint: Center(
          child: Text(
            'Day / Duration'.tr(),
            textAlign: TextAlign.center,
          ),
        ),
        value: selvalduration,
        items: <DropdownMenuItem<int>>[
          DropdownMenuItem(
            child: Center(child: Text('Day by Day'.tr())),
            value: 0,
          ),
          DropdownMenuItem(
            child: Center(child: Text('Monthly'.tr())),
            value: 1,
          ),
        ],
        onChanged: (index) {
          setState(() {
            selvalduration = index!;
          });
          context.read<BookKeepingProvider>().setDayDuration(selvalduration);
        },
      ),
    );
  }
}

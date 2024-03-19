import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_windows/_providers/bookKeepingProvider.dart';
import 'package:provider/provider.dart';

class AllOrOneClinicDropDown extends StatefulWidget {
  const AllOrOneClinicDropDown({Key? key}) : super(key: key);

  @override
  _AllOrOneClinicDropDownState createState() => _AllOrOneClinicDropDownState();
}

class _AllOrOneClinicDropDownState extends State<AllOrOneClinicDropDown> {
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
      child: Consumer<BookKeepingProvider>(
        builder: (context, b, _) {
          return DropdownButton<int>(
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
            value: b.allOrOne,
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
            onChanged: (value) {
              b.setAllOrOne(value!);
            },
          );
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

class _DayDurationDropDownState extends State<DayDurationDropDown> {
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
      child: Consumer<BookKeepingProvider>(
        builder: (context, b, _) {
          return DropdownButton<int>(
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
            value: b.dayDuration,
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
            onChanged: (value) {
              b.setDayDuration(value!);
            },
          );
        },
      ),
    );
  }
}

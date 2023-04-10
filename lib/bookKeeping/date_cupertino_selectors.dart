// ignore_for_file: avoid_print, unnecessary_string_interpolations, unnecessary_brace_in_string_interps

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:proclinic_windows/_providers/bookKeepingProvider.dart';
import 'package:provider/src/provider.dart';

//yearpicker

bool globalVisibility = true;
List<int> years = List.generate(10, (i) => (DateTime.now().year - 5) + i);

class YearClinicPicker extends StatefulWidget {
  const YearClinicPicker({Key? key}) : super(key: key);

  @override
  YearClinicPickerState createState() => YearClinicPickerState();
}

class YearClinicPickerState extends State<YearClinicPicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Pick Year'.tr(),
            textAlign: TextAlign.center,
          ),
          CupertinoPicker(
            scrollController: FixedExtentScrollController(
                initialItem: years.indexOf(DateTime.now().year)),
            looping: true,
            itemExtent: 32,
            onSelectedItemChanged: (value) {
              context.read<BookKeepingProvider>().adjustYear(value);
              setState(() {});
            },
            children: years.map((e) {
              return Center(child: Text('${e}'));
            }).toList(),
          ),
          CircleAvatar(
            child: Text(
              '${context.read<BookKeepingProvider>().year}',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

//monthpicker

Map<int, String> months = {
  1: 'January'.tr(),
  2: 'February'.tr(),
  3: 'March'.tr(),
  4: 'April'.tr(),
  5: 'May'.tr(),
  6: 'June'.tr(),
  7: 'July'.tr(),
  8: 'August'.tr(),
  9: 'September'.tr(),
  10: 'October'.tr(),
  11: 'November'.tr(),
  12: 'December'.tr()
};

class MonthClinicPicker extends StatefulWidget {
  const MonthClinicPicker({Key? key}) : super(key: key);

  @override
  MonthClinicPickerState createState() => MonthClinicPickerState();
}

class MonthClinicPickerState extends State<MonthClinicPicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Pick Month'.tr(),
            textAlign: TextAlign.center,
          ),
          CupertinoPicker(
            scrollController: FixedExtentScrollController(
                initialItem:
                    months.keys.toList().indexOf(DateTime.now().month)),
            useMagnifier: true,
            looping: true,
            itemExtent: 32,
            onSelectedItemChanged: (value) {
              context.read<BookKeepingProvider>().adjustMonth(value);
              setState(() {});
            },
            children: months.values.map((e) {
              return Center(child: Text('${e}'));
            }).toList(),
          ),
          CircleAvatar(
            child: Text(
              '${context.read<BookKeepingProvider>().month}',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

//daypicker

const Map<int, String> days = {
  1: '01',
  2: '02',
  3: '03',
  4: '04',
  5: '05',
  6: '06',
  7: '07',
  8: '08',
  9: '09',
  10: '10',
  11: '11',
  12: '12',
  13: '13',
  14: '14',
  15: '15',
  16: '16',
  17: '17',
  18: '18',
  19: '19',
  20: '20',
  21: '21',
  22: '22',
  23: '23',
  24: '24',
  25: '25',
  26: '26',
  27: '27',
  28: '28',
  29: '29',
  30: '30',
  31: '31'
};

class DayClinicPicker extends StatefulWidget {
  const DayClinicPicker({Key? key}) : super(key: key);

  @override
  _DayClinicPickerState createState() => _DayClinicPickerState();
}

class _DayClinicPickerState extends State<DayClinicPicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Pick Day'.tr(),
            textAlign: TextAlign.center,
          ),
          CupertinoPicker(
            scrollController: FixedExtentScrollController(
              initialItem: days.keys.toList().indexOf(DateTime.now().day),
            ),
            useMagnifier: true,
            looping: true,
            itemExtent: 32,
            onSelectedItemChanged: (value) {
              context.read<BookKeepingProvider>().adjustDay(value);
              setState(() {});
            },
            children: days.values.map((e) {
              return Center(child: Text('${e}'));
            }).toList(),
          ),
          CircleAvatar(
            child: Text(
              '${context.read<BookKeepingProvider>().day}',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

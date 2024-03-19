import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_windows/_providers/bookKeepingProvider.dart';
import 'package:provider/provider.dart';

//yearpicker
class YearClinicPicker extends StatefulWidget {
  const YearClinicPicker({Key? key}) : super(key: key);

  @override
  YearClinicPickerState createState() => YearClinicPickerState();
}

class YearClinicPickerState extends State<YearClinicPicker> {
  final List<int> years = List.generate(5, (i) => (DateTime.now().year - i));

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Card(
        child: Consumer<BookKeepingProvider>(
          builder: (context, b, _) {
            return DropdownButton<int>(
              isExpanded: true,
              alignment: Alignment.center,
              hint: Text(
                'Pick Year'.tr(),
                textAlign: TextAlign.center,
              ),
              items: years.map((e) {
                return DropdownMenuItem<int>(
                  value: e,
                  alignment: Alignment.center,
                  child: Text(
                    e.toString(),
                  ),
                );
              }).toList(),
              value: b.year,
              onChanged: (value) {
                b.adjustYear(value!);
              },
            );
          },
        ),
      ),
    );
  }
}

//monthpicker

final Map<int, String> months = {
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
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Card(
        child: Consumer<BookKeepingProvider>(
          builder: (context, b, _) {
            return DropdownButton<int>(
              isExpanded: true,
              alignment: Alignment.center,
              hint: Text(
                'Pick Month'.tr(),
                textAlign: TextAlign.center,
              ),
              items: months.entries.map((e) {
                return DropdownMenuItem<int>(
                  value: e.key,
                  alignment: Alignment.center,
                  child: Text(
                    e.value,
                  ),
                );
              }).toList(),
              value: b.month,
              onChanged: (value) {
                b.adjustMonth(value!);
              },
            );
          },
        ),
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
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Card(
        child: Consumer<BookKeepingProvider>(
          builder: (context, b, _) {
            return DropdownButton<int>(
              isExpanded: true,
              alignment: Alignment.center,
              hint: Text(
                'Pick Day'.tr(),
                textAlign: TextAlign.center,
              ),
              items: days.entries.map((e) {
                return DropdownMenuItem<int>(
                  value: e.key,
                  alignment: Alignment.center,
                  child: Text(
                    e.value,
                  ),
                );
              }).toList(),
              value: b.day,
              onChanged: (value) {
                b.adjustDay(value!);
              },
            );
          },
        ),
      ),
    );
  }
}

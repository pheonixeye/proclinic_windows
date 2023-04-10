import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_windows/_providers/new_visit_provider.dart';
import 'package:provider/src/provider.dart';

class CashTypeDropdownButton extends StatefulWidget {
  const CashTypeDropdownButton({Key? key}) : super(key: key);

  @override
  _CashTypeDropdownButtonState createState() => _CashTypeDropdownButtonState();
}

class _CashTypeDropdownButtonState extends State<CashTypeDropdownButton> {
  String? cashtype;

  @override
  void initState() {
    super.initState();
  }

  final List<DropdownMenuItem<String>> _dropdowncashlist = [
    DropdownMenuItem<String>(
      value: 'Cash',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Tooltip(message: 'كاش', child: Text('Cash'.tr())),
          const SizedBox(width: 10),
          const Icon(Icons.monetization_on),
        ],
      ),
    ),
    DropdownMenuItem<String>(
      value: 'Visa / MasterCard',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Tooltip(message: 'فيزا', child: Text('Visa / MasterCard'.tr())),
          const SizedBox(width: 10),
          const Icon(Icons.credit_card),
        ],
      ),
    ),
    DropdownMenuItem<String>(
      value: 'Insurance',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Tooltip(message: 'تأمين', child: Text('Insurance'.tr())),
          const SizedBox(width: 10),
          const Icon(Icons.local_hospital_outlined),
        ],
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
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
        child: DropdownButton<String>(
          underline: Container(
            color: Colors.blue,
            height: 2.0,
          ),
          icon: const Icon(
            Icons.arrow_drop_down_circle,
            color: Colors.blue,
          ),
          hint: Tooltip(
            message: 'اختر طريقة الدفع',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Select Payment Type'.tr()),
              ],
            ),
          ),
          isExpanded: true,
          items: _dropdowncashlist,
          onChanged: (value) {
            setState(() {
              cashtype = value!;
            });
            context.read<NewVisitProvider>().setCashType(value!);
          },
          value: cashtype,
        ),
      ),
    );
  }
}

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proclinic_windows/_const/_strings.dart';
import 'package:proclinic_windows/_providers/new_visit_provider.dart';
import 'package:provider/src/provider.dart';

class NewPatientSelector extends StatefulWidget {
  const NewPatientSelector({
    Key? key,
    required this.dateController,
    required this.nameController,
    required this.dobController,
    required this.phoneController,
    required this.formKey,
  }) : super(key: key);

  final TextEditingController dateController;
  final TextEditingController nameController;
  final TextEditingController dobController;
  final TextEditingController phoneController;
  final GlobalKey<FormState> formKey;
  @override
  _NewPatientSelectorState createState() => _NewPatientSelectorState();
}

class _NewPatientSelectorState extends State<NewPatientSelector> {
  //text editing controllers:

  //show calender methods
  Future<void> showCalenderDate(BuildContext context) async {
    DateTime _date = DateTime.now();

    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));

    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
        widget.dateController.text =
            '${_date.day}-${_date.month}-${_date.year}';
        context.read<NewVisitProvider>().setVisitDate(DateTime(
              picked.year,
              picked.month,
              picked.day,
            ).toIso8601String());
      });
    }
  }

  Future<void> showCalenderDoB(BuildContext context) async {
    DateTime _date = DateTime.now();

    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));

    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
        widget.dobController.text = '${_date.day}-${_date.month}-${_date.year}';
        context.read<NewVisitProvider>().setDob(DateTime(
              picked.year,
              picked.month,
              picked.day,
            ).toIso8601String());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 400,
          width: 500,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 150.0,
                        child: Tooltip(
                            message: 'التاريخ', child: Text('Date'.tr()))),
                    const SizedBox(
                      width: 20.0,
                    ),
                    SizedBox(
                      width: 250.0,
                      height: textfieldheight,
                      child: TextFormField(
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Kindly Enter Date...'.tr();
                          }
                          return null;
                        },
                        enabled: false,
                        controller: widget.dateController,
                        obscureText: false,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Enter Date'.tr(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    FloatingActionButton(
                      tooltip: 'Select Date - اختيار التاريخ',
                      heroTag: "today'sDateSelector",
                      child: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        await showCalenderDate(context);
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 150.0,
                      child: Tooltip(
                        message: 'اسم المريض',
                        child: Text('Patient Name'.tr()),
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    SizedBox(
                      width: textfieldwidth,
                      height: textfieldheight,
                      child: TextFormField(
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Kindly Enter Patient Name...'.tr();
                          }
                          return null;
                        },
                        onChanged: (val) {
                          context
                              .read<NewVisitProvider>()
                              .setPtName(widget.nameController.text);
                        },
                        controller: widget.nameController,
                        obscureText: false,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Enter Patient Name'.tr(),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^[\u0600-\u06ff\s]+$'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 150.0,
                      child: Tooltip(
                        message: 'تاريخ الميلاد',
                        child: Text('Date of Birth'.tr()),
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    SizedBox(
                      width: 250.0,
                      height: textfieldheight,
                      child: TextFormField(
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Kindly Enter Patient's Date Of Birth..."
                                .tr();
                          }
                          return null;
                        },
                        controller: widget.dobController,
                        obscureText: false,
                        enabled: false,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: "Enter Patient's Date of Birth".tr(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    FloatingActionButton(
                      tooltip: 'Select Date - اختيار التاريخ',
                      heroTag: "dobDateSelector",
                      child: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        await showCalenderDoB(context);
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 150.0,
                        child: Tooltip(
                            message: 'رقم التليفون',
                            child: Text('Patient Phone'.tr()))),
                    const SizedBox(
                      width: 20.0,
                    ),
                    SizedBox(
                      width: textfieldwidth,
                      height: textfieldheight,
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (val) {
                          if (val!.isEmpty || val.length != 11) {
                            return 'Wrong Phone Number...'.tr();
                          }
                          return null;
                        },
                        controller: widget.phoneController,
                        obscureText: false,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Enter Patient Phone Number'.tr(),
                        ),
                        onChanged: (val) {
                          context
                              .read<NewVisitProvider>()
                              .setPhone(widget.phoneController.text);
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        maxLength: 11,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

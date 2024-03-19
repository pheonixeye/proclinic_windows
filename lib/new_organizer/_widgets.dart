import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_windows/EntryPage/_widgets/doctors_dropdownmenubutton.dart';
import 'package:proclinic_windows/_providers/orgAppProvider.dart';
import 'package:proclinic_windows/new_organizer/choose_old_pt_dialog.dart';
import 'package:provider/src/provider.dart';

class OrganizerControllerMenu extends StatefulWidget {
  const OrganizerControllerMenu({Key? key}) : super(key: key);

  @override
  State<OrganizerControllerMenu> createState() =>
      _OrganizerControllerMenuState();
}

class _OrganizerControllerMenuState extends State<OrganizerControllerMenu> {
  Future<void> showCalenderDate(BuildContext context) async {
    DateTime _date = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      confirmText: 'Confirm'.tr(),
      cancelText: 'Cancel'.tr(),
    );

    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
        datecontroller.text = '${_date.day}-${_date.month}-${_date.year}';
        context.read<OrgAppProvider>().rDay(_date.day);
        context.read<OrgAppProvider>().rMonth(_date.month);
        context.read<OrgAppProvider>().rYear(_date.year);
      });
    }
  }

  Future<void> showCalenderTime(BuildContext context) async {
    TimeOfDay _date = TimeOfDay.now();

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
      confirmText: 'Confirm'.tr(),
      cancelText: 'Cancel'.tr(),
    );
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
        timecontroller.text =
            '${_date.hourOfPeriod} : ${_date.minute} - ${_date.period.name.toUpperCase()}';
        context.read<OrgAppProvider>().rHour(_date.hour);
        context.read<OrgAppProvider>().rMinute(_date.minute);
      });
    }
  }

  TextEditingController namecontroller = TextEditingController();
  TextEditingController cliniccontroller = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  TextEditingController timecontroller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void clr() {
    namecontroller.clear();
    cliniccontroller.clear();
    phoneController.clear();
    datecontroller.clear();
    timecontroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: Card(
          elevation: 20,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            subtitle: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 200.0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Tooltip(
                          message: 'تاريخ الحجز',
                          child: TextFormField(
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Missing data...'.tr();
                              }
                              return null;
                            },
                            enabled: false,
                            controller: datecontroller,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Date'.tr(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Tooltip(
                  message: 'ادخل التاريخ',
                  child: ElevatedButton.icon(
                    onPressed: () {
                      showCalenderDate(context);
                    },
                    icon: const Icon(Icons.calendar_today),
                    label: Text('input Date'.tr()),
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 200.0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Tooltip(
                          message: 'وقت الحجز',
                          child: TextFormField(
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Missing data...'.tr();
                              }
                              return null;
                            },
                            controller: timecontroller,
                            enabled: false,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Time'.tr(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Tooltip(
                  message: 'ادخل الوقت',
                  child: ElevatedButton.icon(
                    onPressed: () {
                      showCalenderTime(context);
                    },
                    icon: const Icon(Icons.access_time),
                    label: Text('input Time'.tr()),
                  ),
                ),
              ],
            ),
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 350.0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Tooltip(
                          message: 'الاسم',
                          child: TextFormField(
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Missing data...'.tr();
                              }
                              return null;
                            },
                            onChanged: (val) {
                              context
                                  .read<OrgAppProvider>()
                                  .rPtname(namecontroller.text);
                            },
                            controller: namecontroller,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Name'.tr(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                //search previous patients
                SizedBox(
                  width: 50.0,
                  height: 50,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        pickoldptorg(
                          context: context,
                          namecont: namecontroller,
                          phonecont: phoneController,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 350,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Tooltip(
                        message: 'العيادة',
                        child: NewlyFormatedDoctorsDropDownButton(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 350,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Tooltip(
                          message: 'رقم التليفون',
                          child: TextFormField(
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Missing data...'.tr();
                              }
                              if (val.length != 11) {
                                return 'Kindly Enter Correct Phone Number - 11-digits...'
                                    .tr();
                              }
                              return null;
                            },
                            onChanged: (val) {
                              context
                                  .read<OrgAppProvider>()
                                  .rPhone(phoneController.text);
                            },
                            controller: phoneController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Phone'.tr(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            trailing: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Tooltip(
                message: 'حفظ',
                child: IconButton(
                  icon: const Icon(
                    Icons.save,
                    color: Colors.lightGreen,
                  ),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      if (context.read<OrgAppProvider>().docname == null) {
                        await EasyLoading.showError(
                            'Unselected Clinic...'.tr());
                      } else {
                        await EasyLoading.show(status: 'LOADING...'.tr());
                        context
                            .read<OrgAppProvider>()
                            .rPtname(namecontroller.text);
                        context
                            .read<OrgAppProvider>()
                            .rPhone(phoneController.text);
                        context.read<OrgAppProvider>().rVisitDate();
                        context.read<OrgAppProvider>().rApp();
                        await context.read<OrgAppProvider>().addAppointement();
                        await context
                            .read<OrgAppProvider>()
                            .fetchAppointements();
                        clr();
                        await EasyLoading.dismiss();
                      }
                    }
                  },
                  tooltip: 'Save',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

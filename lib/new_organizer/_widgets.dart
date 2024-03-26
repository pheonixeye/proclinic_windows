import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_windows/EntryPage/_widgets/doctors_dropdownmenubutton.dart';
import 'package:proclinic_windows/_providers/orgAppProvider.dart';
import 'package:proclinic_windows/functions/format_time.dart';
import 'package:proclinic_windows/new_organizer/choose_old_pt_dialog.dart';
import 'package:provider/src/provider.dart';

enum _dates { appDate, birthDate }

class OrganizerControllerMenu extends StatefulWidget {
  const OrganizerControllerMenu({Key? key}) : super(key: key);

  @override
  State<OrganizerControllerMenu> createState() =>
      _OrganizerControllerMenuState();
}

class _OrganizerControllerMenuState extends State<OrganizerControllerMenu> {
  DateTime? _appDate;
  DateTime? _dobDate;
  Future<void> showCalenderDate(
    BuildContext context,
    _dates dates,
  ) async {
    DateTime _appDate = DateTime.now();
    DateTime _dobDate = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _appDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      confirmText: 'Confirm'.tr(),
      cancelText: 'Cancel'.tr(),
    );

    if (picked != null) {
      setState(() {
        switch (dates) {
          case _dates.appDate:
            _appDate = picked;
            datecontroller.text =
                '${_appDate.day}-${_appDate.month}-${_appDate.year}';

            context
                .read<OrgAppProvider>()
                .setOrgAppointment(dateTime: _appDate.toIso8601String());
            break;
          case _dates.birthDate:
            _dobDate = picked;
            dobcontroller.text =
                '${_dobDate.day}-${_dobDate.month}-${_dobDate.year}';

            context
                .read<OrgAppProvider>()
                .setOrgAppointment(dob: _dobDate.toIso8601String());
            break;
        }
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
        timecontroller.text = formatTime(_date.hour, _date.minute);
        final ad = DateTime.parse(context.read<OrgAppProvider>().app.dateTime);
        final _d =
            DateTime(ad.year, ad.month, ad.day, _date.hour, _date.minute);
        context
            .read<OrgAppProvider>()
            .setOrgAppointment(dateTime: _d.toIso8601String());
      });
    }
  }

  late final TextEditingController namecontroller;
  late final TextEditingController cliniccontroller;
  late final TextEditingController phoneController;
  late final TextEditingController datecontroller;
  late final TextEditingController timecontroller;
  late final TextEditingController dobcontroller;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    namecontroller = TextEditingController();
    cliniccontroller = TextEditingController();
    phoneController = TextEditingController();
    datecontroller = TextEditingController();
    timecontroller = TextEditingController();
    dobcontroller = TextEditingController();
  }

  void clr() {
    namecontroller.clear();
    cliniccontroller.clear();
    phoneController.clear();
    datecontroller.clear();
    timecontroller.clear();
    dobcontroller.clear();
  }

  void _disposeControllers() {
    namecontroller.dispose();
    cliniccontroller.dispose();
    phoneController.dispose();
    datecontroller.dispose();
    timecontroller.dispose();
    dobcontroller.dispose();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
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
            subtitle: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
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
                          message: 'تاريخ الميلاد',
                          child: TextFormField(
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Missing data...'.tr();
                              }
                              return null;
                            },
                            enabled: false,
                            controller: dobcontroller,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Date of Birth'.tr(),
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
                  message: 'ادخل تاريخ الميلاد',
                  child: ElevatedButton.icon(
                    onPressed: () {
                      showCalenderDate(context, _dates.birthDate);
                    },
                    icon: const Icon(Icons.calendar_today),
                    label: Text('Date of Birth'.tr()),
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
                      showCalenderDate(context, _dates.appDate);
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
                      if (context.read<OrgAppProvider>().app.dateTime == "") {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Select Date First")));
                      } else {
                        showCalenderTime(context);
                      }
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
                          datecont: datecontroller,
                          dobcont: dobcontroller,
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
                child: FloatingActionButton(
                  heroTag: 'app-save-btn',
                  child: const Icon(
                    Icons.save,
                  ),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      context.read<OrgAppProvider>().setOrgAppointment(
                            ptname: namecontroller.text,
                            phone: phoneController.text,
                            dob: _dobDate?.toIso8601String(),
                            // dateTime: _appDate?.toIso8601String(),
                          );
                      if (context.read<OrgAppProvider>().app.docnameEN == '') {
                        await EasyLoading.showError(
                            'Unselected Clinic...'.tr());
                      } else {
                        await EasyLoading.show(status: 'LOADING...'.tr());
                        await context.read<OrgAppProvider>().addAppointement();
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

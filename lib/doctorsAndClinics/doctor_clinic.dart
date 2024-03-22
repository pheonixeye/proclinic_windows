import 'package:after_layout/after_layout.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_windows/_const/_constWidgets.dart';
import 'package:proclinic_windows/_localization/_localization.dart';
import 'package:proclinic_windows/_providers/doctorListProvider.dart';
import 'package:proclinic_windows/_providers/selectedDoctorProvider.dart';
import 'package:proclinic_windows/clinic_options_widgets/clinic_options_page.dart';
import 'package:provider/provider.dart';

class ClinicList extends StatefulWidget {
  const ClinicList({Key? key}) : super(key: key);

  @override
  _ClinicListState createState() => _ClinicListState();
}

class _ClinicListState extends State<ClinicList> with AfterLayoutMixin {
  @override
  void afterFirstLayout(BuildContext context) async {
    await context.read<DoctorListProvider>().fetchAllDoctors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Doctors & Clinics'.tr(),
          textScaler: const TextScaler.linear(1.4),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Consumer<DoctorListProvider>(
                      builder: (context, doctors, child) {
                        while (doctors.doctorList == null) {
                          return const WhileValueEqualNullWidget();
                        }
                        return ListView.builder(
                          addAutomaticKeepAlives: true,
                          itemCount: doctors.doctorList!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 20,
                                child: ListTile(
                                  onTap: () {
                                    context.read<SelectedDoctor>().selectDoctor(
                                        doctors.doctorList![index].id);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DoctorClinicOptionsPage(
                                          doctor: doctors.doctorList![index],
                                        ),
                                      ),
                                    );
                                  },
                                  leading: CircleAvatar(
                                    radius: 50,
                                    child: Text(
                                      (index + 1).toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    english(context)
                                        ? doctors.doctorList![index].docnameEN
                                            .toString()
                                            .toUpperCase()
                                        : doctors.doctorList![index].docnameAR
                                            .toString()
                                            .toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    english(context)
                                        ? doctors.doctorList![index].clinicEN
                                        : doctors.doctorList![index].clinicAR,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

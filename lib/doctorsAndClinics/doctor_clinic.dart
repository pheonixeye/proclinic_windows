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

class _ClinicListState extends State<ClinicList> {
  @override
  void initState() {
    initDoctors();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void initDoctors() async {
    await context.read<DoctorListProvider>().fetchAllDoctors();
    setState(() {});
  }

  void setstatehere() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Doctors & Clinics'.tr(),
          textScaleFactor: 2.0,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                offset: Offset(3.0, 3.0),
                blurRadius: 5.0,
                spreadRadius: 5.0,
              ),
            ],
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
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
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent:
                            MediaQuery.of(context).size.height * 0.45,
                      ),
                      addAutomaticKeepAlives: true,
                      itemCount: doctors.doctorList!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              context
                                  .read<SelectedDoctor>()
                                  .selectDoctor(doctors.doctorList![index].id);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DoctorClinicOptionsPage(
                                    initDoctors: initDoctors,
                                    doctor: doctors.doctorList![index],
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              shape: cardbuttonstyle,
                              elevation: 20,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    child: Text(
                                      (index + 1).toString(),
                                      style: const TextStyle(
                                        fontSize: 42,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    english(context)
                                        ? doctors.doctorList![index].docnameEN
                                            .toString()
                                            .toUpperCase()
                                        : doctors.doctorList![index].docnameAR
                                            .toString()
                                            .toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 42,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    english(context)
                                        ? doctors.doctorList![index].clinicEN
                                        : doctors.doctorList![index].clinicAR,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 42,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

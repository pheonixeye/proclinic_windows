import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proclinic_windows/_const/_constWidgets.dart';
import 'package:proclinic_windows/_providers/new_visit_provider.dart';
import 'package:proclinic_windows/_providers/orgAppProvider.dart';
import 'package:proclinic_windows/_providers/patient_provider.dart';
import 'package:provider/provider.dart';

class OldPatientSelector extends StatefulWidget {
  final TextEditingController? dateController;
  final TextEditingController dobController;
  final TabController? tabController;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final bool organizer;

  const OldPatientSelector({
    Key? key,
    required this.tabController,
    required this.dateController,
    required this.dobController,
    required this.nameController,
    required this.phoneController,
    required this.organizer,
  }) : super(key: key);
  @override
  _OldPatientSelectorState createState() => _OldPatientSelectorState();
}

class _OldPatientSelectorState extends State<OldPatientSelector> {
  // final searchController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initPatients();
  }

  void _initPatients() async {
    await context.read<PxPatient>().fetchPatients();
  }

  final fkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<PxPatient>(
        builder: (context, p, _) {
          while (p.patients.isEmpty) {
            return const WhileValueEqualNullWidget();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 500,
                  child: Form(
                    key: fkey,
                    child: TextFormField(
                      validator: (val) {
                        if (val == null || val.length != 11) {
                          return 'Kindly Enter Correct Phone Number - 11-digits...'
                              .tr();
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      // controller: searchController,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Search by Phone...'.tr(),
                      ),
                      onChanged: (value) {
                        p.filterPatients(value);
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: widget.organizer == true ? 400 : 175,
                  width: 550,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CupertinoScrollbar(
                        controller: _scrollController,
                        thickness: 10,
                        thumbVisibility: true,
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: p.filtered.length,
                          itemExtent: 60,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  child: Text(
                                    '${index + 1}',
                                    textScaler: const TextScaler.linear(1.0),
                                  ),
                                ),
                                title: Text(p.filtered[index].name),
                                subtitle: Text(p.filtered[index].phone),
                                onTap: () {
                                  DateTime parseDates(String dateString) {
                                    return DateTime.parse(dateString);
                                  }

                                  if (widget.organizer == false) {
                                    final _now = DateTime.now();
                                    final d = DateTime(
                                        _now.year, _now.month, _now.day);

                                    widget.dateController!.text =
                                        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';
                                    context
                                        .read<NewVisitProvider>()
                                        .setVisitDate(d.toIso8601String());
                                    widget.nameController.text =
                                        p.filtered[index].name;
                                    context
                                        .read<NewVisitProvider>()
                                        .setPtName(p.filtered[index].name);
                                    widget.phoneController.text =
                                        p.filtered[index].phone;
                                    context
                                        .read<NewVisitProvider>()
                                        .setPhone(p.filtered[index].phone);
                                    final dob =
                                        parseDates(p.filtered[index].dob);
                                    widget.dobController.text =
                                        '${dob.day}-${dob.month}-${dob.year}';
                                    context
                                        .read<NewVisitProvider>()
                                        .setDob(p.filtered[index].dob);
                                    context
                                        .read<NewVisitProvider>()
                                        .setptId(p.filtered[index].id);
                                    widget.tabController!.animateTo(
                                        (widget.tabController!.index + 1) % 2);
                                  } else if (widget.organizer == true) {
                                    widget.nameController.text =
                                        p.filtered[index].name;
                                    widget.phoneController.text =
                                        p.filtered[index].phone;
                                    final dob =
                                        parseDates(p.filtered[index].dob);
                                    widget.dobController.text =
                                        '${dob.day}-${dob.month}-${dob.year}';
                                    context
                                        .read<OrgAppProvider>()
                                        .setOrgAppointment(
                                          ptname: p.filtered[index].name,
                                          phone: p.filtered[index].phone,
                                          dob: DateTime(
                                                  dob.year, dob.month, dob.day)
                                              .toIso8601String(),
                                        );
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

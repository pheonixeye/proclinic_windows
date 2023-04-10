// ignore_for_file: avoid_print

import 'package:after_layout/after_layout.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proclinic_windows/EntryPage/_widgets/affiliation_dropdown.dart';
import 'package:proclinic_windows/EntryPage/_widgets/cash_type_dropdown.dart';
import 'package:proclinic_windows/EntryPage/_widgets/consultation_followup_dropdown.dart';
import 'package:proclinic_windows/EntryPage/_widgets/doctors_dropdownmenubutton.dart';
import 'package:proclinic_windows/EntryPage/_widgets/Procedures_dropdown.dart';
import 'package:proclinic_windows/_const/_constWidgets.dart';
import 'package:proclinic_windows/_models/visitModel.dart';
import 'package:proclinic_windows/_mongoRequests/_visit_req.dart';
import 'package:proclinic_windows/_providers/new_visit_provider.dart';
import 'package:proclinic_windows/_providers/procedureVisibilityProvider.dart';
import 'package:proclinic_windows/_providers/visitsControllerProvider.dart';
import 'package:provider/provider.dart';

class UpdateVisitInfoPage extends StatefulWidget {
  const UpdateVisitInfoPage({
    Key? key,
    required this.visit,
  }) : super(key: key);
  final Visit visit;
  @override
  _UpdateVisitInfoPageState createState() => _UpdateVisitInfoPageState();
}

class _UpdateVisitInfoPageState extends State<UpdateVisitInfoPage>
    with AfterLayoutMixin {
  late TextEditingController dateController;
  late TextEditingController nameController;
  late TextEditingController dobController;
  late TextEditingController phoneController;
  late TextEditingController amountController;
  late TextEditingController remainingController;
  var formKey = GlobalKey<FormState>();

  @override
  void afterFirstLayout(BuildContext context) {
    context.read<NewVisitProvider>().setDocId(widget.visit.docid);
    context.read<NewVisitProvider>().setPtName(widget.visit.ptName);
    context.read<NewVisitProvider>().setPhone(widget.visit.phone);
    context.read<NewVisitProvider>().setVisitDate(widget.visit.visitDate);
    context.read<NewVisitProvider>().setVisitType(widget.visit.visitType);
    context.read<NewVisitProvider>().setProcedureEN(widget.visit.procedureEN);
    context
        .read<NewVisitProvider>()
        .setAffiliationEN(widget.visit.affiliationEN);
    context.read<NewVisitProvider>().setDocNameEN(widget.visit.docNameEN);
    context.read<NewVisitProvider>().setClinicEN(widget.visit.clinicEN);
    context.read<NewVisitProvider>().setProcedureAR(widget.visit.procedureAR);
    context
        .read<NewVisitProvider>()
        .setAffiliationAR(widget.visit.affiliationAR);
    context.read<NewVisitProvider>().setDocNameAR(widget.visit.docNameAR);
    context.read<NewVisitProvider>().setClinicAR(widget.visit.clinicAR);
    context.read<NewVisitProvider>().setDob(widget.visit.dob);
    context.read<NewVisitProvider>().setCashType(widget.visit.cashType);
    context.read<NewVisitProvider>().setAmount(widget.visit.amount);
    context.read<NewVisitProvider>().setRemaining(widget.visit.remaining);
  }

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
        dateController.text = '${_date.day}-${_date.month}-${_date.year}';
        context.read<NewVisitProvider>().setVisitDate(DateTime(
                picked.year,
                picked.month,
                picked.day,
                DateTime.now().hour,
                DateTime.now().minute)
            .toIso8601String());
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
        dobController.text = '${_date.day}-${_date.month}-${_date.year}';
        context.read<NewVisitProvider>().setDob(_date.toIso8601String());
      });
    }
  }

  @override
  void initState() {
    DateTime date = DateTime.parse(widget.visit.visitDate);
    DateTime dob = DateTime.parse(widget.visit.dob);
    dateController =
        TextEditingController(text: '${date.day}-${date.month}-${date.year}');
    nameController = TextEditingController(text: widget.visit.ptName);
    dobController =
        TextEditingController(text: '${dob.day}-${dob.month}-${dob.year}');
    phoneController = TextEditingController(text: widget.visit.phone);
    amountController =
        TextEditingController(text: widget.visit.amount.toString());
    remainingController =
        TextEditingController(text: widget.visit.remaining.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update info Page'.tr()),
        centerTitle: true,
      ),
      body: Builder(
        builder: (context) {
          return Form(
            key: formKey,
            child: SingleChildScrollView(
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
                        SizedBox(width: 150.0, child: Text('Date'.tr())),
                        const SizedBox(
                          width: 20.0,
                        ),
                        SizedBox(
                          width: 250.0,
                          child: TextFormField(
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Enter Date...'.tr();
                              }
                              return null;
                            },
                            onChanged: (val) {},
                            controller: dateController,
                            obscureText: false,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Enter Date'.tr(),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: CircleAvatar(
                            child: IconButton(
                              icon: const Icon(Icons.calendar_today),
                              onPressed: () async {
                                await showCalenderDate(context);
                              },
                            ),
                          ),
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
                            width: 150.0, child: Text('Patient Name'.tr())),
                        const SizedBox(
                          width: 20.0,
                        ),
                        SizedBox(
                          width: 350.0,
                          child: TextFormField(
                            onChanged: (val) {
                              context
                                  .read<NewVisitProvider>()
                                  .setPtName(nameController.text);
                            },
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Enter Patient Name...'.tr();
                              }
                              return null;
                            },
                            controller: nameController,
                            obscureText: false,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Enter Patient Name'.tr(),
                            ),
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
                            width: 150.0, child: Text('Date of Birth'.tr())),
                        const SizedBox(
                          width: 20.0,
                        ),
                        SizedBox(
                          width: 250.0,
                          child: TextFormField(
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Enter Date Of Birth...'.tr();
                              }
                              return null;
                            },
                            controller: dobController,
                            obscureText: false,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: "Enter Patient's Date of Birth".tr(),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: CircleAvatar(
                            child: IconButton(
                              icon: const Icon(Icons.calendar_today),
                              onPressed: () async {
                                await showCalenderDoB(context);
                              },
                            ),
                          ),
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
                            width: 150.0, child: Text('Patient Phone'.tr())),
                        const SizedBox(
                          width: 20.0,
                        ),
                        SizedBox(
                          width: 350.0,
                          child: TextFormField(
                            onChanged: (val) {
                              context
                                  .read<NewVisitProvider>()
                                  .setPhone(phoneController.text);
                            },
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Enter Patient Phone...'.tr();
                              }
                              if (val.length != 11) {
                                return 'Enter Correct Phone - 11-digits...'
                                    .tr();
                              }
                              return null;
                            },
                            controller: phoneController,
                            obscureText: false,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Enter Patient Phone Number'.tr(),
                            ),
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
                        SizedBox(width: 150.0, child: Text('Clinic'.tr())),
                        const SizedBox(
                          width: 20.0,
                        ),
                        const SizedBox(
                          width: 350.0,
                          child: NewlyFormatedDoctorsDropDownButton(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 150.0, child: Text('Visit type'.tr())),
                        const SizedBox(
                          width: 20.0,
                        ),
                        const SizedBox(
                          child: TypeofVisitDropdown(),
                        ),
                      ],
                    ),
                    Consumer<ProcedureVisibilityProvider>(
                      builder: (context, visibility, child) {
                        return SizedBox(
                          height: visibility.visible == false ? 0 : 20.0,
                        );
                      },
                    ),
                    Consumer<ProcedureVisibilityProvider>(
                      builder: (context, visibility, child) {
                        return const ProceduresDropDown();
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const AffiliationDropdown(),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 150.0, child: Text('Amount'.tr())),
                        const SizedBox(
                          width: 20.0,
                        ),
                        SizedBox(
                          width: 350.0,
                          child: TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            onChanged: (val) {
                              try {
                                int amount = int.parse(
                                    amountController.text.isEmpty
                                        ? '0'
                                        : amountController.text);
                                context
                                    .read<NewVisitProvider>()
                                    .setAmount(amount);
                              } catch (e) {
                                print(e);
                              }
                            },
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Enter Paid Amount...'.tr();
                              }
                              return null;
                            },
                            controller: amountController,
                            obscureText: false,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Enter Amount'.tr(),
                            ),
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
                            width: 150.0, child: Text('Remaining Amount'.tr())),
                        const SizedBox(
                          width: 20.0,
                        ),
                        SizedBox(
                          width: 350.0,
                          child: TextFormField(
                            onChanged: (val) {
                              try {
                                int remaining = int.parse(
                                    remainingController.text.isEmpty
                                        ? '0'
                                        : remainingController.text);
                                context
                                    .read<NewVisitProvider>()
                                    .setRemaining(remaining);
                              } catch (e) {
                                print(e);
                              }
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            validator: (val) {
                              return null;
                            },
                            controller: remainingController,
                            obscureText: false,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Enter Remaining Amount'.tr(),
                            ),
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
                            width: 150.0, child: Text('Payment Type'.tr())),
                        const SizedBox(
                          width: 20.0,
                        ),
                        const SizedBox(
                          width: 350,
                          child: CashTypeDropdownButton(),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        shape: cardbuttonstyle,
                        backgroundColor: Colors.blue,
                      ),
                      icon: const Icon(Icons.update),
                      label: Text('Update'.tr()),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          context.read<NewVisitProvider>().setVISIT();
                          context.read<NewVisitProvider>().visit.toString();
                          await EmbeddEasyLoading(() async {
                            await VisitRequests.updateVisitData(widget.visit,
                                context.read<NewVisitProvider>().visit!);
                            await context
                                .read<VisitsSearchController>()
                                .initializeVisits();
                          });
                          Navigator.pop(context);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

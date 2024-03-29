// ignore_for_file: avoid_print

import 'package:after_layout/after_layout.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mongo_dart/mongo_dart.dart' show ObjectId;
import 'package:proclinic_windows/EntryPage/_widgets/affiliation_dropdown.dart';
import 'package:proclinic_windows/EntryPage/_widgets/fromOrganizer.dart';
import 'package:proclinic_windows/EntryPage/new_pt_tab.dart';
import 'package:proclinic_windows/EntryPage/old_pt_tab.dart';
import 'package:proclinic_windows/_const/_strings.dart';
import 'package:proclinic_windows/_mongoRequests/_visit_req.dart';
import 'package:proclinic_windows/_providers/new_visit_provider.dart';
import 'package:proclinic_windows/_providers/patient_provider.dart';
import 'package:proclinic_windows/_providers/procedureVisibilityProvider.dart';
import 'package:proclinic_windows/_providers/selectedDoctorProvider.dart';
import 'package:proclinic_windows/EntryPage/_widgets/cash_type_dropdown.dart';
import 'package:proclinic_windows/EntryPage/_widgets/consultation_followup_dropdown.dart';
import 'package:proclinic_windows/EntryPage/_widgets/doctors_dropdownmenubutton.dart';
import 'package:proclinic_windows/EntryPage/_widgets/Procedures_dropdown.dart';
import 'package:provider/provider.dart';

class HomePageWithTabView extends StatefulWidget {
  const HomePageWithTabView({Key? key}) : super(key: key);

  @override
  _HomePageWithTabViewState createState() => _HomePageWithTabViewState();
}

class _HomePageWithTabViewState extends State<HomePageWithTabView>
    with SingleTickerProviderStateMixin, AfterLayoutMixin {
  //textediting controllers
  final dateController = TextEditingController();
  final nameController = TextEditingController();
  final dobController = TextEditingController();
  final procedureController = TextEditingController();
  final phoneController = TextEditingController();
  final clinicController = TextEditingController();
  final amountController = TextEditingController();
  final remainingController = TextEditingController();
  //tab controller
  late TabController _tabController;
  //local id
  // get localId => (int.parse(phoneController.text) * 2020).toString();

  void clrflds() {
    dateController.dispose();
    nameController.dispose();
    phoneController.dispose();
    amountController.dispose();
    remainingController.dispose();
    dobController.dispose();
    clinicController.dispose();
    procedureController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void afterFirstLayout(BuildContext context) {
    context.read<SelectedDoctor>().nullifyDoctor();
  }

  @override
  void dispose() {
    clrflds();
    super.dispose();
  }

  void callsetstate() {
    setState(() {});
  }

  bool isFirstVisit = false;

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'ProClinic Entry Page'.tr(),
            textScaler: const TextScaler.linear(1.4),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          width: 800,
          height: MediaQuery.of(context).size.height * 0.9,
          child: Card(
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  children: <Widget>[
                    // construct the profile details widget here
                    const SizedBox(
                      height: 5,
                    ),

                    // the tab bar with two items
                    SizedBox(
                      height: 75,
                      width: 400,
                      child: AppBar(
                        bottom: TabBar(
                          controller: _tabController,
                          tabs: [
                            Tab(
                              icon: const Tooltip(
                                message: 'زيارة جديدة',
                                child: Icon(Icons.person_add),
                              ),
                              text: 'New Visit'.tr(),
                            ),
                            Tab(
                              icon: const Tooltip(
                                message: 'مريض سابق',
                                child: Icon(
                                  Icons.person_search,
                                ),
                              ),
                              text: 'Find Patient'.tr(),
                            ),
                            Tab(
                              icon: const Tooltip(
                                message: 'من المواعيد',
                                child: Icon(
                                  Icons.person_search,
                                ),
                              ),
                              text: 'From Organizer'.tr(),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // create widgets for each tab bar here
                    SizedBox(
                      height: 330,
                      width: 600,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          // first tab bar view widget (New Patient)
                          NewPatientSelector(
                            dateController: dateController,
                            dobController: dobController,
                            nameController: nameController,
                            phoneController: phoneController,
                            formKey: formkey,
                          ),

                          // second tab bar viiew widget (Find Patient)
                          OldPatientSelector(
                            dateController: dateController,
                            dobController: dobController,
                            nameController: nameController,
                            phoneController: phoneController,
                            tabController: _tabController,
                            organizer: false,
                          ),

                          //third tab from organizer
                          FromOrganizer(
                            dateController: dateController,
                            dobController: dobController,
                            nameController: nameController,
                            phoneController: phoneController,
                            tabController: _tabController,
                          )
                        ],
                      ),
                    ),
                    // rest of selection criteria

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 150.0,
                          child: Tooltip(
                            message: 'العيادة',
                            child: Text('Clinic'.tr()),
                          ),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        const SizedBox(
                          width: 350.0,
                          height: 50.0,
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
                        SizedBox(
                          width: 150.0,
                          child: Tooltip(
                            message: 'نوع الزيارة',
                            child: Text('Visit type'.tr()),
                          ),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        const TypeofVisitDropdown(),
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
                        SizedBox(
                          width: 150.0,
                          child: Tooltip(
                            message: 'المدفوع',
                            child: Text('Amount'.tr()),
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
                              if (val!.isEmpty) {
                                return 'kindly Enter Amount...'.tr();
                              }
                              return null;
                            },
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
                          width: 150.0,
                          child: Tooltip(
                            message: 'المتبقي',
                            child: Text('Remaining Amount'.tr()),
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
                              return null;
                            },
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
                          width: 150.0,
                          child: Tooltip(
                            message: 'طريقة الدفع',
                            child: Text('Payment Type'.tr()),
                          ),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        const SizedBox(
                          width: 350,
                          child: CashTypeDropdownButton(),
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
                            message: 'اول زيارة',
                            child: Text("is First Visit".tr()),
                          ),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        SizedBox(
                          width: 350,
                          child: Checkbox(
                            value: isFirstVisit,
                            onChanged: (value) {
                              setState(() {
                                isFirstVisit = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 20.0,
                    ),
                    //----------------Buttons for actions--------------------//

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton.icon(
                                  onPressed: () async {
                                    if (formkey.currentState!.validate()) {
                                      if (isFirstVisit) {
                                        //todo: ADD PT ENTITY TO DB
                                        context
                                            .read<NewVisitProvider>()
                                            .setVISIT(ObjectId());
                                        final _v = context
                                            .read<NewVisitProvider>()
                                            .visit;
                                        await EasyLoading.show(
                                            status: "Loading...".tr());
                                        context.read<PxPatient>().setPatient(
                                              id: _v?.ptId,
                                              name: _v?.ptName,
                                              phone: _v?.phone,
                                              dob: _v?.dob,
                                            );
                                        await context
                                            .read<PxPatient>()
                                            .addNewPatient();
                                        await EasyLoading.dismiss();
                                      } else {
                                        context
                                            .read<NewVisitProvider>()
                                            .setVISIT();
                                      }
                                    }

                                    await EasyLoading.show(
                                        status: "Loading...".tr());

                                    await VisitRequests.addNewVisitToDb(context
                                        .read<NewVisitProvider>()
                                        .visit!);
                                    context
                                        .read<NewVisitProvider>()
                                        .nullifyVisit();
                                    await EasyLoading.dismiss();
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.person_add),
                                  label: Tooltip(
                                    message: 'اضافة الي قاعدة البيانات',
                                    child: Text('Add to Database'.tr()),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

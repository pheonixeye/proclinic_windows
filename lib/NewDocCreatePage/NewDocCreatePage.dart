// ignore_for_file: avoid_print

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_windows/NewDocCreatePage/_widgets.dart';
import 'package:proclinic_windows/_models/doctorModel.dart';
import 'package:proclinic_windows/_mongoRequests/_doc_req.dart';

BoxDecoration docCreationPageDecoration = BoxDecoration(
  boxShadow: const [
    BoxShadow(offset: Offset(3.0, 3.0), blurRadius: 5.0, spreadRadius: 5.0),
  ],
  color: Colors.grey[300],
  borderRadius: BorderRadius.circular(10),
);

class NewDoctorCreationPage extends StatefulWidget {
  const NewDoctorCreationPage({Key? key}) : super(key: key);

  @override
  _NewDoctorCreationPageState createState() => _NewDoctorCreationPageState();
}

class _NewDoctorCreationPageState extends State<NewDoctorCreationPage> {
  mysetstate() {
    setState(() {});
  }

  final engNameController = TextEditingController();
  final arbNameController = TextEditingController();
  final engSpecController = TextEditingController();
  final arbSpecController = TextEditingController();
  final personalPhoneController = TextEditingController();
  final assPhoneController = TextEditingController();
  final nationalIDController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Doctor Creation Page'.tr(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          textScaleFactor: 2,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: docCreationPageDecoration,
          child: Form(
            key: formKey,
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 4,
                crossAxisSpacing: 20,
              ),
              children: [
                ItemWidgetDoctorCreationPage(
                  itemController: engNameController,
                  itemTitle: 'English Doctor Name'.tr(),
                  mysetstate: mysetstate,
                  formKey: formKey,
                ),
                ItemWidgetDoctorCreationPage(
                  itemController: arbNameController,
                  itemTitle: 'اسم الدكتور باللغة العربية',
                  mysetstate: mysetstate,
                  formKey: formKey,
                ),
                ItemWidgetDoctorCreationPage(
                  itemController: engSpecController,
                  itemTitle: 'English Speciality'.tr(),
                  mysetstate: mysetstate,
                  formKey: formKey,
                ),
                ItemWidgetDoctorCreationPage(
                  itemController: arbSpecController,
                  itemTitle: 'التخصص باللغة العربية',
                  mysetstate: mysetstate,
                  formKey: formKey,
                ),
                ItemWidgetDoctorCreationPage(
                  itemController: personalPhoneController,
                  itemTitle: 'Personal Phone Number'.tr(),
                  mysetstate: mysetstate,
                  formKey: formKey,
                ),
                ItemWidgetDoctorCreationPage(
                  itemController: assPhoneController,
                  itemTitle: 'Assistant Phone Number'.tr(),
                  mysetstate: mysetstate,
                  formKey: formKey,
                ),
                ItemWidgetDoctorCreationPage(
                  itemController: nationalIDController,
                  itemTitle: 'Syndicate Id_'.tr(),
                  mysetstate: mysetstate,
                  formKey: formKey,
                ),
                FinalizeAdditionButton(
                  mysetstate: mysetstate,
                  calledFunction: newAddDoctorToMongo,
                  confirmatoryDialog: confirmatoryfunction,
                  clrtxtcntrls: clrtxtcontrollers,
                  formKey: formKey,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future newAddDoctorToMongo() async {
    final doctor = Doctor(
      id: int.parse(nationalIDController.text),
      docnameEN: engNameController.text,
      docnameAR: arbNameController.text,
      clinicEN: engSpecController.text,
      clinicAR: arbSpecController.text,
      phonePER: personalPhoneController.text,
      phoneASS: assPhoneController.text,
      password: null,
      avatar: null,
      grid: true,
      proceduersAR: [],
      proceduersEN: [],
      titlesAR: [],
      titlesEN: [],
      affiliatesAR: [],
      affiliatesEN: [],
      fields: [],
      published: true,
      drugs: [],
      clinicDetails: [],
      labs: [],
      rads: [],
    );
    await DoctorRequests.newAddDoctorToMongoDB(
      doctor: doctor,
    );
    print('added a new doctor to mongodb');
  }

  clrtxtcontrollers() {
    arbNameController.clear();
    engNameController.clear();
    arbSpecController.clear();
    engSpecController.clear();
    personalPhoneController.clear();
    assPhoneController.clear();
    nationalIDController.clear();
  }
}

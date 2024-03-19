// ignore_for_file: constant_identifier_names, implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_windows/_const/_constWidgets.dart';
import 'package:proclinic_windows/_models/doctorModel.dart';
import 'package:proclinic_windows/_mongoRequests/_doc_req.dart';
import 'package:proclinic_windows/_providers/selectedDoctorProvider.dart';
import 'package:provider/src/provider.dart';

class PhoneEditingSection extends StatefulWidget {
  const PhoneEditingSection({
    Key? key,
    required this.rebuildParent,
  }) : super(key: key);
  final Function rebuildParent;
  @override
  _PhoneEditingSectionState createState() => _PhoneEditingSectionState();
}

class _PhoneEditingSectionState extends State<PhoneEditingSection> {
  final personalPhoneController = TextEditingController();

  final assistantPhoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  mysetstate() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final doctor = context.read<SelectedDoctor>().doctor;
    while (doctor == null) {
      return const WhileValueEqualNullWidget();
    }
    return ListTile(
      leading: const CircleAvatar(),
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 8.0),
            child: Container(
              width: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Phone Numbers'.tr(),
                  textAlign: TextAlign.center,
                  textScaler: const TextScaler.linear(1.5),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
      subtitle: Form(
        key: formKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ItemWidgetDoctorCreationPageModifiedPhone(
                    formKey: formKey,
                    itemController: personalPhoneController,
                    mysetstate: widget.rebuildParent,
                    whichPhone: WhichPhone.PERSONAL,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ItemWidgetDoctorCreationPageModifiedPhone(
                    formKey: formKey,
                    itemController: assistantPhoneController,
                    mysetstate: widget.rebuildParent,
                    whichPhone: WhichPhone.ASSISTANT,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

enum WhichPhone {
  PERSONAL,
  ASSISTANT,
}

class ItemWidgetDoctorCreationPageModifiedPhone extends StatefulWidget {
  const ItemWidgetDoctorCreationPageModifiedPhone({
    Key? key,
    required this.itemController,
    required this.mysetstate,
    required this.formKey,
    required this.whichPhone,
  }) : super(key: key);

  final TextEditingController itemController;
  final Function mysetstate;
  final GlobalKey<FormState> formKey;
  final WhichPhone whichPhone;

  @override
  State<ItemWidgetDoctorCreationPageModifiedPhone> createState() =>
      _ItemWidgetDoctorCreationPageModifiedPhoneState();
}

class _ItemWidgetDoctorCreationPageModifiedPhoneState
    extends State<ItemWidgetDoctorCreationPageModifiedPhone> {
  @override
  Widget build(BuildContext context) {
    final doctor = context.read<SelectedDoctor>().doctor;
    while (doctor == null) {
      return const WhileValueEqualNullWidget();
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 20,
        child: ListTile(
          leading: const Icon(Icons.near_me),
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.whichPhone == WhichPhone.ASSISTANT
                      ? 'Assistant Phone'.tr()
                      : 'Personal Phone'.tr(),
                  textScaler: const TextScaler.linear(1.5),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.whichPhone == WhichPhone.ASSISTANT
                      ? doctor.phoneASS
                      : doctor.phonePER,
                  textScaler: const TextScaler.linear(1.1),
                ),
              ),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (val) {
                if (val!.isEmpty || val.length != 11) {
                  return 'Kindly Supply correct phone number...'.tr();
                }
                return null;
              },
              controller: widget.itemController,
              style: const TextStyle(
                fontSize: 24,
              ),
              decoration: InputDecoration(
                suffix: IconButton(
                  icon: const Icon(
                    Icons.save,
                    color: Colors.green,
                  ),
                  onPressed: () async {
                    switch (widget.whichPhone) {
                      case WhichPhone.ASSISTANT:
                        // if (formKey.currentState!.validate() == true) {
                        await DoctorRequests.modifyField(
                          id: doctor.id,
                          parameter: SxDoctor.PHONEASSISTANT,
                          value: widget.itemController.text,
                        );
                        context.read<SelectedDoctor>().selectDoctor(doctor.id);
                        widget.itemController.clear();
                        widget.mysetstate();
                        setState(() {});

                        break;
                      case WhichPhone.PERSONAL:
                        await DoctorRequests.modifyField(
                          id: doctor.id,
                          parameter: SxDoctor.PHONEPERSONAL,
                          value: widget.itemController.text,
                        );
                        context.read<SelectedDoctor>().selectDoctor(doctor.id);
                        widget.itemController.clear();
                        widget.mysetstate();
                        setState(() {});
                        break;
                    }
                  },
                ),
                prefixIcon: const Icon(
                  Icons.edit_rounded,
                ),
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

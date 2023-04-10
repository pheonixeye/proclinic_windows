import 'dart:math';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_windows/_const/_constWidgets.dart';

class ItemWidgetDoctorCreationPage extends StatelessWidget {
  const ItemWidgetDoctorCreationPage({
    Key? key,
    required this.itemController,
    required this.itemTitle,
    required this.mysetstate,
    required this.formKey,
  }) : super(key: key);

  final TextEditingController itemController;
  final String itemTitle;
  final Function mysetstate;
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 20,
        child: ListTile(
          leading: Icon(
            Icons.near_me,
            color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
          ),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              itemTitle,
              textScaleFactor: 1.5,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (val) {
                if (val == '' || itemController.text == '') {
                  return 'Please Complete Information...'.tr();
                }
                return null;
              },
              onChanged: (value) {
                mysetstate();
              },
              controller: itemController,
              style: const TextStyle(
                fontSize: 24,
              ),
              decoration: InputDecoration(
                suffix: IconButton(
                  icon: const Icon(
                    Icons.clear_all,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    itemController.clear();
                    mysetstate();
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

final SnackBar adding = SnackBar(
  duration: const Duration(milliseconds: 50),
  content: Row(
    children: const [
      Text('Adding Clinic . . . . '),
      CircularProgressIndicator(),
    ],
  ),
);

final SnackBar added = SnackBar(
  duration: const Duration(seconds: 2),
  content: Row(
    children: const [
      Text('Clinic Added Successfully. '),
      Icon(
        Icons.thumb_up,
        color: Colors.green,
      ),
    ],
  ),
);

class FinalizeAdditionButton extends StatelessWidget {
  final Function(BuildContext) confirmatoryDialog;
  final Function calledFunction;
  final Function clrtxtcntrls;
  final Function mysetstate;
  final GlobalKey<FormState> formKey;

  const FinalizeAdditionButton({
    Key? key,
    required this.confirmatoryDialog,
    required this.calledFunction,
    required this.mysetstate,
    required this.clrtxtcntrls,
    required this.formKey,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      shape: cardbuttonstyle,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            shape: cardbuttonstyle,
          ),
          onPressed: () async {
            if (formKey.currentState!.validate() == false) {
              await confirmatoryDialog(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(adding);

              await calledFunction();

              ScaffoldMessenger.of(context).showSnackBar(added);
              await clrtxtcntrls();
              await mysetstate();
            }
          },
          icon: const Icon(Icons.add),
          label: Text('add doctor...'.tr()),
        ),
      ),
    );
  }
}

confirmatoryfunction(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Missing Data...'.tr()),
        content: Text('Kindly Complete Missing Data To Proceed...'.tr()),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Confirm'.tr()),
          ),
        ],
      );
    },
  );
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NewSupplyItemForm extends StatefulWidget {
  const NewSupplyItemForm({super.key});

  @override
  State<NewSupplyItemForm> createState() => _NewSupplyItemFormState();
}

class _NewSupplyItemFormState extends State<NewSupplyItemForm> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 10,
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Add New Item'.tr(),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 150.0, child: Text('English Name'.tr())),
                    const SizedBox(
                      width: 20.0,
                    ),
                    SizedBox(
                      width: 350.0,
                      child: TextFormField(
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Enter English Item Name...'.tr();
                          }
                          return null;
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Enter English Item Name'.tr(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 150.0, child: Text('Arabic Name'.tr())),
                    const SizedBox(
                      width: 20.0,
                    ),
                    SizedBox(
                      width: 350.0,
                      child: TextFormField(
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Enter Arabic Item Name...'.tr();
                          }
                          return null;
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Enter Arabic Item Name'.tr(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 150.0, child: Text('English Description'.tr())),
                    const SizedBox(
                      width: 20.0,
                    ),
                    SizedBox(
                      width: 350.0,
                      child: TextFormField(
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Enter English Item Description...'.tr();
                          }
                          return null;
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Enter English Item Description'.tr(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 150.0, child: Text('Arabic Description'.tr())),
                    const SizedBox(
                      width: 20.0,
                    ),
                    SizedBox(
                      width: 350.0,
                      child: TextFormField(
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Enter Arabic Item Description...'.tr();
                          }
                          return null;
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Enter Arabic Item Description'.tr(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 150.0, child: Text('Amount'.tr())),
                    const SizedBox(
                      width: 20.0,
                    ),
                    SizedBox(
                      width: 350.0,
                      child: TextFormField(
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Enter Amount...'.tr();
                          }
                          return null;
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Enter Amount'.tr(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 150.0, child: Text('Price'.tr())),
                    const SizedBox(
                      width: 20.0,
                    ),
                    SizedBox(
                      width: 350.0,
                      child: TextFormField(
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Enter Price...'.tr();
                          }
                          return null;
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Enter Price'.tr(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 150.0, child: Text('Notification Amount'.tr())),
                    const SizedBox(
                      width: 20.0,
                    ),
                    SizedBox(
                      width: 350.0,
                      child: TextFormField(
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Enter Notification Amount...'.tr();
                          }
                          return null;
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Enter Notification Amount'.tr(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 24,
                ),
                child: ElevatedButton.icon(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      //TODO: send add item request
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: Text("Add".tr()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

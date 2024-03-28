import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mongo_dart/mongo_dart.dart' show ObjectId;
import 'package:proclinic_windows/_providers/inventory_provider.dart';
import 'package:provider/provider.dart';

class NewSupplyItemForm extends StatefulWidget {
  const NewSupplyItemForm({super.key});

  @override
  State<NewSupplyItemForm> createState() => _NewSupplyItemFormState();
}

class _NewSupplyItemFormState extends State<NewSupplyItemForm> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController engNameController;
  late final TextEditingController arbNameController;
  late final TextEditingController engDescController;
  late final TextEditingController arbDescController;
  late final TextEditingController amountController;
  late final TextEditingController priceController;
  late final TextEditingController notAmountController;

  @override
  void initState() {
    super.initState();
    engNameController = TextEditingController();
    arbNameController = TextEditingController();
    engDescController = TextEditingController();
    arbDescController = TextEditingController();
    amountController = TextEditingController();
    priceController = TextEditingController();
    notAmountController = TextEditingController();
  }

  @override
  void dispose() {
    engNameController.dispose();
    arbNameController.dispose();
    engDescController.dispose();
    arbDescController.dispose();
    amountController.dispose();
    priceController.dispose();
    notAmountController.dispose();
    super.dispose();
  }

  _clearControllers() {
    engNameController.clear();
    arbNameController.clear();
    engDescController.clear();
    arbDescController.clear();
    amountController.clear();
    priceController.clear();
    notAmountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 10,
        child: Consumer<PxInventory>(
          builder: (context, i, _) {
            return Form(
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
                        SizedBox(
                            width: 150.0, child: Text('English Name'.tr())),
                        const SizedBox(
                          width: 20.0,
                        ),
                        SizedBox(
                          width: 350.0,
                          child: TextFormField(
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Enter English Item Name'.tr();
                              }
                              return null;
                            },
                            controller: engNameController,
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
                                return 'Enter Arabic Item Name'.tr();
                              }
                              return null;
                            },
                            controller: arbNameController,
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
                            width: 150.0,
                            child: Text('English Description'.tr())),
                        const SizedBox(
                          width: 20.0,
                        ),
                        SizedBox(
                          width: 350.0,
                          child: TextFormField(
                            validator: (val) {
                              return null;
                            },
                            controller: engDescController,
                            obscureText: false,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Enter English Description'.tr(),
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
                            width: 150.0,
                            child: Text('Arabic Description'.tr())),
                        const SizedBox(
                          width: 20.0,
                        ),
                        SizedBox(
                          width: 350.0,
                          child: TextFormField(
                            validator: (val) {
                              return null;
                            },
                            controller: arbDescController,
                            obscureText: false,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Enter Arabic Description'.tr(),
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
                            width: 150.0, child: Text('Available Amount'.tr())),
                        const SizedBox(
                          width: 20.0,
                        ),
                        SizedBox(
                          width: 350.0,
                          child: TextFormField(
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Enter Available Amount'.tr();
                              }
                              if (double.tryParse(val) == null) {
                                return "Wrong Format, Use Numbers Only.".tr();
                              }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: amountController,
                            obscureText: false,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Enter Available Amount'.tr(),
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
                        SizedBox(width: 150.0, child: Text('Item Price'.tr())),
                        const SizedBox(
                          width: 20.0,
                        ),
                        SizedBox(
                          width: 350.0,
                          child: TextFormField(
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Enter Item Price'.tr();
                              }
                              if (double.tryParse(val) == null) {
                                return "Wrong Format, Use Numbers Only.".tr();
                              }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: priceController,
                            obscureText: false,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Enter Item Price'.tr(),
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
                            width: 150.0,
                            child: Text('Notification Amount'.tr())),
                        const SizedBox(
                          width: 20.0,
                        ),
                        SizedBox(
                          width: 350.0,
                          child: TextFormField(
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Enter Notification Amount'.tr();
                              }
                              if (double.tryParse(val) == null) {
                                return "Wrong Format, Use Numbers Only.".tr();
                              }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: notAmountController,
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
                          //todo: SET item
                          try {
                            i.setSuppyItem(
                              id: ObjectId(),
                              nameEn: engNameController.text,
                              nameAr: arbNameController.text,
                              descriptionEn: engDescController.text,
                              descriptionAr: arbDescController.text,
                              amount: double.parse(amountController.text),
                              price: double.parse(priceController.text),
                              notifyAmount:
                                  double.parse(notAmountController.text),
                            );
                          } catch (e) {
                            await EasyLoading.showError(
                                "Wrong or Missing Information.".tr());
                          }
                          //todo: send add item request
                          try {
                            await EasyLoading.show(status: "LOADING...".tr());
                            await i.addItem();
                            await EasyLoading.showSuccess("Item Added...".tr());
                            _clearControllers();
                          } catch (e) {
                            await EasyLoading.showError(
                                "Item Add Failed...".tr());
                          }
                        }
                      },
                      icon: const Icon(Icons.add),
                      label: Text("Add Item".tr()),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

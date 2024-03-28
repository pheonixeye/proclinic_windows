import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_windows/_localization/_localization.dart';
import 'package:proclinic_windows/_models/supply_item/supply_item.dart';
import 'package:proclinic_windows/_providers/inventory_provider.dart';
import 'package:provider/provider.dart';

class InventoryItemCard extends StatefulWidget {
  const InventoryItemCard({super.key, required this.supplyItem});
  final SupplyItem supplyItem;

  @override
  State<InventoryItemCard> createState() => _InventoryItemCardState();
}

class _InventoryItemCardState extends State<InventoryItemCard> {
  Map<String, (bool, TextEditingController)> isAttributeEditing = {};

  @override
  void initState() {
    super.initState();
    widget.supplyItem.toMap().keys.map((e) {
      isAttributeEditing[e] = (false, TextEditingController());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // print(isAttributeEditing);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ExpansionTile(
          leading: const CircleAvatar(),
          title: Row(
            children: [
              Text(english(context)
                  ? widget.supplyItem.nameEn
                  : widget.supplyItem.nameAr),
              const Spacer(),
              FloatingActionButton.small(
                heroTag: widget.supplyItem.id,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                onPressed: () async {
                  await EasyLoading.show(status: "Loading...".tr());
                  if (context.mounted) {
                    await context
                        .read<PxInventory>()
                        .deleteItem(widget.supplyItem.id);
                  }
                  await EasyLoading.showSuccess("Item Deleted.".tr());
                },
                child: const Icon(Icons.delete),
              ),
            ],
          ),
          children: [
            ...widget.supplyItem.toMap().entries.map((e) {
              if (e.key == "_id") {
                return const SizedBox();
              }
              if (!isAttributeEditing[e.key]!.$1) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.attractions),
                          const SizedBox(
                            width: 20,
                          ),
                          SelectableText(e.value.toString()),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  isAttributeEditing[e.key] =
                                      (true, TextEditingController());
                                });
                              },
                              icon: const Icon(Icons.edit),
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                    ],
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.attractions),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Wrong or Missing Information.'.tr();
                                }

                                return null;
                              },
                              controller: isAttributeEditing[e.key]!.$2
                                ..text = e.value.toString(),
                              obscureText: false,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: e.key.toString(),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  isAttributeEditing[e.key] =
                                      (false, TextEditingController());
                                });
                              },
                              icon: const Icon(Icons.close),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              onPressed: () async {
                                //todo: update attribute
                                await EasyLoading.show(
                                    status: "LOADING...".tr());
                                if (context.mounted) {
                                  final newItem =
                                      widget.supplyItem.updateFromKey(
                                    e.key,
                                    isAttributeEditing[e.key]!.$2.text,
                                  );
                                  // print(newItem.toMap());
                                  await context
                                      .read<PxInventory>()
                                      .updateItem(newItem);
                                }
                                await EasyLoading.showSuccess(
                                    "Item Updated.".tr());
                                setState(() {
                                  isAttributeEditing[e.key] =
                                      (false, TextEditingController());
                                });
                              },
                              icon: const Icon(Icons.save),
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                    ],
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}

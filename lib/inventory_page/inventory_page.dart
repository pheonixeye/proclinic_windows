import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_windows/inventory_page/widgets/inventory_items_list.dart';
import 'package:proclinic_windows/inventory_page/widgets/new_item_form.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Inventory'.tr(),
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            //add new item section
            NewSupplyItemForm(),
            // check quantities and delete items section
            InventoryItemsList(),
          ],
        ),
      ),
    );
  }
}

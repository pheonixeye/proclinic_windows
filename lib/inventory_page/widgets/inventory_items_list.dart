import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_windows/_providers/inventory_provider.dart';
import 'package:proclinic_windows/inventory_page/widgets/inventory_item_card.dart';
import 'package:provider/provider.dart';

class InventoryItemsList extends StatelessWidget {
  const InventoryItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 10,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Inventory Items'.tr(),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Consumer<PxInventory>(
                builder: (context, i, _) {
                  while (i.items.isEmpty) {
                    return Center(
                      child: Card.filled(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("No Items Found".tr()),
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: i.items.length,
                    itemBuilder: (context, index) {
                      final item = i.items[index];
                      return InventoryItemCard(supplyItem: item);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

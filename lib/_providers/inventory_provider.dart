import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:proclinic_windows/Mongo_db/Mongo_db.dart';
import 'package:proclinic_windows/_models/supply_item/supply_item.dart';

class PxInventory extends ChangeNotifier {
  SupplyItem _item = SupplyItem.initial();
  SupplyItem get item => _item;

  void setSuppyItem({
    ObjectId? id,
    String? nameEn,
    String? nameAr,
    String? descriptionEn,
    String? descriptionAr,
    double? amount,
    double? price,
    double? notifyAmount,
  }) {
    _item = SupplyItem(
      id: id ?? _item.id,
      nameEn: nameEn ?? _item.nameEn,
      nameAr: nameAr ?? _item.nameAr,
      descriptionEn: descriptionEn ?? _item.descriptionEn,
      descriptionAr: descriptionAr ?? _item.descriptionAr,
      amount: amount ?? _item.amount,
      price: price ?? _item.price,
      notifyAmount: notifyAmount ?? _item.notifyAmount,
    );
    notifyListeners();
  }

  List<SupplyItem> _items = [];
  List<SupplyItem> get items => _items;

  Future<void> addItem() async {
    await MongoDB.supplies.insertOne(_item.toMap());
    await fetchItems();
  }

  Future<void> fetchItems() async {
    final result = await MongoDB.supplies.find().toList();
    _items = result.map((e) => SupplyItem.fromMap(e)).toList();
    notifyListeners();
  }

  Future<void> updateItem(ObjectId id, SupplyItem newItem) async {
    await MongoDB.supplies.updateOne(
      where.eq("_id", id),
      newItem.toMap(),
    );
    await fetchItems();
  }

  Future<void> deleteItem(ObjectId id) async {
    await MongoDB.supplies.deleteOne(where.eq("_id", id));
    await fetchItems();
  }
}

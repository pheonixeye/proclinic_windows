// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:mongo_dart/mongo_dart.dart' show ObjectId;

class SupplyItem extends Equatable {
  final ObjectId id;
  final String nameEn;
  final String nameAr;
  final double amount;
  final double price;
  final double notifyAmount;

  const SupplyItem({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.amount,
    required this.price,
    required this.notifyAmount,
  });

  SupplyItem copyWith({
    ObjectId? id,
    String? nameEn,
    String? nameAr,
    double? amount,
    double? price,
    double? notifyAmount,
  }) {
    return SupplyItem(
      id: id ?? this.id,
      nameEn: nameEn ?? this.nameEn,
      nameAr: nameAr ?? this.nameAr,
      amount: amount ?? this.amount,
      price: price ?? this.price,
      notifyAmount: notifyAmount ?? this.notifyAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // '_id': id,
      'nameEn': nameEn,
      'nameAr': nameAr,
      'amount': amount,
      'price': price,
      'notifyAmount': notifyAmount,
    };
  }

  factory SupplyItem.fromMap(Map<String, dynamic> map) {
    return SupplyItem(
      id: map['_id'] as ObjectId,
      nameEn: map['nameEn'] as String,
      nameAr: map['nameAr'] as String,
      amount: map['amount'] as double,
      price: map['price'] as double,
      notifyAmount: map['notifyAmount'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory SupplyItem.fromJson(String source) =>
      SupplyItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      nameEn,
      nameAr,
      amount,
      price,
      notifyAmount,
    ];
  }
}

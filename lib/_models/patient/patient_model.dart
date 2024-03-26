// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Patient extends Equatable {
  final ObjectId id;
  final String name;
  final String phone;
  final String dob;

  const Patient({
    required this.id,
    required this.name,
    required this.phone,
    required this.dob,
  });

  Patient copyWith({
    ObjectId? id,
    String? name,
    String? phone,
    String? dob,
  }) {
    return Patient(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      dob: dob ?? this.dob,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // '_id': id,
      'name': name,
      'phone': phone,
      'dob': dob,
    };
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      id: map["_id"] as ObjectId,
      name: map['name'] as String,
      phone: map['phone'] as String,
      dob: map['dob'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  static List<Patient> list(List<dynamic> json) {
    return json.map((e) => Patient.fromMap(e)).toList();
  }

  factory Patient.fromJson(String source) =>
      Patient.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, name, phone, dob];

  factory Patient.initial() {
    return Patient(
      id: ObjectId(),
      name: '',
      phone: '',
      dob: '',
    );
  }
}

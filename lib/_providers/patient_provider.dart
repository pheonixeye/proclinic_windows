import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:proclinic_windows/Mongo_db/Mongo_db.dart';
import 'package:proclinic_windows/_models/patient/patient_model.dart';

class PxPatient extends ChangeNotifier {
  Patient _patient = Patient.initial();
  Patient get patient => _patient;

  List<Patient> _patients = [];
  List<Patient> get patients => _patients;

  List<Patient> _filteredPatients = [];
  List<Patient> get filtered => _filteredPatients;

  void setPatient({
    ObjectId? id,
    String? name,
    String? phone,
    String? dob,
  }) {
    _patient = _patient.copyWith(
      id: id ?? _patient.id,
      name: name ?? _patient.name,
      phone: phone ?? _patient.phone,
      dob: dob ?? _patient.dob,
    );
    notifyListeners();
  }

  Future<void> addNewPatient() async {
    try {
      if (_patient != Patient.initial()) {
        await MongoDB.patients.insertOne(_patient.toMap());
        await fetchPatients();
      }
    } catch (e) {
      throw Exception("Failed to Add Patient, Error: $e");
    }
  }

  Future<void> fetchPatients() async {
    try {
      final result = await MongoDB.patients.find().toList();
      _patients = Patient.list(result);
      notifyListeners();
    } catch (e) {
      throw Exception("Failed to Fetch Patients, Error: $e");
    }
  }

  void filterPatients(String phone) {
    _filteredPatients = phone.isEmpty
        ? _patients
        : _patients
            .where((element) => element.phone.startsWith(phone))
            .toList();
    notifyListeners();
  }
}

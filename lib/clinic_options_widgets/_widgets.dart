// ignore_for_file: constant_identifier_names, implementation_imports

import 'dart:math';

import 'package:easy_localization/src/public_ext.dart';
import 'package:proclinic_windows/_const/_constWidgets.dart';
import 'package:proclinic_windows/_models/doctorModel.dart';
import 'package:proclinic_windows/_mongoRequests/_doc_req.dart';
import 'package:proclinic_windows/_providers/selectedDoctorProvider.dart';
import 'package:provider/src/provider.dart';
import 'package:flutter/material.dart';

enum PARAMETER {
  TITLES_EN,
  PROCEDURES_EN,
  AFFILIATES_EN,
  AFFILIATES_AR,
  PROCEDURES_AR,
  TITLES_AR,
}

class MyDivider extends StatelessWidget {
  const MyDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Divider(
        height: 15,
        thickness: 15,
        color: Colors.blueGrey,
      ),
    );
  }
}

class AddRemoveListWidget extends StatefulWidget {
  final Function rebuildParent;
  final PARAMETER param;
  const AddRemoveListWidget({
    Key? key,
    required this.rebuildParent,
    required this.param,
  }) : super(key: key);
  @override
  _AddRemoveListWidgetState createState() => _AddRemoveListWidgetState();
}

class _AddRemoveListWidgetState extends State<AddRemoveListWidget> {
  final procedureController = TextEditingController();

  String _buildParameter() {
    switch (widget.param) {
      case PARAMETER.PROCEDURES_EN:
        return SxDoctor.PROCEDURES_E;
      case PARAMETER.TITLES_EN:
        return SxDoctor.TITLES_E;
      case PARAMETER.AFFILIATES_EN:
        return SxDoctor.AFFILIATES_E;
      case PARAMETER.AFFILIATES_AR:
        return SxDoctor.AFFILIATES_A;
      case PARAMETER.PROCEDURES_AR:
        return SxDoctor.PROCEDURES_A;
      case PARAMETER.TITLES_AR:
        return SxDoctor.TITLES_A;
    }
  }

  List<String> _buildText() {
    switch (widget.param) {
      case PARAMETER.TITLES_EN:
        return ['Titles'.tr(), 'Enter Title'.tr(), 'Add Title'.tr()];
      case PARAMETER.PROCEDURES_EN:
        return [
          'Procedures'.tr(),
          'Enter Procedure'.tr(),
          'Add Procedure'.tr()
        ];
      case PARAMETER.AFFILIATES_EN:
        return [
          'Affiliates'.tr(),
          'Enter Affiliate'.tr(),
          'Add Affiliate'.tr()
        ];
      case PARAMETER.AFFILIATES_AR:
        return ['Arabic'.tr(), 'Enter Affiliate'.tr(), 'Add Affiliate'.tr()];
      case PARAMETER.PROCEDURES_AR:
        return ['Arabic'.tr(), 'Enter Procedure'.tr(), 'Add Procedure'.tr()];
      case PARAMETER.TITLES_AR:
        return ['Arabic'.tr(), 'Enter Title'.tr(), 'Add Title'.tr()];
    }
  }

  @override
  Widget build(BuildContext context) {
    final doctor = context.read<SelectedDoctor>().doctor;

    _buildValue() {
      if (doctor != null) {
        switch (widget.param) {
          case PARAMETER.PROCEDURES_EN:
            return doctor.proceduersEN;
          case PARAMETER.TITLES_EN:
            return doctor.titlesEN;
          case PARAMETER.AFFILIATES_EN:
            return doctor.affiliatesEN;
          case PARAMETER.AFFILIATES_AR:
            return doctor.affiliatesAR;
          case PARAMETER.PROCEDURES_AR:
            return doctor.proceduersAR;
          case PARAMETER.TITLES_AR:
            return doctor.titlesAR;
        }
      }
    }

    while (doctor == null) {
      return const WhileValueEqualNullWidget();
    }

    return ListTile(
      leading: CircleAvatar(
        backgroundColor:
            Colors.primaries[Random().nextInt(Colors.primaries.length)],
        child: Text('${_buildValue()!.length}'),
      ),
      title: Column(
        children: [
          Row(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.primaries[
                            Random().nextInt(Colors.primaries.length)],
                        offset: const Offset(3, 3),
                        blurRadius: 3.0,
                        spreadRadius: 3.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _buildText()[0],
                    textScaleFactor: 1.5,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.primaries[
                              Random().nextInt(Colors.primaries.length)],
                          offset: const Offset(3, 3),
                          blurRadius: 3.0,
                          spreadRadius: 3.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: procedureController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: _buildText()[1],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors
                      .primaries[Random().nextInt(Colors.primaries.length)],
                  shape: cardbuttonstyle,
                ),
                onPressed: () async {
                  await DoctorRequests.pushToList(
                    id: doctor.id,
                    parameter: _buildParameter(),
                    value: procedureController.text,
                  );
                  context.read<SelectedDoctor>().selectDoctor(doctor.id);

                  widget.rebuildParent();
                  setState(() {});

                  procedureController.clear();
                },
                icon: const Icon(Icons.add_circle),
                label: Text(_buildText()[2]),
              ),
            ],
          ),
        ],
      ),
      subtitle: SizedBox(
        height: 400,
        child: Card(
          color: Colors.grey[200],
          elevation: 10.0,
          child: Builder(
            builder: (context) {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _buildValue()!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.primaries[
                              Random().nextInt(Colors.primaries.length)],
                          child: Text('${index + 1}'),
                        ),
                        title: Text(_buildValue()![index]),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_forever),
                          onPressed: () async {
                            await DoctorRequests.pullFromList(
                              id: doctor.id,
                              parameter: _buildParameter(),
                              value: _buildValue()![index],
                            );
                            context
                                .read<SelectedDoctor>()
                                .selectDoctor(doctor.id);
                            widget.rebuildParent();
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

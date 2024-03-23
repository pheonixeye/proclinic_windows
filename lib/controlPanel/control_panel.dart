// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_windows/controlPanel/_model.dart';

import '_widgets.dart';

class ControlPanel extends StatelessWidget {
  const ControlPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ProClinic Control Panel'.tr(),
          textScaler: const TextScaler.linear(1.4),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.5,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            children: [
              ...SelectionButtonModel.modelList().map((e) {
                return SelectionButton(
                  iconData: e.iconData,
                  title: e.title,
                  tooltip: e.tooltip,
                  route: e.route,
                  shadowColor: e.shadowColor,
                );
              }).toList(),
              QRCodeSelectionButton(),
            ],
          ),
        ),
      ),
    );
  }
}

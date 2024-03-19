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
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Wrap(
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
            ),
          ),
        ),
      ),
    );
  }
}

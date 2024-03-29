// ignore_for_file: file_names

import 'package:after_layout/after_layout.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_windows/_providers/settingsProvider.dart';
import 'package:proclinic_windows/settings_page/section_database.dart';
import 'package:proclinic_windows/settings_page/section_theme_language.dart';
import 'package:provider/src/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with AfterLayoutMixin {
  final _controller = ScrollController();
  @override
  void afterFirstLayout(BuildContext context) {
    _initSettings();
  }

  _initSettings() async {
    await context.read<SettingsProvider>().setScanScriptPath();
    await context.read<SettingsProvider>().setDbPath();
    await context.read<SettingsProvider>().setPrintFilePath();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Settings'.tr(),
            textScaler: const TextScaler.linear(1.4),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: const <BoxShadow>[
              BoxShadow(
                offset: Offset(5.0, 5.0),
                blurRadius: 5.0,
                spreadRadius: 5.0,
              ),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoScrollbar(
                  controller: _controller,
                  thickness: 20,
                  thumbVisibility: true,
                  child: ListView(
                    controller: _controller,
                    padding: const EdgeInsets.all(8.0),
                    children: const [
                      //dark mode
                      ThemeChangerSection(),
                      CustomDivider_Settings(),

                      //language
                      ThemeChangerSection(
                        language: true,
                      ),
                      CustomDivider_Settings(),

                      //database path
                      DatabaseSection(),
                      CustomDivider_Settings(),

                      //Print file path
                      // PrintFileSection(),
                      // CustomDivider_Settings(),

                      //scan script path
                      // ScannerScriptSection(),
                      // CustomDivider_Settings(),
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

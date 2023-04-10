// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:math';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:localstorage/localstorage.dart';
import 'package:proclinic_windows/_const/_strings.dart';
import 'package:proclinic_windows/_providers/settingsProvider.dart';
import 'package:provider/provider.dart';

class DatabaseSection extends StatefulWidget {
  const DatabaseSection({Key? key}) : super(key: key);

  @override
  _DatabaseSectionState createState() => _DatabaseSectionState();
}

class _DatabaseSectionState extends State<DatabaseSection> {
  Future _pickFile() async {
    String? selectedDirectory = await FilePicker.platform
        .getDirectoryPath(dialogTitle: 'Select Database Path...');

    if (selectedDirectory != null) {
      final LocalStorage _storagedb = LocalStorage('$DBPATH.json');
      await _storagedb.ready;
      await _storagedb.setItem(DBPATH, selectedDirectory);
    } else {
      print('db not selected...');
    }
    await context.read<SettingsProvider>().setDbPath();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors
                  .primaries[Random.secure().nextInt(Colors.primaries.length)],
            ),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text('Set Database Path').tr(),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Consumer<SettingsProvider>(
                    builder: (context, settings, child) {
                      while (settings.dbpath == null) {
                        return Text('No Selected Path...'.tr());
                      }
                      return Text(settings.dbpath!);
                    },
                  ),
                ],
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () async {
                await _pickFile();
              },
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class CustomDivider_Settings extends StatelessWidget {
  const CustomDivider_Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Divider(
        height: 15,
        thickness: 3,
        color: Colors.blueGrey,
        indent: 20,
        endIndent: 20,
      ),
    );
  }
}

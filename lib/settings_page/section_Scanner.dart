// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:math';

import 'package:easy_localization/src/public_ext.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:proclinic_windows/_const/_strings.dart';
import 'package:proclinic_windows/_providers/settingsProvider.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class ScannerScriptSection extends StatefulWidget {
  const ScannerScriptSection({Key? key}) : super(key: key);

  @override
  _ScannerScriptSectionState createState() => _ScannerScriptSectionState();
}

class _ScannerScriptSectionState extends State<ScannerScriptSection> {
  Future _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      dialogTitle: 'Select Print File Path...',
      allowedExtensions: [
        'exe',
      ],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      final LocalStorage _storagedb = LocalStorage('$SCANSCRIPTPATH.json');
      await _storagedb.ready;
      await _storagedb.setItem(SCANSCRIPTPATH, file.path);
    } else {
      print('scan script not selected...');
    }
    await context.read<SettingsProvider>().setScanScriptPath();
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
              child: const Text('Scan Script Path').tr(),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<SettingsProvider>(
                builder: (context, settings, child) {
                  while (settings.scanscriptpath == null) {
                    return const Text('No Scan Script Selected...').tr();
                  }
                  return Text(settings.scanscriptpath!);
                },
              ),
            ),
            trailing: IconButton(
              tooltip: 'Select Scan-Script Path',
              icon: const Icon(Icons.search),
              onPressed: () {
                _pickFile();
              },
            ),
          ),
        ),
      ),
    );
  }
}

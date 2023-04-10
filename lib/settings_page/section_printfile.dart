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
// import 'package:proclinic_windows/Win_32_Trials/zTEST_TXT_open_dialog_ffi.dart';

class PrintFileSection extends StatefulWidget {
  const PrintFileSection({Key? key}) : super(key: key);

  @override
  _PrintFileSectionState createState() => _PrintFileSectionState();
}

class _PrintFileSectionState extends State<PrintFileSection> {
  Future _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      dialogTitle: 'Select Print File Path...',
      allowedExtensions: [
        'txt',
      ],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      final LocalStorage _storagedb = LocalStorage('$PRINTFILEPATH.json');
      await _storagedb.ready;
      await _storagedb.setItem(PRINTFILEPATH, file.path);
    } else {
      print('print file not selected...');
    }
    await context.read<SettingsProvider>().setPrintFilePath();
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
              child: const Text('Set Print File Path').tr(),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<SettingsProvider>(
                builder: (context, settings, child) {
                  while (settings.printfilepath == null) {
                    return const Text('No Print File Selected...').tr();
                  }
                  return Text(settings.printfilepath!);
                },
              ),
            ),
            trailing: IconButton(
              tooltip: 'Select Print-Reciept File Path',
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

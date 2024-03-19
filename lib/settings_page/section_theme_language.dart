import 'dart:async';
import 'dart:io';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_windows/_localization/_localization.dart';
import 'package:proclinic_windows/theming/theme_data.dart';
import 'package:provider/provider.dart';

class ThemeChangerSection extends StatefulWidget {
  const ThemeChangerSection({
    Key? key,
    this.language = false,
  }) : super(key: key);

  final bool language;
  @override
  _ThemeChangerSectionState createState() => _ThemeChangerSectionState();
}

class _ThemeChangerSectionState extends State<ThemeChangerSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: const CircleAvatar(),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.language ? 'Language' : 'Dark Mode').tr(),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.language
                      ? 'Select App Language'
                      : 'Select App Theme')
                  .tr(),
            ),
            trailing: widget.language
                ? IconButton(
                    onPressed: () async {
                      await changeLocale(context);
                      await EasyLoading.showToast(
                          'Language Changed - Restarting...');
                      await EasyLoading.showSuccess(
                              'Exiting in... 2 Seconds...')
                          .then((value) async {
                        await Future.delayed(const Duration(seconds: 2))
                            .then((value) => exit(0));
                      });
                    },
                    icon: const Icon(Icons.language),
                  )
                : IconButton(
                    icon: const Icon(Icons.theater_comedy),
                    onPressed: () {
                      context.read<ThemeChanger>().switchTheme();
                    },
                  ),
          ),
        ),
      ),
    );
  }
}

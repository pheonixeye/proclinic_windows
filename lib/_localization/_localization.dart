import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Future<void> changeLocale(BuildContext context) async {
  if (context.locale == const Locale('en', 'US')) {
    await context.setLocale(const Locale('ar', 'EG'));
  } else {
    await context.setLocale(const Locale('en', 'US'));
  }
}

bool english(BuildContext context) {
  if (context.locale == const Locale('en', 'US')) {
    return true;
  } else {
    return false;
  }
}

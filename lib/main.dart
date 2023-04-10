// ignore_for_file: avoid_print

import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_windows/_const/_providers.dart';
import 'package:proclinic_windows/_logic/_UUID/fetchUUID.dart';

import 'package:hive/hive.dart';
import 'package:proclinic_windows/loadingScreen/loading_screen.dart';
import 'package:proclinic_windows/loadingScreen/wrong_mac_adress_page/wrong_mac_UI.dart';
import 'package:proclinic_windows/theming/theme_config.dart';
import 'package:proclinic_windows/theming/theme_data.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  Hive.init('assets\\themestore.hive');
  box = await Hive.openBox('themestore');

  runApp(
    MultiProvider(
      providers: providers,
      child: EasyLocalization(
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ar', 'EG'),
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        startLocale: const Locale('en', 'US'),
        child:
            //  MultiProvider(
            //   providers: providers,
            //   child:
            const ProClinic(),
        // ),
      ),
    ),
  );
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class ProClinic extends StatefulWidget {
  const ProClinic({Key? key}) : super(key: key);

  @override
  _ProClinicState createState() => _ProClinicState();
}

class _ProClinicState extends State<ProClinic> {
  @override
  void initState() {
    super.initState();
    themeChanger.addListener(() {
      print('theme changed');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: modedDarkTheme,
      themeMode: themeChanger.currentTheme(),
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      initialRoute: '/',
      routes: {
        '/': (context) =>
            checkUUID() ? const LoadingScreen() : const WrongMacAddressPage(),
        // const LoadingScreen(),
      },
      builder: EasyLoading.init(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}

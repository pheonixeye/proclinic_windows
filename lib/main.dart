// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:json_theme/json_theme.dart';
import 'package:proclinic_windows/_const/_providers.dart';
import 'package:proclinic_windows/_logic/_UUID/fetchUUID.dart';

import 'package:hive/hive.dart';
import 'package:proclinic_windows/loadingScreen/loading_screen.dart';
import 'package:proclinic_windows/loadingScreen/wrong_mac_adress_page/wrong_mac_UI.dart';
import 'package:proclinic_windows/theming/theme_data.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  Hive.init('assets\\themestore.hive');
  ThemeChanger.box = await Hive.openBox('themestore');

  final _themeStringLight =
      await rootBundle.loadString('assets/theme/theme_light.json');
  final _themeJsonLight = jsonDecode(_themeStringLight);
  final ThemeData lightTheme = ThemeDecoder.decodeThemeData(_themeJsonLight)!;
  final _themeStringDark =
      await rootBundle.loadString('assets/theme/theme_dark.json');
  final _themeJsonDark = jsonDecode(_themeStringDark);
  final ThemeData darkTheme = ThemeDecoder.decodeThemeData(_themeJsonDark)!;

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
        child: ProClinic(
          lightTheme: lightTheme,
          darkTheme: darkTheme,
        ),
      ),
    ),
  );
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class ProClinic extends StatelessWidget {
  const ProClinic({
    Key? key,
    required this.lightTheme,
    required this.darkTheme,
  }) : super(key: key);
  final ThemeData lightTheme;
  final ThemeData darkTheme;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeChanger>(
      builder: (context, t, _) {
        return MaterialApp(
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: t.currentTheme(),
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          initialRoute: '/',
          routes: {
            '/': (context) => checkUUID()
                ? const LoadingScreen()
                : const WrongMacAddressPage(),
          },
          builder: EasyLoading.init(),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
        );
      },
    );
  }
}

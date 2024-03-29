import 'dart:async' show Timer;

import 'package:flutter/material.dart';
import 'package:proclinic_windows/Mongo_db/Mongo_db.dart';
import 'package:proclinic_windows/_localization/_localization.dart';
import 'package:proclinic_windows/_logic/get_mac_adress_fns/get_mac_adress.dart';
import 'package:proclinic_windows/controlPanel/control_panel.dart';
import 'package:proclinic_windows/loadingScreen/not_connected_db/not_connected_db.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    MongoDB.openYaMongo().then((value) {
      Timer(
        const Duration(seconds: 5),
        () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => const ControlPanel(),
          ),
        ),
      );
    }).catchError(
      (e) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => NoDBConnectionPage(
              error: e.toString(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    runshellmac(context);

    return Scaffold(
      body: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/color.png'),
              width: 400,
              height: 400,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    english(context)
                        ? 'Custom Integrated \nClinic Management Systems : \nProClinic v1.5'
                        : 'نظام ادارة\nالعيادات المتكامل :\nبروكلينيك',
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(english(context)
                      ? '\n \n \n by Dr.Kareem Zaher'
                      : '\n \n \n تصميم : د. كريم زاهر'),
                ],
              ),
            ),
            const Image(
              image: AssetImage('assets/loading.gif'),
              width: 300,
              height: 80,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

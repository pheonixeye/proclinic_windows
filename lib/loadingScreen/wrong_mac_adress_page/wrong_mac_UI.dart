import 'dart:io';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

class WrongMacAddressPage extends StatelessWidget {
  const WrongMacAddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'UnAuthorized Device'.tr(),
          textScaler: const TextScaler.linear(1.4),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: const SizedBox(),
      ),
      body: Builder(
        builder: (context) {
          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(4.0, 4.0),
                    blurRadius: 4.0,
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                          'This Device is not registered for using the Application.'
                              .tr()),
                      Text(' \n Kindly Contact the vendor.'.tr()),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.exit_to_app),
                        label: Text('Exit'.tr()),
                        onPressed: () {
                          exit(0);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

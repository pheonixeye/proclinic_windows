import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_windows/loadingScreen/loading_screen.dart';
import 'dart:io';

class NoDBConnectionPage extends StatefulWidget {
  final String error;

  const NoDBConnectionPage({Key? key, required this.error}) : super(key: key);
  @override
  _NoDBConnectionPageState createState() => _NoDBConnectionPageState();
}

class _NoDBConnectionPageState extends State<NoDBConnectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Failed to innitialize ProClinic App.'.tr()),
            const SizedBox(
              height: 20,
            ),
            Card(
                color: Colors.red,
                child: Text('Error : ${widget.error.toString()}')),
            const SizedBox(
              height: 20,
            ),
            Text('Please Resolve this Error and try again later.'.tr()),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: Text('Retry'.tr()),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoadingScreen(),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.close),
              label: Text('Exit'.tr()),
              onPressed: () {
                exit(0);
              },
            ),
          ],
        ),
      ),
    );
  }
}

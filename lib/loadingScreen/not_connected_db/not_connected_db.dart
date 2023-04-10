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
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Failed to innitialize ProClinic App.'),
            const SizedBox(
              height: 20,
            ),
            Card(
                color: Colors.red,
                child: Text('Error : ${widget.error.toString()}')),
            const SizedBox(
              height: 20,
            ),
            const Text('Please Resolve this Error and try again later.'),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoadingScreen()));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.close),
              label: const Text('Exit'),
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

import 'dart:math';

import 'package:flutter/material.dart';

class ButtonType1 extends StatelessWidget {
  const ButtonType1(
      {Key? key,
      required this.route,
      required this.icondata,
      required this.title})
      : super(key: key);
  final Widget route;
  final IconData icondata;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 250,
      child: TextButton.icon(
        style: TextButton.styleFrom(
          foregroundColor:
              Colors.primaries[Random().nextInt(Colors.primaries.length)],
          disabledForegroundColor: Colors
              .primaries[Random().nextInt(Colors.primaries.length)]
              .withOpacity(0.38),
          backgroundColor:
              Colors.primaries[Random().nextInt(Colors.primaries.length)],
          shadowColor:
              Colors.primaries[Random().nextInt(Colors.primaries.length)],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        icon: Icon(
          icondata,
          color: Colors.black,
        ),
        label: Text(
          title,
          textScaler: const TextScaler.linear(2.0),
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => route,
            ),
          );
        },
      ),
    );
  }
}

class ButtonType2 extends StatelessWidget {
  const ButtonType2(
      {Key? key,
      required this.route,
      required this.icondata,
      required this.title})
      : super(key: key);
  final Widget route;
  final IconData icondata;
  final String title;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 250,
      child: MaterialButton(
        color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
        hoverColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
        highlightColor:
            Colors.primaries[Random().nextInt(Colors.primaries.length)],
        splashColor:
            Colors.primaries[Random().nextInt(Colors.primaries.length)],
        shape: const CircleBorder(),
        onPressed: () {
          // showdialogofSHEETS(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => route,
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icondata,
              color: Colors.black,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              title,
              textScaler: const TextScaler.linear(2.0),
              style: const TextStyle(
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}

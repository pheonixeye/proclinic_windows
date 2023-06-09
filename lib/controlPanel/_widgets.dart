// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SelectionButton extends StatefulWidget {
  final Color shadowColor;

  const SelectionButton({
    Key? key,
    required this.iconData,
    required this.title,
    required this.tooltip,
    required this.route,
    required this.shadowColor,
  }) : super(key: key);
  final IconData iconData;
  final String title;
  final String tooltip;
  final Widget route;
  @override
  State<SelectionButton> createState() => _SelectionButtonState();
}

class _SelectionButtonState extends State<SelectionButton> {
  bool pressed = false;
  var duration = const Duration(milliseconds: 200);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          setState(() {
            pressed = true;
          });
          await Future.delayed(duration);
          setState(() {
            pressed = false;
          });
          await Navigator.push(
              context, MaterialPageRoute(builder: (context) => widget.route));
        },
        child: Tooltip(
          message: widget.tooltip.toUpperCase(),
          child: AnimatedContainer(
            duration: duration,
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: pressed ? Colors.blue : Colors.white,
              boxShadow: [
                BoxShadow(
                    offset: pressed ? Offset(0, 0) : Offset(5, 5),
                    blurRadius: pressed ? 0 : 5,
                    spreadRadius: pressed ? 0 : 5,
                    color: widget.shadowColor),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.iconData,
                  size: pressed ? 70 : 50,
                ),
                Text(
                  widget.title.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: pressed ? 42 : 36,
                    fontWeight: pressed ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

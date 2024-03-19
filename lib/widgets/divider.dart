import 'package:flutter/material.dart';

class SeparatorLine extends StatelessWidget {
  const SeparatorLine({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 2,
      height: 10,
    );
  }
}

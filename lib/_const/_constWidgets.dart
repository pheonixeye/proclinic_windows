// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

final cardbuttonstyle =
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(20));

class WhileValueEqualNullWidget extends StatelessWidget {
  const WhileValueEqualNullWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      shape: cardbuttonstyle,
      child: const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}

Future EmbeddEasyLoading(Function call) async {
  await EasyLoading.show(status: 'LOADING');
  await call();
  await EasyLoading.dismiss();
}

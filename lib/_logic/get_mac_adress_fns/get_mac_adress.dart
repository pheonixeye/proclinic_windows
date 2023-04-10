// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:proclinic_windows/loadingScreen/wrong_mac_adress_page/wrong_mac_UI.dart';
import 'package:hive/hive.dart';

Future runshellmac(BuildContext context) async {
  // final macadr = LocalStorage('macadr');
  Hive.init('assets\\internals.hive');
  Box boxInternals = await Hive.openBox('internals');
  // await macadr.ready;
  ProcessResult netadapter = Process.runSync('powershell.exe', [
    r'$CurrMac = get-netadapter | where {$_.name -ceq "Ethernet"}'
        '\n'
        r'$CurrMacAddr = $CurrMac.MacAddress'
        '\n'
        r'$CurrMacAddr'
  ]);
  if (boxInternals.isEmpty) {
    await runscript().then((value) {
      boxInternals.put('macadr', value);
    });
    print(boxInternals.get('macadr'));
    // await macadr.setItem('macadr', netadapter.stdout);
  } else if (await boxInternals.get('macadr') != netadapter.stdout) {
    print('wrong address ${netadapter.stdout}');
    await Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const WrongMacAddressPage()));
  } else if (await boxInternals.get('macadr') == netadapter.stdout) {
    print('true address ${netadapter.stdout}');

    // await Navigator.pushReplacement(context,
    //     MaterialPageRoute(builder: (context) => WrongMacAddressPage()));
  }
}

Future runscript() async {
  var netadapter = Process.runSync('powershell.exe', [
    r'$CurrMac = get-netadapter | where {$_.name -ceq "Ethernet"}'
        '\n'
        r'$CurrMacAddr = $CurrMac.MacAddress'
        '\n'
        r'$CurrMacAddr'
  ]);
  return netadapter.stdout;
}

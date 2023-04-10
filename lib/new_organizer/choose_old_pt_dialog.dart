import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_windows/EntryPage/old_pt_tab.dart';

pickoldptorg(
    {required BuildContext context,
    required TextEditingController namecont,
    required TextEditingController phonecont}) {
  double htpad = MediaQuery.of(context).size.height * 0.1;
  double wdpad = MediaQuery.of(context).size.width * 0.1;
  ScrollController _scrcont = ScrollController();
  showDialog(
      useSafeArea: false,
      barrierColor: Colors.transparent,
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: wdpad,
            vertical: htpad,
          ),
          child: CupertinoScrollbar(
            controller: _scrcont,
            thickness: 20,
            isAlwaysShown: true,
            thicknessWhileDragging: 20,
            child: SingleChildScrollView(
              controller: _scrcont,
              child: Material(
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.primaries[
                                Random().nextInt(Colors.primaries.length)],
                            offset: const Offset(5, 5),
                            blurRadius: 5.0,
                            spreadRadius: 5.0),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 30, top: 20),
                              child: IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            )
                          ],
                        ),
                        OldPatientSelector(
                          organizer: true,
                          nameController: namecont,
                          phoneController: phonecont,
                          tabController: null,
                          dateController: null,
                          dobController: null,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      });
}

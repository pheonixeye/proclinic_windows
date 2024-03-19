import 'package:flutter/material.dart';
import 'package:proclinic_windows/EntryPage/old_pt_tab.dart';

pickoldptorg({
  required BuildContext context,
  required TextEditingController namecont,
  required TextEditingController phonecont,
}) {
  showDialog(
    useSafeArea: false,
    barrierColor: Colors.transparent,
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text('Search Patients'),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        content: Container(
          width: 600,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
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
      );
    },
  );
}

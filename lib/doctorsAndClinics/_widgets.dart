import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_windows/_localization/_localization.dart';
import 'package:proclinic_windows/_models/doctorModel.dart';
import 'package:proclinic_windows/_providers/doctorListProvider.dart';
import 'package:proclinic_windows/_providers/selectedDoctorProvider.dart';
import 'package:provider/src/provider.dart';

class DeleteDoctorAlertDialog extends StatefulWidget {
  const DeleteDoctorAlertDialog({
    Key? key,
    required this.doctor,
  }) : super(key: key);
  final Doctor doctor;
  @override
  _DeleteDoctorAlertDialogState createState() =>
      _DeleteDoctorAlertDialogState();
}

class _DeleteDoctorAlertDialogState extends State<DeleteDoctorAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(english(context)
          ? 'Delete dr. ${widget.doctor.docnameEN.toUpperCase()}\'s clinic ?'
          : 'تاكيد الغاء عيادة دكنور ${widget.doctor.docnameAR.toUpperCase()}'),
      titlePadding: const EdgeInsets.all(40),
      content: Text(english(context)
          ? 'Please confirm deleting dr. ${widget.doctor.docnameEN.toUpperCase()} clinic and all it\'s data.\nDeleted data cannot be Retrieved again !'
          : 'اتمام هذه العملية سوف يلغي كل بيانات الطبيب دون رجعة ؟؟'),
      actions: [
        TextButton(
          child: Text(
            'Confirm'.tr(),
            style: const TextStyle(color: Colors.green),
          ),
          onPressed: () async {
            await context
                .read<SelectedDoctor>()
                .unpublishDoctor(widget.doctor.id);
            await context.read<DoctorListProvider>().fetchAllDoctors();
            Navigator.pop(context);
          },
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Cancel'.tr(),
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}

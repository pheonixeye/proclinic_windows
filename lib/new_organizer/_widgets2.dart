import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_windows/_const/_constWidgets.dart';
import 'package:proclinic_windows/_localization/_localization.dart';
import 'package:proclinic_windows/_models/orgAppModel.dart';
import 'package:proclinic_windows/_providers/orgAppProvider.dart';
import 'package:proclinic_windows/functions/format_time.dart';
import 'package:provider/src/provider.dart';

class DeleteAppDialog extends StatelessWidget {
  const DeleteAppDialog({Key? key, required this.app}) : super(key: key);
  final OrgAppointement app;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      shape: cardbuttonstyle,
      title: Text(
        'Delete Entry...'.tr(),
        textAlign: TextAlign.center,
      ),
      content: Text(
        'Delete Patient Entry?'.tr(),
        textAlign: TextAlign.center,
      ),
      actions: [
        ElevatedButton.icon(
          onPressed: () async {
            await context.read<OrgAppProvider>().removeAppointement(app);
            await context.read<OrgAppProvider>().fetchAppointements();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.check_circle,
            color: Colors.green,
          ),
          label: Text('Confirm'.tr()),
        ),
        TextButton.icon(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.cancel,
            color: Colors.red,
          ),
          label: Text('Cancel'.tr()),
        ),
      ],
    );
  }
}

class OrgInfoCard extends StatefulWidget {
  const OrgInfoCard({Key? key, required this.index, required this.app})
      : super(key: key);
  final int index;
  final OrgAppointement app;

  @override
  _OrgInfoCardState createState() => _OrgInfoCardState();
}

class _OrgInfoCardState extends State<OrgInfoCard> {
  @override
  Widget build(BuildContext context) {
    final visD = widget.app.dateTime;
    final d = DateTime.parse(visD);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          leading: CircleAvatar(
            child: Text((widget.index + 1).toString()),
          ),
          trailing: Tooltip(
            message: 'حذف',
            child: IconButton(
              icon: const Icon(Icons.delete_forever),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return DeleteAppDialog(
                      app: widget.app,
                    );
                  },
                );
              },
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.person),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${'Name'.tr()} : '),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                widget.app.ptname,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.phone),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${'Phone Number'.tr()} : '),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                widget.app.phone,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.calendar_today),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${'Appointment'.tr()} : '),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                '${d.day}-${d.month}-${d.year}\n${formatTime(d.hour, d.minute)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.local_hospital),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${'Doctor'.tr()} : '),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                english(context)
                    ? widget.app.docnameEN.toUpperCase()
                    : widget.app.docnameAR,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.local_hospital),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${'Clinic'.tr()} : '),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                english(context)
                    ? widget.app.clinicEN.toUpperCase()
                    : widget.app.clinicAR,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

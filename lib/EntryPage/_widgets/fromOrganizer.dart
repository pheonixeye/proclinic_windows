import 'package:flutter/material.dart';
import 'package:proclinic_windows/_const/_constWidgets.dart';
import 'package:proclinic_windows/_localization/_localization.dart';
import 'package:proclinic_windows/_models/orgAppModel.dart';
import 'package:proclinic_windows/_providers/new_visit_provider.dart';
import 'package:proclinic_windows/_providers/orgAppProvider.dart';
import 'package:proclinic_windows/functions/format_time.dart';
import 'package:provider/provider.dart';

class FromOrganizer extends StatefulWidget {
  const FromOrganizer({
    Key? key,
    required this.dateController,
    required this.dobController,
    required this.tabController,
    required this.nameController,
    required this.phoneController,
  }) : super(key: key);
  final TextEditingController dateController;
  final TextEditingController dobController;
  final TabController tabController;
  final TextEditingController nameController;
  final TextEditingController phoneController;

  @override
  _FromOrganizerState createState() => _FromOrganizerState();
}

class _FromOrganizerState extends State<FromOrganizer> {
  @override
  void initState() {
    super.initState();
    _initApps();
  }

  _initApps() async {
    await context.read<OrgAppProvider>().fetchAppointements();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedContainer(
        height: 700,
        width: 500,
        duration: const Duration(milliseconds: 300),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Consumer<OrgAppProvider>(
              builder: (context, org, child) {
                while (org.appointements == null) {
                  return const WhileValueEqualNullWidget();
                }
                return ListView.builder(
                  itemCount: org.appointements!.length,
                  itemBuilder: (context, index) {
                    final d =
                        DateTime.parse(org.appointements![index].dateTime);
                    final dob = DateTime.parse(org.appointements![index].dob);
                    final ptname = org.appointements![index].ptname;
                    final phone = org.appointements![index].phone;
                    return EntryOrganizerTile(
                      app: org.appointements![index],
                      index: index,
                      onTap: () {
                        widget.dateController.text =
                            '${d.day}-${d.month}-${d.year}';
                        widget.dobController.text =
                            '${dob.day}-${dob.month}-${dob.year}';
                        context.read<NewVisitProvider>().setVisitDate(
                            DateTime(d.year, d.month, d.day).toIso8601String());
                        context.read<NewVisitProvider>().setDob(
                            DateTime(dob.year, dob.month, dob.day)
                                .toIso8601String());
                        widget.nameController.text = ptname;
                        context.read<NewVisitProvider>().setPtName(ptname);
                        widget.phoneController.text = phone;
                        context.read<NewVisitProvider>().setPhone(phone);
                        widget.tabController.animateTo(0);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class EntryOrganizerTile extends StatelessWidget {
  const EntryOrganizerTile({
    Key? key,
    required this.app,
    required this.index,
    required this.onTap,
  }) : super(key: key);
  final OrgAppointement app;
  final int index;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    var d = DateTime.parse(app.dateTime);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            child: Text('${index + 1}'),
          ),
          title: Row(
            children: [
              Text(app.ptname.toUpperCase()),
              const Spacer(),
              Text(app.phone),
            ],
          ),
          subtitle: Row(
            children: [
              Text(english(context) ? app.docnameEN : app.docnameAR),
              const Spacer(),
              Text(
                '${d.day}-${d.month}-${d.year}\n${formatTime(d.hour, d.minute)}',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}

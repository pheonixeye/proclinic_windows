import 'package:flutter/material.dart';
import 'package:proclinic_windows/_const/_constWidgets.dart';
import 'package:proclinic_windows/_models/orgAppModel.dart';
import 'package:proclinic_windows/_providers/new_visit_provider.dart';
import 'package:proclinic_windows/_providers/orgAppProvider.dart';
import 'package:provider/provider.dart';

class FromOrganizer extends StatefulWidget {
  const FromOrganizer(
      {Key? key,
      this.dateController,
      this.dobController,
      this.tabController,
      required this.nameController,
      required this.phoneController})
      : super(key: key);
  final TextEditingController? dateController;
  final TextEditingController? dobController;
  final TabController? tabController;
  final TextEditingController nameController;
  final TextEditingController phoneController;

  @override
  _FromOrganizerState createState() => _FromOrganizerState();
}

class _FromOrganizerState extends State<FromOrganizer> {
  @override
  void initState() {
    // TODO: implement initState
    _initApps();
    super.initState();
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
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  offset: Offset(2, 2),
                  blurRadius: 2,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Consumer<OrgAppProvider>(
              builder: (context, org, child) {
                while (org.appointements == null) {
                  return const WhileValueEqualNullWidget();
                }
                return ListView.builder(
                  itemCount: org.appointements!.length,
                  itemBuilder: (context, index) {
                    var d = DateTime.parse(org.appointements![index].dateTime);
                    return EntryOrganizerTile(
                      app: org.appointements![index],
                      index: index,
                      onTap: () {
                        widget.dateController!.text =
                            '${d.day}-${d.month}-${d.year} - ${d.hour} : ${d.minute}';
                        context
                            .read<NewVisitProvider>()
                            .setVisitDate(DateTime.now().toIso8601String());
                        widget.nameController.text =
                            org.appointements![index].ptname;
                        context
                            .read<NewVisitProvider>()
                            .setPtName(org.appointements![index].ptname);
                        widget.phoneController.text =
                            org.appointements![index].phone;
                        context
                            .read<NewVisitProvider>()
                            .setPhone(org.appointements![index].phone);
                        widget.tabController!.animateTo(0);
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
  const EntryOrganizerTile(
      {Key? key, required this.app, required this.index, required this.onTap})
      : super(key: key);
  final OrgAppointement app;
  final int index;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    var d = DateTime.parse(app.dateTime);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.grey.shade300,
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
              Text(app.docname),
              const Spacer(),
              Text(
                '${d.day}-${d.month}-${d.year}\n${d.hour} : ${d.minute}',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          onTap: () {
            onTap();
          },
        ),
      ),
    );
  }
}

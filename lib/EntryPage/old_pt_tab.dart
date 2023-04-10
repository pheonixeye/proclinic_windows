import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proclinic_windows/_const/_constWidgets.dart';
import 'package:proclinic_windows/_providers/new_visit_provider.dart';
import 'package:proclinic_windows/_providers/visitsControllerProvider.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class OldPatientSelector extends StatefulWidget {
  final TextEditingController? dateController;
  final TextEditingController? dobController;
  final TabController? tabController;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final bool organizer;

  const OldPatientSelector(
      {Key? key,
      required this.tabController,
      required this.dateController,
      required this.dobController,
      required this.nameController,
      required this.phoneController,
      required this.organizer})
      : super(key: key);
  @override
  _OldPatientSelectorState createState() => _OldPatientSelectorState();
}

class _OldPatientSelectorState extends State<OldPatientSelector> {
  final searchController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    initVisits();
    super.initState();
  }

  Future initVisits() async {
    await context.read<VisitsSearchController>().initializeVisits();
  }

  final fkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 700,
        width: 500,
        child: Consumer<VisitsSearchController>(
          builder: (context, visits, child) {
            while (visits.visits == null) {
              return const WhileValueEqualNullWidget();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 500,
                    child: Form(
                      key: fkey,
                      child: TextFormField(
                        validator: (val) {
                          if (val == null || val.length != 11) {
                            return 'Kindly Enter Correct Phone Number - 11-digits...'
                                .tr();
                          }
                          return null;
                        },
                        onChanged: (String value) {},
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        controller: searchController,
                        obscureText: false,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Search by Phone...'.tr(),
                          suffix: IconButton(
                            onPressed: () async {
                              if (fkey.currentState!.validate() == true) {
                                await visits.searchVisitsbyPhoneNumber(
                                    searchController.text);
                              }
                            },
                            icon: const Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: widget.organizer == true ? 260 : 175,
                    width: 550,
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CupertinoScrollbar(
                          controller: _scrollController,
                          thickness: 10,
                          isAlwaysShown: true,
                          child: ListView.builder(
                            controller: _scrollController,
                            itemCount: visits.visits!.length,
                            itemExtent: 60,
                            itemBuilder: (context, index) {
                              return Card(
                                color: Colors.grey[300],
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Text(
                                      '${index + 1}',
                                      textScaleFactor: 1,
                                    ),
                                  ),
                                  title: Text(visits.visits![index].ptName),
                                  subtitle: Text(visits.visits![index].phone),
                                  onTap: () {
                                    if (widget.organizer == false) {
                                      DateTime parseDates(String dateString) {
                                        return DateTime.parse(dateString);
                                      }

                                      widget.dateController!.text =
                                          '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';
                                      context
                                          .read<NewVisitProvider>()
                                          .setVisitDate(
                                              DateTime.now().toIso8601String());
                                      widget.nameController.text =
                                          visits.visits![index].ptName;
                                      context
                                          .read<NewVisitProvider>()
                                          .setPtName(
                                              visits.visits![index].ptName);
                                      widget.phoneController.text =
                                          visits.visits![index].phone;
                                      context.read<NewVisitProvider>().setPhone(
                                          visits.visits![index].phone);
                                      var dateofbith =
                                          parseDates(visits.visits![index].dob);
                                      widget.dobController!.text =
                                          '${dateofbith.day}-${dateofbith.month}-${dateofbith.year}';
                                      context
                                          .read<NewVisitProvider>()
                                          .setDob(visits.visits![index].dob);
                                      widget.tabController!.animateTo(
                                          (widget.tabController!.index + 1) %
                                              2);
                                    } else if (widget.organizer == true) {
                                      widget.nameController.text =
                                          visits.visits![index].ptName;
                                      widget.phoneController.text =
                                          visits.visits![index].phone;
                                      Navigator.pop(context);
                                    }
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

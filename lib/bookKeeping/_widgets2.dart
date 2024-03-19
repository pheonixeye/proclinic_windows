import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_windows/_const/_constWidgets.dart';
import 'package:proclinic_windows/_localization/_localization.dart';
import 'package:proclinic_windows/_models/visitModel.dart';
import 'package:proclinic_windows/_providers/bookKeepingProvider.dart';
import 'package:proclinic_windows/_providers/selectedDoctorProvider.dart';
import 'package:proclinic_windows/_providers/visitsControllerProvider.dart';
import 'package:proclinic_windows/widgets/divider.dart';
import 'package:proclinic_windows/widgets/item_text.dart';
import 'package:provider/provider.dart';

class KeepingResultsContainer extends StatefulWidget {
  const KeepingResultsContainer({Key? key}) : super(key: key);

  @override
  _KeepingResultsContainerState createState() =>
      _KeepingResultsContainerState();
}

class _KeepingResultsContainerState extends State<KeepingResultsContainer> {
  final _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    initVisits();
  }

  Future<void> initVisits() async {
    await context.read<VisitsSearchController>().initializeVisits();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VisitsSearchController>(
      builder: (context, visits, child) {
        while (visits.visits == null) {
          return const WhileValueEqualNullWidget();
        }
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: CupertinoScrollbar(
                controller: _scroll,
                thumbVisibility: true,
                thickness: 20,
                radius: const Radius.circular(5),
                child: ListView.separated(
                  controller: _scroll,
                  itemCount: visits.visits!.length,
                  itemBuilder: (context, index) {
                    return InfoTile(visit: visits.visits![index], index: index);
                  },
                  separatorBuilder: (context, index) {
                    return const SeparatorLine();
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: FloatingActionButton(
                  heroTag: 'showinfo',
                  onPressed: () async {
                    await showDialog(
                        context: context,
                        builder: (context) {
                          return const BookKeepingDetailsDialog();
                        });
                  },
                  child: const Icon(Icons.details),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class InfoTile extends StatelessWidget {
  const InfoTile({Key? key, required this.visit, required this.index})
      : super(key: key);
  final Visit visit;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CircleAvatar(
                  child: Text('${index + 1}'),
                ),
              ),
              ItemText(
                title: "Name".tr(),
                data: visit.ptName.toUpperCase(),
                iconData: Icons.person,
              ),
              ItemText(
                title: "Phone".tr(),
                data: visit.phone,
                iconData: Icons.phone,
              ),
              Builder(
                builder: (context) {
                  final doc = english(context)
                      ? visit.docNameEN.toUpperCase()
                      : visit.docNameAR.toUpperCase();
                  return ItemText(
                    title: 'Dr.'.tr(),
                    data: doc,
                    iconData: Icons.person,
                  );
                },
              ),
              Builder(
                builder: (context) {
                  final d = DateTime.parse(visit.visitDate);
                  return ItemText(
                    title: 'Visit Date'.tr(),
                    data: '${d.day}-${d.month}-${d.year}',
                    iconData: Icons.calendar_today,
                  );
                },
              ),
              ItemText(
                title: "Visit Type".tr(),
                data: visit.visitType.tr().toUpperCase(),
                iconData: Icons.vaccines_sharp,
              ),
              visit.visitType != SxVisit.PROCEDURE_E
                  ? const SizedBox()
                  : Builder(
                      builder: (context) {
                        final p = english(context)
                            ? visit.procedureEN?.toUpperCase()
                            : visit.procedureAR?.toUpperCase();
                        return ItemText(
                          title: 'Procedure'.tr(),
                          data: p ?? "No Procedure".tr(),
                          iconData: Icons.calendar_today,
                        );
                      },
                    ),
              Builder(
                builder: (context) {
                  final aff = english(context)
                      ? visit.affiliationEN.toUpperCase()
                      : visit.affiliationAR.toUpperCase();
                  return ItemText(
                    title: 'Affiliation'.tr(),
                    data: aff,
                    iconData: Icons.replay_circle_filled_rounded,
                  );
                },
              ),
              ItemText(
                title: "Paid".tr(),
                data: visit.amount.toString() + "L.E.".tr(),
                iconData: Icons.attach_money,
              ),
              ItemText(
                title: "Remaining".tr(),
                data: visit.remaining.toString() + "L.E.".tr(),
                iconData: Icons.money_off,
              ),
              ItemText(
                title: "Payment Type".tr(),
                data: visit.cashType,
                iconData: Icons.local_atm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookKeepingDetailsDialog extends StatelessWidget {
  const BookKeepingDetailsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: cardbuttonstyle,
      contentPadding: EdgeInsets.zero,
      content: Consumer<VisitsSearchController>(
        builder: (context, visits, child) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.9,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Column(
              children: [
                DetailsTitle(),
                SearchParams(),
                Expanded(child: KeepingAnalysis()),
              ],
            ),
          );
        },
      ),
    );
  }
}

class DetailsTitle extends StatelessWidget {
  const DetailsTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const IconButton(
            onPressed: null,
            icon: Icon(
              Icons.ac_unit,
              color: Colors.transparent,
            ),
          ),
          const Spacer(),
          Card(
            elevation: 20,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'BookKeeping Details...'.tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close,
            ),
          ),
        ],
      ),
    );
  }
}

class SearchParams extends StatelessWidget {
  const SearchParams({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<BookKeepingProvider>(
        builder: (context, k, child) {
          _builditem1() {
            switch (k.allOrOne) {
              case 0:
                return 'All Clinics'.tr();
              case 1:
                return 'One Clinic'.tr();
              default:
                return 'UnSelected !!!'.tr();
            }
          }

          _builditem2() {
            switch (k.dayDuration) {
              case 0:
                return 'Day by day'.tr();
              case 1:
                return 'Monthly'.tr();
              default:
                return 'UnSelected !!!'.tr();
            }
          }

          return Card(
            elevation: 20,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'All / Single Clinic'.tr(),
                    textAlign: TextAlign.center,
                  ),
                  Card(
                    elevation: 20,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _builditem1(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Text(
                    'Day / Duration'.tr(),
                    textAlign: TextAlign.center,
                  ),
                  Card(
                    elevation: 20,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _builditem2(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  k.allOrOne == 0
                      ? const SizedBox()
                      : Text(
                          'Selected Clinic'.tr(),
                          textAlign: TextAlign.center,
                        ),
                  k.allOrOne == 0
                      ? const SizedBox()
                      : Consumer<SelectedDoctor>(
                          builder: (context, d, child) {
                            return Card(
                              elevation: 20,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  d.doctor == null
                                      ? 'UnSelected !!!'.tr()
                                      : english(context)
                                          ? d.doctor!.docnameEN
                                          : d.doctor!.docnameAR,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          },
                        ),
                  Text(
                    'Picked Year'.tr(),
                    textAlign: TextAlign.center,
                  ),
                  Card(
                    elevation: 20,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${k.year}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Text(
                    'Picked Month'.tr(),
                    textAlign: TextAlign.center,
                  ),
                  Card(
                    elevation: 20,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${k.month}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  k.dayDuration == 1
                      ? const SizedBox()
                      : Text(
                          'Picked Day'.tr(),
                          textAlign: TextAlign.center,
                        ),
                  k.dayDuration == 1
                      ? const SizedBox()
                      : Card(
                          elevation: 20,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${k.day}',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class KeepingAnalysis extends StatelessWidget {
  const KeepingAnalysis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<VisitsSearchController>(
      builder: (context, v, child) {
        while (v.visits == null) {
          return const WhileValueEqualNullWidget();
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 20,
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Total Visit Count'.tr(),
                      textAlign: TextAlign.center,
                    ),
                    Card(
                      elevation: 20,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${v.visits!.length}',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 3,
                  thickness: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Number Of Consultations'.tr(),
                      textAlign: TextAlign.center,
                    ),
                    Card(
                      elevation: 20,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Builder(
                          builder: (context) {
                            List<Visit> cons = [];
                            v.visits!.map((e) {
                              if (e.visitType == 'Consultation') {
                                cons.add(e);
                              }
                            }).toList();
                            return Text(
                              '${cons.length}',
                              textAlign: TextAlign.center,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 3,
                  thickness: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Number Of Follow ups'.tr(),
                      textAlign: TextAlign.center,
                    ),
                    Card(
                      elevation: 20,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Builder(
                          builder: (context) {
                            List<Visit> cons = [];
                            v.visits!.map((e) {
                              if (e.visitType == 'Follow Up') {
                                cons.add(e);
                              }
                            }).toList();
                            return Text(
                              '${cons.length}',
                              textAlign: TextAlign.center,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 3,
                  thickness: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Number Of Procedures'.tr(),
                      textAlign: TextAlign.center,
                    ),
                    Card(
                      elevation: 20,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Builder(
                          builder: (context) {
                            List<Visit> cons = [];
                            v.visits!.map((e) {
                              if (e.visitType == 'Procedure') {
                                cons.add(e);
                              }
                            }).toList();
                            return Text(
                              '${cons.length}',
                              textAlign: TextAlign.center,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 3,
                  thickness: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Procedure Analysis'.tr(),
                      textAlign: TextAlign.center,
                    ),
                    Card(
                      elevation: 20,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Builder(
                          builder: (context) {
                            List<String> procs = [];
                            Map<String, int> a = {};
                            v.visits!.map((e) {
                              if (e.procedureEN != null) {
                                procs.add(e.procedureEN!);
                              }
                            }).toList();
                            var procset = procs.toSet();
                            procset.map((e) {
                              a.addEntries([MapEntry(e, 0)]);
                              for (String element in procs) {
                                if (e == element) {
                                  a[e] = a[e]! + 1;
                                }
                              }
                            }).toSet();

                            return Column(
                              children: a.entries.map(
                                (e) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${e.key.toUpperCase()} : ${e.value}',
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                },
                              ).toList(),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 3,
                  thickness: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Total Incomne'.tr(),
                      textAlign: TextAlign.center,
                    ),
                    Card(
                      elevation: 20,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Builder(
                          builder: (context) {
                            List<int> incomne = [];
                            v.visits!.map((e) {
                              incomne.add(e.amount);
                            }).toList();
                            int total = incomne.fold<int>(0, (a, b) => a + b);
                            return Text(
                              '$total ${'L.E.'.tr()}',
                              textAlign: TextAlign.center,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 3,
                  thickness: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Total Remaining'.tr(),
                      textAlign: TextAlign.center,
                    ),
                    Card(
                      elevation: 20,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Builder(
                          builder: (context) {
                            List<int> remain = [];
                            v.visits!.map((e) {
                              remain.add(e.remaining);
                            }).toList();
                            int total = remain.fold<int>(0, (a, b) => a + b);
                            return Text(
                              '$total ${'L.E.'.tr()}',
                              textAlign: TextAlign.center,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 3,
                  thickness: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Affiliaton Analysis'.tr(),
                      textAlign: TextAlign.center,
                    ),
                    Card(
                      elevation: 20,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Builder(
                          builder: (context) {
                            List<String> affiliations = [];
                            Map<String, int> a = {};
                            v.visits!.map((e) {
                              affiliations.add(e.affiliationEN);
                            }).toList();
                            var affset = affiliations.toSet();
                            affset.map((e) {
                              a.addEntries([MapEntry(e, 0)]);
                              for (String element in affiliations) {
                                if (e == element) {
                                  a[e] = a[e]! + 1;
                                }
                              }
                            }).toSet();

                            return Column(
                              children: a.entries.map(
                                (e) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${e.key.toUpperCase()} : ${e.value}',
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                },
                              ).toList(),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

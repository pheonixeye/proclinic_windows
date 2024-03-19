// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:proclinic_windows/EntryPage/Update_Data_Page/update_data_page.dart';
import 'package:proclinic_windows/_const/_constWidgets.dart';
import 'package:proclinic_windows/_localization/_localization.dart';
import 'package:proclinic_windows/_models/visitModel.dart';
import 'package:proclinic_windows/_mongoRequests/_visit_req.dart';
import 'package:proclinic_windows/_providers/new_visit_provider.dart';
import 'package:proclinic_windows/_providers/visitsControllerProvider.dart';
import 'package:proclinic_windows/printReciept/reciept_page_UI.dart';
import 'package:proclinic_windows/widgets/item_text.dart';
import 'package:proclinic_windows/widgets/qr_dialog.dart';
import 'package:provider/src/provider.dart';

class LocalDBInfoCard extends StatelessWidget {
  const LocalDBInfoCard({
    Key? key,
    required this.visit,
    required this.index,
  }) : super(key: key);
  final Visit visit;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          title: Card(
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                runAlignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
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
                      final d = DateTime.parse(visit.dob);
                      return ItemText(
                        title: 'Date of Birth'.tr(),
                        data: '${d.day}-${d.month}-${d.year}',
                        iconData: Icons.calendar_month,
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
                      final clinic = english(context)
                          ? visit.clinicEN.toUpperCase()
                          : visit.clinicAR.toUpperCase();
                      return ItemText(
                        title: 'Clinic'.tr(),
                        data: clinic,
                        iconData: Icons.local_hospital,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              children: [
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
          onTap: () async {
            await showDialog(
              context: context,
              builder: (context) => QrDialog(
                code: QrCode.fromData(
                  data: visit.id.oid,
                  errorCorrectLevel: QrErrorCorrectLevel.H,
                ),
              ),
            );
          },
          trailing: PopUpMenuButtonForActions(
            visit: visit,
          ),
          selected: false,
        ),
      ),
    );
  }
}

class PopUpMenuButtonForActions extends StatefulWidget {
  const PopUpMenuButtonForActions({Key? key, required this.visit})
      : super(key: key);
  final Visit visit;

  @override
  _PopUpMenuButtonForActionsState createState() =>
      _PopUpMenuButtonForActionsState();
}

class _PopUpMenuButtonForActionsState extends State<PopUpMenuButtonForActions> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 10,
      onSelected: (String value) async {
        switch (value) {
          case 'update':
            print('update');
            context.read<NewVisitProvider>().setVisitFromVisit(widget.visit);
            context.read<NewVisitProvider>().visit.toString();
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UpdateVisitInfoPage(
                  visit: widget.visit,
                ),
              ),
            );
            break;
          case 'print':
            print('print');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecieptPage(
                  visit: widget.visit,
                ),
              ),
            );
            break;
          case 'delete':
            print('delete');
            showDialog(
                context: context,
                builder: (context) {
                  return DeleteEntryDialog(
                    visit: widget.visit,
                  );
                });
            break;
        }
      },
      icon: const CircleAvatar(
        child: Icon(
          Icons.menu_open,
        ),
      ),
      tooltip: 'Options - خصائص',
      itemBuilder: (context) {
        return <PopupMenuItem<String>>[
          PopupMenuItem(
            value: 'update',
            child: Tooltip(
              message: 'تعديل',
              child: Row(
                children: [
                  const Icon(
                    Icons.edit,
                    color: Colors.green,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text('Update Entry'.tr()),
                ],
              ),
            ),
          ),
          PopupMenuItem(
            value: 'print',
            child: Tooltip(
              message: 'طباعة ايصال',
              child: Row(
                children: [
                  const Icon(
                    Icons.print,
                    color: Colors.blue,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text('Print Reciept'.tr()),
                ],
              ),
            ),
          ),
          PopupMenuItem(
            value: 'delete',
            child: Tooltip(
              message: 'حذف',
              child: Row(
                children: [
                  const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text('Delete Entry'.tr()),
                ],
              ),
            ),
          ),
        ];
      },
    );
  }
}

class DeleteEntryDialog extends StatefulWidget {
  const DeleteEntryDialog({Key? key, required this.visit}) : super(key: key);
  final Visit visit;

  @override
  _DeleteEntryDialogState createState() => _DeleteEntryDialogState();
}

class _DeleteEntryDialogState extends State<DeleteEntryDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text('Delete Entry ??'.tr()),
      content: SingleChildScrollView(
        child: Text(
            'Deleting this entry makes this data no longer available. \n Are You Sure ?'
                .tr()),
      ),
      actions: [
        ElevatedButton.icon(
          icon: const Icon(
            Icons.check,
            color: Colors.green,
          ),
          label: Text('Confirm'.tr()),
          onPressed: () async {
            EmbeddEasyLoading(() async {
              await VisitRequests.deleteOneVisit(widget.visit);
            });
            await context.read<VisitsSearchController>().initializeVisits();
            Navigator.pop(context);
          },
        ),
        ElevatedButton.icon(
          icon: const Icon(
            Icons.cancel,
            color: Colors.red,
          ),
          label: Text('Cancel'.tr()),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

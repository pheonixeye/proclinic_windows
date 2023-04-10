// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'dart:math';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_windows/EntryPage/Update_Data_Page/update_data_page.dart';
import 'package:proclinic_windows/PatientProfile/Patient_Profile_Page.dart';
import 'package:proclinic_windows/_const/_constWidgets.dart';
import 'package:proclinic_windows/_localization/_localization.dart';
import 'package:proclinic_windows/_models/visitModel.dart';
import 'package:proclinic_windows/_mongoRequests/_visit_req.dart';
import 'package:proclinic_windows/_providers/new_visit_provider.dart';
import 'package:proclinic_windows/_providers/visitsControllerProvider.dart';
import 'package:proclinic_windows/printReciept/reciept_page_UI.dart';
import 'package:provider/src/provider.dart';

class LocalDBInfoCard extends StatefulWidget {
  const LocalDBInfoCard({
    Key? key,
    required this.visit,
    required this.index,
  }) : super(key: key);
  final Visit visit;
  final int index;

  @override
  _LocalDBInfoCardState createState() => _LocalDBInfoCardState();
}

class _LocalDBInfoCardState extends State<LocalDBInfoCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.blueGrey[300],
      child: ListTile(
        isThreeLine: true,
        leading: CircleAvatar(
          backgroundColor:
              Colors.primaries[Random().nextInt(Colors.primaries.length)],
          child: Text('${widget.index + 1}'),
        ),
        title: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Colors.grey.shade300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(widget.visit.ptName.toUpperCase()),
                ),
                margin: const EdgeInsets.all(10),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(widget.visit.phone.toUpperCase()),
                ),
                margin: const EdgeInsets.all(10),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '${'Date of Birth'.tr()}  ${widget.visit.dob.substring(0, 10)}',
                  ),
                ),
                margin: const EdgeInsets.all(10),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                      '${'Visit Date'.tr()}  ${widget.visit.visitDate.substring(0, 10)}'),
                ),
                margin: const EdgeInsets.all(10),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                      '${'Affiliation'.tr()}  ${english(context) ? widget.visit.affiliationEN.toUpperCase() : widget.visit.affiliationAR.toUpperCase()}'),
                ),
                margin: const EdgeInsets.all(10),
              ),
            ],
          ),
        ),
        subtitle: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Colors.grey.shade300,
          child: Wrap(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('${'Doc-ID'.tr()}  ${widget.visit.docid}'),
                ),
                margin: const EdgeInsets.all(10),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                      '${'Dr.'.tr()}  ${english(context) ? widget.visit.docNameEN.toUpperCase() : widget.visit.docNameAR.toUpperCase()}'),
                ),
                margin: const EdgeInsets.all(10),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(english(context)
                      ? widget.visit.clinicEN.toUpperCase()
                      : widget.visit.clinicAR.toUpperCase()),
                ),
                margin: const EdgeInsets.all(10),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(widget.visit.visitType.tr().toUpperCase()),
                ),
                margin: const EdgeInsets.all(10),
              ),
              widget.visit.visitType != SxVisit.PROCEDURE_E
                  ? const SizedBox()
                  : Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(english(context)
                            ? widget.visit.procedureEN!
                            : widget.visit.procedureAR!),
                      ),
                      margin: const EdgeInsets.all(10),
                    ),
              Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('Amount'.tr() +
                        '  ${widget.visit.amount}' +
                        "  " +
                        'L.E.'.tr()),
                  ),
                  margin: const EdgeInsets.all(10)),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Remaining'.tr() +
                      '  ${widget.visit.remaining}' +
                      "  " +
                      'L.E.'.tr()),
                ),
                margin: const EdgeInsets.all(10),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                      '${'Payment Type'.tr()}  ${widget.visit.cashType.tr()}'),
                ),
                margin: const EdgeInsets.all(10),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PatientProfilePage(
                visit: widget.visit,
              ),
            ),
          );
        },
        trailing: PopUpMenuButtonForActions(
          visit: widget.visit,
        ),
        selected: false,
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
          style: ElevatedButton.styleFrom(
            shape: cardbuttonstyle,
          ),
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
          style: ElevatedButton.styleFrom(
            shape: cardbuttonstyle,
          ),
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

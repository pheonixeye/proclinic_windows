import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_windows/PatientProfile/SRLCP_page.dart';
import 'package:proclinic_windows/PatientProfile/_widgets.dart';
import 'package:proclinic_windows/PatientProfile/visits_page.dart';
import 'package:proclinic_windows/_const/_strings.dart';
import 'package:proclinic_windows/_localization/_localization.dart';
import 'package:proclinic_windows/_models/visitModel.dart';
import 'package:proclinic_windows/_providers/visitsControllerProvider.dart';
import 'package:provider/src/provider.dart';

class PatientProfilePage extends StatefulWidget {
  final Visit visit;
  const PatientProfilePage({Key? key, required this.visit}) : super(key: key);
  @override
  _PatientProfilePageState createState() => _PatientProfilePageState();
}

class _PatientProfilePageState extends State<PatientProfilePage> {
  @override
  void initState() {
    _initializePtVisits();
    super.initState();
  }

  _initializePtVisits() async {
    await context
        .read<VisitsSearchController>()
        .searchVisitsByPatientPhone(widget.visit.phone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.visit.ptName.toUpperCase()),
        centerTitle: true,
        leading: IconButton(
          icon: english(context)
              ? const Icon(Icons.arrow_back_ios_new)
              : const Icon(Icons.arrow_back),
          onPressed: () {
            context.read<VisitsSearchController>().initializeVisits();
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                offset: Offset(3, 3),
                blurRadius: 3.0,
                spreadRadius: 3.0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ButtonType1(
                        route: const VisitsPage(),
                        icondata: Icons.view_list,
                        title: 'Visits'.tr()),
                    const SizedBox(
                      height: 40,
                      width: 40,
                    ),
                    ButtonType2(
                        route: const SRLCP(
                          scrlp: SHEETS,
                        ),
                        icondata: Icons.poll,
                        title: 'Sheets'.tr()),
                    const SizedBox(
                      height: 40,
                      width: 40,
                    ),
                    ButtonType1(
                        route: const SRLCP(
                          scrlp: LABS,
                        ),
                        icondata: Icons.library_books,
                        title: 'Labs'.tr()),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ButtonType2(
                        route: const SRLCP(
                          scrlp: RADS,
                        ),
                        icondata: Icons.radio,
                        title: 'Rads'.tr()),
                    const SizedBox(
                      height: 40,
                      width: 40,
                    ),
                    ButtonType1(
                        route: const SRLCP(
                          scrlp: PRESCRIPTIONS,
                        ),
                        icondata: Icons.comment_bank,
                        title: 'Prescriptions'.tr()),
                    const SizedBox(
                      height: 40,
                      width: 40,
                    ),
                    ButtonType2(
                        route: const SRLCP(
                          scrlp: COMMENTS,
                        ),
                        icondata: Icons.comment,
                        title: 'Comments'.tr()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

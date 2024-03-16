// ignore_for_file: file_names

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_windows/_const/_constWidgets.dart';
import 'package:proclinic_windows/_localization/_localization.dart';
import 'package:proclinic_windows/_providers/visitsControllerProvider.dart';
import 'package:proclinic_windows/localdb_search_pts/_widgets.dart';
import 'package:proclinic_windows/localdb_search_pts/_widgets2.dart';
import 'package:provider/provider.dart';
// import 'package:provider/src/provider.dart';

class CollectivePatientDataUI extends StatefulWidget {
  const CollectivePatientDataUI({Key? key}) : super(key: key);

  @override
  _CollectivePatientDataUIState createState() =>
      _CollectivePatientDataUIState();
}

class _CollectivePatientDataUIState extends State<CollectivePatientDataUI> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    initVisits();
    super.initState();
  }

  Future initVisits() async {
    await context.read<VisitsSearchController>().initializeVisits();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VisitsSearchController>(
      builder: (context, visits, child) {
        while (visits.visits == null) {
          return const WhileValueEqualNullWidget();
        }
        return Scaffold(
          endDrawer: SearchEndDrawer(
            formKey: GlobalKey<FormState>(),
          ),
          appBar: AppBar(
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Patient Database'.tr(),
                textScaler: const TextScaler.linear(2.0),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            leading: IconButton(
              icon: english(context)
                  ? const Icon(Icons.arrow_back_ios_new)
                  : const Icon(
                      Icons.arrow_back,
                    ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue[150],
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(4.0, 4.0),
                      blurRadius: 4.0,
                    ),
                  ],
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.blue,
                        offset: Offset(4.0, 4.0),
                        blurRadius: 4.0,
                      ),
                    ],
                  ),
                  child: Builder(
                    builder: (context) {
                      return CupertinoScrollbar(
                        radius: const Radius.circular(5),
                        controller: _scrollController,
                        thumbVisibility: true,
                        thickness: 20,
                        child: ListView.separated(
                          controller: _scrollController,
                          itemCount: visits.visits!.length,
                          itemBuilder: (context, index) {
                            return LocalDBInfoCard(
                              visit: visits.visits![index],
                              index: index,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(
                              color: Colors.blueGrey,
                              height: 5,
                              thickness: 5,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

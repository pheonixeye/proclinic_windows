// ignore_for_file: file_names

import 'dart:math';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_windows/EntryPage/_widgets/doctors_dropdownmenubutton.dart';
import 'package:proclinic_windows/_providers/bookKeepingProvider.dart';
import 'package:proclinic_windows/_providers/selectedDoctorProvider.dart';
import 'package:proclinic_windows/_providers/visitsControllerProvider.dart';
import 'package:proclinic_windows/bookKeeping/_widgets2.dart';
import 'package:proclinic_windows/_const/_constWidgets.dart';
import 'package:proclinic_windows/bookKeeping/_widgets.dart';
import 'package:proclinic_windows/bookKeeping/date_cupertino_selectors.dart';
import 'package:provider/provider.dart';

class BookKeeping extends StatefulWidget {
  const BookKeeping({Key? key}) : super(key: key);

  @override
  _BookKeepingState createState() => _BookKeepingState();
}

class _BookKeepingState extends State<BookKeeping> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'BookKeeping & Financing'.tr(),
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white54.withOpacity(0.8),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color:
                    Colors.primaries[Random().nextInt(Colors.primaries.length)],
                offset: const Offset(5, 5),
                blurRadius: 5,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
              elevation: 20,
              shape: cardbuttonstyle,
              shadowColor:
                  Colors.primaries[Random().nextInt(Colors.primaries.length)],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white54.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.primaries[
                                Random().nextInt(Colors.primaries.length)],
                            offset: const Offset(5, 5),
                            blurRadius: 5,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          //one or all doctors
                          const SizedBox(
                            width: 10,
                          ),
                          const Expanded(
                            flex: 1,
                            child: AllOrOneClinicDropDown(),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Expanded(
                            flex: 1,
                            child: DayDurationDropDown(),
                          ),
                          // doctors dropdown
                          const SizedBox(
                            width: 10,
                          ),
                          Consumer<BookKeepingProvider>(
                            builder: (context, book, child) {
                              switch (book.allOrOne) {
                                case 0:
                                  return const SizedBox();
                                case 1:
                                  return const Expanded(
                                    flex: 3,
                                    child: NewlyFormatedDoctorsDropDownButton(),
                                  );
                                default:
                                  return const SizedBox();
                              }
                            },
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Expanded(flex: 1, child: YearClinicPicker()),
                          const SizedBox(
                            width: 10,
                          ),
                          const Expanded(flex: 2, child: MonthClinicPicker()),
                          const SizedBox(
                            width: 10,
                          ),
                          Consumer<BookKeepingProvider>(
                              builder: (context, book, child) {
                            switch (book.dayDuration) {
                              case 0:
                                return const Expanded(
                                  flex: 1,
                                  child: DayClinicPicker(),
                                );
                              case 1:
                                return const SizedBox();
                              default:
                                return const SizedBox();
                            }
                          }),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                primary: Theme.of(context).primaryColor,
                              ),
                              label: Text('Search'.tr()),
                              icon: const Icon(Icons.search),
                              onPressed: () async {
                                final src = context.read<BookKeepingProvider>();
                                if (src.allOrOne == null ||
                                    src.dayDuration == null) {
                                  await EasyLoading.showError(
                                      'Invalid Search Parameters...'.tr());
                                } else {
                                  await EmbeddEasyLoading(
                                    () async {
                                      await context
                                          .read<VisitsSearchController>()
                                          .parametrizedRequest(
                                              allOrOne: src.allOrOne!,
                                              dayDuration: src.dayDuration!,
                                              day: src.day,
                                              month: src.month,
                                              year: src.year,
                                              doctor: context
                                                  .read<SelectedDoctor>()
                                                  .doctor);
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //results
                  const Expanded(
                    flex: 9,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: KeepingResultsContainer(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

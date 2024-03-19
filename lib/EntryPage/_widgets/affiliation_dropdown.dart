import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_windows/_localization/_localization.dart';
import 'package:proclinic_windows/_providers/new_visit_provider.dart';
import 'package:proclinic_windows/_providers/selectedDoctorProvider.dart';
import 'package:provider/provider.dart';

class AffiliationDropdown extends StatefulWidget {
  const AffiliationDropdown({Key? key}) : super(key: key);

  @override
  AffiliationDropdownState createState() => AffiliationDropdownState();
}

class AffiliationDropdownState extends State<AffiliationDropdown> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SelectedDoctor>(
      builder: (context, d, _) {
        while (d.doctor == null) {
          return const SizedBox();
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 150.0,
              child: Tooltip(
                message: 'اختر الجهة',
                child: Text('Select Affiliation'.tr()),
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            SizedBox(
              width: 350,
              height: 50.0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Card(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      icon: const Icon(Icons.arrow_drop_down_circle),
                      isExpanded: true,
                      items: d.doctor!.affiliatesEN.map((e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          alignment: Alignment.center,
                          child: Text(english(context)
                              ? e
                              : d.doctor!.affiliatesAR.elementAt(
                                  d.doctor!.affiliatesEN.indexOf(e))),
                        );
                      }).toList(),
                      value: context.watch<NewVisitProvider>().affiliationEN,
                      onChanged: (val) {
                        if (val != null) {
                          context
                              .read<NewVisitProvider>()
                              .setAffiliationEN(val);
                          context.read<NewVisitProvider>().setAffiliationAR(
                              d.doctor!.affiliatesAR[
                                  d.doctor!.affiliatesEN.indexOf(val)]);
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proclinic_windows/EntryPage/_widgets/doctors_dropdownmenubutton.dart';
import 'package:proclinic_windows/_const/_constWidgets.dart';
import 'package:proclinic_windows/_providers/searchValueProvider.dart';
import 'package:proclinic_windows/_providers/selectedDoctorProvider.dart';
import 'package:proclinic_windows/_providers/visitsControllerProvider.dart';
import 'package:provider/provider.dart';

class SearchEndDrawer extends StatelessWidget {
  const SearchEndDrawer({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const TitleOfSearch(),
              const SizedBox(
                height: 20,
              ),
              const SearchFilterIcons(),
              const SizedBox(
                height: 20,
              ),
              SearchFilterOptions(
                formKey: formKey,
              ),
              const SizedBox(
                height: 20,
              ),
              const Spacer(),
              SearchButton(
                formKey: formKey,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchButton extends StatelessWidget {
  const SearchButton({Key? key, required this.formKey}) : super(key: key);
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchValueProvider>(
      builder: (context, search, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    switch (search.groupValue) {
                      case 0:
                        EmbeddEasyLoading(() async {
                          await context
                              .read<VisitsSearchController>()
                              .initializeVisits();
                        });
                        break;
                      case 1:
                        if (formKey.currentState!.validate()) {
                          EmbeddEasyLoading(() async {
                            await context
                                .read<VisitsSearchController>()
                                .searchVisitsbyPhoneNumber(search.phone!);
                          });
                        }

                        break;
                      case 2:
                        EmbeddEasyLoading(() async {
                          await context
                              .read<VisitsSearchController>()
                              .searchVisitsbyDate(search.month, search.year);
                        });
                        break;
                      case 3:
                        EmbeddEasyLoading(() async {
                          await context
                              .read<VisitsSearchController>()
                              .searchVisitsbyDoctorId(
                                  context.read<SelectedDoctor>().doctor!.id);
                        });
                        break;
                    }
                    Navigator.pop(context);
                  },
                  label: const Text('Search'),
                  icon: const Icon(Icons.search),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SearchFilterOptions extends StatefulWidget {
  const SearchFilterOptions({Key? key, required this.formKey})
      : super(key: key);
  final GlobalKey<FormState> formKey;

  @override
  _SearchFilterOptionsState createState() => _SearchFilterOptionsState();
}

class _SearchFilterOptionsState extends State<SearchFilterOptions> {
  late final TextEditingController _searchController;
  final List<int> years = List.generate(5, (i) => (DateTime.now().year - i));
  final Map<int, String> months = {
    1: 'January'.tr(),
    2: 'February'.tr(),
    3: 'March'.tr(),
    4: 'April'.tr(),
    5: 'May'.tr(),
    6: 'June'.tr(),
    7: 'July'.tr(),
    8: 'August'.tr(),
    9: 'September'.tr(),
    10: 'October'.tr(),
    11: 'November'.tr(),
    12: 'December'.tr()
  };
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchValueProvider>(
      builder: (context, valProv, child) {
        switch (valProv.groupValue) {
          case 0:
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Select Search Parameter...'.tr(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            );
          case 1:
            return Form(
              key: widget.formKey,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Tooltip(
                    message: 'بحث برقم الموبايل',
                    child: Card(
                      elevation: 20,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (val) {
                            if (val!.length != 11) {
                              return 'Kindly Enter Correct Phone Number - 11-digits...'
                                  .tr();
                            }
                            return null;
                          },
                          onChanged: (String value) {
                            context
                                .read<SearchValueProvider>()
                                .adjustPhone(_searchController.text);
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          controller: _searchController,
                          enableInteractiveSelection: true,
                          enabled: true,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            isDense: true,
                            icon: const Icon(Icons.search),
                            hintText: '...',
                            labelText: 'Search by Phone...'.tr(),
                            alignLabelWithHint: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          case 2:
            return Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //month picker
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<int>(
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_drop_down_circle),
                          hint: Text('Select Month...'.tr()),
                          items: months.entries.map((e) {
                            return DropdownMenuItem<int>(
                              alignment: Alignment.center,
                              value: e.key,
                              child: Text(e.value),
                            );
                          }).toList(),
                          value: context.watch<SearchValueProvider>().month,
                          onChanged: (val) {
                            context
                                .read<SearchValueProvider>()
                                .adjustMonth(val!);
                          },
                        ),
                      ),
                    ),
                  ),
                  //year picker
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<int>(
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_drop_down_circle),
                          hint: Text('Select Year...'.tr()),
                          items: years.map((e) {
                            return DropdownMenuItem<int>(
                              alignment: Alignment.center,
                              value: e,
                              child: Text(e.toString()),
                            );
                          }).toList(),
                          value: context.watch<SearchValueProvider>().year,
                          onChanged: (val) {
                            context
                                .read<SearchValueProvider>()
                                .adjustYear(val!);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          case 3:
            return const Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: NewlyFormatedDoctorsDropDownButton(),
                  ),
                ),
              ],
            );
        }
        return const SizedBox();
      },
    );
  }
}

class SearchFilterIcons extends StatefulWidget {
  const SearchFilterIcons({Key? key}) : super(key: key);

  @override
  _SearchFilterIconsState createState() => _SearchFilterIconsState();
}

class _SearchFilterIconsState extends State<SearchFilterIcons> {
  // int? groupValue;
  final duration = const Duration(milliseconds: 200);
  final double padding = 16.0;

  @override
  Widget build(BuildContext context) {
    final valProv = context.read<SearchValueProvider>();
    return Wrap(
      children: [
        Padding(
          padding: EdgeInsets.all(padding),
          child: AnimatedContainer(
            duration: duration,
            child: Card(
              child: RadioListTile<int>(
                title: Text('By Phone Number...'.tr()),
                value: 1,
                groupValue: valProv.groupValue,
                onChanged: (val) {
                  setState(() {
                    valProv.adjust(val!);
                  });
                },
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(padding),
          child: AnimatedContainer(
            duration: duration,
            child: Card(
              child: RadioListTile<int>(
                title: Text('By Date...'.tr()),
                value: 2,
                groupValue: valProv.groupValue,
                onChanged: (val) {
                  setState(() {
                    valProv.adjust(val!);
                  });
                },
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(padding),
          child: AnimatedContainer(
            duration: duration,
            child: Card(
              child: RadioListTile<int>(
                title: Text('By Clinic...'.tr()),
                value: 3,
                groupValue: valProv.groupValue,
                onChanged: (val) {
                  setState(() {
                    valProv.adjust(val!);
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TitleOfSearch extends StatelessWidget {
  const TitleOfSearch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const IconButton(
          onPressed: null,
          icon: Icon(
            Icons.close,
            color: Colors.transparent,
          ),
        ),
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Search Parameters'.tr(),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.pop(context);
            context.read<SearchValueProvider>().adjust(0);
          },
          icon: const Icon(
            Icons.close,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}

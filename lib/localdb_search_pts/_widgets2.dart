import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proclinic_windows/EntryPage/_widgets/doctors_dropdownmenubutton.dart';
import 'package:proclinic_windows/_const/_constWidgets.dart';
import 'package:proclinic_windows/_const/_strings.dart';
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
      elevation: 20,
      shape: cardbuttonstyle,
      color: Colors.blue.shade300,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(20),
            boxShadow: <BoxShadow>[
              BoxShadow(
                offset: const Offset(3, 3),
                blurRadius: 3,
                spreadRadius: 3,
                color: Colors.orange.shade200,
              ),
            ],
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
                  style: ElevatedButton.styleFrom(
                    shape: cardbuttonstyle,
                  ),
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
                              .searchVisitsbyDoctorName(
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
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchValueProvider>(
      builder: (context, valProv, child) {
        switch (valProv.groupValue) {
          case 0:
            return Card(
              elevation: 20,
              shape: cardbuttonstyle,
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
                    color: Colors.white,
                  ),
                  child: Tooltip(
                    message: 'بحث برقم الموبايل',
                    child: Card(
                      elevation: 20,
                      shape: cardbuttonstyle,
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
              elevation: 20,
              shape: cardbuttonstyle,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //month picker
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Select Month...'.tr(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CupertinoPicker(
                            backgroundColor: Colors.blue.shade200,
                            useMagnifier: true,
                            magnification: 1.5,
                            itemExtent: 40,
                            onSelectedItemChanged: (item) {
                              context
                                  .read<SearchValueProvider>()
                                  .adjustMonth(item);
                            },
                            children: MONTHS.map((e) {
                              return Text(
                                e.toString(),
                                textAlign: TextAlign.center,
                              );
                            }).toList(),
                          ),
                        ),
                        CircleAvatar(
                          child: Text(
                              '${context.read<SearchValueProvider>().month}'),
                        ),
                      ],
                    ),
                  ),
                  //year picker
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Select Year...'.tr(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CupertinoPicker(
                            backgroundColor: Colors.orange.shade200,
                            useMagnifier: true,
                            magnification: 1.5,
                            itemExtent: 40,
                            onSelectedItemChanged: (item) {
                              context
                                  .read<SearchValueProvider>()
                                  .adjustYear(item);
                            },
                            children: YEARS.map((e) {
                              return Text(
                                e.toString(),
                                textAlign: TextAlign.center,
                              );
                            }).toList(),
                          ),
                        ),
                        CircleAvatar(
                          child: Text(
                              '${context.read<SearchValueProvider>().year}'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          case 3:
            return Row(
              children: const [
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
  var activeColor = Colors.blue;
  final pressedDecoration = BoxDecoration(
    color: Colors.orange,
    borderRadius: BorderRadius.circular(20),
    boxShadow: const <BoxShadow>[
      BoxShadow(
        offset: Offset(0, 0),
        blurRadius: 0,
        spreadRadius: 0,
      ),
    ],
  );
  final unpressedDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: const <BoxShadow>[
      BoxShadow(
        offset: Offset(3, 3),
        blurRadius: 3,
        spreadRadius: 3,
      ),
    ],
  );
  final double padding = 16.0;
  @override
  Widget build(BuildContext context) {
    final valProv = context.read<SearchValueProvider>();
    return Wrap(
      children: [
        Padding(
          padding: EdgeInsets.all(padding),
          child: AnimatedContainer(
            decoration: valProv.groupValue == 1
                ? pressedDecoration
                : unpressedDecoration,
            duration: duration,
            child: RadioListTile<int>(
              activeColor: activeColor,
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
        Padding(
          padding: EdgeInsets.all(padding),
          child: AnimatedContainer(
            duration: duration,
            decoration: valProv.groupValue == 2
                ? pressedDecoration
                : unpressedDecoration,
            child: RadioListTile<int>(
              activeColor: activeColor,
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
        Padding(
          padding: EdgeInsets.all(padding),
          child: AnimatedContainer(
            duration: duration,
            decoration: valProv.groupValue == 3
                ? pressedDecoration
                : unpressedDecoration,
            child: RadioListTile<int>(
              activeColor: activeColor,
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
            elevation: 20,
            shape: cardbuttonstyle,
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
          color: Colors.blue,
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

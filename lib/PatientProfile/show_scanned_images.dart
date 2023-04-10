import 'dart:convert';
import 'dart:typed_data';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_windows/_const/_constWidgets.dart';
import 'package:proclinic_windows/_const/_strings.dart';
import 'package:proclinic_windows/_models/visitModel.dart';
import 'package:proclinic_windows/_providers/ptDocumentProvider.dart';
import 'package:provider/provider.dart';

class ScannedImagesWidget extends StatefulWidget {
  final String sclrp;
  final Visit visit;

  const ScannedImagesWidget({
    Key? key,
    required this.sclrp,
    required this.visit,
  }) : super(key: key);
  @override
  _ScannedImagesWidgetState createState() => _ScannedImagesWidgetState();
}

class _ScannedImagesWidgetState extends State<ScannedImagesWidget> {
  @override
  void initState() {
    _initDocuments();
    super.initState();
  }

  _initDocuments() async {
    await context
        .read<PatientDocumentProvider>()
        .setDocuments(widget.visit.phone, widget.visit.visitDate, widget.sclrp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade500.withOpacity(0.5),
      body: Consumer<PatientDocumentProvider>(
        builder: (context, docs, child) {
          while (docs.documents == null) {
            return const WhileValueEqualNullWidget();
          }
          return Dialog(
            child: SizedBox(
              height: 600,
              width: 500,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      color: Theme.of(context).primaryColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(),
                          Text(widget.sclrp.tr().toUpperCase()),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 500,
                      width: 500,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1.0,
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                          ),
                          itemCount: docs.documents!.length,
                          itemBuilder: (context, index) {
                            String? imgString;
                            switch (widget.sclrp) {
                              case SHEETS:
                                imgString = docs.documents![index].sheets;
                                break;
                              case LABS:
                                imgString = docs.documents![index].labs;
                                break;
                              case RADS:
                                imgString = docs.documents![index].rads;
                                break;
                              case PRESCRIPTIONS:
                                imgString =
                                    docs.documents![index].prescriptions;
                                break;
                              case COMMENTS:
                                imgString = docs.documents![index].comments;
                                break;
                            }

                            Uint8List bytelist = Uint8List.fromList(
                                base64Decode(imgString ?? ''));
                            MemoryImage provider = MemoryImage(bytelist);

                            return Container(
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      offset: Offset(5, 5),
                                      blurRadius: 5,
                                      spreadRadius: 5,
                                    )
                                  ],
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  child: Image(
                                    image: provider,
                                  ),
                                  onTap: () async {
                                    await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return DialogForMagnification(
                                          provider: provider,
                                          visitDate:
                                              docs.documents![index].scanTime,
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DialogForMagnification extends StatelessWidget {
  const DialogForMagnification(
      {Key? key, required this.provider, required this.visitDate})
      : super(key: key);
  final MemoryImage provider;
  final String visitDate;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Text(visitDate),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
          Container(
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(5, 5),
                    blurRadius: 5,
                    spreadRadius: 5,
                  )
                ],
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10)),
            child: SizedBox(
              width: 1024,
              height: 650,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    Image(
                      image: provider,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

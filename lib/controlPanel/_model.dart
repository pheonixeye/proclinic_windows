import 'dart:math';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_windows/bookKeeping/bookKeeping_UI.dart';
import 'package:proclinic_windows/localdb_search_pts/Collective_PolyClinic_Patient_data_UI.dart';
import 'package:proclinic_windows/EntryPage/entry_page.dart';
import 'package:proclinic_windows/NewDocCreatePage/NewDocCreatePage.dart';
import 'package:proclinic_windows/doctorsAndClinics/doctor_clinic.dart';
import 'package:proclinic_windows/new_organizer/pt_organizer_new_UI.dart';
import 'package:proclinic_windows/online_offers/online_offers_ui.dart';
import 'package:proclinic_windows/send_msg_to_pt/send_msg_UI.dart';
import 'package:proclinic_windows/settings_page/Settings_Page_UI.dart';

class SelectionButtonModel {
  final IconData iconData;
  final String title;
  final String tooltip;
  final Widget route;
  final Color shadowColor =
      Colors.primaries[Random().nextInt(Colors.primaries.length)];

  SelectionButtonModel(
      {required this.iconData,
      required this.title,
      required this.tooltip,
      required this.route});

  static List<SelectionButtonModel> modelList() {
    return [
      SelectionButtonModel(
          iconData: Icons.person_add,
          title: 'New Patient'.tr(),
          tooltip: 'مريض جديد',
          route: const HomePageWithTabView()),
      SelectionButtonModel(
          iconData: Icons.format_list_numbered,
          title: 'Patient Database'.tr(),
          tooltip: 'بيانات المرضي',
          route: const CollectivePatientDataUI()),
      SelectionButtonModel(
          iconData: Icons.offline_bolt,
          title: 'Appointment Organizer'.tr(),
          tooltip: 'ترتيب المواعيد',
          route: const PatientOrganizer()),
      SelectionButtonModel(
        iconData: Icons.local_hospital,
        title: 'New Doctor'.tr(),
        tooltip: 'اضافة طبيب',
        route: const NewDoctorCreationPage(),
        //! modify
      ),
      SelectionButtonModel(
        iconData: Icons.swap_horiz,
        title: 'Doctors & Clinics'.tr(),
        tooltip: 'اعداد العيادات',
        route: const ClinicList(),
      ),
      SelectionButtonModel(
        iconData: Icons.local_atm,
        title: 'BookKeeping'.tr(),
        tooltip: 'الحسابات',
        route: const BookKeeping(),
      ),
      // SelectionButtonModel(
      //   iconData: Icons.message_outlined,
      //   title: 'Messaging',
      //   tooltip: 'المراسلة',
      //   route: const SendMessagePage(),
      // ),
      // SelectionButtonModel(
      //   iconData: Icons.local_offer,
      //   title: 'Online Offers',
      //   tooltip: 'العروض',
      //   route: OnlineOffersPageUI(),
      // ),
      SelectionButtonModel(
        iconData: Icons.settings,
        title: 'Settings'.tr(),
        tooltip: 'الاعدادات العامة',
        route: const SettingsPage(),
      ),
    ];
  }
}

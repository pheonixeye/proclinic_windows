import 'package:proclinic_windows/_providers/bookKeepingProvider.dart';
import 'package:proclinic_windows/_providers/doctorListProvider.dart';
import 'package:proclinic_windows/_providers/new_visit_provider.dart';
import 'package:proclinic_windows/_providers/orgAppProvider.dart';
import 'package:proclinic_windows/_providers/ptDocumentProvider.dart';
import 'package:proclinic_windows/_providers/searchValueProvider.dart';
import 'package:proclinic_windows/_providers/settingsProvider.dart';
import 'package:proclinic_windows/_providers/visitsControllerProvider.dart';
import 'package:proclinic_windows/_providers/procedureVisibilityProvider.dart';
import 'package:proclinic_windows/_providers/selectedDoctorProvider.dart';
import 'package:proclinic_windows/theming/theme_data.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => DoctorListProvider()),
  ChangeNotifierProvider(create: (context) => SelectedDoctor()),
  ChangeNotifierProvider(create: (context) => ProcedureVisibilityProvider()),
  ChangeNotifierProvider(create: (context) => NewVisitProvider()),
  ChangeNotifierProvider(create: (context) => VisitsSearchController()),
  ChangeNotifierProvider(create: (context) => SearchValueProvider()),
  ChangeNotifierProvider(create: (context) => BookKeepingProvider()),
  ChangeNotifierProvider(create: (context) => SettingsProvider()),
  ChangeNotifierProvider(create: (context) => PatientDocumentProvider()),
  ChangeNotifierProvider(create: (context) => OrgAppProvider()),
  ChangeNotifierProvider(create: (context) => ThemeChanger()),
];

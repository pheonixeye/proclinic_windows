import 'package:easy_localization/easy_localization.dart';

String formatTime(int hour, int minute) {
  if (hour < 12) {
    return "$hour:$minute ${"A.M.".tr()}";
  } else if (hour > 12) {
    return "${hour - 12}:$minute ${"P.M.".tr()}";
  } else {
    return "$hour:$minute ${"P.M.".tr()}";
  }
}

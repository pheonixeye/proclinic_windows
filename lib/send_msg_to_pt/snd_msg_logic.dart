// import 'package:url_launcher/url_launcher.dart';
// import 'package:whatsapp_unilink/whatsapp_unilink.dart';
// import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';
// import 'package:twilio_flutter/twilio_flutter.dart';

// final link = WhatsAppUnilink(
//   phoneNumber: '+20-01227022248',
//   text: "Hey! I'm inquiring about the apartment listing",
// );

// Future<void> launchInBrowser({String phone, String msg}) async {
//   final link = WhatsAppUnilink(
//     phoneNumber: '+20-$phone',
//     text: "$msg",
//   );
//   if (await UrlLauncherPlatform.instance.canLaunch('$link')) {
//     await UrlLauncherPlatform.instance.launch(
//       '$link',
//       useSafariVC: false,
//       useWebView: false,
//       enableJavaScript: false,
//       enableDomStorage: false,
//       universalLinksOnly: false,
//       headers: <String, String>{},
//     );
//   } else {
//     throw 'Could not launch $link';
//   }
// }

// class SMS {
//   TwilioFlutter twilioFlutter = TwilioFlutter(
//     accountSid: 'AC46ca2d56f0c8967494e7daa8a7813d6e',
//     authToken: '38fd94c99b5998fd98f24d9779abd183',
//     twilioNumber: '+1 206 900 8901',
//   );
// }

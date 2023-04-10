// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';

// import 'package:http/http.dart' as http;

// const String username = 'drkazgm@gmail.com';
// const String password = 'stupidsmseg';
// const String sendername = 'CosmoSurge';

// Future makesmsrequest({required String mobile, required String message}) async {
//   const String url = 'https://smssmartegypt.com/sms/api/json/';

//   var headers = {
//     "Content-Type": "application/json",
//     "Accept": "application/json",
//     "Accept-Language": "en-US"
//   };
//   var body = jsonEncode({
//     "username": username,
//     "password": password,
//     "sendername": sendername,
//     "mobiles": mobile,
//     "message": message
//   });
//   // var response = await http.get(url);
//   var request = await http.post(Uri.parse(url), headers: headers, body: body);

//   print(request.body.toString());
//   print(jsonDecode(request.body));
//   return jsonDecode(request.body);
// }

// Future balancesmseg() async {
//   const String url =
//       'https://smssmartegypt.com/sms/api/getBalance?username=drkazgm@gmail.com&password=stupidsmseg';

//   var headers = {
//     "Content-Type": "application/json",
//     "Accept": "application/json",
//     "Accept-Language": "en-US"
//   };

//   var request = await http.get(Uri.parse(url), headers: headers);
//   // print(request.body.toString());
//   return request.body;
// }

// class CreditSMSEG {
//   CreditSMSEG() {
//     credit.listen((data) {
//       _creditStream.add(data);
//     });
//   }
//   Stream get credit async* {
//     var request;
//     const String url =
//         'https://smssmartegypt.com/sms/api/getBalance?username=drkazgm@gmail.com&password=stupidsmseg';

//     var headers = {
//       "Content-Type": "application/json",
//       "Accept": "application/json",
//       "Accept-Language": "en-US"
//     };
//     try {
//       request = await http.get(Uri.parse(url), headers: headers);
//       if (request != null) {
//         yield jsonDecode(request.body);
//       }
//     } catch (e) {
//       yield 'error';
//     }

//     // yield jsonDecode(request.body);
//   }

//   StreamController _creditStream = StreamController.broadcast();

//   Stream get creditStream => _creditStream.stream;
// }

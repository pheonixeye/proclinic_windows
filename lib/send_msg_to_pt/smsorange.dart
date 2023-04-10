// import 'dart:convert';
// import 'dart:io';

// import 'package:http/http.dart' as http;

// Future orangegetAuth() async {
//   const orangeAuthurl = 'https://api.orange.com/oauth/v2/token';

//   var headers = {
//     "Authorization":
//         " Basic SVZHUkdFSFlxeTVPcEdBYnhsS3VkSkFsZmVabThiRUI6cWZsQWQ3c2U0ZEF6VkRvMQ=="
//   };
//   var body = {"grant_type": "client_credentials"};
//   var request =
//       await http.post(Uri.parse(orangeAuthurl), headers: headers, body: body);
//   print(request.body.toString());
// }

// // {
// //             "token_type": "Bearer",
// //                 "access_token": "ALUQg74XoCj1ORyH7odgX0gA3xG9",
// //                 "expires_in": "7776000"
// //           }

// Future sendOrangeSms() async {
//   final String orangesendurl =
//       'https://api.orange.com/smsmessaging/v1/outbound/tel%3A%2B200000/requests';

//   var header = {
//     "Authorization": "Bearer ALUQg74XoCj1ORyH7odgX0gA3xG9",
//     "Content-Type": "application/json"
//   };
//   var body = {
//     "outboundSMSMessageRequest": {
//       "address": "tel:+201227022248",
//       "senderAddress": "tel:+200000",
//       'senderName': 'CosmoSurge',
//       "outboundSMSTextMessage": {
//         "message": "Hello ya Mozza, how are your f5ad today??!"
//       }
//     }
//   };
//   var request = await http.post(Uri.parse(orangesendurl),
//       headers: header, body: jsonEncode(body));
//   print(request.body.toString());
// }

// // '{"outboundSMSMessageRequest":{ \
// //         "address": "tel:+{{recipient_phone_number}}", \
// //         "senderAddress":"tel:+{{dev_phone_number}}", \
// //         "outboundSMSTextMessage":{ \
// //             "message": "Hello!" \
// //         } \
// //     } \
// // }'

// Future getsmsbalance() async {
//   final url = 'https://api.orange.com/sms/admin/v1/contracts';
//   var header = {"Authorization": "Bearer ALUQg74XoCj1ORyH7odgX0gA3xG9"};
//   var request = await http.get(Uri.parse(url), headers: header);
//   print(request.body.toString());
// }

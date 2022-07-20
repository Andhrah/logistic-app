// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
//
// import 'package:trakk/src/Exceptions/api_failure_exception.dart';
// import 'package:trakk/src/utils/constant.dart';
//
// class VerifyAcountService {
//   Future<dynamic> verifyAccount(String code, String email) async {
//     var body = {
//       "code": code,
//       "email": email,
//     };
//     var response = await http.post(
//       uriConverter('api/user/verify-otp'),
//       headers: kHeaders(''), body: json.encode(body)
//     );
//     var decoded = jsonDecode(response.body);
//     if (response.statusCode.toString().startsWith('2')) {
//       return decoded;
//     } else if (response.statusCode.toString().startsWith('4')) {
//     throw ApiFailureException(decoded["error"]["message"] ?? response.reasonPhrase);
//     } else {
//       throw ApiFailureException(
//       decoded['message'] ?? response.reasonPhrase ?? 'Unknown error');
//     }
//   }
//
//   Future<dynamic> resendOtp(String email, String phoneNumber) async {
//     var body = {
//       "email": email,
//       "phoneNumber": phoneNumber,
//     };
//     var response = await http.post(
//       uriConverter('api/user/send-otp'),
//       headers: kHeaders(''), body: json.encode(body)
//     );
//     var decoded = jsonDecode(response.body);
//       if (response.statusCode.toString().startsWith('2')) {
//         return decoded;
//       } else if (response.statusCode.toString().startsWith('4')) {
//       throw ApiFailureException(decoded["error"]["message"] ?? response.reasonPhrase);
//       } else {
//         throw ApiFailureException(
//         decoded['message'] ?? response.reasonPhrase ?? 'Unknown error');
//       }
//     // return await getForgetPasswordRequest('api/User/reset/initiate/$email');
//   }
// }

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:trakk/Exceptions/api_failure_exception.dart';
import 'package:trakk/utils/constant.dart';

class ForgotPasswordService {

  Future<dynamic> forgotPasswordRequest(Map body, String url) async {
    print('body is $body');
    print('Encoded body ${json.encode(body)}');
    var response = await http.post(uriConverter(url),
      headers: kHeaders(""), 
      body: json.encode(body)
    );
    print(response.body);
    var decoded = jsonDecode(response.body);
    print(decoded);
    if (response.statusCode.toString().startsWith('2') && decoded["status"]) {
      print('data here for reset: $decoded');
      return decoded;
    } else {
      print('======= GOT HERE ELSE ==========');
      print('reason is ${response.reasonPhrase} message is ${decoded['status']}');
      throw ApiFailureException(decoded["message"] ?? response.reasonPhrase ?? 'Internal server error');
    }
  }

  Future<dynamic> forgetPassword(String email) async {
    var body = {
      "email": email,
    };
    return await forgotPasswordRequest(body, "api/user/forgot-password");
  }


  Future<dynamic> resetPassword(String code, String newPassword, String password) async {
    var body = {
      "code": code,
      "newPassword": newPassword,
      "password": password,
    };
    return await forgotPasswordRequest(body, '/api/user/reset-password');
  }
}

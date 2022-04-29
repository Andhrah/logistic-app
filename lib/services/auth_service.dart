// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trakk/Exceptions/api_failure_exception.dart';
import 'package:trakk/utils/constant.dart';

class AuthService {
  uriConverter(String url) {
    print('$baseUrl/$url');
    return Uri.https(baseUrl, '/$url');
  }

  ssoUriConverter(String url) {
    print('$ssoUrl/$url');
    return Uri.https(ssoUrl, '/$url');
  }

  Future<dynamic> authRequest(Map body, String url) async {
    print('body is $body');
    print('Encoded body ${json.encode(body)}');
    var response = await http.post(
      uriConverter(url),
      // headers: kHeaders(null),
      body: body
    );
    print(response.body);
    var decoded = jsonDecode(response.body);
    if (response.statusCode.toString().startsWith('2')) {
      print('data: $decoded');
      return decoded;
    } else {
      print('reason is ${response.reasonPhrase} message is ${decoded['data'][0]['message']}');
      throw ApiFailureException(decoded['data'][0]['message'] ?? response.reasonPhrase);
    }
  }

  Future<dynamic> getForgetPasswordRequest(String url) async {
    var response = await http.get(ssoUriConverter(url));
    var decoded = jsonDecode(response.body);
    print('Forget Password Response: $decoded');
    print(response.headers);
    if (response.statusCode.toString().startsWith('2')) {
      return decoded;
    } else {
      throw ApiFailureException(decoded['message'] ?? response.reasonPhrase ?? 'Unknown error');
    }
  }

  Future<dynamic> resetPasswordRequest(Map body, String url) async {
    print('body is $body');
    print('Encoded body ${json.encode(body)}');
    var response = await http.post(
      ssoUriConverter(url),
      // headers: kHeaders(null),
      body: body
    );
    print('======= GOT HERE ==========');
    print(response.body);
    print('======= GOT HERE ==========');
    var decoded = jsonDecode(response.body);
    if (response.statusCode.toString().startsWith('2')) {
      print('data: $decoded');
      return decoded;
    } else {
      print('reason is ${response.reasonPhrase} message is ${decoded['data'][0]['message']}');
      throw ApiFailureException(decoded['data'] ?? response.reasonPhrase);
    }
  }

  // Future<dynamic> resetPasswordRequest(Map body, String url) async {
  //   var response = await http.post(ssoUriConverter(url));
  //   var decoded = jsonDecode(response.body);
  //   print('Forget Password Response: $decoded');
  //   print(response.headers);
  //   if (response.statusCode.toString().startsWith('2')) {
  //     return decoded;
  //   } else {
  //     throw ApiFailureException(decoded['message'] ?? response.reasonPhrase ?? 'Unknown error');
  //   }
  // }

  Future<dynamic> createUser(
    String firstName,
    String lastName,
    String email,
    String password,
    String phoneNumber,
    String userType) async {
    var body = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "phoneNumber": phoneNumber,
      "password": password,
      "userType": userType,
    };
    return await authRequest(body, 'api/v1/auth/signup');
  }

  Future<dynamic> login(String email, String password) async {
    var body = {
      "email": email,
      "password": password,
    };
    return await authRequest(body, 'api/v1/auth/login');
  }

  Future<dynamic> forgetPassword(String email) async {
    return await getForgetPasswordRequest('api/User/reset/initiate/$email');
  }

  Future<dynamic> resetPassword(String code, String password) async {
    var body = {
      "code": code,
      "newPassword": password,
    };
   return await resetPasswordRequest(body, 'api/User/reset/complete');
  }
}
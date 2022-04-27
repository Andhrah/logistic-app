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
}
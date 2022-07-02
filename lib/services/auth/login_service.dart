import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trakk/Exceptions/api_failure_exception.dart';

import 'package:trakk/utils/constant.dart';

class LoginService {
  Future<dynamic> login(String email, String password) async {
    var body = {
      "email": email,
      "password": password,
    };
    var response = await http.post(
      uriConverter('api/user/login'),
      headers: kHeaders(''), body: json.encode(body),
    );
    var decoded = jsonDecode(response.body);
    if (response.statusCode.toString().startsWith('2')) {
      print(">data response >>${decoded}");
      return decoded;
    } else if (response.statusCode.toString().startsWith('4')) {
      throw ApiFailureException(decoded['error']["message"] ?? response.reasonPhrase);
    } else {
      throw ApiFailureException('An error occurred, please try again');
      // throw ApiFailureException(decoded['error']['message'] ?? response.reasonPhrase);
    }
  }
}

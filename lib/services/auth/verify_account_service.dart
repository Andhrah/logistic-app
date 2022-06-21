import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:trakk/Exceptions/api_failure_exception.dart';
import 'package:trakk/utils/constant.dart';

class VerifyAcountService {
  Future<dynamic> verifyAccount(String code, String email) async {
    var body = {
      "code": code,
      "email": email,
    };
    var response = await http.post(
      uriConverter('api/user/verify-otp'),
      headers: kHeaders(''), body: json.encode(body)

    );
    var decoded = jsonDecode(response.body);
    if (response.statusCode.toString().startsWith('2')) {
      return decoded;
    } else if (response.statusCode.toString().startsWith('4')) {
    throw ApiFailureException(decoded["error"]["message"] ?? response.reasonPhrase);
    } else {
      throw ApiFailureException(
      decoded['message'] ?? response.reasonPhrase ?? 'Unknown error');
    }
  }
}

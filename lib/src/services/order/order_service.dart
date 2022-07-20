import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trakk/src/Exceptions/api_failure_exception.dart';
import 'package:trakk/src/values/constant.dart';

class OrderService {
  Future<dynamic> postOrder(String firstName, String lastName, String email,
      String password, String phoneNumber, String userType) async {
    var body = {
      "pickUp": firstName,
      "lastName": lastName,
      "email": email,
      "phoneNumber": phoneNumber,
      "password": password,
      "userType": userType,
    };
    var response = await http.post(uriConverter('api/user/register'),
        headers: kHeaders(''), body: json.encode(body));
    var decoded = jsonDecode(response.body);
    if (response.statusCode.toString().startsWith('2')) {
      return decoded;
    } else if (response.statusCode.toString().startsWith('4')) {
      // print('reason is ...${response.reasonPhrase} message is ${decoded['error']}');
      throw ApiFailureException(
          decoded['error']["message"] ?? response.reasonPhrase);
    } else {
      throw ApiFailureException('An error occurred, please try again');
      // throw ApiFailureException(decoded['error']['message'] ?? response.reasonPhrase);
    }
  }
}

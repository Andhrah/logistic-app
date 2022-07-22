import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trakk/src/Exceptions/api_failure_exception.dart';
import 'package:trakk/src/values/constant.dart';

class AddCompanyDataService {
  Future<dynamic> addCompanyData(String token, String name, String email,
      String phoneNumber, String rcNumber, String cacDocument) async {
    var body = {
      "data": {
        "name": name,
        "email": email,
        "phoneNumber": phoneNumber,
        "rcNumber": rcNumber,
        // "cacDocument": cacDocument,
      }
    };
    var response = await http.post(uriConverter('api/merchants'),
        headers: kHeaders(token), body: json.encode(body));
    print(body);
    // print(kHeaders(token));
    // print(uriConverter('api/merchants'));
    // print('************ FROM SERVICE *************');
    // print(response.body);
    var decoded = jsonDecode(response.body);
    // print('************ FROM SERVICE *************');
    // print(response);
    if (response.statusCode.toString().startsWith('2')) {
      return decoded;
    } else if (response.statusCode.toString().startsWith('4')) {
      throw ApiFailureException(
          decoded['error']["message"] ?? response.reasonPhrase);
    } else {
      throw ApiFailureException('An error occurred, please try again');
      // throw ApiFailureException(decoded['error']['message'] ?? response.reasonPhrase);
    }
  }
}

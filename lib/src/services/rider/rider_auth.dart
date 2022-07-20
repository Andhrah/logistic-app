import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trakk/src/Exceptions/api_failure_exception.dart';
import 'package:trakk/src/values/constant.dart';

class RiderAuthService {
  uriConverter(String url) {
    print('$baseUrl/$url');
    return Uri.https(baseUrl, '/$url');
  }

  Future<dynamic> authRequest(Map body, String url) async {
    print('body is $body');
    print('Encoded body ${json.encode(body)}');
    var response = await http.post(uriConverter(url),
        headers: kHeaders(''), body: json.encode(body));
    print(response.body);
    var decoded = jsonDecode(response.body);
    if (response.statusCode.toString().startsWith('2')) {
      print('data: $decoded');
      return decoded;
    } else if (decoded['data']) {
      print(
          'reason is ...${response.reasonPhrase} message is ${decoded['data']}');
      throw ApiFailureException(
          decoded['data'][0]["message"] ?? response.reasonPhrase);
    } else {
      print('reason is ${response.reasonPhrase} message is ${decoded['data']}');
      throw ApiFailureException(
          decoded['data'][0]["message"] ?? response.reasonPhrase);
    }
  }

  Future<dynamic> createRider(
    String firstName,
    String lastName,
    String email,
    String password,
    String phoneNumber,
    String stateOfOrigin,
    String stateOfResidence,
    String residentialAddress,
    String vehicleName,
    String vehicleColor,
    String vehicleNumber,
    String vehicleCapacity,
    String vehicleModel,
    int vehicleTypeId,
    List documents,
    String kinFirstName,
    String kinLastName,
    String kinPhoneNumber,
    String kinEmail,
    String kinAddress,
    String kinRelationship,
  ) async {
    var body = {
      "user": {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": phoneNumber,
        "password": password,
        "residentialAddress": residentialAddress,
        "stateOfOrigin": stateOfOrigin,
        "stateOfResidence": stateOfResidence,
        "nextOfKin": {
          "firstName": kinFirstName,
          "lastName": kinLastName,
          "phoneNumber": kinPhoneNumber,
          "email": kinEmail,
          "address": kinAddress,
          "relationship": kinRelationship,
        },
      },
      "vehicle": {
        "color": vehicleColor,
        "name": vehicleName,
        "number": vehicleNumber,
        "capacity": vehicleCapacity,
        "model": vehicleModel,
        "vehicleTypeId": vehicleTypeId,
        "documents": documents,
      },
    };
    return await authRequest(body, 'Rider/createRider');
  }
}

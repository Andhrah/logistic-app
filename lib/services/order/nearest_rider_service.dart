import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trakk/Exceptions/api_failure_exception.dart';
import 'package:trakk/values/constant.dart';

class NearestRiderService {
  Future<dynamic> nearestRider(
      String token, String latitude, String longitude) async {
    final queryParams = {
      'latitude': latitude,
      'longitude': longitude,
    };
    var response = await http.get(
      paramsUriConverter('api/nearest-riders', queryParams),
      headers: kHeaders(token),
    );
    var decoded = jsonDecode(response.body);
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

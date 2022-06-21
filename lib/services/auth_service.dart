// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trakk/Exceptions/api_failure_exception.dart';
import 'package:trakk/utils/constant.dart';

class AuthService {

  Future<dynamic> loginRequest(Map body, String url) async {
    print('body is $body');
    print('Encoded body ${json.encode(body)}');
    var response = await http.post(ssoUriConverter(url),
        headers: kHeaders(""), body: json.encode(body));
    // print(response.body);
    var decoded = jsonDecode(response.body);
    print(decoded);
    if (response.statusCode.toString().startsWith('2') && decoded["status"]) {
      print('data here for reset: $decoded');
      return decoded;
    } else {
      print(
          'reason is ${response.reasonPhrase} message is ${decoded['status']}');
      throw ApiFailureException(decoded["message"] ??
          response.reasonPhrase ??
          'Internal server error');
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
      throw ApiFailureException(
          decoded['message'] ?? response.reasonPhrase ?? 'Unknown error');
    }
  }

  Future<dynamic> resetPasswordRequest(Map body, String url) async {
    print('body is $body');
    print('Encoded body ${json.encode(body)}');
    var response = await http.post(ssoUriConverter(url),
        headers: kHeaders(""), body: json.encode(body));
    print(response.body);
    var decoded = jsonDecode(response.body);
    print(decoded);
    if (response.statusCode.toString().startsWith('2') && decoded["status"]) {
      print('data here for reset: $decoded');
      return decoded;
    } else {
      print('======= GOT HERE ELSE ==========');
      print(
          'reason is ${response.reasonPhrase} message is ${decoded['status']}');
      throw ApiFailureException(decoded["message"] ??
          response.reasonPhrase ??
          'Internal server error');
    }
  }

  // Future<dynamic> createUser(String firstName, String lastName, String email,
  //     String password, String phoneNumber, String userType) async {
  //   var body = {
  //     "firstName": firstName,
  //     "lastName": lastName,
  //     "email": email,
  //     "phoneNumber": phoneNumber,
  //     "password": password,
  //     "userType": userType,
  //   };
  //   return await authRequest(body, 'api/user/register');
  // }

  // Future<dynamic> createComplaint (
  //    String name,
  //   String email,
  //   String message,
  // ) async {
  //   var body = {
  //     "name": name,
  //     "email": email,
  //     "message": message
  //   };
  //   return await authRequest(body, 'api/Complaints/create');
  // }

  // Future<dynamic> createRider(
  //   String firstName,
  //   String lastName,
  //   String email,
  //   String password,
  //   String phoneNumber,
  //   String userType,
  //   String stateOfOrigin,
  //   String stateOfResidence,
  //   String residentialAddress,
  //   String userPassport,
  //   String vehicleName,
  //   String vehicleColor,
  //   String vehicleNumber,
  //   String vehicleCapacity,
  //   String vehicleParticulars,
  //   String vehicleImage,
  //   String vehicleModel,
  //   int vehicleTypeId,
  //   String kinFirstName,
  //   String kinLastName,
  //   String kinEmail,
  //   String kinAddress,
  //   String kinPhoneNumber,
  //   String kinRelationship,
  // ) async {
  //   var body = {
  //     "user": {
  //       "firstName": firstName,
  //       "lastName": lastName,
  //       "email": email,
  //       "phoneNumber": phoneNumber,
  //       "password": password,
  //       "userType": userType,
  //       "nextOfKin": {
  //         "firstName": kinFirstName,
  //         "lastName": kinLastName,
  //         "phoneNumber": kinPhoneNumber,
  //         "email": kinEmail,
  //         "address": kinAddress,
  //         "relationship": kinRelationship,
  //       },
  //       "residentialAddress": residentialAddress,
  //       "stateOfOrigin": stateOfOrigin,
  //       "stateOfResidence": stateOfResidence,
  //     },
  //     "vehicle": {
  //       "color": vehicleColor,
  //       "name": vehicleName,
  //       "number": vehicleNumber,
  //       "capacity": vehicleCapacity,
  //       "model": vehicleModel,
  //       "vehicleTypeId": vehicleTypeId,
  //       // "documents": [
  //       //   {
  //       //     "name": "string",
  //       //     "url": "string"
  //       //   }
  //       // ],
  //     },
  //     // "firstName": firstName,
  //     // "lastName": lastName,
  //     // "email": email,
  //     // "phoneNumber": phoneNumber,
  //     // "password": password,
  //     "userType": userType,

  //     "stateOfOrigin": stateOfOrigin,
  //     "stateOfResidence": stateOfResidence,
  //     "residentialAddress": residentialAddress,
  //     "avatar": userPassport,

  //     "vehicleName": vehicleName,
  //     "vehicleColor": vehicleColor,
  //     "vehicleNumber": vehicleNumber,
  //     "vehicleCapacity": vehicleCapacity,
  //     "vehicleImage": vehicleImage,
  //     "vehicleParticulars": vehicleParticulars,

  //     // "nOKFullName": kinFullName,
  //     "nOKEmail": kinEmail,
  //     "nOKAddress": kinAddress,
  //     "nOKPhoneNumber": kinPhoneNumber,
  //   };
  //   return await authRequest(body, 'api/v1/auth/signup');
  // }

  Future<dynamic> login(String email, String password) async {
    var body = {
      "email": email,
      "password": password,
    };
    return await loginRequest(body, 'api/User/token');
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

  // updateProfile
  // Future<dynamic> updateProfile(
  //   String firstName,
  //   String lastName,
  //   int phoneNumber,
  //   String email,
  //   String address,
  // ) async {
  //   var body = {
  //     "firstName": firstName,
  //     "lastName": lastName,
  //     "phoneNumber": phoneNumber,
  //     "email": email,
  //     "address": address,
  //   };
  //   // create your http function
  //   return await authRequest(body, 'api/User/update');
  // }
}

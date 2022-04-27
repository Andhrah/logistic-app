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
    // var body = User(email: email).toJson();
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

  // Future<dynamic> createUser(
  //   String firstName,
  //   String lastName,
  //   String email,
  //   String password,
  //   String phoneNumber,
  //   String userType) async {

  //   print('Im trying to make this happen');

    // var body = {
    //   "firstName": firstName,
    //   ":lastName": lastName,
    //   "email": email,
    //   "phoneNumber": phoneNumber,
    //   "password": password,
    //   "userType": userType,
    // };
  //    var url = "$baseUrl/auth/signup";
  //   try {
  //     var response = await http.post(uriConverter(url), body: json.encode(body));
  //     print(response.body);
  //   } catch(err) {
  //     print(err);
  //     rethrow;
  //   }
  //   // return await authRequest(body, 'auth/signup');
  // }

  // Future<Map<String, dynamic>> createUser({
  //   required String firstName,
  //   required String lastName,
  //   required String email,
  //   required String password,
  //   required String phoneNumber,
  //   required String userType,
  //   }) async {
  //   Map<String, dynamic> result = {};

  //   var body = jsonEncode({
  //     "firstName": firstName,
  //     ":lastName": lastName,
  //     "email": email,
  //     "phoneNumber": phoneNumber,
  //     "password": password,
  //     "userType": userType,
  //   });
  //   var url = "${MyStrings.baseUrl}/users/patients";

  //   try{
  //     var response  =await dio.post(url, data: body);
          

  //     final int statusCode = response.statusCode;
  //     if (statusCode != 200 || response.data['status'] != 'success') {

  //       result['message'] = "Sorry, we could not complete your request, try again later";
  //       result['error'] = true;
  //     }else {
  //       result['error'] = false;
  //       var user = User.fromJson(response.data);
  //       result['user'] = user;
  //     }
  //   }on DioError catch(e){
  //     result['error'] = true;
  //     if(e.response != null ){
  //       result['message'] = e.response.data['message'];

  //     }else{
  //       print(e.toString());
  //       result['message'] = "Sorry, We could not complete your request";
  //     }

  //   }


  //   return result;
  // }
}
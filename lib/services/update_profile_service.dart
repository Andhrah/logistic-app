import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:trakk/Exceptions/api_failure_exception.dart';

import 'package:trakk/models/update_profile/update_profile.dart';
import 'package:trakk/services/get_user_service.dart';
import 'package:trakk/utils/constant.dart';

class UpdateProfileService {
  Future<bool?> updateProfile({required String firstName, required String lastName,required String phoneNumber,
   required String  email,required String address}) async {
    print("[][][][] NETWORK");
    // var box = await Hive.openBox('userData');
    // String token = box.get('token');
    // print("This is the token >>>>>>>" + token);
    try {
      UpdateProfileModel updateProfileModel = UpdateProfileModel(firstName: firstName, lastName: lastName,
      phoneNumber: phoneNumber, address: address);
      var response = await http
          .put(Uri.parse('https://zebrra.itskillscenter.com/api/users/55'),
            body: updateProfileModelToJson(updateProfileModel),
            
              // body: json.encode({
              //   "data": {
              //     "name": name,
              //     "email": email,
              //     "message": message
              //   }
              // }),
              headers: {'Content-Type': 'application/json',
              'Authorization': "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NTUsImlhdCI6MTY1NjAxOTY0OSwiZXhwIjoxNjU2MTA2MDQ5fQ.5OX8fs5LDpdmeQ8LULyjZn2fRj2slCk6kgpwhX1U0Z0"
              });
      if (response.statusCode == 200 || response.statusCode == 201) {
        var decoded = jsonDecode(response.body);
        print(response.body);
        box.putAll({
        "firstName": decoded['data']['firstName'],
        "lastName": decoded['data']['lastName'],
        "email": decoded['data']['email'],
        "phoneNumber": decoded['data']['phoneNumber'],
        "address": decoded['data']['address'],
        "id": decoded['data']['id'],
        
      });
        print(">>>>>>>>>>>>>>>>");
       await GetUserData.getUser();
        return true;
      } else {
        print('error ********');
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  uriConverter(String url) {
    print('$baseUrl/$url');
    return Uri.https(baseUrl, '/$url');
  }

  Future<dynamic> authRequest(Map body, String url) async {
    print('body is $body');
    print('Encoded body ${json.encode(body)}');

    //Support support = Support(data: body);
    var response = await http.post(uriConverter(url),
        headers: kHeaders(''),
        //body: json.encode(body)
        body: body);
    print("****************" + response.body);
    var decoded = jsonDecode(response.body);
    if (response.statusCode.toString().startsWith('2')) {
      print('data: $decoded');
      return decoded;
    } else {
      print("error posting request");
      return null;
    }
  }

  updateUserProfile() {}

  // Future<dynamic> createComplaint(
  //   String name,
  //   String email,
  //   String message,
  // ) async {
  //   var body = {"name": name, "email": email, "message": message};
  //   return await authRequest(body, 'api/Complaints/create');
  // }
}

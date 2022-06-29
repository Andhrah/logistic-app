import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:trakk/Exceptions/api_failure_exception.dart';

import 'package:trakk/models/update_profile/update_profile.dart';
import 'package:trakk/utils/constant.dart';

class UpdateProfileService {
  Future<bool?> updateProfile({required String firstName, required String lastName,required String phoneNumber,
   required String  email,required String address}) async {
    print("[][][][] NETWORK");
    var box = await Hive.openBox('userData');
    String token = box.get('token');
    print("This is the token >>>>>>>" + token);
    try {
      Data data = Data(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, 
      email: email, address: address);
      UpdateProfile updateProfile = UpdateProfile(data: data);
      var response = await http
          .put(Uri.parse('https://zebrra.itskillscenter.com/api/users/53'),
            body: updateProfileToJson(updateProfile),
            
              // body: json.encode({
              //   "data": {
              //     "name": name,
              //     "email": email,
              //     "message": message
              //   }
              // }),
              headers: {'Content-Type': 'application/json',
              'Authorization': "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NTMsImlhdCI6MTY1NDkwMTk3NSwiZXhwIjoxNjU0OTg4Mzc1fQ.wUfVM8hTrWV-Na6tpdMLEB9_FL-a52OiUt1MsJwFMe4"
              });
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
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

  // Future<dynamic> createComplaint(
  //   String name,
  //   String email,
  //   String message,
  // ) async {
  //   var body = {"name": name, "email": email, "message": message};
  //   return await authRequest(body, 'api/Complaints/create');
  // }
}

import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:trakk/Exceptions/api_failure_exception.dart';

import 'package:trakk/models/update_profile/update_profile.dart';
import 'package:trakk/services/get_user_service.dart';
import 'package:trakk/utils/constant.dart';

class UpdateProfileService {
  var box = Hive.box('appState');
  Future<bool?> updateProfile(
      {required String firstName,
      required String lastName,
      required String phoneNumber,
      required String email,
      required String address}) async {
    print("[][][][] NETWORK");
    //String token = box.get("appState");
    String token = box.get("token");
    var ID = box.get("id");
    try {
      Data data = Data(
          firstName: firstName,
          lastName: lastName,
          phoneNumber: phoneNumber,
          email: email,
          address: address);
      UpdateProfile updateProfile = UpdateProfile(data: data);
      var putResponses = await http.put(
        putUriConverter("api/users", ID),
        headers: kHeaders(token),
        body: updateProfileToJson(updateProfile),
      );
      // var putResponse = await http.put(putUriConverter("api/users/", ID),
      // headers: kHeaders(token), body: updateProfileToJson(updateProfile),
      // );
      print(">>>>>>>>> ${putResponses.body}");
      if (putResponses.statusCode == 200 || putResponses.statusCode == 201) {
        print(putResponses.body);
        GetUserData.getUser();
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

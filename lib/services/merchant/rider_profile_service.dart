import 'dart:convert';
//import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';

import '../../Exceptions/api_failure_exception.dart';
import '../../utils/constant.dart';

class RiderProfileService {
  static Future<dynamic> getRiderProfile() async {
       var boxR = await Hive.openBox('riderData');
       var box =  Hive.box('appState');
       print("riderData ox opend>>>>>>>>");

       var merchantId = boxR.get('merchantId');
       String token = box.get('token');
       // get user id and token from the values stored in hive after login
  // var id = box.get('id');
  // var token = box.get('token');
    var response = await http.get(
        //this merchant ID is hard-coded, but should be gotten from the service when the merchant logs in
        Uri.parse(
            'https://zebrra.itskillscenter.com/api/users?populate[0]=rider&populate[1]=rider.vehicles&filters[rider][id][\$eq]=17'),
        headers: {
          'Content-type': 'application/json',
          //this token are hard-coded, but should be gotten from the service when the merchant logs in
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ODYsImlhdCI6MTY1NjY2NTkyMiwiZXhwIjoxNjU2NzUyMzIyfQ.LwCkXw7EENxOwrzlLUKVmjffB_MAIo8PNhGA2c9Fj1c'
        });

    //headers: kHeaders(''), body: json.encode(body));
    print("print test for rider profile ${response.body}");
    var decoded = jsonDecode(response.body);
    if (response.statusCode.toString().startsWith('2')) {
      print('profile test: $decoded');
         
      // set returned value hive
    boxR.putAll({
        "firstName": decoded['data'][0]['firstName'],
        "lastName": decoded['data'][0]['lastName'],
        "email": decoded['data'][0]['email'],
        "phoneNumber": decoded['data'][0]['phoneNumber'],
        "address": decoded['data'][0]['address'],
        "bikeName": decoded['data'][0]["rider"]["vehicles"][0]["name"],
        "bikeNumber": decoded['data'][0]["rider"]["vehicles"][0]["number"],
        //"id": decoded['data']['id'],
        // "riderId": decoded['data']['rider']['id']
      });
   print("see >>>. ${boxR.get('bikeName')} ~~~~~~~???????>>>>");
      return decoded;
    } else if (decoded['data']) {
      print(
          'reason is ...${response.reasonPhrase} message is ${decoded['data']}');
      throw ApiFailureException(
          decoded['data'][0]["message"] ?? response.reasonPhrase);
    } else {
      // if(decoded['data'] && decoded['data'][0]){
      //   throw ApiFailureException(decoded['data'][0]["message"] ?? response.reasonPhrase);
      // }
      print('reason is ${response.reasonPhrase} message is ${decoded['data']}');
      throw ApiFailureException(
          decoded['data'][0]["message"] ?? response.reasonPhrase);
    }
  }
}

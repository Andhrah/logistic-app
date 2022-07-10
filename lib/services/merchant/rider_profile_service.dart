import 'dart:convert';

//import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:http/http.dart';
import 'package:trakk/bloc/app_settings_bloc.dart';
import 'package:trakk/models/auth_response.dart';

import '../../Exceptions/api_failure_exception.dart';
import '../../utils/constant.dart';

class RiderProfileService {
  static Future<dynamic> getRiderProfile() async {
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

      var appSettings = await appSettingsBloc.fetchAppSettings();
      User user = appSettings.loginResponse?.data?.user ?? User();

      Rider rider = user.rider ?? Rider();

      Vehicles vehicles = rider.vehicles ?? Vehicles();

      vehicles.name = decoded['data'][0]["rider"]["vehicles"][0]["name"];
      vehicles.number = decoded['data'][0]["rider"]["vehicles"][0]["number"];

      user.firstName = decoded['data'][0]['firstName'];
      user.lastName = decoded['data'][0]['lastName'];
      user.email = decoded['data'][0]['email'];
      user.phoneNumber = decoded['data'][0]['phoneNumber'];
      user.address = decoded['data'][0]['address'];
      user.rider = rider;

      AuthResponse authResponse = AuthResponse(
          data: AuthData(
              token: appSettings.loginResponse?.data?.token,
              refreshToken: appSettings.loginResponse?.data?.refreshToken,
              ssoToken: appSettings.loginResponse?.data?.ssoToken,
              user: user));
      await appSettingsBloc.saveLoginDetails(authResponse);

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

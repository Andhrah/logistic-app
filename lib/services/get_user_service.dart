// Get User Service

import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:trakk/bloc/app_settings_bloc.dart';
import 'package:trakk/models/auth_response.dart';

//var box = Hive.box('appState');

class GetUserData {
  // a new instance of hive can be created with new box

  static Future getUser() async {
    // get user id and token from the values stored in hive after login

    var token = await appSettingsBloc.getToken;
    try {
      var response = await http.get(
          Uri.parse(
              'https://zebrra.itskillscenter.com/api/users/55?populate=*'),
          headers: {
            'Content-type': 'application/json',
            //'Authorization': 'Bearer '
          });
      var decoded = json.decode(response.body);
      print('This is the get user data response' + response.body);
      if (response.statusCode == 200) {
        // set returned value hive

        await appSettingsBloc.saveLoginDetails(AuthResponse.fromJson(decoded));

        // this will be done for all details to be stored locally
      } else {
        throw ('unable to get user data');
      }

      return response;
    } catch (err) {
      print(err.toString());

      return null;
    }
  }
}

// on the UI being displayed immediately after login

// initState(){
//   //super ...
//   // you can create an instace of the getUserData Service or call it
//   // directly since is a static method
//   GetUserData.getUser();
// }

// or this, but not necessary if the mehtod is static
// GetUserData getUserData = GetUserData();
// initState(){
//   //super ...
//   // accessing the class with an instamce
//   getUserData.getUser();
// }

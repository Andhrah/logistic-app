// Get User Service

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';

import '../utils/constant.dart';

class GetUserData{
  // a new instance of hive can be created with new box 
  
  static void getUser() async {
    
  var box = Hive.box('appState');
  // get user id and token from the values stored in hive after login
  var id = box.get('id');
  var token = box.get('token');
  try{
    // var response = await http.get(Uri.parse('https://zebrra.itskillscenter.com/api/users/53'), headers: {
    //   'Content-type': 'application/json',
    //   'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NTMsImlhdCI6MTY1NTM3MTAyMiwiZXhwIjoxNjU1NDU3NDIyfQ.oi4bFAF81PkXUC1GRyqMjbUAz1GgjRp7GQW0D9y-ETk'
    // });

    var response = await http.get(Uri.parse("https://zebrra.itskillscenter.com/api/users/202"),
              headers: kHeaders(token),
              );
    var decoded = json.decode(response.body);
    print('This is the get user data response' + response.body);
    if(response.statusCode == 200) {
     
      // set returned value hive
      await box.put("phoneNumber", decoded["data"]["phoneNumber"]);
      await box.put("firstName", decoded["data"]["firstName"]);
      await box.put("lastName", decoded["data"]["lastName"]);
      await box.put("email", decoded["data"]["email"]);
    // box.putAll({
    //     "lastName": decoded['data']['lastName'],
    //     //"lastName": decoded['data']['lastName'],
    //   });
   
    
    // this will be done for all details to be stored locally
    } else {
      throw('unable to get user data');
    }
    
  } catch (err) {
    print(err.toString());
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
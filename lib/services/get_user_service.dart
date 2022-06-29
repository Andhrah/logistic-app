// Get User Service

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';

class GetUserData{
  // a new instance of hive can be created with new box 
  
  static void getUser() async {
    
  var box = await Hive.box('userData');
  // get user id and token from the values stored in hive after login
  var id = box.get('id');
  var token = box.get('token');
  try{
    var response = await http.get(Uri.parse('https://zebrra.itskillscenter.com/api/users/19?populate=*'), headers: {
      'Content-type': 'application/json',
      //'Authorization': 'Bearer '
    });
    var decoded = json.decode(response.body);
    print('This is the get user data response' + response.body);
    if(response.statusCode == 200) {
     
      // set returned value hive
    box.putAll({
        "firstName": decoded['data']['firstName'],
        "lastName": decoded['data']['lastName'],
        "email": decoded['data']['email'],
        "phoneNumber": decoded['data']['phoneNumber'],
        "address": decoded['data']['address'],
        "id": decoded['data']['id'],
        "riderId": decoded['data']['rider']['id']
      });
    // box.putAll({
    //     "lastName": decoded['data']['lastName'],
    //     //"lastName": decoded['data']['lastName'],
    //   });
   print("${box.get('riderId')} >>>>");
    
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
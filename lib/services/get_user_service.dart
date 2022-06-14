// Get User Service

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';

class GetUserData{
  // a new instance of hive can be created with new box 
  
  static void getUser()async{
    
  var box = Hive.box('userData');
  // get user id and token from the values stored in hive after login
  var id = box.get('id');
  var token = box.get('token');
  try{
    var response = await http.get(Uri.parse('https://zebrra.itskillscenter.com/api/users/53'), headers: {
      'Content-type': 'application/json',
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NTMsImlhdCI6MTY1NTIwNzE5NiwiZXhwIjoxNjU1MjkzNTk2fQ.DZ1xwwhd4yh7uAecaofs1fNuyjCstR6fR3c2OaTJt3w'
    });
    var decoded = json.decode(response.body);
    // open hive
    box.put('firstname', 'firstname');
    box.put('lastname', 'lastname');
    // this will be done for all details to be stored locally
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

// // or this, but not necessary if the mehtod is static
// GetUserData getUserData = GetUserData();
// initState(){
//   //super ...
//   // accessing the class with an instamce
//   getUserData.getUser();
// }
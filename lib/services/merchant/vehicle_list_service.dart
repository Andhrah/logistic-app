
import 'dart:convert';
//import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';

import '../../Exceptions/api_failure_exception.dart';
import '../../utils/constant.dart';

class GetVehiclesListService {

  static Future<dynamic> getVehiclesList() async {
    // print('body is $body');
    //print('Encoded body ${json.encode(body)}');
    var response = await http.get(
      
        Uri.parse('https://zebrra.itskillscenter.com/api/vehicles?populate[riderId][populate][0]=merchantId&filters[riderId][merchantId][id][\$eq]=17'),
        headers: {
          'Content-type': 'application/json',
          'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NjEsImlhdCI6MTY1NjQwNzQzMSwiZXhwIjoxNjU2NDkzODMxfQ.SBo-24aVkVKcSP72YG57sxnVXYFRM4VBzvthKYM6Ijw'
        });

    //headers: kHeaders(''), body: json.encode(body));
    print("print test ${response.body}");
    var decoded = jsonDecode(response.body);
    if (response.statusCode.toString().startsWith('2')) {
      print('JJdata: $decoded');
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



// // Get User Service

// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:hive_flutter/hive_flutter.dart';

// class GetVehiclesListService{
//   // a new instance of hive can be created with new box 
  
//   Future<dynamic> getVehicles() async {


//   try{
//     //var eq = "\$eq";
//     var response = await http.get(Uri.parse('https://zebrra.itskillscenter.com/api/vehicles?populate[riderId][populate][0]=merchantId&filters[riderId][merchantId][id][\$eq]=17'), headers: {
//       'Content-type': 'application/json',
//       'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NjEsImlhdCI6MTY1NjQwNzQzMSwiZXhwIjoxNjU2NDkzODMxfQ.SBo-24aVkVKcSP72YG57sxnVXYFRM4VBzvthKYM6Ijw'
//     });
//     var decoded = json.decode(response.body);
//     print('This is the response for get vehicles' + response.body);
//     if(response.statusCode == 200) {

//     } else {
//       throw('unable to get list of vehicles');
//     }
    
//   } catch (err) {
//     print(err.toString());
//   }
    
//   }
// }

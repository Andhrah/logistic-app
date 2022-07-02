import 'package:hive_flutter/hive_flutter.dart';

Map<String, String> _headers(String token) {
  return {
    'Content-type': 'application/json',
    'Authorization': 'Bearer $token'
  };
}

const String kFirstTimeUser = 'firstTimeUser';
const String baseUrl = 'zebrra.itskillscenter.com';
const kHeaders = _headers;
const ssoUrl = "zebrrasso.herokuapp.com";

uriConverter(String url) {
  print('$baseUrl/$url');
  return Uri.https(baseUrl, '/$url');
}

paramsUriConverter(String url, Map<String, dynamic>? params) {
  print('$baseUrl/$url');
  return Uri.https(baseUrl, '/$url', params);
}
putUriConverter(String url, int id) {
  print('$baseUrl/$url');
  return Uri.https(baseUrl, '/$url/$id', );
}


ssoUriConverter(String url) {
  print('$ssoUrl/$url');
  return Uri.https(ssoUrl, '/$url');
}var box =  Hive.box('userData');


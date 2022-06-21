Map<String, String> _headers(String token) {
  return {
    'Content-type': 'application/json',
    'Bearer': token
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

ssoUriConverter(String url) {
  print('$ssoUrl/$url');
  return Uri.https(ssoUrl, '/$url');
}

const String kFirstTimeUser = 'firstTimeUser';
const String baseUrl = '2ba8-102-89-32-193.ngrok.io';
const kHeaders = _headers;


Map<String, String> _headers(String token) {
  return {
    'Content-type': 'application/json',
    'Bearer': token
  };
}

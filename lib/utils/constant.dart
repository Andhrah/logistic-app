Map<String, String> _headers(String token) {
  return {
    'Content-type': 'application/json',
    'Bearer': token
  };
}

const String kFirstTimeUser = 'firstTimeUser';
const String baseUrl = '3f37-102-89-47-41.ngrok.io';
const kHeaders = _headers;
const ssoUrl = "zebrrasso.herokuapp.com";


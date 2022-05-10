Map<String, String> _headers(String token) {
  return {
    'Content-type': 'application/json',
    'Bearer': token
  };
}

const String kFirstTimeUser = 'firstTimeUser';
const String baseUrl = '6a5a-102-89-42-180.ngrok.io';
const kHeaders = _headers;
const ssoUrl = "zebrrasso.herokuapp.com";

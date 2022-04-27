Map<String, String> _headers(String token) {
  return {
    'Content-type': 'application/json',
    'Bearer': token
  };
}

const String kFirstTimeUser = 'firstTimeUser';
const String baseUrl = '42e0-102-89-34-189.ngrok.io';
const kHeaders = _headers;
const ssoUrl = "zebrrasso.herokuapp.com";


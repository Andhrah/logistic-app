Map<String, String> _headers(String token) {
  return {
    'Content-type': 'application/json',
    'Bearer': token
  };
}

const String kFirstTimeUser = 'firstTimeUser';
const String baseUrl = 'trakk-server.herokuapp.com';
const kHeaders = _headers;
const ssoUrl = "zebrrasso.herokuapp.com";

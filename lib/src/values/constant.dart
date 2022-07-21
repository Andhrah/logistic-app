Map<String, String> _headers(String token) {
  return {'Content-type': 'application/json', 'Authorization': 'Bearer $token'};
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
  return Uri.https(
    baseUrl,
    '/$url/$id',
  );
}

ssoUriConverter(String url) {
  print('$ssoUrl/$url');
  return Uri.https(ssoUrl, '/$url');
}

// var box = Hive.box('userData');

const kDistanceKMCoveredInAnHour = 60.0;
//multiply by 60 to convert from hour to minutes
const kSpeedInMinutes = kDistanceKMCoveredInAnHour * 60.0;

String naira = '₦';

String cloudinaryUploadPreset = '';
String cloudinaryCloudName = '';

const List<String> states = [
  "Abia",
  "Adamawa",
  "Akwa Ibom",
  "Anambra",
  "Bauchi",
  "Bayelsa",
  "Benue",
  "Borno",
  "Cross River",
  "Delta",
  "Ebonyi",
  "Edo",
  "Ekiti",
  "Enugu",
  "FCT - Abuja",
  "Gombe",
  "Imo",
  "Jigawa",
  "Kaduna",
  "Kano",
  "Katsina",
  "Kebbi",
  "Kogi",
  "Kwara",
  "Lagos",
  "Nasarawa",
  "Niger",
  "Ogun",
  "Ondo",
  "Osun",
  "Oyo",
  "Plateau",
  "Rivers",
  "Sokoto",
  "Taraba",
  "Yobe",
  "Zamfara"
];

const orderIdentifier = 'trk';

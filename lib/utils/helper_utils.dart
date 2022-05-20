import 'dart:core';
import 'dart:math';

const chars = "abcdefghijklmnopqrstuvwxyz0123456789";

String generateRandomString(int strlen) {
  Random rnd =  Random( DateTime.now().millisecondsSinceEpoch);
  String result = "";
  for (var i = 0; i < strlen; i++) {
    result += chars[rnd.nextInt(chars.length)];
  }
  return result;
}
// import 'dart:math';

// String generateRandomString(int len) {
//   var r = Random();
//   String randomString =
//       String.fromCharCodes(List.generate(len, (index) => r.nextInt(33) + 89));
//   return randomString;
// }

import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:trakk/src/.env.dart';
import 'package:trakk/src/utils/app_toast.dart';
import 'package:trakk/src/utils/singleton_data.dart';
import 'package:trakk/src/values/enums.dart';
import 'package:url_launcher/url_launcher.dart';

const chars = "abcdefghijklmnopqrstuvwxyz0123456789";

String generateRandomString(int strlen) {
  Random rnd = Random(DateTime.now().millisecondsSinceEpoch);
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

double safeAreaWidth(context, double width) {
  MediaQueryData _mediaQueryData = MediaQuery.of(context);

  double safeAreaHorizontal =
      _mediaQueryData.padding.left + _mediaQueryData.padding.right;

  double safeAreaBlockHorizontal =
      (_mediaQueryData.size.width - safeAreaHorizontal) / 100;
  double actualWidth = width * safeAreaBlockHorizontal;

  return actualWidth;
}

double safeAreaHeight(context, double height) {
  MediaQueryData _mediaQueryData = MediaQuery.of(context);

  double safeAreaVertical =
      _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;

  double safeAreaBlockVertical =
      (_mediaQueryData.size.height - safeAreaVertical) / 100;
  double actualHeight = height * safeAreaBlockVertical;

  return actualHeight;
}

extension SizedboxUitls on num {
  Widget heightInPixel() {
    return SizedBox(height: this * 1.0);
  }

  Widget widthInPixel() {
    return SizedBox(width: this * 1.0);
  }

  Widget safeAreaHeight(context) {
    MediaQueryData _mediaQueryData = MediaQuery.of(context);

    double safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;

    double safeAreaBlockVertical =
        (_mediaQueryData.size.height - safeAreaVertical) / 100;
    double actualHeight = this * safeAreaBlockVertical;

    return SizedBox(
      height: actualHeight,
    );
  }

  Widget safeAreaWidth(context) {
    MediaQueryData _mediaQueryData = MediaQuery.of(context);

    double safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;

    double safeAreaBlockHorizontal =
        (_mediaQueryData.size.width - safeAreaHorizontal) / 100;
    double actualWidth = this * safeAreaBlockHorizontal;

    return SizedBox(
      height: actualWidth,
    );
  }

  Widget flexSpacer() {
    return Spacer(flex: toInt());
  }
}

Future<String> getAddressFromLatLng(double lat, double long) async {
  try {
    List<Placemark> p =
        await placemarkFromCoordinates(lat, long, localeIdentifier: 'en_US');
    Placemark place = p[0];

    return "${place.street}, ${place.name}, ${place.country}";
  } catch (e) {
    return '...';
  }
}

getAddressFromLatLngWithMap(double lat, double lng) async {
  String _host = 'https://maps.google.com/maps/api/geocode/json';
  final url = '$_host?key=$googleAPIKey&language=en&latlng=$lat,$lng';

  var response = await SingletonData.singletonData.dio.get(url);
  if (kDebugMode) {
    print(response.data);
  }
  if (response.statusCode == 200 &&
      response.data['results'] != null &&
      (response.data['results'] as List).isNotEmpty) {
    Map data = response.data;
    String _formattedAddress = data["results"][0]["formatted_address"];
    if (kDebugMode) {
      print("response ==== $_formattedAddress");
    }
    return _formattedAddress;
  }
  return null;
}

String greetWithTime() {
  if (DateTime.now().hour < 12) {
    return 'Good morning ';
  } else if (DateTime.now().hour >= 12 && DateTime.now().hour < 18) {
    return 'Good afternoon ';
  } else if (DateTime.now().hour >= 18 && DateTime.now().hour <= 24) {
    return 'Good evening ';
  } else {
    return 'Hi ';
  }
}

Future<Uint8List?> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
      ?.buffer
      .asUint8List();
}

String getLongDate({String? dateValue, int? milliSecSinceEpoch}) {
  try {
    if (milliSecSinceEpoch != null) {
      var date = DateTime.fromMillisecondsSinceEpoch(milliSecSinceEpoch);

      return DateFormat('dd/MM/yyyy').format(date);
    }
    if (dateValue != null) {
      var date = DateTime.parse(dateValue);
      return DateFormat('dd/MM/yyyy').format(date);
    }
  } catch (err) {
    return 'dd/mm/yyyy';
  }
  return 'dd/mm/yyyy';
}

String getTimeFromDate({String? dateValue, int? milliSecSinceEpoch}) {
  try {
    if (milliSecSinceEpoch != null) {
      var date = DateTime.fromMillisecondsSinceEpoch(milliSecSinceEpoch);

      return DateFormat('hh:mm').format(date);
    }
    if (dateValue != null) {
      var date = DateTime.parse(dateValue);
      return DateFormat('hh:mm').format(date);
    }
  } catch (err) {
    return 'hh:mm';
  }
  return 'hh:mm';
}

String convertFileToString(File file) {
  String convertedFile = base64Encode(file.readAsBytesSync());

  return convertedFile;
}

String formatMoney(double value) {
  return NumberFormat('#,##0.##').format(value);
}

Uint8List createByteFromString(String base64Encoded) {
  Uint8List bytes = base64.decode(base64Encoded);

  return bytes;
}

urlLauncher(String url,
    {required UrlLaunchType urlLaunchType,
    bool forceWebView = false,
    bool forceSafariVC = false}) async {
  Uri urlString = Uri.parse(url);
  if (urlLaunchType == UrlLaunchType.call) {
    urlString = Uri.parse('tel://$url');
  }

  if (urlString.toString().isNotEmpty) {
    try {
      if (await canLaunchUrl(urlString)) {
        await launchUrl(urlString);
      }
    } catch (err) {
      appToast('Cannot process');
    }
  } else {
    appToast('Cannot process');
  }
}

String camelCase(String? input) {
  if (input == null) {
    return '';
  }
  if (input.length < 2) {
    return input;
  }
  return input[0].toUpperCase() + input.substring(1);
}

bool isFileMoreThanMaxInMB(File file,
    {int value = 5, String message = 'Maximum file size upload is 5MB'}) {
  if (file.lengthSync() > (1000000 * value)) {
    runToast(message);
    return true;
  }

  return false;
}

UserType userTypeDeterminant(String userType) {
  switch (userType) {
    case 'customer':
      return UserType.customer;
    case 'rider':
      return UserType.rider;
    case 'merchant':
      return UserType.merchant;
    case 'guest':
      return UserType.guest;
    default:
      return UserType.none;
  }
}

double textFontSize(context, double size) {
  double _scaleFactor = MediaQuery.of(context).textScaleFactor;
  return (size) / _scaleFactor;
}

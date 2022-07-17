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
import 'package:trakk/.env.dart';
import 'package:trakk/utils/app_toast.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/utils/enums.dart';
import 'package:trakk/utils/singleton_data.dart';
import 'package:trakk/widgets/button.dart';
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

modalDialog(BuildContext context,
    {String title = '',
    Widget? child,
    required String positiveLabel,
    required Function() onPositiveCallback,
    required String negativeLabel,
    required Function() onNegativeCallback}) {
  var theme = Theme.of(context);
  MediaQueryData mediaQuery = MediaQuery.of(context);

  showBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
          margin: EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
          constraints: const BoxConstraints(maxWidth: 450),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 54),
          decoration: const BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50), topLeft: Radius.circular(50))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title.isNotEmpty) 24.heightInPixel(),
              if (title.isNotEmpty)
                Center(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headline6!.copyWith(),
                  ),
                ),
              if (title.isNotEmpty) 24.heightInPixel(),
              if (child != null) child,
              if (child != null) 24.heightInPixel(),
              Row(
                children: [
                  Expanded(
                    child: Button(
                        text: positiveLabel,
                        fontSize: 12,
                        onPress: () {
                          onPositiveCallback();
                        },
                        borderRadius: 12,
                        color: kTextColor,
                        width: double.infinity,
                        textColor: whiteColor,
                        isLoading: false),
                  ),
                  20.widthInPixel(),
                  Expanded(
                    child: Button(
                        text: negativeLabel,
                        fontSize: 12,
                        onPress: () {
                          onNegativeCallback();
                        },
                        borderRadius: 12,
                        color: redColor,
                        width: double.infinity,
                        textColor: whiteColor,
                        isLoading: false),
                  ),
                ],
              ),
            ],
          )));
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
    {UrlLaunchType urlLaunchType = UrlLaunchType.call,
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

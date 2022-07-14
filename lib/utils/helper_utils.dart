import 'dart:core';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/button.dart';

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
        await GeocodingPlatform.instance.placemarkFromCoordinates(lat, long);
    Placemark place = p[0];

    return "${place.street}, ${place.name}, ${place.country}";
  } catch (e) {
    return '...';
  }
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
  if (milliSecSinceEpoch != null) {
    var date = DateTime.fromMillisecondsSinceEpoch(milliSecSinceEpoch);

    return DateFormat('dd/MM/yyyy').format(date);
  }
  if (dateValue != null) {
    var date = DateTime.parse(dateValue);
    return DateFormat('dd/MM/yyyy').format(date);
  }

  return 'dd/mm/yyyy';
}

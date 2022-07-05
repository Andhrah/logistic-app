import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';

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

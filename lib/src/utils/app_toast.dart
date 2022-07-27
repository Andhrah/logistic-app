import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trakk/src/utils/singleton_data.dart';
import 'package:trakk/src/values/enums.dart';
import 'package:trakk/src/values/values.dart';

appToast(String message,
    {AppToastType appToastType = AppToastType.success,
    Color backgroundColor = appPrimaryColor}) {
  var context =
      SingletonData.singletonData.navKey.currentState!.overlay!.context;
  double maxWidth = MediaQuery.of(context).size.width / 1.4;
  return Flushbar(
    messageText: Text(
      message,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: whiteColor,
        fontSize: 14,
      ),
    ),
    margin: const EdgeInsets.only(top: 20.0),
    backgroundColor: appToastType == AppToastType.success
        ? green
        : appToastType == AppToastType.failed
            ? redColor
            : appToastType == AppToastType.normal
                ? appPrimaryColor
                : backgroundColor,
    maxWidth: maxWidth,
    flushbarPosition: FlushbarPosition.TOP,
    borderRadius: BorderRadius.circular(10),
    duration: const Duration(seconds: 3),
  ).show(context);
}

runToast(String message,
    {Toast length = Toast.LENGTH_SHORT,
    ToastGravity toastGravity = ToastGravity.BOTTOM,
    Color? backgroundColor,
    Color? textColor}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: length,
      backgroundColor: backgroundColor,
      textColor: textColor,
      timeInSecForIosWeb: length == Toast.LENGTH_SHORT ? 1 : 3,
      gravity: toastGravity);
}

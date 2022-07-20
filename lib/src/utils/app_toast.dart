import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/values/enums.dart';
import 'package:trakk/src/utils/singleton_data.dart';

//todo: change is success to an enum and make color optional
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
            : backgroundColor,
    maxWidth: maxWidth,
    flushbarPosition: FlushbarPosition.TOP,
    borderRadius: BorderRadius.circular(10),
    duration: const Duration(seconds: 3),
  ).show(context);
}

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:trakk/utils/colors.dart';

appToast(BuildContext context, String message, Color color) {
  return Flushbar(
    messageText: Text(
      message,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: whiteColor,
        fontSize: 18,
      ),
    ),
    margin: const EdgeInsets.only(top: 20.0),
    backgroundColor: color,
    maxWidth: MediaQuery.of(context).size.width/1.4,
    flushbarPosition: FlushbarPosition.TOP,
    borderRadius: BorderRadius.circular(10),
    duration: const Duration(seconds: 3),
  ).show(context);
}
/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */
import 'package:flutter/services.dart';
import 'package:trakk/utils/app_toast.dart';
import 'package:trakk/utils/enums.dart';

class CustomClipboard {
  /// copy receives a string text and saves to Clipboard
  /// returns void
  static Future<void> copy(String text) async {
    if (text.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: text));
      return;
    } else {
      appToast('Could not copy empty text', appToastType: AppToastType.failed);
      throw ('Please enter a string');
    }
  }

  /// Paste retrieves the data from clipboard.
  static Future<String> paste() async {
    var result = await Clipboard.getData('text/plain');
    ClipboardData data = result == null ? ClipboardData(text: '') : result;
    return data.text?.toString() ?? "";
  }

  /// controlC receives a string text and saves to Clipboard
  /// returns boolean value
  static Future<bool> controlC(String text) async {
    if (text.isNotEmpty) {
      await Clipboard.setData(ClipboardData(text: text));
      return true;
    } else {
      return false;
    }
  }

  /// controlV retrieves the data from clipboard.
  /// same as paste
  /// But returns dynamic data
  static Future<dynamic> controlV() async {
    return await Clipboard.getData('text/plain');
  }
}

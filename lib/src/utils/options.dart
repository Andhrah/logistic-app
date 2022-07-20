/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2021 [Zebrra]. All rights reserved.
    */

import 'package:flutter/material.dart';
import 'package:trakk/src/values/text_font/scales.dart';
import 'package:trakk/src/values/theme/themes.dart';

class SettingOptions {
  SettingOptions({
    this.theme,
    this.darkTheme,
    this.trakkThemeMode,
    this.textDirection = TextDirection.ltr,
    this.textScaleFactor,
    this.platform,
  });

  final TrakkThemeMode? trakkThemeMode;
  final TrakkTheme? theme;
  final TrakkTheme? darkTheme;
  final TextDirection textDirection;
  final TrakkTextScaleValue? textScaleFactor;
  final TargetPlatform? platform;

  SettingOptions copyWith({
    TrakkThemeMode? trakkThemeMode,
    TrakkTheme? theme,
    TrakkTheme? darkTheme,
    TextDirection? textDirection,
    TrakkTextScaleValue? textScaleFactor,
    TargetPlatform? platform,
  }) {
    return SettingOptions(
      theme: theme ?? this.theme,
      darkTheme: darkTheme ?? this.darkTheme,
      trakkThemeMode: trakkThemeMode ?? this.trakkThemeMode,
      textDirection: textDirection ?? this.textDirection,
      textScaleFactor: textScaleFactor ?? this.textScaleFactor,
      platform: platform ?? this.platform,
    );
  }

  @override
  bool operator ==(dynamic other) {
    if (runtimeType != other.runtimeType) return false;
    final SettingOptions typedOther = other;
    return darkTheme == typedOther.darkTheme &&
        theme == typedOther.theme &&
        trakkThemeMode == typedOther.trakkThemeMode &&
        textDirection == typedOther.textDirection &&
        textScaleFactor == typedOther.textScaleFactor &&
        platform == typedOther.platform;
  }

  @override
  int get hashCode => hashValues(
        theme,
        darkTheme,
        trakkThemeMode,
        textDirection,
        textScaleFactor,
        platform,
      );

  @override
  String toString() {
    return '$runtimeType($theme)';
  }
}

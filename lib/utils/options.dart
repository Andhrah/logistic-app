/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2021 [Zebrra]. All rights reserved.
    */

import 'package:flutter/material.dart';
import 'package:trakk/values/text_font/scales.dart';
import 'package:trakk/values/theme/themes.dart';

class SettingOptions {
  SettingOptions({
    this.theme,
    this.darkTheme,
    this.trakkThemeMode,
    this.textScaleFactor,
    this.platform,
  });

  final TrakkThemeMode? trakkThemeMode;
  final TrakkTheme? theme;
  final TrakkTheme? darkTheme;
  final TrakkTextScaleValue? textScaleFactor;
  final TargetPlatform? platform;

  SettingOptions copyWith({
    bool? notification,
    TrakkThemeMode? trakkThemeMode,
    TrakkTheme? theme,
    TrakkTheme? darkTheme,
    TrakkTextScaleValue? textScaleFactor,
    TextDirection? textDirection,
    double? timeDilation,
    TargetPlatform? platform,
    bool? showPerformanceOverlay,
    bool? showRasterCacheImagesCheckerboard,
    bool? showOffscreenLayersCheckerboard,
  }) {
    return SettingOptions(
      theme: theme ?? this.theme,
      darkTheme: darkTheme ?? this.darkTheme,
      trakkThemeMode: trakkThemeMode ?? this.trakkThemeMode,
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
        textScaleFactor == typedOther.textScaleFactor &&
        platform == typedOther.platform;
  }

  @override
  int get hashCode => hashValues(
        theme,
        darkTheme,
        trakkThemeMode,
        textScaleFactor,
        platform,
      );

  @override
  String toString() {
    return '$runtimeType($theme)';
  }
}

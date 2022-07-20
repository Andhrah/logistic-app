/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/values/font.dart';

// ThemeMode
class TrakkThemeMode {
  const TrakkThemeMode(this.themeMode, this.label, this.index);

  final ThemeMode themeMode;
  final String label;
  final int index;

  @override
  bool operator ==(dynamic other) {
    if (runtimeType != other.runtimeType) return false;
    final TrakkThemeMode typedOther = other;
    return themeMode == typedOther.themeMode &&
        index == typedOther.index &&
        label == typedOther.label;
  }

  @override
  int get hashCode => hashValues(themeMode, label, index);

  @override
  String toString() {
    return '$runtimeType($label)';
  }
}

const List<TrakkThemeMode> kAllTrakkThemeModeValues = <TrakkThemeMode>[
  TrakkThemeMode(ThemeMode.system, 'Default', 0),
  TrakkThemeMode(ThemeMode.dark, 'Dark', 1),
  TrakkThemeMode(ThemeMode.light, 'Light', 2),
];

// Themedata
class TrakkTheme {
  const TrakkTheme._(this.name, this.data);

  final String name;
  final ThemeData data;
}

final TrakkTheme kDarkTrakkTheme = TrakkTheme._('Dark', _buildDarkTheme());
final TrakkTheme kLightTrakkTheme = TrakkTheme._('Light', _buildLightTheme());

TextTheme _buildLightTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline6: base.headline6!.copyWith(
            fontFamily: kDefaultFontFamilyHeading,
            color: kTextColor,
            fontWeight: kRegularWeight,
            fontStyle: FontStyle.normal),
        headline5: base.headline5!.copyWith(
            fontFamily: kDefaultFontFamilyHeading,
            color: kTextColor,
            fontWeight: kRegularWeight,
            fontStyle: FontStyle.normal),
        headline4: base.headline4!.copyWith(
            fontFamily: kDefaultFontFamilyHeading,
            color: kTextColor,
            fontWeight: kRegularWeight,
            fontStyle: FontStyle.normal),
        headline3: base.headline3!.copyWith(
            fontFamily: kDefaultFontFamilyHeading,
            color: kTextColor,
            fontWeight: kRegularWeight,
            fontStyle: FontStyle.normal),
        headline2: base.headline2!.copyWith(
            fontFamily: kDefaultFontFamilyHeading,
            color: kTextColor,
            fontWeight: kRegularWeight,
            fontStyle: FontStyle.normal),
        headline1: base.headline1!.copyWith(
            fontFamily: kDefaultFontFamilyHeading,
            color: kTextColor,
            fontWeight: kRegularWeight,
            fontStyle: FontStyle.normal),
        subtitle2: base.subtitle2!.copyWith(
            color: kTextColor,
            fontWeight: kRegularWeight,
            fontFamily: kDefaultFontFamilyHeading,
            fontStyle: FontStyle.normal),
        subtitle1: base.subtitle1!.copyWith(
            color: kTextColor,
            fontWeight: kRegularWeight,
            fontFamily: kDefaultFontFamilyHeading,
            fontStyle: FontStyle.normal),
        button: base.button!.copyWith(
            color: kTextColor,
            fontWeight: kRegularWeight,
            fontFamily: kDefaultFontFamily,
            fontStyle: FontStyle.normal),
        bodyText2: base.bodyText2!.copyWith(
            color: kTextColor,
            fontWeight: kRegularWeight,
            fontFamily: kDefaultFontFamily,
            fontStyle: FontStyle.normal),
        bodyText1: base.bodyText1!.copyWith(
            fontWeight: kRegularWeight,
            color: kTextColor,
            fontFamily: kDefaultFontFamily,
            fontStyle: FontStyle.normal),
        overline: base.overline!.copyWith(
            color: kTextColor,
            fontWeight: kRegularWeight,
            fontFamily: kDefaultFontFamily,
            fontStyle: FontStyle.normal),
        caption: base.caption!.copyWith(
            color: kTextColor,
            fontWeight: kRegularWeight,
            fontFamily: kDefaultFontFamily,
            fontStyle: FontStyle.normal),
      )
      .apply(
        bodyColor: kTextColor,
      );
}

TextTheme _buildDarkTextTheme(TextTheme base) {
  return base.copyWith(
      headline6: base.headline6!.copyWith(
          fontFamily: kDefaultFontFamilyHeading,
          color: kDarkThemeTextColor,
          fontWeight: kRegularWeight,
          fontStyle: FontStyle.normal),
      headline5: base.headline5!.copyWith(
          fontFamily: kDefaultFontFamilyHeading,
          fontWeight: kRegularWeight,
          color: kDarkThemeTextColor,
          fontStyle: FontStyle.normal),
      headline4: base.headline4!.copyWith(
          fontFamily: kDefaultFontFamilyHeading,
          fontWeight: kRegularWeight,
          color: kDarkThemeTextColor,
          fontStyle: FontStyle.normal),
      headline3: base.headline3!.copyWith(
          fontFamily: kDefaultFontFamilyHeading,
          fontWeight: kRegularWeight,
          color: kDarkThemeTextColor,
          fontStyle: FontStyle.normal),
      headline2: base.headline2!.copyWith(
          fontFamily: kDefaultFontFamilyHeading,
          fontWeight: kRegularWeight,
          color: kDarkThemeTextColor,
          fontStyle: FontStyle.normal),
      headline1: base.headline1!.copyWith(
          fontFamily: kDefaultFontFamilyHeading,
          fontWeight: kRegularWeight,
          color: kDarkThemeTextColor,
          fontStyle: FontStyle.normal),
      subtitle2: base.subtitle2!.copyWith(
          color: kDarkThemeTextColor,
          fontWeight: kRegularWeight,
          fontFamily: kDefaultFontFamilyHeading,
          fontStyle: FontStyle.normal),
      subtitle1: base.subtitle1!.copyWith(
          color: kDarkThemeTextColor,
          fontWeight: kRegularWeight,
          fontFamily: kDefaultFontFamilyHeading,
          fontStyle: FontStyle.normal),
      button: base.button!.copyWith(
          color: kDarkThemeTextColor,
          fontWeight: kRegularWeight,
          fontFamily: kDefaultFontFamily,
          fontStyle: FontStyle.normal),
      bodyText2: base.bodyText2!.copyWith(
          color: kDarkThemeTextColor,
          fontWeight: kRegularWeight,
          fontFamily: kDefaultFontFamily,
          fontStyle: FontStyle.normal),
      bodyText1: base.bodyText1!.copyWith(
          color: kDarkThemeTextColor,
          fontWeight: kRegularWeight,
          fontFamily: kDefaultFontFamily,
          fontStyle: FontStyle.normal),
      overline: base.overline!.copyWith(
          color: kDarkThemeTextColor,
          fontWeight: kRegularWeight,
          fontFamily: kDefaultFontFamily,
          fontStyle: FontStyle.normal),
      caption: base.caption!.copyWith(
          color: kDarkThemeTextColor,
          fontWeight: kRegularWeight,
          fontFamily: kDefaultFontFamily,
          fontStyle: FontStyle.normal));
}

ThemeData _buildDarkTheme() {
  final ColorScheme colorScheme = const ColorScheme.dark().copyWith(
    primary: appPrimaryDarkColor,
    secondary: secondaryDarkColor,
  );
  final ThemeData base = ThemeData(
    brightness: Brightness.dark,
    colorScheme: colorScheme,
    primaryColor: appPrimaryDarkColor,
    indicatorColor: Colors.white,
    toggleableActiveColor: secondaryDarkColor,
    splashColor: Colors.grey,
    splashFactory: InkRipple.splashFactory,
    canvasColor: kDarkThemeBackgroundColor,
    scaffoldBackgroundColor: kDarkThemeBackgroundColor,
    backgroundColor: Colors.white,
    errorColor: redColor,
    primaryIconTheme: const IconThemeData(
      color: Colors.black,
    ),
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(color: labelColor, fontSize: 14),
      hintStyle: const TextStyle(color: hintColor, fontSize: 14),
      fillColor: kDarkThemeBackgroundColor,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: appPrimaryDarkColor.withOpacity(0.0),
          width: 0,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: appPrimaryDarkColor.withOpacity(00),
          width: 0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: redColor.withOpacity(0.8)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: secondaryColor.withOpacity(0.8)),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: appPrimaryDarkColor.withOpacity(0.0),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(kButtonColor),
      ),
    ),
    buttonTheme: const ButtonThemeData(
        colorScheme: ColorScheme.dark(
          primary: kButtonColor,
        ),
        textTheme: ButtonTextTheme.normal,
        buttonColor: kButtonColor),
    cardColor: Colors.white,
  );

  return base.copyWith(
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        titleTextStyle: base.textTheme.headline6!.copyWith(
          fontFamily: kDefaultFontFamily,
          color: kDarkThemeTextColor,
        ),
        actionsIconTheme: const IconThemeData(color: Colors.black)),
    toggleButtonsTheme:
        const ToggleButtonsThemeData(color: appPrimaryDarkColor),
    iconTheme: const IconThemeData(
      color: secondaryDarkColor,
    ),
    textTheme: _buildDarkTextTheme(base.textTheme),
    primaryTextTheme: _buildDarkTextTheme(base.primaryTextTheme),
    primaryIconTheme: base.primaryIconTheme.copyWith(
      color: secondaryDarkColor,
    ),
  );
}

ThemeData _buildLightTheme() {
  final ColorScheme colorScheme = const ColorScheme.light().copyWith(
    primary: appPrimaryColor,
    secondary: secondaryColor,
  );
  final ThemeData base = ThemeData(
      brightness: Brightness.light,
      colorScheme: colorScheme,
      primaryColor: appPrimaryColor,
      indicatorColor: Colors.black,
      toggleableActiveColor: secondaryColor,
      splashColor: Colors.grey,
      splashFactory: InkRipple.splashFactory,
      canvasColor: kBackgroundColor,
      scaffoldBackgroundColor: kBackgroundColor,
      backgroundColor: Colors.white,
      errorColor: redColor,
      primaryIconTheme: const IconThemeData(
        color: Colors.black,
      ),
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: const TextStyle(color: labelColor, fontSize: 14),
        hintStyle: const TextStyle(color: hintColor, fontSize: 14),
        fillColor: kDarkThemeBackgroundColor,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: appPrimaryColor.withOpacity(0.0),
            width: 0,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: appPrimaryColor.withOpacity(00),
            width: 0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: redColor.withOpacity(0.8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: secondaryColor.withOpacity(0.8)),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: appPrimaryColor.withOpacity(0.0),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(kButtonColor),
        ),
      ),
      buttonTheme: const ButtonThemeData(
          colorScheme: ColorScheme.light(primary: kButtonColor),
          textTheme: ButtonTextTheme.normal,
          buttonColor: kButtonColor),
      cardColor: Colors.white);

  return base.copyWith(
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        titleTextStyle: base.textTheme.headline6!.copyWith(
          fontFamily: kDefaultFontFamily,
          color: kTextColor,
        ),
        actionsIconTheme: const IconThemeData(color: Colors.black)),
    toggleButtonsTheme: const ToggleButtonsThemeData(color: appPrimaryColor),
    iconTheme: const IconThemeData(
      color: secondaryColor,
    ),
    textTheme: _buildLightTextTheme(base.textTheme),
    primaryTextTheme: _buildLightTextTheme(base.primaryTextTheme),
    primaryIconTheme: base.primaryIconTheme.copyWith(
      color: secondaryColor,
    ),
  );
}

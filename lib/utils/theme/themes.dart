// /*
// *
// *  Created by [Folarin Opeyemi].
// *  Copyright © 2022 [Zebrra]. All rights reserved.
//     */
//
// import 'package:flutter/material.dart';
// import 'package:trakk/utils/colors.dart';
// import 'package:trakk/utils/font.dart';
//
// // ThemeMode
// class GigXPadThemeMode {
//   const GigXPadThemeMode(this.themeMode, this.label, this.index);
//
//   final ThemeMode themeMode;
//   final String label;
//   final int index;
//
//   @override
//   bool operator ==(dynamic other) {
//     if (runtimeType != other.runtimeType) return false;
//     final GigXPadThemeMode typedOther = other;
//     return themeMode == typedOther.themeMode &&
//         index == typedOther.index &&
//         label == typedOther.label;
//   }
//
//   @override
//   int get hashCode => hashValues(themeMode, label, index);
//
//   @override
//   String toString() {
//     return '$runtimeType($label)';
//   }
// }
//
// const List<GigXPadThemeMode> kAllGigXPadThemeModeValues = <GigXPadThemeMode>[
//   GigXPadThemeMode(ThemeMode.system, 'Default', 0),
//   GigXPadThemeMode(ThemeMode.dark, 'Dark', 1),
//   GigXPadThemeMode(ThemeMode.light, 'Light', 2),
// ];
//
// // Themedata
// class GigXPadTheme {
//   const GigXPadTheme._(this.name, this.data);
//
//   final String name;
//   final ThemeData data;
// }
//
// final GigXPadTheme kDarkGigXPadTheme =
//     GigXPadTheme._('Dark', _buildDarkTheme());
// final GigXPadTheme kLightGigXPadTheme =
//     GigXPadTheme._('Light', _buildLightTheme());
//
// TextTheme _buildLightTextTheme(TextTheme base) {
//   return base
//       .copyWith(
//         headline6: base.headline6!.copyWith(
//             fontFamily: kDefaultFontFamilyHeading,
//             color: kTextColor,
//             fontWeight: kRegularWeight,
//             fontStyle: FontStyle.normal),
//         headline5: base.headline5!.copyWith(
//             fontFamily: kDefaultFontFamilyHeading,
//             color: kTextColor,
//             fontWeight: kRegularWeight,
//             fontStyle: FontStyle.normal),
//         headline4: base.headline4!.copyWith(
//             fontFamily: kDefaultFontFamilyHeading,
//             color: kTextColor,
//             fontWeight: kRegularWeight,
//             fontStyle: FontStyle.normal),
//         headline3: base.headline3!.copyWith(
//             fontFamily: kDefaultFontFamilyHeading,
//             color: kTextColor,
//             fontWeight: kRegularWeight,
//             fontStyle: FontStyle.normal),
//         headline2: base.headline2!.copyWith(
//             fontFamily: kDefaultFontFamilyHeading,
//             color: kTextColor,
//             fontWeight: kRegularWeight,
//             fontStyle: FontStyle.normal),
//         headline1: base.headline1!.copyWith(
//             fontFamily: kDefaultFontFamilyHeading,
//             color: kTextColor,
//             fontWeight: kRegularWeight,
//             fontStyle: FontStyle.normal),
//         subtitle2: base.subtitle2!.copyWith(
//             color: kTextColor,
//             fontWeight: kRegularWeight,
//             fontFamily: kDefaultFontFamilyHeading,
//             fontStyle: FontStyle.normal),
//         subtitle1: base.subtitle1!.copyWith(
//             color: kTextColor,
//             fontWeight: kRegularWeight,
//             fontFamily: kDefaultFontFamilyHeading,
//             fontStyle: FontStyle.normal),
//         button: base.button!.copyWith(
//             color: kTextColor,
//             fontWeight: kRegularWeight,
//             fontFamily: kDefaultFontFamily,
//             fontStyle: FontStyle.normal),
//         bodyText2: base.bodyText2!.copyWith(
//             color: kTextColor,
//             fontWeight: kRegularWeight,
//             fontFamily: kDefaultFontFamily,
//             fontStyle: FontStyle.normal),
//         bodyText1: base.bodyText1!.copyWith(
//             fontWeight: kRegularWeight,
//             color: kTextColor,
//             fontFamily: kDefaultFontFamily,
//             fontStyle: FontStyle.normal),
//         overline: base.overline!.copyWith(
//             color: kTextColor,
//             fontWeight: kRegularWeight,
//             fontFamily: kDefaultFontFamily,
//             fontStyle: FontStyle.normal),
//         caption: base.caption!.copyWith(
//             color: kTextColor,
//             fontWeight: kRegularWeight,
//             fontFamily: kDefaultFontFamily,
//             fontStyle: FontStyle.normal),
//       )
//       .apply(
//         bodyColor: kTextColor,
//       );
// }
//
// TextTheme _buildDarkTextTheme(TextTheme base) {
//   return base.copyWith(
//       headline6: base.headline6!.copyWith(
//           fontFamily: kDefaultFontFamilyHeading,
//           color: kDarkThemeTextColor,
//           fontWeight: kRegularWeight,
//           fontStyle: FontStyle.normal),
//       headline5: base.headline5!.copyWith(
//           fontFamily: kDefaultFontFamilyHeading,
//           fontWeight: kRegularWeight,
//           color: kDarkThemeTextColor,
//           fontStyle: FontStyle.normal),
//       headline4: base.headline4!.copyWith(
//           fontFamily: kDefaultFontFamilyHeading,
//           fontWeight: kRegularWeight,
//           color: kDarkThemeTextColor,
//           fontStyle: FontStyle.normal),
//       headline3: base.headline3!.copyWith(
//           fontFamily: kDefaultFontFamilyHeading,
//           fontWeight: kRegularWeight,
//           color: kDarkThemeTextColor,
//           fontStyle: FontStyle.normal),
//       headline2: base.headline2!.copyWith(
//           fontFamily: kDefaultFontFamilyHeading,
//           fontWeight: kRegularWeight,
//           color: kDarkThemeTextColor,
//           fontStyle: FontStyle.normal),
//       headline1: base.headline1!.copyWith(
//           fontFamily: kDefaultFontFamilyHeading,
//           fontWeight: kRegularWeight,
//           color: kDarkThemeTextColor,
//           fontStyle: FontStyle.normal),
//       subtitle2: base.subtitle2!.copyWith(
//           color: kDarkThemeTextColor,
//           fontWeight: kRegularWeight,
//           fontFamily: kDefaultFontFamilyHeading,
//           fontStyle: FontStyle.normal),
//       subtitle1: base.subtitle1!.copyWith(
//           color: kDarkThemeTextColor,
//           fontWeight: kRegularWeight,
//           fontFamily: kDefaultFontFamilyHeading,
//           fontStyle: FontStyle.normal),
//       button: base.button!.copyWith(
//           color: kDarkThemeTextColor,
//           fontWeight: kRegularWeight,
//           fontFamily: kDefaultFontFamily,
//           fontStyle: FontStyle.normal),
//       bodyText2: base.bodyText2!.copyWith(
//           color: kDarkThemeTextColor,
//           fontWeight: kRegularWeight,
//           fontFamily: kDefaultFontFamily,
//           fontStyle: FontStyle.normal),
//       bodyText1: base.bodyText1!.copyWith(
//           color: kDarkThemeTextColor,
//           fontWeight: kRegularWeight,
//           fontFamily: kDefaultFontFamily,
//           fontStyle: FontStyle.normal),
//       overline: base.overline!.copyWith(
//           color: kDarkThemeTextColor,
//           fontWeight: kRegularWeight,
//           fontFamily: kDefaultFontFamily,
//           fontStyle: FontStyle.normal),
//       caption: base.caption!.copyWith(
//           color: kDarkThemeTextColor,
//           fontWeight: kRegularWeight,
//           fontFamily: kDefaultFontFamily,
//           fontStyle: FontStyle.normal));
// }
//
// ThemeData _buildDarkTheme() {
//   final ColorScheme colorScheme = const ColorScheme.dark().copyWith(
//     primary: AppColors.primaryDarkBackground.withOpacity(0.8),
//     secondary: AppColors.secondaryDarkBackground.withOpacity(0.8),
//   );
//   final ThemeData base = ThemeData(
//     brightness: Brightness.dark,
//     accentColorBrightness: Brightness.dark,
//     primaryColor: AppColors.primaryDarkElement,
//     primaryColorDark: AppColors.primaryDarkBackground,
//     primaryColorLight: AppColors.primaryDarkBackground,
//     buttonColor: AppColors.primaryDarkButton,
//     indicatorColor: AppColors.secondaryText,
//     toggleableActiveColor: AppColors.secondaryDarkBackground,
//     accentColor: AppColors.secondaryDarkBackground,
//     splashColor: AppColors.primaryDarkButton,
//     splashFactory: InkRipple.splashFactory,
//     canvasColor: AppColors.secondaryDarkBackground,
//     scaffoldBackgroundColor: AppColors.primaryDarkBackground,
//     backgroundColor: AppColors.primaryDarkBackground,
//     errorColor: const Color(0xFFB00020),
//     inputDecorationTheme: InputDecorationTheme(
//         labelStyle: TextStyle(color: AppColors.secondaryText)),
//     iconTheme: IconThemeData(
//       color: AppColors.secondaryElement,
//     ),
//     buttonTheme: ButtonThemeData(
//         splashColor: AppColors.primaryElement,
//         colorScheme: const ColorScheme.dark().copyWith(
//             primary: AppColors.primaryDarkButton,
//             secondary: AppColors.secondaryDarkButton),
//         textTheme: ButtonTextTheme.primary,
//         buttonColor: AppColors.primaryDarkButton),
//     cardColor: AppColors.primaryBackground.withOpacity(0.4),
//     textSelectionColor: AppColors.secondaryText,
//     textSelectionTheme: TextSelectionThemeData(
//         selectionColor: Colors.white54,
//         cursorColor: AppColors.white,
//         selectionHandleColor: AppColors.white),
//   );
//   return base.copyWith(
//     appBarTheme: AppBarTheme(
//         color: AppColors.primaryElement,
//         brightness: Brightness.light,
//         iconTheme: IconThemeData(
//           color: AppColors.secondaryDarkElement.withOpacity(0.8),
//         ),
//         textTheme: TextTheme(
//           headline6: base.textTheme.headline6!.copyWith(
//               fontFamily: kDefaultFontFamily, fontStyle: FontStyle.normal),
//         ),
//         actionsIconTheme: IconThemeData(
//             color: AppColors.secondaryDarkElement.withOpacity(0.8))),
//     textTheme: _buildLightTextTheme(base.textTheme),
//     iconTheme: IconThemeData(
//       color: AppColors.secondaryElement,
//     ),
//     accentIconTheme: IconThemeData(
//       color: AppColors.secondaryElement,
//     ),
//     toggleButtonsTheme:
//         ToggleButtonsThemeData(color: AppColors.primaryDarkElement),
//     buttonColor: AppColors.primaryElement,
//     primaryTextTheme: _buildLightTextTheme(base.primaryTextTheme),
//     accentTextTheme: _buildLightTextTheme(base.accentTextTheme),
//     primaryIconTheme: base.primaryIconTheme.copyWith(
//       color: AppColors.secondaryElement,
//     ),
//   );
// }
//
// ThemeData _buildLightTheme() {
//   final ColorScheme colorScheme = const ColorScheme.light().copyWith(
//     primary: AppColors.primaryElement,
//     secondary: AppColors.secondaryElement,
//   );
//   final ThemeData base = ThemeData(
//     brightness: Brightness.light,
//     accentColorBrightness: Brightness.light,
//     colorScheme: colorScheme,
//     primaryColor: AppColors.primaryElement,
//     buttonColor: AppColors.primaryButton,
//     indicatorColor: Colors.black,
//     toggleableActiveColor: AppColors.secondaryElement,
//     splashColor: AppColors.grey,
//     splashFactory: InkRipple.splashFactory,
//     accentColor: AppColors.secondaryElement,
//     canvasColor: AppColors.primaryBackground,
//     scaffoldBackgroundColor: AppColors.primaryBackground,
//     backgroundColor: AppColors.white,
//     errorColor: const Color(0xFFB00020),
//     accentIconTheme: IconThemeData(color: AppColors.secondaryElement),
//     primaryIconTheme: IconThemeData(
//       color: AppColors.secondaryElement,
//     ),
//     iconTheme: IconThemeData(
//       color: AppColors.secondaryElement,
//     ),
//     inputDecorationTheme: InputDecorationTheme(
//       labelStyle: TextStyle(color: Colors.black),
//     ),
//     buttonTheme: ButtonThemeData(
//         splashColor: AppColors.grey,
//         colorScheme: const ColorScheme.light().copyWith(
//             primary: AppColors.primaryButton,
//             secondary: AppColors.secondaryButton),
//         textTheme: ButtonTextTheme.normal,
//         buttonColor: AppColors.primaryButton),
//     cardColor: AppColors.secondaryText,
//     textSelectionColor: Colors.black45,
//     textSelectionTheme: TextSelectionThemeData(
//         selectionColor: Colors.white54,
//         cursorColor: Colors.white,
//         selectionHandleColor: Colors.white),
//   );
//
//   return base.copyWith(
//     appBarTheme: AppBarTheme(
//         color: AppColors.primaryDarkElement,
//         brightness: Brightness.dark,
//         iconTheme: IconThemeData(
//           color: AppColors.secondaryDarkText,
//         ),
//         textTheme: TextTheme(
//           headline6: base.textTheme.headline6!.copyWith(
//             fontFamily: kDefaultFontFamily,
//             color: AppColors.secondaryDarkText,
//           ),
//         ),
//         actionsIconTheme: IconThemeData(color: AppColors.secondaryDarkText)),
//     buttonColor: AppColors.primaryButton,
//     toggleButtonsTheme:
//         ToggleButtonsThemeData(color: AppColors.primaryDarkElement),
//     iconTheme: IconThemeData(
//       color: AppColors.secondaryDarkElement,
//     ),
//     accentIconTheme: IconThemeData(
//       color: AppColors.secondaryDarkElement,
//     ),
//     textTheme: _buildDarkTextTheme(base.textTheme),
//     primaryTextTheme: _buildDarkTextTheme(base.primaryTextTheme),
//     accentTextTheme: _buildDarkTextTheme(base.accentTextTheme),
//     primaryIconTheme: base.primaryIconTheme.copyWith(
//       color: AppColors.secondaryDarkElement,
//     ),
//   );
// }

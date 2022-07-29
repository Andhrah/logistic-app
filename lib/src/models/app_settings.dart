/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'dart:ui';

import 'package:trakk/src/models/auth_response.dart';

class AppSettings {
  bool hasViewedAppTour;
  bool isLoggedIn;
  AuthResponse? loginResponse;
  bool isPersistentLogin;
  bool biometricsEnabled;
  int themeModeIndex;

  AppSettings(
      {this.hasViewedAppTour = false,
      this.biometricsEnabled = false,
      this.isLoggedIn = false,
      this.isPersistentLogin = false,
      this.loginResponse,
      this.themeModeIndex = 0});

  AppSettings copyWith(
      {bool? hasViewedAppTour,
      bool? isLoggedIn,
      AuthResponse? loginResponse,
      bool? isPersistentLogin,
      bool? biometricsEnabled,
      int? themeModeIndex}) {
    return AppSettings(
      hasViewedAppTour: hasViewedAppTour ?? this.hasViewedAppTour,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      loginResponse: loginResponse ?? this.loginResponse,
      biometricsEnabled: biometricsEnabled ?? this.biometricsEnabled,
      isPersistentLogin: isPersistentLogin ?? this.isPersistentLogin,
      themeModeIndex: themeModeIndex ?? this.themeModeIndex,
    );
  }

  @override
  bool operator ==(dynamic other) {
    if (runtimeType != other.runtimeType) return false;
    final AppSettings typedOther = other;
    return hasViewedAppTour == typedOther.hasViewedAppTour &&
        isLoggedIn == typedOther.isLoggedIn &&
        biometricsEnabled == typedOther.biometricsEnabled &&
        loginResponse == typedOther.loginResponse &&
        isPersistentLogin == typedOther.isPersistentLogin &&
        themeModeIndex == typedOther.themeModeIndex;
  }

  @override
  int get hashCode => hashValues(hasViewedAppTour, isLoggedIn,
      biometricsEnabled, loginResponse, isPersistentLogin, themeModeIndex);

  @override
  String toString() {
    return '$runtimeType';
  }

  factory AppSettings.fromJson(Map<String, dynamic> data) => AppSettings(
        hasViewedAppTour: data['hasViewedAppTour'] ?? false,
        biometricsEnabled: data['biometricsEnabled'] ?? false,
        isPersistentLogin: data['isPersistentLogin'] ?? false,
        isLoggedIn: data['isLoggedIn'] ?? false,
        loginResponse: data['loginResponse'] == null
            ? null
            : AuthResponse.fromJson(data['loginResponse']),
        themeModeIndex:
            data['themeModeIndex'] == null ? 0 : data['themeModeIndex'],
      );

  Map<String, dynamic> toMap() => {
        'hasViewedAppTour': hasViewedAppTour,
        "isPersistentLogin": isPersistentLogin,
        'biometricsEnabled': biometricsEnabled,
        "isLoggedIn": isLoggedIn,
        'loginResponse': loginResponse != null ? loginResponse!.toJson() : null,
        'themeModeIndex': themeModeIndex,
      };

  removeAccount({bool removeLoginData = true}) {
    isLoggedIn = false;

    isPersistentLogin = false;
    if (removeLoginData) {
      loginResponse = null;
    }
  }
}

/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'package:trakk/models/auth_response.dart';

class AppSettings {
  bool hasViewedAppTour;
  bool isLoggedIn;
  AuthResponse? loginResponse;
  bool isPersistentLogin;

  AppSettings(
      {this.hasViewedAppTour = false,
      this.isLoggedIn = false,
      this.isPersistentLogin = false,
      this.loginResponse});

  factory AppSettings.fromJson(Map<String, dynamic> data) => AppSettings(
        hasViewedAppTour: data['hasViewedAppTour'] ?? false,
        isPersistentLogin: data['isPersistentLogin'] ?? false,
        isLoggedIn: data['isLoggedIn'] ?? false,
        loginResponse: data['loginResponse'] == null
            ? null
            : AuthResponse.fromJson(data['loginResponse']),
      );

  Map<String, dynamic> toMap() => {
        'hasViewedAppTour': hasViewedAppTour,
        "isPersistentLogin": isPersistentLogin,
        "isLoggedIn": isLoggedIn,
        'loginResponse': loginResponse != null ? loginResponse!.toJson() : null,
      };

  removeAccount({bool removeLoginData = true}) {
    isLoggedIn = false;
    isPersistentLogin = false;
    if (removeLoginData) {
      loginResponse = null;
    }
  }
}

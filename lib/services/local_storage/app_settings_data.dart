/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'dart:convert';

import 'package:trakk/models/app_settings.dart';
import 'package:trakk/models/auth_response.dart';
import 'package:trakk/utils/singleton_data.dart';

class AppSettingsProvider {
  Future<AppSettings> markAppTourViewed() async {
    AppSettings appSettings = await fetchAppSettings();
    appSettings.hasViewedAppTour = true;
    return await _saveAppSettings(appSettings);
  }

  Future<AppSettings> _saveAppSettings(AppSettings appSettings) async {
    var preferences = await SingletonData.singletonData.preferences;
    preferences.setString(
        'zebrra_app_settings', json.encode(appSettings.toMap()));

    return appSettings;
  }

  Future<AppSettings> fetchAppSettings() async {
    var preferences = await SingletonData.singletonData.preferences;

    AppSettings appSettings = AppSettings();
    String? settingsData = preferences.getString('zebrra_app_settings');
    if (settingsData != null && settingsData.isNotEmpty) {
      appSettings = AppSettings.fromJson(
          Map<String, dynamic>.from(json.decode(settingsData)));
    }
    return appSettings;
  }

  Future<AppSettings> saveLoginDetails(AuthResponse? loginResponse,
      {bool isLoggedIn = true}) async {
    AppSettings appSettings = await fetchAppSettings();

    appSettings.loginResponse = loginResponse;
    appSettings.isLoggedIn = isLoggedIn;

    return await _saveAppSettings(appSettings);
  }

  Future<AppSettings> setPersistentLogin(bool value) async {
    AppSettings appSettings = await fetchAppSettings();

    appSettings.isPersistentLogin = value;

    return await _saveAppSettings(appSettings);
  }

  Future<AppSettings> setLogOut() async {
    AppSettings appSettings = await fetchAppSettings();
    appSettings.removeAccount();

    return await _saveAppSettings(appSettings);
  }
}

final appSettingsProvider = AppSettingsProvider();

/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'package:rxdart/rxdart.dart';
import 'package:trakk/models/app_settings.dart';
import 'package:trakk/models/auth_response.dart';
import 'package:trakk/services/local_storage/app_settings_provider.dart';
import 'package:trakk/utils/enums.dart';

class _AppSettingsBloc {
  final BehaviorSubject<AppSettings> _appSettingsStreamController =
      BehaviorSubject<AppSettings>();

  BehaviorSubject<AppSettings> get appSettings => _appSettingsStreamController;

  void dispose() => _appSettingsStreamController.close();

  Future<AppSettings> fetchAppSettings() async {
    AppSettings appSettings = await appSettingsProvider.fetchAppSettings();
    _appSettingsStreamController.sink.add(appSettings);

    return appSettings;
  }

  markAppTourViewed() async {
    var saved = await appSettingsProvider.markAppTourViewed();
    _appSettingsStreamController.sink.add(saved);
  }

  saveLoginDetails(AuthResponse authResponse, {bool isLoggedIn = true}) {
    appSettingsProvider
        .saveLoginDetails(authResponse, isLoggedIn: isLoggedIn)
        .then((result) {
      _appSettingsStreamController.sink.add(result);
    });
  }

  setPersistentLogin(bool setRememberMe) async {
    var saved = await appSettingsProvider.setPersistentLogin(setRememberMe);
    _appSettingsStreamController.sink.add(saved);
  }

  setLogOut() async {
    var saved = await appSettingsProvider.setLogOut();
    _appSettingsStreamController.sink.add(saved);
  }

  //getters
  Future<String> get getToken async {
    var appSettings = await appSettingsProvider.fetchAppSettings();

    String token = appSettings.loginResponse?.data?.token ?? '';

    return token;
  }

  Future<String> get getUserID async {
    var appSettings = await appSettingsProvider.fetchAppSettings();

    String id = '${appSettings.loginResponse?.data?.user?.id ?? ''}';

    return id;
  }

  //getters
  Future<UserType> get getUserType async {
    var appSettings = await appSettingsProvider.fetchAppSettings();

    switch (appSettings.loginResponse?.data?.user?.userType ?? '') {
      case 'user':
        return UserType.user;
      case 'rider':
        return UserType.rider;
      case 'merchant':
        return UserType.merchant;
      case 'guest':
        return UserType.guest;
      default:
        return UserType.guest;
    }
  }
}

final appSettingsBloc = _AppSettingsBloc();

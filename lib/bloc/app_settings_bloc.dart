/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'package:rxdart/rxdart.dart';
import 'package:trakk/models/app_settings.dart';
import 'package:trakk/models/auth_response.dart';
import 'package:trakk/services/local_storage/app_settings_data.dart';
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

    String id = '';

    UserType userType = await getUserType;

    switch (userType) {
      case UserType.customer:
        id = '${appSettings.loginResponse?.data?.user?.id ?? ''}';

        break;
      case UserType.rider:
        id = '${appSettings.loginResponse?.data?.user?.rider?.id ?? ''}';

        break;
      case UserType.guest:
        // TODO: Handle this case.
        break;
      case UserType.merchant:
        id = '${appSettings.loginResponse?.data?.user?.merchant?.id ?? ''}';

        break;
      case UserType.none:
        // TODO: Handle this case.
        break;
    }

    return id;
  }

  //getters
  Future<UserType> get getUserType async {
    var appSettings = await appSettingsProvider.fetchAppSettings();

    switch (appSettings.loginResponse?.data?.user?.userType ?? '') {
      case 'customer':
        return UserType.customer;
      case 'rider':
        return UserType.rider;
      case 'merchant':
        return UserType.merchant;
      case 'guest':
        return UserType.guest;
      default:
        return UserType.none;
    }
  }
}

final appSettingsBloc = _AppSettingsBloc();

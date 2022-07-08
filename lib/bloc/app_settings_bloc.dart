/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'package:rxdart/rxdart.dart';
import 'package:trakk/models/app_settings.dart';
import 'package:trakk/models/auth_response.dart';
import 'package:trakk/services/local_storage/app_settings_provider.dart';

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

  saveLoginDetails(AuthResponse loginResponse, {bool isLoggedIn = true}) {
    appSettingsProvider
        .saveLoginDetails(loginResponse, isLoggedIn: isLoggedIn)
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
}

final appSettingsBloc = _AppSettingsBloc();

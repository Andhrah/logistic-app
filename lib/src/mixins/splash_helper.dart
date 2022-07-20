/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'dart:async';

import 'package:trakk/src/bloc/app_settings_bloc.dart';
import 'package:trakk/src/models/app_settings.dart';
import 'package:trakk/src/screens/auth/login.dart';
import 'package:trakk/src/screens/onboarding/get_started.dart';
import 'package:trakk/src/screens/onboarding/onboarding.dart';
import 'package:trakk/src/screens/tab.dart';
import 'package:trakk/src/utils/singleton_data.dart';

class SplashHelper {
  Future checkFirstScreen() async {
    AppSettings appSettings = await appSettingsBloc.fetchAppSettings();

    Timer(const Duration(milliseconds: 0), () {
      if (appSettings.hasViewedAppTour) {
        if (appSettings.isLoggedIn) {
          _navigationHomePage();
        } else {
          _navigationToLandingPage();
        }
      } else {
        appSettingsBloc.markAppTourViewed();
        _navigationToOnBoardingPage();
      }
    });
  }

  _navigationToLogin() {
    _navigationToLandingPage();
    SingletonData.singletonData.navKey.currentState!.pushNamed(Login.id);
  }

  _navigationHomePage() async {
    _navigationToLandingPage();
    AppSettings appSettings = await appSettingsBloc.fetchAppSettings();
    if (appSettings.isLoggedIn &&
        appSettings.loginResponse != null &&
        appSettings.loginResponse!.data != null) {
      SingletonData.singletonData.navKey.currentState!.pushNamed(Tabs.id);
    }
  }

  _navigationToLandingPage() async {
    SingletonData.singletonData.navKey.currentState!.pushNamed(GetStarted.id);
  }

  _navigationToOnBoardingPage() async {
    SingletonData.singletonData.navKey.currentState!.pushNamed(Onboarding.id);
  }
}

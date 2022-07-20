/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'package:flutter/material.dart';
import 'package:trakk/src/bloc/app_settings_bloc.dart';
import 'package:trakk/src/provider/rider/rider_map_provider.dart';
import 'package:trakk/src/screens/auth/login.dart';
import 'package:trakk/src/screens/onboarding/get_started.dart';
import 'package:trakk/src/values/enums.dart';
import 'package:trakk/src/utils/singleton_data.dart';

typedef CompleteLogout();

class LogoutHelper {
  CompleteLogout? _completeLogout;

  logout(BuildContext context, {CompleteLogout? completeLogout}) async {
    _completeLogout = completeLogout;

    _doLogout();

    _completeLogout!();
  }

  _doLogout() async {
    UserType userType = await appSettingsBloc.getUserType;
    if (userType == UserType.merchant) {
      var injector = RiderMapProvider.riderMapProvider(
          SingletonData.singletonData.navKey.currentState!.context);
      injector.disconnectSocket();
    }
    await appSettingsBloc.setLogOut();
  }

  logoutGlobal() async {
    await _doLogout();
    SingletonData.singletonData.navKey.currentState!
        .popUntil(ModalRoute.withName(GetStarted.id));
    SingletonData.singletonData.navKey.currentState!.pushNamed(Login.id);
  }
}
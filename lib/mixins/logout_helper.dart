/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'package:flutter/material.dart';
import 'package:trakk/bloc/app_settings_bloc.dart';
import 'package:trakk/screens/auth/login.dart';
import 'package:trakk/screens/onboarding/get_started.dart';
import 'package:trakk/utils/singleton_data.dart';

typedef CompleteLogout();

class LogoutHelper {
  CompleteLogout? _completeLogout;

  logout(BuildContext context, {CompleteLogout? completeLogout}) async {
    _completeLogout = completeLogout;

    _doLogout();

    _completeLogout!();
  }

  _doLogout() async {
    await appSettingsBloc.setLogOut();
  }

  logoutGlobal() async {
    await _doLogout();
    SingletonData.singletonData.navKey.currentState!
        .popUntil(ModalRoute.withName(GetStarted.id));
    SingletonData.singletonData.navKey.currentState!.pushNamed(Login.id);
  }
}

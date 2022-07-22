/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'package:flutter/material.dart';
import 'package:trakk/src/bloc/app_settings_bloc.dart';
import 'package:trakk/src/mixins/connectivity_helper.dart';
import 'package:trakk/src/models/auth_response.dart';
import 'package:trakk/src/models/message_only_response.dart';
import 'package:trakk/src/screens/auth/verify_account.dart';
import 'package:trakk/src/screens/tab.dart';
import 'package:trakk/src/services/auth/login_service.dart';
import 'package:trakk/src/utils/app_toast.dart';
import 'package:trakk/src/utils/singleton_data.dart';
import 'package:trakk/src/values/enums.dart';

import '../utils/operation.dart';

typedef LoginCompleted = Function(AuthResponse loginResponse);

class LoginHelper with ConnectivityHelper {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailCC = TextEditingController();
  TextEditingController passwordCC = TextEditingController();

  bool _isPersistentLogin = false;

  doLoginOperation(bool isPersistentLogin, Function() onShowLoader,
      Function() onCloseLoader) async {
    _isPersistentLogin = isPersistentLogin;

    if (formKey.currentState!.validate()) {
      onShowLoader();
      loginService
          .doLogin(emailCC.text.trim(), passwordCC.text)
          .then((value) => _completeLogin(value, onCloseLoader));
    }
  }

  _completeLogin(Operation operation, Function() onCloseLoader) async {
    onCloseLoader();
    if (operation.code == 200 || operation.code == 201) {
      passwordCC.clear();
      AuthResponse authResponse = AuthResponse.fromJson(operation.result);
      await appSettingsBloc.saveLoginDetails(authResponse);

      if ((authResponse.data?.user?.confirmed ?? false) == true) {
        await appToast('Login Successful', appToastType: AppToastType.success);
        SingletonData.singletonData.navKey.currentState!.pushNamed(Tabs.id);
      } else {
        await appToast('Login Successful, please verify your account',
            appToastType: AppToastType.success);
        SingletonData.singletonData.navKey.currentState!
            .pushNamed(VerifiyAccountScreen.id, arguments: {
          "email": authResponse.data?.user?.email ?? '',
          "phoneNumber": authResponse.data?.user?.phoneNumber ?? '',
          'userType': authResponse.data?.user?.userType ?? ''
        });
      }
    } else {
      MessageOnlyResponse error = operation.result;

      appToast(error.message ?? '', appToastType: AppToastType.failed);
    }
  }
}

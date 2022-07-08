/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'package:flutter/material.dart';
import 'package:trakk/bloc/app_settings_bloc.dart';
import 'package:trakk/mixins/connectivity_helper.dart';
import 'package:trakk/models/auth_response.dart';
import 'package:trakk/models/message_only_response.dart';
import 'package:trakk/screens/auth/verify_account.dart';
import 'package:trakk/screens/tab.dart';
import 'package:trakk/services/auth/login_service.dart';
import 'package:trakk/utils/app_toast.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/utils/singleton_data.dart';

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
      AuthResponse authResponse = AuthResponse.fromJson(operation.result);
      await appSettingsBloc.saveLoginDetails(authResponse);

      if ((authResponse.data?.user?.confirmed ?? false) == true) {
        await appToast('Login Successful', green);
        SingletonData.singletonData.navKey.currentState!.pushNamed(Tabs.id);
      } else {
        await appToast('Login Successful, please verify your account', green);
        SingletonData.singletonData.navKey.currentState!
            .pushNamed(VerifiyAccountScreen.id, arguments: {
          "email": authResponse.data?.user?.email ?? '',
          "phoneNumber": authResponse.data?.user?.phoneNumber ?? ''
        });
      }
    } else {
      MessageOnlyResponse error = operation.result;

      appToast(error.message ?? '', redColor);
    }
  }
}

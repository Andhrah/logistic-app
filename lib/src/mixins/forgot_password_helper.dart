/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'package:flutter/material.dart';
import 'package:trakk/src/mixins/connectivity_helper.dart';
import 'package:trakk/src/models/auth_response.dart';
import 'package:trakk/src/models/message_only_response.dart';
import 'package:trakk/src/screens/auth/login.dart';
import 'package:trakk/src/services/auth/forgot_password_service.dart';
import 'package:trakk/src/utils/app_toast.dart';
import 'package:trakk/src/values/enums.dart';
import 'package:trakk/src/utils/singleton_data.dart';

import '../utils/operation.dart';

typedef LoginCompleted = Function(AuthResponse loginResponse);

class ForgotPasswordHelper with ConnectivityHelper {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailCC = TextEditingController();

  TextEditingController passwordCC = TextEditingController();
  TextEditingController confirmPasswordCC = TextEditingController();

  doForgotPasswordOperation(
      Function() onShowLoader, Function() onCloseLoader) async {
    if (formKey.currentState!.validate()) {
      onShowLoader();
      forgotPasswordService
          .doForgetPassword(emailCC.text.trim())
          .then((value) => _completeForgotPassword(value, onCloseLoader));
    }
  }

  _completeForgotPassword(Operation operation, Function() onCloseLoader) async {
    onCloseLoader();
    if (operation.code == 200 || operation.code == 201) {
      MessageOnlyResponse messageOnlyResponse =
          MessageOnlyResponse.fromJson(operation.result);

      await appToast(messageOnlyResponse.message ?? '',
          appToastType: AppToastType.success);
    } else {
      MessageOnlyResponse error = operation.result;

      appToast(error.message ?? '', appToastType: AppToastType.failed);
    }
  }

  doResetPasswordOperation(
      String code, Function() onShowLoader, Function() onCloseLoader) async {
    if (formKey.currentState!.validate()) {
      onShowLoader();
      forgotPasswordService
          .doResetPassword(code, passwordCC.text, confirmPasswordCC.text)
          .then((value) => _completeResetPassword(value, onCloseLoader));
    }
  }

  _completeResetPassword(Operation operation, Function() onCloseLoader) async {
    onCloseLoader();
    if (operation.code == 200 || operation.code == 201) {
      MessageOnlyResponse messageOnlyResponse =
          MessageOnlyResponse.fromJson(operation.result);

      await appToast(messageOnlyResponse.message ?? '',
          appToastType: AppToastType.success);
      SingletonData.singletonData.navKey.currentState!.pushNamed(Login.id);
    } else {
      MessageOnlyResponse error = operation.result;

      appToast(error.message ?? '', appToastType: AppToastType.failed);
    }
  }
}

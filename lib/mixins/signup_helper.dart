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
import 'package:trakk/screens/auth/merchant/company_data.dart';
import 'package:trakk/screens/auth/verify_account.dart';
import 'package:trakk/screens/tab.dart';
import 'package:trakk/services/auth/login_service.dart';
import 'package:trakk/services/auth/signup_service.dart';
import 'package:trakk/utils/app_toast.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/utils/enums.dart';
import 'package:trakk/utils/singleton_data.dart';

import '../utils/operation.dart';

typedef LoginCompleted = Function(AuthResponse loginResponse);

class SignupHelper with ConnectivityHelper {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController firstNameController = TextEditingController();
  late TextEditingController lastNameController = TextEditingController();
  late TextEditingController emailController = TextEditingController();
  late TextEditingController phoneNumberController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();

  doSignUpOperation(String userType, Function() onShowLoader,
      Function() onCloseLoader) async {
    if (formKey.currentState!.validate()) {
      onShowLoader();
      signupService
          .doSignUp(
              firstNameController.text.trim(),
              lastNameController.text.trim(),
              emailController.text.trim(),
              phoneNumberController.text.trim(),
              passwordController.text,
              userType)
          .then((value) => _completeLogin(value, userType, onCloseLoader));
    }
  }

  _completeLogin(
      Operation operation, String userType, Function() onCloseLoader) async {
    onCloseLoader();
    if (operation.code == 200 || operation.code == 201) {
      // AuthResponse authResponse = AuthResponse.fromJson(operation.result);
      // await appSettingsBloc.saveLoginDetails(authResponse);

      MessageOnlyResponse messageOnlyResponse =
          MessageOnlyResponse.fromJson(operation.result);

      await appToast(
          'Your account has been created and ' +
              (messageOnlyResponse.message ?? ''),
          green);

      SingletonData.singletonData.navKey.currentState!
          .pushNamed(VerifiyAccountScreen.id, arguments: {
        "email": emailController.text,
        "phoneNumber": phoneNumberController.text,
        'userType': userType
      });
    } else {
      MessageOnlyResponse error = operation.result;

      appToast(error.message ?? '', redColor);
    }
  }

  doVerifyOperation(String userType, String code, String email,
      Function() onShowLoader, Function() onCloseLoader) async {
    if (formKey.currentState!.validate()) {
      onShowLoader();
      signupService
          .doVerify(code, email)
          .then((value) => _completeVerify(value, userType, onCloseLoader));
    }
  }

  _completeVerify(
      Operation operation, String userType, Function() onCloseLoader) async {
    onCloseLoader();
    if (operation.code == 200 || operation.code == 201) {
      if (userType == UserType.merchant.value) {
        SingletonData.singletonData.navKey.currentState!
            .pushNamed(CompanyData.id);
      } else {
        SingletonData.singletonData.navKey.currentState!.pushNamed(Tabs.id);
      }
    } else {
      MessageOnlyResponse error = operation.result;

      appToast(error.message ?? '', redColor);
    }
  }

  doResendOTPOperation(String email, String phoneNumber,
      Function() onShowLoader, Function() onCloseLoader) async {
    if (formKey.currentState!.validate()) {
      onShowLoader();
      signupService
          .doResendOTP(email, phoneNumber)
          .then((value) => _completeResendOTP(value, onCloseLoader));
    }
  }

  _completeResendOTP(Operation operation, Function() onCloseLoader) async {
    onCloseLoader();
    if (operation.code == 200 || operation.code == 201) {
      // AuthResponse authResponse = AuthResponse.fromJson(operation.result);
      // await appSettingsBloc.saveLoginDetails(authResponse);

      MessageOnlyResponse messageOnlyResponse =
          MessageOnlyResponse.fromJson(operation.result);
      await appToast(
        (messageOnlyResponse.message ?? ''),
        green,
      );
    } else {
      MessageOnlyResponse error = operation.result;

      appToast(error.message ?? '', redColor);
    }
  }
}

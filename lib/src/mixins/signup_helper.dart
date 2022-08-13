/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'package:flutter/material.dart';
import 'package:trakk/src/bloc/app_settings_bloc.dart';
import 'package:trakk/src/mixins/connectivity_helper.dart';
import 'package:trakk/src/mixins/logout_helper.dart';
import 'package:trakk/src/models/auth/signup_model.dart';
import 'package:trakk/src/models/auth_response.dart';
import 'package:trakk/src/models/message_only_response.dart';
import 'package:trakk/src/screens/auth/login.dart';
import 'package:trakk/src/screens/auth/merchant/company_data.dart';
import 'package:trakk/src/screens/auth/verify_account.dart';
import 'package:trakk/src/screens/onboarding/get_started.dart';
import 'package:trakk/src/services/auth/signup_service.dart';
import 'package:trakk/src/utils/app_toast.dart';
import 'package:trakk/src/utils/singleton_data.dart';
import 'package:trakk/src/values/enums.dart';

import '../utils/operation.dart';

typedef LoginCompleted = Function(AuthResponse loginResponse);

class SignupHelper with ConnectivityHelper, LogoutHelper {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController firstNameController = TextEditingController();
  late TextEditingController lastNameController = TextEditingController();
  late TextEditingController emailController = TextEditingController();
  late TextEditingController phoneNumberController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();

  late TextEditingController nameController = TextEditingController();
  late TextEditingController rcNumberController = TextEditingController();

  disposeControllers() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    nameController.dispose();
    rcNumberController.dispose();
  }

  doSignUpOperation(String userType, Function() onShowLoader,
      Function() onCloseLoader) async {
    if (formKey.currentState!.validate()) {
      onShowLoader();
      signupService
          .doSignUp(
            SignupModel(
                firstName: firstNameController.text.trim(),
                lastName: lastNameController.text.trim(),
                email: emailController.text.trim(),
                phoneNumber: phoneNumberController.text.trim(),
                password: passwordController.text,
                userType: userType),
          )
          .then((value) => _completeLogin(value, userType, onCloseLoader));
    }
  }

  _completeLogin(
      Operation operation, String userType, Function() onCloseLoader) async {
    onCloseLoader();
    if (operation.code == 200 || operation.code == 201) {
      AuthResponse authResponse = AuthResponse.fromJson(operation.result);
      await appSettingsBloc.saveLoginDetails(authResponse);

      await appToast(
          'Your account has been created'
          // +
          // (messageOnlyResponse.message ?? ''
          // )
          ,
          appToastType: AppToastType.success);

      SingletonData.singletonData.navKey.currentState!
          .pushNamed(VerifyAccountScreen.id, arguments: {
        "email": emailController.text,
        "phoneNumber": phoneNumberController.text,
        'userType': userType
      });
    } else {
      MessageOnlyResponse error = operation.result;

      appToast(error.message ?? '', appToastType: AppToastType.failed);
    }
  }

  doVerifyOperation(String code, String email, Function() onShowLoader,
      Function() onCloseLoader) async {
    onShowLoader();
    signupService
        .doVerify(code, email)
        .then((value) => _completeVerify(value, onCloseLoader));
  }

  _completeVerify(Operation operation, Function() onCloseLoader) async {
    if (operation.code == 200 || operation.code == 201) {
      UserType userType = await appSettingsBloc.getUserType;
      if (userType == UserType.merchant) {
        SingletonData.singletonData.navKey.currentState!
            .pushNamed(CompanyData.id);
      } else {
        await logout();
        await appToast('You will be redirected to login',
            appToastType: AppToastType.success);

        SingletonData.singletonData.navKey.currentState!
            .popUntil(ModalRoute.withName(GetStarted.id));
        SingletonData.singletonData.navKey.currentState!.pushNamed(Login.id);

        // SingletonData.singletonData.navKey.currentState!.pushNamed(Tabs.id);
      }
    } else {
      onCloseLoader();
      MessageOnlyResponse error = operation.result;

      appToast(error.message ?? '', appToastType: AppToastType.failed);
    }
  }

  doResendOTPOperation(String email, String phoneNumber,
      Function() onShowLoader, Function() onCloseLoader) async {
    onShowLoader();
    signupService
        .doResendOTP(email, phoneNumber)
        .then((value) => _completeResendOTP(value, onCloseLoader));
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
        appToastType: AppToastType.success,
      );
    } else {
      MessageOnlyResponse error = operation.result;

      appToast(error.message ?? '', appToastType: AppToastType.failed);
    }
  }

  /// This flow is exclusive to merchant *Start*
  String cacDocument = "";

  doAddCompanyInfoOperation(
      Function() onShowLoader, Function() onCloseLoader) async {
    if (formKey.currentState!.validate()) {
      if (cacDocument.isEmpty) {
        appToast('CAC document is required', appToastType: AppToastType.failed);
        return;
      }
      onShowLoader();
      signupService
          .doAddCompanyInfo(
            SignupModel.toCompanyData(
                name: nameController.text.trim(),
                email: emailController.text.trim(),
                phoneNumber: phoneNumberController.text.trim(),
                rcNumber: rcNumberController.text.trim()),
          )
          .then(
              (operation) => _completeCompanyInfoAdd(operation, onCloseLoader));
    }
  }

  _completeCompanyInfoAdd(Operation operation, Function() onCloseLoader) async {
    onCloseLoader();
    if (operation.code == 200 || operation.code == 201) {
      await appToast(
        'Your information has been add successfully',
        appToastType: AppToastType.success,
      );

      await logout();
      await appToast('You will be redirected to login',
          appToastType: AppToastType.success);

      SingletonData.singletonData.navKey.currentState!
          .popUntil(ModalRoute.withName(GetStarted.id));
      SingletonData.singletonData.navKey.currentState!.pushNamed(Login.id);
    } else {
      MessageOnlyResponse error = operation.result;

      appToast(error.message ?? '', appToastType: AppToastType.failed);
    }
  }

  ///   *End*
}

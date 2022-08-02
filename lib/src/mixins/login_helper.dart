/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'package:flutter/material.dart';
import 'package:trakk/src/bloc/app_settings_bloc.dart';
import 'package:trakk/src/bloc/validation_bloc.dart';
import 'package:trakk/src/mixins/biometrics_helper.dart';
import 'package:trakk/src/mixins/connectivity_helper.dart';
import 'package:trakk/src/mixins/merchant_add_rider_and_vehicle_helper.dart';
import 'package:trakk/src/mixins/profile_helper.dart';
import 'package:trakk/src/models/app_settings.dart';
import 'package:trakk/src/models/auth_response.dart';
import 'package:trakk/src/models/message_only_response.dart';
import 'package:trakk/src/models/rider/add_rider_to_merchant_model.dart';
import 'package:trakk/src/screens/auth/verify_account.dart';
import 'package:trakk/src/screens/tab.dart';
import 'package:trakk/src/services/auth/login_service.dart';
import 'package:trakk/src/utils/app_toast.dart';
import 'package:trakk/src/utils/singleton_data.dart';
import 'package:trakk/src/values/enums.dart';

import '../utils/operation.dart';

typedef LoginCompleted = Function(AuthResponse loginResponse);

class LoginHelper
    with
        ConnectivityHelper,
        MerchantAddRiderAndVehicleHelper,
        ProfileHelper,
        BiometricsHelper {
  late Function() _onShowLoader;
  late Function() _onCloseLoader;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ValidationBloc validationBloc = ValidationBloc();
  TextEditingController emailCC = TextEditingController();
  TextEditingController passwordCC = TextEditingController();

  disposeControllers() {
    emailCC.dispose();
    passwordCC.dispose();
    validationBloc.dispose();
  }

  bool _isPersistentLogin = false;

  doLoginOperation(bool isPersistentLogin, Function() onShowLoader,
      Function() onCloseLoader) async {
    _onShowLoader = onShowLoader;
    _onCloseLoader = onCloseLoader;
    _isPersistentLogin = isPersistentLogin;

    if (formKey.currentState!.validate()) {
      onShowLoader();
      loginService
          .doLogin(emailCC.text.trim(), passwordCC.text)
          .then((value) => _completeLogin(value));
    }
  }

  _completeLogin(Operation operation) async {
    _onCloseLoader();
    if (operation.code == 200 || operation.code == 201) {
      AuthResponse authResponse = AuthResponse.fromJson(operation.result);
      await appSettingsBloc.saveLoginDetails(authResponse);

      if ((authResponse.data?.user?.confirmed ?? false) == true) {
        if ((authResponse.data?.user?.userType!.toString().toLowerCase() ==
                'rider') &&
            (authResponse.data?.user?.rider == null)) {
          //make an API request to update the riderID so that rider's object can be created

          addRiderBioData(
              AddRiderToMerchantModel(
                  data: AddRiderToMerchantModelData(
                      userId: '${authResponse.data?.user?.id ?? ''}',
                      firstName: authResponse.data?.user?.firstName,
                      lastName: authResponse.data?.user?.lastName,
                      avatar: authResponse.data?.user?.avatar,
                      phone: authResponse.data?.user?.phoneNumber,
                      email: authResponse.data?.user?.email)),
              onSuccessCallback: () async {
            // //use this flow and remove the flow below when the profile API returns Rider Object
            // doGetProfileOperation(
            // onShowLoader: _onShowLoader,
            // onCloseLoader: () async {
            //   _onCloseLoader();
            //   await appToast('Login Successful',
            //       appToastType: AppToastType.success);
            //   await SingletonData.singletonData.navKey.currentState!
            //       .pushNamed(Tabs.id);
            // });

            doLoginOperation(_isPersistentLogin, _onShowLoader, _onCloseLoader);
          }, continueStepAfterCompletion: false);
          return;
        }

        finaliseLogin(authResponse, true);
      } else {
        await appToast('Login Successful, please verify your account',
            appToastType: AppToastType.success);
        await SingletonData.singletonData.navKey.currentState!
            .pushNamed(VerifiyAccountScreen.id, arguments: {
          "email": authResponse.data?.user?.email ?? '',
          "phoneNumber": authResponse.data?.user?.phoneNumber ?? '',
          'userType': authResponse.data?.user?.userType ?? ''
        });

        passwordCC.clear();
      }
    } else {
      MessageOnlyResponse error = operation.result;

      appToast(error.message ?? '', appToastType: AppToastType.failed);
    }
  }

  finaliseLogin(AuthResponse authResponse, bool setBiometric) async {
    await appToast('Login Successful', appToastType: AppToastType.success);

    if (setBiometric) {
      toggleBiometrics(
          SingletonData.singletonData.navKey.currentState!.overlay!.context,
          true,
          false, (bool status) {
        _finalStep(authResponse, status);
      });
    } else {
      AppSettings appSettings = await appSettingsBloc.fetchAppSettings();

      _finalStep(authResponse, appSettings.biometricsEnabled);
    }
  }

  _finalStep(AuthResponse authResponse, bool enableBiometric) async {
    await appSettingsBloc.saveLoginDetails(authResponse);
    await appSettingsBloc.setPersistentLogin(_isPersistentLogin);
    await appSettingsBloc.setBiometrics(enableBiometric);

    await SingletonData.singletonData.navKey.currentState!.pushNamed(Tabs.id);

    passwordCC.clear();
  }
}

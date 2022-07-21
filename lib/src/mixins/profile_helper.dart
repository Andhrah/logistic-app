/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'package:trakk/src/bloc/app_settings_bloc.dart';
import 'package:trakk/src/models/auth_response.dart';
import 'package:trakk/src/models/message_only_response.dart';
import 'package:trakk/src/models/update_profile/update_profile.dart';
import 'package:trakk/src/services/get_user_service.dart';
import 'package:trakk/src/utils/app_toast.dart';
import 'package:trakk/src/values/enums.dart';

import '../utils/operation.dart';

typedef _ProfileFetchSuccess = Function(AuthData authData);

class ProfileHelper {
  doGetProfileOperation(
      {Function()? onShowLoader,
      Function()? onCloseLoader,
      _ProfileFetchSuccess? profileFetchSuccess}) async {
    if (onShowLoader != null) onShowLoader();
    profileService.getProfile().then(
        (value) => _completeGet(value, onCloseLoader, profileFetchSuccess));
  }

  _completeGet(Operation operation,
      [Function()? onCloseLoader,
      _ProfileFetchSuccess? profileFetchSuccess]) async {
    if (onCloseLoader != null) onCloseLoader();
    if (operation.code == 200 || operation.code == 201) {
      AuthData authData = AuthData.fromJsonWithData(operation.result);

      var appSettings = await appSettingsBloc.fetchAppSettings();
      if (!appSettings.isLoggedIn) {
        return;
      }

      AuthData user =
          appSettings.loginResponse?.data?.copyWith(user: authData.user) ??
              authData;

      if (user.user!.rider == null) {
        user.user!.rider = appSettings.loginResponse?.data!.user!.rider;
      }
      if (user.user!.merchant == null) {
        user.user!.merchant = appSettings.loginResponse?.data!.user!.merchant;
      }

      await appSettingsBloc.saveLoginDetails(
          appSettings.loginResponse?.copyWith(data: user) ??
              AuthResponse(data: authData));

      if (profileFetchSuccess != null) profileFetchSuccess(user);
    } else {
      MessageOnlyResponse error = operation.result;

      appToast(error.message ?? '', appToastType: AppToastType.failed);
    }
  }

  doUpdateProfileOperation(UpdateProfile updateProfile, Function() onShowLoader,
      Function() onCloseLoader) async {
    onShowLoader();
    profileService
        .updateProfile(updateProfile)
        .then((value) => _completeUpdate(value, onCloseLoader));
  }

  _completeUpdate(Operation operation, Function() onCloseLoader) async {
    if (operation.code == 200 || operation.code == 201) {
      doGetProfileOperation(profileFetchSuccess: (AuthData authData) {
        appToast('Profile updated successfully',
            appToastType: AppToastType.success);

        onCloseLoader();
      });
    } else {
      onCloseLoader();
      MessageOnlyResponse error = operation.result;

      appToast(error.message ?? '', appToastType: AppToastType.failed);
    }
  }

  ///below is exclusive to rider only

  doUpdateOnBoardingOperation(
      Map<String, dynamic> map, Function() onCloseLoader) async {
    profileService
        .updateOnBoarding(map)
        .then((value) => _completeOnBoardingUpdate(value, onCloseLoader));
  }

  _completeOnBoardingUpdate(
      Operation operation, Function() onCloseLoader) async {
    if (operation.code == 200 || operation.code == 201) {
      doGetProfileOperation(profileFetchSuccess: (AuthData authData) {
        onCloseLoader();
      });
    } else {
      onCloseLoader();
      MessageOnlyResponse error = operation.result;

      appToast(error.message ?? '', appToastType: AppToastType.failed);
    }
  }

  doUpdateRiderContactDetailsOperation(UpdateProfile updateProfile,
      Function() onShowLoader, Function() onCloseLoader) async {
    onShowLoader();
    profileService
        .updateRider(updateProfile)
        .then((value) => _completeRiderContactUpdate(value, onCloseLoader));
  }

  _completeRiderContactUpdate(
      Operation operation, Function() onCloseLoader) async {
    if (operation.code == 200 || operation.code == 201) {
      doUpdateOnBoardingOperation({
        'onBoardingSteps': {'riderContactCompleted': true}
      }, () async {
        onCloseLoader();
      });
    } else {
      onCloseLoader();
      MessageOnlyResponse error = operation.result;

      appToast(error.message ?? '', appToastType: AppToastType.failed);
    }
  }

  doNextOfKinOperation(UpdateProfile updateProfile, Function() onShowLoader,
      Function() onCloseLoader) async {
    onShowLoader();
    profileService
        .updateRiderNextOfKin(updateProfile)
        .then((value) => _completeNOK(value, onCloseLoader));
  }

  _completeNOK(Operation operation, Function() onCloseLoader) async {
    if (operation.code == 200 || operation.code == 201) {
      doUpdateOnBoardingOperation({
        'onBoardingSteps': {'riderNOKCompleted': true}
      }, () {
        onCloseLoader();
        appToast('Next of kin updated successfully',
            appToastType: AppToastType.success);
      });
    } else {
      onCloseLoader();
      MessageOnlyResponse error = operation.result;

      appToast(error.message ?? '', appToastType: AppToastType.failed);
    }
  }
}

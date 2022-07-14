/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'package:trakk/bloc/app_settings_bloc.dart';
import 'package:trakk/models/auth_response.dart';
import 'package:trakk/models/message_only_response.dart';
import 'package:trakk/models/update_profile/update_profile.dart';
import 'package:trakk/services/get_user_service.dart';
import 'package:trakk/utils/app_toast.dart';
import 'package:trakk/utils/enums.dart';

import '../utils/operation.dart';

typedef _ProfileFetchSuccess = Function(AuthData authData);

class ProfileHelper {
  doGetProfileOperation(
      {String? authToken,
      Function()? onShowLoader,
      Function()? onCloseLoader,
      _ProfileFetchSuccess? profileFetchSuccess}) async {
    if (onShowLoader != null) onShowLoader();
    profileService.getProfile(authToken).then(
        (value) => _completeGet(value, onCloseLoader, profileFetchSuccess));
  }

  _completeGet(Operation operation,
      [Function()? onCloseLoader,
      _ProfileFetchSuccess? profileFetchSuccess]) async {
    if (onCloseLoader != null) onCloseLoader();
    if (operation.code == 200 || operation.code == 201) {
      AuthData authData = AuthData.fromJsonWithData(operation.result);

      var appSettings = await appSettingsBloc.fetchAppSettings();
      if (!appSettings.isLoggedIn) {}
      AuthData user =
          appSettings.loginResponse?.data?.copyWith(user: authData.user) ??
              authData;

      // await appSettingsBloc.saveLoginDetails(
      //     appSettings.loginResponse?.copyWith(data: user) ??
      //         AuthResponse(data: authData));

      if (profileFetchSuccess != null) profileFetchSuccess(user);
    } else {
      MessageOnlyResponse error = operation.result;

      appToast(error.message ?? '', appToastType: AppToastType.failed);
    }
  }

  doUpdateProfileOperation(bool isPersistentLogin, Function() onShowLoader,
      Function() onCloseLoader) async {
    onShowLoader();
    profileService
        .updateProfile(UpdateProfile())
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
}

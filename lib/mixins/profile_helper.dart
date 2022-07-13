/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'package:trakk/bloc/app_settings_bloc.dart';
import 'package:trakk/mixins/connectivity_helper.dart';
import 'package:trakk/models/auth_response.dart';
import 'package:trakk/models/message_only_response.dart';
import 'package:trakk/models/update_profile/update_profile.dart';
import 'package:trakk/services/get_user_service.dart';
import 'package:trakk/utils/app_toast.dart';
import 'package:trakk/utils/enums.dart';

import '../utils/operation.dart';

typedef _Completed = Function(AuthResponse loginResponse);

class ProfileHelper with ConnectivityHelper {
  doGetProfileOperation(
      [Function()? onShowLoader, Function()? onCloseLoader]) async {
    if (onShowLoader != null) onShowLoader();
    profileService
        .getProfile()
        .then((value) => _completeGet(value, onCloseLoader));
  }

  _completeGet(Operation operation, [Function()? onCloseLoader]) async {
    if (onCloseLoader != null) onCloseLoader();
    if (operation.code == 200 || operation.code == 201) {
      AuthData authData = AuthData.fromJsonWithData(operation.result);

      var appSettings = await appSettingsBloc.fetchAppSettings();

      AuthData user =
          appSettings.loginResponse!.data!.copyWith(user: authData.user);

      await appSettingsBloc
          .saveLoginDetails(appSettings.loginResponse!.copyWith(data: user));
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
      doGetProfileOperation(() {}, () {
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

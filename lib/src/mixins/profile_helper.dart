/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:trakk/src/bloc/app_settings_bloc.dart';
import 'package:trakk/src/models/auth_response.dart';
import 'package:trakk/src/models/message_only_response.dart';
import 'package:trakk/src/models/update_profile/update_profile.dart';
import 'package:trakk/src/services/get_user_service.dart';
import 'package:trakk/src/utils/app_toast.dart';
import 'package:trakk/src/utils/singleton_data.dart';
import 'package:trakk/src/values/enums.dart';
import 'package:uploadcare_client/uploadcare_client.dart';

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

  _uploadProfilePic(File? profilePic, Function({String? url}) onSuccess) async {
    if (profilePic != null) {
      final CancelToken _cancelToken = CancelToken('canceled by user');
      try {
        String _fileId =
            await SingletonData.singletonData.uploadCareClient!.upload.auto(
          UCFile(profilePic),
          cancelToken: _cancelToken,
          storeMode: false, runInIsolate: true,
          // onProgress: (progress) => _progressController.add(progress),
          metadata: {
            'metakey': 'metavalue',
          },
        );

        onSuccess(url: '${SingletonData.singletonData.imageURL}$_fileId/');
      } on CancelUploadException catch (e) {
        debugPrint(e.toString());
        appToast('Could not process request at the moment.\nPlease try again',
            appToastType: AppToastType.failed);
      } catch (err) {
        debugPrint(err.toString());
      }
    } else {
      onSuccess();
    }
  }

  doUpdateProfileOperation(UpdateProfile updateProfile, Function() onShowLoader,
      Function() onCloseLoader) async {
    onShowLoader();

    _uploadProfilePic(updateProfile.profilePic, ({String? url}) {
      updateProfile.avatar = url;
      profileService
          .updateProfile(updateProfile)
          .then((value) => _completeUpdate(value, onCloseLoader));
    });
  }

  _completeUpdate(Operation operation, Function() onCloseLoader) async {
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
      });
    } else {
      onCloseLoader();
      MessageOnlyResponse error = operation.result;

      appToast(error.message ?? '', appToastType: AppToastType.failed);
    }
  }
}

/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:trakk/src/bloc/app_settings_bloc.dart';
import 'package:trakk/src/models/app_settings.dart';
import 'package:trakk/src/widgets/general_widget.dart';

typedef ProcessCompleted(bool enable);

class BiometricsHelper {
  var localAuth = LocalAuthentication();
  List<BiometricType>? _availableBiometrics;

  Future<bool> get deviceHasBiometrics => _checkBiometrics();

  Future<bool> _checkBiometrics() async {
    try {
      final isAvailable = await localAuth.canCheckBiometrics;
      final isDeviceSupported = await localAuth.isDeviceSupported();
      List<BiometricType> biometrics = (await getAvailableBiometrics()) ?? [];
      return isAvailable && isDeviceSupported && biometrics.length > 0;
    } on PlatformException catch (e) {
      return false;
    }
  }

  Future<List<BiometricType>?> getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await localAuth.getAvailableBiometrics();

      _availableBiometrics = availableBiometrics;
      return _availableBiometrics;
    } on PlatformException catch (err) {
      return null;
    }
  }

  //Mostly use processCompleted function for login/signup scenarios
  //It does not allow to proceed if there is no successful validation
  // Use the await to get the actual status of the validation
  Future<bool> toggleBiometrics(BuildContext context, bool enable,
      bool isFromSettings, ProcessCompleted processCompleted) async {
    bool value = await deviceHasBiometrics;

    if (await deviceHasBiometrics) {
      bool result = false;
      bool isYesPressed = false;
      await yesNoDialog(context,
          title: enable ? 'Activate Biometric?' : 'Deactivate Biometric?',
          message: enable
              ? 'Do you want to enable Fingerprint/Face ID for authorization?'
              : 'Do you want to disable Fingerprint/Face ID for authorization?',
          positiveCallback: () async {
        isYesPressed = true;
      }, negativeCallback: () {
        isYesPressed = false;
      });
      if (isYesPressed) {
        result = await authenticate(processCompleted);
      } else {
        if (!isFromSettings) processCompleted(false);
      }

      return result;
    } else {
      if (!isFromSettings) processCompleted(false);
      return false;
    }
  }

  Future<bool> authenticate(ProcessCompleted processCompleted) async {
    bool authenticated = false;

    if (await _checkBiometrics()) {
      bool isFaceID = false;

      await getAvailableBiometrics();
      if (Platform.isIOS) {
        if (_availableBiometrics!.contains(BiometricType.face)) {
          isFaceID = true;
        } else if (_availableBiometrics!.contains(BiometricType.fingerprint)) {
          isFaceID = false;
        }
      }
      try {
        authenticated = await localAuth.authenticate(
            localizedReason: isFaceID
                ? 'Using FaceID to authenticate'
                : 'Scan your fingerprint to authenticate',
            useErrorDialogs: true,
            biometricOnly: true,
            stickyAuth: true);
        if (authenticated) processCompleted(true);
      } on PlatformException catch (e) {
        print(e);
        authenticated = false;
      }
    } else {
      // processCompleted(false);
      authenticated = false;
    }

    return authenticated;
  }

  cancelAuthentication() {
    try {
      localAuth.stopAuthentication();
    } catch (err) {
      print(err.toString());
    }
  }

  doBiometricActivity(BuildContext context, Function() processCompleted) async {
    AppSettings appSettings = await appSettingsBloc.fetchAppSettings();

    if (appSettings.biometricsEnabled) {
      authenticate((enable) => processCompleted());
    } else {
      processCompleted();
    }
  }
}

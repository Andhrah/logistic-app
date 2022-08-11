/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'package:rxdart/rxdart.dart';
import 'package:trakk/src/utils/validators.dart';
import 'package:trakk/src/values/enums.dart';

class PasswordValidationStage {
  bool minimumOf8Characters;
  bool oneUpperCase;
  bool oneLowerCase;
  bool oneNumberCase;
  bool oneSpecialCharacter;
  bool oneCharacterEntered;

  PasswordValidationStage(
      {this.oneCharacterEntered = false,
      this.minimumOf8Characters = false,
      this.oneLowerCase = false,
      this.oneNumberCase = false,
      this.oneSpecialCharacter = false,
      this.oneUpperCase = false});

  bool isValidationGood() =>
      oneCharacterEntered &&
      minimumOf8Characters &&
      oneLowerCase &&
      oneNumberCase &&
      oneSpecialCharacter &&
      oneUpperCase;
}

class ValidationBloc extends FormValidators {
  final _emailOnlyController = BehaviorSubject<String>();
  final _passwordOldController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<PasswordValidationStage> get oldPassword =>
      _passwordOldController.transform(validatePasswordBloc);

  Stream<PasswordValidationStage> get password =>
      _passwordController.transform(validatePasswordBloc);

  // Add data to stream
  Stream<String> get emailOnly =>
      _emailOnlyController.transform(validateEmailOnlyBloc);

  // change data
  Function(String) get changeEmailOnly => _emailOnlyController.sink.add;

  Function(String) get changeOldPassword => _passwordOldController.sink.add;

  Function(String) get changePassword => _passwordController.sink.add;

  dispose() {
    _emailOnlyController.close();
    _passwordOldController.close();
    _passwordController.close();
  }

  ///below are for function

  String? emailValidator(String? email, {String? response}) {
    ValidationState state = validateEmail(email!);
    return state == ValidationState.isValidateSuccess
        ? null
        : state == ValidationState.isValidateFailed
            ? (response ?? "Enter a valid email address")
            : (response ?? "Email address cannot be empty");
  }

  String? singleInputValidator(String? value, {String? response}) {
    ValidationState state = validateSingleInput(value);
    return state == ValidationState.isValidateSuccess
        ? null
        : state == ValidationState.isValidateFailed
            ? (response ?? "Enter a valid email address")
            : state == ValidationState.isEmpty
                ? (response ?? "Field is required")
                : (response ?? "Email address cannot be empty");
  }

  String? phoneValidator(String? value, {String? response}) {
    ValidationState state = validatePhone(value);
    return state == ValidationState.isValidateSuccess
        ? null
        : state == ValidationState.isValidateFailed
            ? (response ?? "Enter a valid phone number")
            : state == ValidationState.isEmpty
                ? (response ?? "Field is required")
                : (response ?? "Phone cannot be empty");
  }

  String? passwordValidator(String? password, {String? response}) {
    ValidationState state = validatePassword(password);
    return state == ValidationState.isValidateSuccess
        ? null
        : state == ValidationState.isValidateFailed
            ? (response ??
                "The password must be at least 8 characters, 1 uppercase, 1 lowercase, 1 number and 1 special character.")
            : state == ValidationState.isEmpty
                ? (response ?? "Field is required")
                : (response ?? "Password cannot be empty");
  }
}

/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'dart:async';

import 'package:trakk/src/bloc/validation_bloc.dart';
import 'package:trakk/src/values/enums.dart';

const String _kEmailRule = r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$";
const String _kOneUpperCase = r'[A-Z]';
const String _kOneLowerCase = r'[a-z]';
const String _kOneNumber = r'[0-9]';
const String _strongPassword =
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*])(?=.{8,})';

class FormValidators {
  ValidationState validateEmail(String email) {
    final RegExp emailExp = RegExp(_kEmailRule);
    email = email.trim();
    if (email.isEmpty) {
      return ValidationState.isEmpty;
    } else if (emailExp.hasMatch(email)) {
      return ValidationState.isValidateSuccess;
    } else {
      return ValidationState.isValidateFailed;
    }
  }

  ValidationState validateSingleInput(String? value) {
    if (value == null) {
      return ValidationState.isValidateFailed;
    } else if (value.isEmpty) {
      return ValidationState.isEmpty;
    } else {
      return ValidationState.isValidateSuccess;
    }
  }

  ValidationState validatePhone(String? value) {
    if (value == null || (value.isEmpty)) {
      return ValidationState.isEmpty;
    } else if (value.length != 11) {
      return ValidationState.isValidateFailed;
    } else {
      return ValidationState.isValidateSuccess;
    }
  }

  ValidationState validatePassword(String? password) {
    if (password == null || (password.isEmpty)) {
      return ValidationState.isEmpty;
    }
    // final RegExp emailExp =
    //      RegExp(_kMin8CharsOneUpperOneLowerOneNumberOneSpecial);

    final RegExp oneUpperCaseExp = RegExp(_kOneUpperCase);
    final RegExp oneLowerCaseExp = RegExp(_kOneLowerCase);
    final RegExp oneNumberCaseExp = RegExp(_kOneNumber);

    PasswordValidationStage validationStage = PasswordValidationStage();
    if (password.isNotEmpty) {
      validationStage.oneCharacterEntered = true;
    }
    if (password.length >= 8) {
      validationStage.minimumOf8Characters = true;
    }
    if (oneUpperCaseExp.hasMatch(password)) {
      validationStage.oneUpperCase = true;
    }
    if (oneLowerCaseExp.hasMatch(password)) {
      validationStage.oneLowerCase = true;
    }
    if (oneNumberCaseExp.hasMatch(password)) {
      validationStage.oneNumberCase = true;
    }
    /***
     * use a better regex that checks for symbol only and does not
     * allow numbers for checking this
     * ~!@#$%^&*()-_=]
     */
    // if (oneSpecialCharacterExp.hasMatch(password)) {
    //   validationStage.oneSpecialCharacter = true;
    // }

    //work around for above:
    if (password.containsSpecialCharacter()) {
      validationStage.oneSpecialCharacter = true;
    }

    return validationStage.isValidationGood()
        ? ValidationState.isValidateSuccess
        : ValidationState.isValidateFailed;
  }

  final validateEmailOnlyBloc =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    final RegExp emailExp = RegExp(_kEmailRule);
    if (emailExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('Enter a valid email');
    }
  });

  final StreamTransformer<String, PasswordValidationStage>
      validatePasswordBloc =
      StreamTransformer<String, PasswordValidationStage>.fromHandlers(
          handleData: (password, sink) {
    final RegExp oneUpperCaseExp = RegExp(_kOneUpperCase);
    final RegExp oneLowerCaseExp = RegExp(_kOneLowerCase);
    final RegExp oneNumberCaseExp = RegExp(_kOneNumber);
    // final RegExp oneSpecialCharacterExp =  RegExp(_kOneSpecialCharacter);

    PasswordValidationStage validationStage = PasswordValidationStage();
    if (password.isNotEmpty) {
      validationStage.oneCharacterEntered = true;
    }
    if (password.length >= 8) {
      validationStage.minimumOf8Characters = true;
    }
    if (oneUpperCaseExp.hasMatch(password)) {
      validationStage.oneUpperCase = true;
    }
    if (oneLowerCaseExp.hasMatch(password)) {
      validationStage.oneLowerCase = true;
    }
    if (oneNumberCaseExp.hasMatch(password)) {
      validationStage.oneNumberCase = true;
    }
    /***
         * use a better regex that checks for symbol only and does not
         * allow numbers for checking this
         * ~!@#$%^&*()-_=]
         */
    // if (oneSpecialCharacterExp.hasMatch(password)) {
    //   validationStage.oneSpecialCharacter = true;
    // }

    //work around for above:
    if (password.containsSpecialCharacter()) {
      validationStage.oneSpecialCharacter = true;
    }

    sink.add(validationStage);
    // sink.addError('Minimum 8 characters. Contains both letters and numbers');
  });
}

extension SpecialCharcter on String {
  bool containsSpecialCharacter() {
    return contains('~') ||
        contains('!') ||
        contains('@') ||
        contains('#') ||
        contains('\$') ||
        contains('%') ||
        contains('^') ||
        contains('&') ||
        contains('*') ||
        contains('{') ||
        contains('}') ||
        contains('(') ||
        contains(')') ||
        contains('-') ||
        contains('+') ||
        contains('_') ||
        contains('=') ||
        contains('|');
  }
}

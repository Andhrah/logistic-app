/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'dart:async';

import 'package:trakk/src/values/enums.dart';

const String _kEmailRule = r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$";

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

  final validateEmailOnlyBloc =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    final RegExp emailExp = RegExp(_kEmailRule);
    if (emailExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('Enter a valid email');
    }
  });
}

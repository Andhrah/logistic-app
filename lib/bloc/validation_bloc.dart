/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'package:rxdart/rxdart.dart';
import 'package:trakk/utils/enums.dart';
import 'package:trakk/utils/validators.dart';

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

  // Add data to stream
  Stream<String> get emailOnly =>
      _emailOnlyController.transform(validateEmailOnlyBloc);

  // change data
  Function(String) get changeEmailOnly => _emailOnlyController.sink.add;

  dispose() {
    _emailOnlyController.close();
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
}

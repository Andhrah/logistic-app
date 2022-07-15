/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'dart:async';

const String _kEmailRule = r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$";

class FormValidators {
  bool validateEmail(String email) {
    final RegExp emailExp = RegExp(_kEmailRule);
    email = email.trim();
    if (!emailExp.hasMatch(email) || email.isEmpty) {
      return false;
    } else {
      return true;
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

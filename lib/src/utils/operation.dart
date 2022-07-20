/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'dart:convert';

import 'package:trakk/src/models/message_only_response.dart';
import 'package:trakk/src/services/base_network_call_handler.dart';

typedef OperationCompleted = Function(Operation operation);

class Operation {
  final dynamic _result;
  int? code;

  Operation(this.code, this._result);

  static generalError() => Operation(
      509, MessageOnlyResponse.fromJson(json.decode(kNetworkGeneralError)));

  static platformError() =>
      Operation(510, MessageOnlyResponse.fromJson(json.decode(kPlatformError)));

  bool get succeeded => code! >= 200 && code! <= 226;

  dynamic get result => _result;
}

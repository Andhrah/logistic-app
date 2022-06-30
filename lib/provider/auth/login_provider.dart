import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:trakk/Exceptions/api_failure_exception.dart';
import 'package:trakk/services/auth/login_service.dart';

class LoginProvider extends ChangeNotifier {
  final LoginService _api = LoginService();

  static LoginProvider authProvider(BuildContext context, {bool listen = false}) {
    return Provider.of<LoginProvider>(context, listen: listen);
  }

  Future loginUser(
    String email,
    String password,
   ) async {
    try {
      var response = await _api.login(
        email,
        password,
      );
      var box = await Hive.openBox('appState');
      await box.put("token", response["data"]["jwt"]);
      await box.put("userType", response["data"]["user"]["userType"]);
      await box.put("phoneNumber", response["data"]["user"]["phoneNumber"]);
      await box.put("firstName", response["data"]["user"]["firstName"]);
      await box.put("lastName", response["data"]["user"]["lastName"]);
      await box.put("email", response["data"]["user"]["email"]);
      await box.put("id", response["data"]["user"]["id"]);
      return response;
    } catch(err) {
      throw ApiFailureException(err);
    }
  }
}

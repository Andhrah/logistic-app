import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:trakk/Exceptions/api_failure_exception.dart';
import 'package:trakk/services/auth/signup_service.dart';

class SignupProvider extends ChangeNotifier {
  final SignupService _api = SignupService();

  static SignupProvider authProvider(BuildContext context, {bool listen = false}) {
    return Provider.of<SignupProvider>(context, listen: listen);
  }

  Future createUser(
    String firstName,
    String lastName,
    String email,
    String password,
    String phoneNumber,
    String userType) async {
    try {
      var response = await _api.signupUser(
        firstName,
        lastName,
        email,
        password,
        phoneNumber,
        userType,
      );
      var box = await Hive.openBox('appState');
      await box.put("token", response["data"]["jwt"]);
      return response;
    } catch(err) {
      throw ApiFailureException(err);
    }
  }
}

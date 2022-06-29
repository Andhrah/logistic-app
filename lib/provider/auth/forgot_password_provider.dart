import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trakk/Exceptions/api_failure_exception.dart';
import 'package:trakk/services/auth/forgot_password_service.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  final ForgotPasswordService _api = ForgotPasswordService();

  static ForgotPasswordProvider authProvider(BuildContext context, {bool listen = false}) {
    return Provider.of<ForgotPasswordProvider>(context, listen: listen);
  }
  

  Future forgetPassword(String email) async {
    try {
      var response = await _api.forgetPassword(email);
      // _setInitialData(response);
      return response;
    } catch(err) {
      throw ApiFailureException(err);
    }
  }

  // reset password
  Future resetPassword(String code, String newPassword, String password) async {
    try {
      var response = await _api.resetPassword(code, newPassword, password);
      return response;
    } catch(err) {
      print(err);
      throw ApiFailureException(err);
    }
  }
}
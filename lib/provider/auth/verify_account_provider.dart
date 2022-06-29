import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trakk/Exceptions/api_failure_exception.dart';
import 'package:trakk/services/auth/verify_account_service.dart';

class VerifyAccountProvider extends ChangeNotifier {
  final VerifyAcountService _api = VerifyAcountService();

  static VerifyAccountProvider authProvider(BuildContext context, {bool listen = false}) {
    return Provider.of<VerifyAccountProvider>(context, listen: listen);
  }

  Future verifyAccount(String code, String email) async {
    try {
      var response = await _api.verifyAccount(
        code,
        email,
      );
      return response;
    } catch(err) {
      throw ApiFailureException(err);
    }
  }

  Future resendOtp(String email, String phoneNumber) async {
    try {
      var response = await _api.resendOtp(
        email,
        phoneNumber,
      );
      return response;
    } catch(err) {
      throw ApiFailureException(err);
    }
  }
}

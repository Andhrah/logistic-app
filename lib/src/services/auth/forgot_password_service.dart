import 'package:trakk/src/services/base_network_call_handler.dart';
import 'package:trakk/src/utils/operation.dart';
import 'package:trakk/src/values/enums.dart';

class ForgotPasswordService extends BaseNetworkCallHandler {
  Future<Operation> doForgetPassword(String email) async {
    return runAPI('api/user/forgot-password', HttpRequestType.post,
        body: {"email": email}, useIsLoggedIn: false);
  }

  Future<Operation> doResetPassword(
      String email, String code, String newPassword, String password) async {
    return runAPI('api/user/reset-password', HttpRequestType.post,
        body: {
          'email': email,
          "code": code,
          "newPassword": newPassword,
          "password": password,
        },
        useIsLoggedIn: false);
  }
}

final forgotPasswordService = ForgotPasswordService();

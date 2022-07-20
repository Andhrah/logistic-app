import 'package:trakk/src/services/base_network_call_handler.dart';
import 'package:trakk/src/values/enums.dart';
import 'package:trakk/src/utils/operation.dart';

class ForgotPasswordService extends BaseNetworkCallHandler {
  Future<Operation> doForgetPassword(String email) async {
    return runAPI('api/user/forgot-password', HttpRequestType.post,
        body: {"email": email});
  }

  Future<Operation> doResetPassword(
      String code, String newPassword, String password) async {
    return runAPI('api/user/forgot-password', HttpRequestType.post, body: {
      "code": code,
      "newPassword": newPassword,
      "password": password,
    });
  }
}

final forgotPasswordService = ForgotPasswordService();

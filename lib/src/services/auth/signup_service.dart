import 'package:trakk/src/models/auth/signup_model.dart';
import 'package:trakk/src/services/base_network_call_handler.dart';
import 'package:trakk/src/values/enums.dart';
import 'package:trakk/src/utils/operation.dart';

class SignupService extends BaseNetworkCallHandler {
  Future<Operation> doSignUp(SignupModel signupModel) async {
    return runAPI('api/user/register', HttpRequestType.post,
        useIsLoggedIn: false, body: signupModel.toJson());
  }

  Future<Operation> doVerify(String code, String email) async {
    return runAPI('api/user/verify-otp', HttpRequestType.post,
        body: {
          "code": code,
          "email": email,
        },
        useIsLoggedIn: false);
  }

  Future<Operation> doResendOTP(String email, String phoneNumber) async {
    return runAPI('api/user/send-otp', HttpRequestType.post,
        body: {
          "email": email,
          "phoneNumber": phoneNumber,
        },
        useIsLoggedIn: false);
  }
}

final signupService = SignupService();

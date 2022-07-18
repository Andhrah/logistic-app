import 'package:trakk/models/auth/signup_model.dart';
import 'package:trakk/services/base_network_call_handler.dart';
import 'package:trakk/utils/enums.dart';
import 'package:trakk/utils/operation.dart';

class SignupService extends BaseNetworkCallHandler {
  Future<Operation> doSignUp(SignupModel signupModel) async {
    return runAPI('api/user/register', HttpRequestType.post,
        body: signupModel.toJson());
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
    return runAPI('api/user/send-otp', HttpRequestType.post, body: {
      "email": email,
      "phoneNumber": phoneNumber,
    });
  }
}

final signupService = SignupService();

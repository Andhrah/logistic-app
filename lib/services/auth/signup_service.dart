import 'package:trakk/services/base_network_call_handler.dart';
import 'package:trakk/utils/enums.dart';
import 'package:trakk/utils/operation.dart';

class SignupService extends BaseNetworkCallHandler {
  Future<Operation> doSignUp(String firstName, String lastName, String email,
      String phoneNumber, String password, String userType) async {
    return runAPI('api/user/register', HttpRequestType.post, body: {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "phoneNumber": phoneNumber,
      "password": password,
      "userType": userType,
    });
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

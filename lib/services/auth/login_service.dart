import 'package:trakk/services/base_network_call_handler.dart';
import 'package:trakk/utils/enums.dart';
import 'package:trakk/utils/operation.dart';

class LoginService extends BaseNetworkCallHandler {
  Future<Operation> doLogin(String email, String password) async {
    return runAPI('api/user/login', HttpRequestType.post,
        body: {"email": email, "password": password});
  }
}

final loginService = LoginService();

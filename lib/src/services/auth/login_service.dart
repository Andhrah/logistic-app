import 'package:trakk/src/services/base_network_call_handler.dart';
import 'package:trakk/src/utils/operation.dart';
import 'package:trakk/src/values/enums.dart';

class LoginService extends BaseNetworkCallHandler {
  Future<Operation> doLogin(String email, String password) async {
    return runAPI('api/user/login', HttpRequestType.post,
        body: {"email": email, "password": password}, useIsLoggedIn: false);
  }
}

final loginService = LoginService();

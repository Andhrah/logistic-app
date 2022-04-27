import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trakk/Exceptions/api_failure_exception.dart';
import 'package:trakk/models/auth/first_time_user.dart';
import 'package:trakk/models/auth/user.dart';
import 'package:trakk/services/auth_service.dart';

class Auth extends ChangeNotifier {
  final AuthService _authApi = AuthService();

  late FirstTimeUser _firstTimeUser;
  late User _user;

  FirstTimeUser get firstTimeUser => _firstTimeUser;
  User get user => _user;

  // static BuildContext _context;

  setFirstTimerUser(FirstTimeUser firstTimeUser) => _firstTimeUser = firstTimeUser;
  setUser(User user) => _user = user;

  static Auth authProvider(BuildContext context, {bool listen = false}) {
    // _context = context;
    return Provider.of<Auth>(context, listen: listen);
  }

  FirstTimeUser myFirst(FirstTimeUser myFirst) {
    setFirstTimerUser(myFirst);
    print('myfirst ${_firstTimeUser.firstTimeUserBool}');
    return myFirst;
  }

  // create a user
  Future createUser(
    String firstName,
    String lastName,
    String email,
    String password,
    String phoneNumber,
    String userType) async {
    try {
      var response = await _authApi.createUser(
        firstName,
        lastName,
        email,
        password,
        phoneNumber,
        userType,
      );
      return response;
    } catch(err) {
      throw ApiFailureException(err);
    }
  }
}
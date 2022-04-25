import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trakk/models/auth/first_time_user.dart';

class Auth extends ChangeNotifier {
  late FirstTimeUser _firstTimeUser;

  FirstTimeUser get firstTimeUser => _firstTimeUser;

  // static BuildContext _context;

  setFirstTimerUser(FirstTimeUser firstTimeUser) => _firstTimeUser = firstTimeUser;

  static Auth authProvider(BuildContext context, {bool listen = false}) {
    // _context = context;
    return Provider.of<Auth>(context, listen: listen);
  }

  FirstTimeUser myFirst(FirstTimeUser myFirst) {
    setFirstTimerUser(myFirst);
    print('myfirst ${_firstTimeUser.firstTimeUserBool}');
    return myFirst;
  }
}
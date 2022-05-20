import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trakk/Exceptions/api_failure_exception.dart';
import 'package:trakk/models/auth/first_time_user.dart';
import 'package:trakk/models/auth/user.dart';
import 'package:trakk/services/auth_service.dart';
import 'package:trakk/utils/helper_utils.dart';

class Auth extends ChangeNotifier {
  final AuthService _authApi = AuthService();

   String? _token;
  late FirstTimeUser _firstTimeUser;
   User? _user;

  String? get token => _token;
  FirstTimeUser get firstTimeUser => _firstTimeUser;
  User? get user => _user;

  setFirstTimerUser(FirstTimeUser firstTimeUser) => _firstTimeUser = firstTimeUser;
  setUser(User? user) => _user = user;
  setToken(String? token) => _token = token;


  static Auth authProvider(BuildContext context, {bool listen = false}) {
    return Provider.of<Auth>(context, listen: listen);
  }

  FirstTimeUser myFirst(FirstTimeUser myFirst) {
    setFirstTimerUser(myFirst);
    print('myfirst ${_firstTimeUser.firstTimeUserBool}');
    return myFirst;
  }

  void guestLogin(){
    setUser(null);
    String randomToken = generateRandomString(25);
    setToken(randomToken);
    notifyListeners();
  }

  void _setInitialData(data) {
    setUser(User.fromJson(data["data"]["data"]));
    print("=========== Jehovah is AWESOME ==========");
    print(data["data"]["data"]["token"]);
    setToken(data["data"]["data"]["token"]);
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

  Future createRider(
    String firstName,
    String lastName,
    String email,
    String password,
    String phoneNumber,
    String userType,

    String stateOfOrigin,
    String stateOfResidence,
    String residentialAddress,
    String userPassport,

    String vehicleName,
    String vehicleColor,
    String vehicleNumber,
    String vehicleCapacity,
    String vehicleParticulars,
    String vehicleImage,

    String kinFullName,
    String kinEmail,
    String kinAddress,
    String kinPhoneNumber,
    ) async {
    try {
      var response = await _authApi.createRider(
        firstName,
        lastName,
        email,
        password,
        phoneNumber,
        userType,
        stateOfOrigin,
        stateOfResidence,
        residentialAddress,
        userPassport,
        vehicleName,
        vehicleColor,
        vehicleNumber,
        vehicleCapacity,
        vehicleParticulars,
        vehicleImage,
        kinFullName,
        kinEmail,
        kinAddress,
        kinPhoneNumber,
      );
      return response;
    } catch(err) {
      throw ApiFailureException(err);
    }
  }

  // login a user
  Future login(String email, String password) async {
    try {
      var response = await _authApi.login(email, password);
      // _setInitialData(response);
      return response;
    } catch(err) {
      throw ApiFailureException(err);
    }
  }

  // forget password
  Future forgetPassword(String email) async {
    try {
      var response = await _authApi.forgetPassword(email);
      // _setInitialData(response);
      return response;
    } catch(err) {
      throw ApiFailureException(err);
    }
  }

  // reset password
  Future resetPassword(String code, String password) async {
    try {
      var response = await _authApi.resetPassword(code, password);
      return response;
    } catch(err) {
      print(err);
      throw ApiFailureException(err);
    }
  }
}
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:trakk/Exceptions/api_failure_exception.dart';
import 'package:trakk/models/auth/first_time_user.dart';
import 'package:trakk/models/auth/user.dart';
import 'package:trakk/services/auth_service.dart';
import 'package:trakk/utils/helper_utils.dart';

class Auth extends ChangeNotifier {
  final AuthService _authApi = AuthService();
  //final AuthService _authApi = AuthService();

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
    // print('myfirst ${_firstTimeUser.firstTimeUserBool}');
    return myFirst;
  }

  void guestLogin(){
    setUser(null);
    String randomToken = generateRandomString(25);
    setToken(randomToken);
    notifyListeners();
  }

  void _setInitialData(data) {
    // print(data["data"]['token']);
    // setUser(User.fromJson(data));
    setToken(data["data"]["token"]);
  }

  // update profile
  Future updateProfile(
    String firstName,
    String lastName,
    int phoneNumber,
    String email,
    String address,
  ) async {
    try {
      var response = await _authApi.updateProfile(
        firstName,
        lastName,
        phoneNumber,
        email,
        address,
        
      );
      return response;
    } catch(err) {
      throw ApiFailureException(err);
    }

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
    String vehicleModel,
    int vehicleTypeId,

    String kinFirstName,
    String kinLastName,
    // String kinFullName,
    String kinEmail,
    String kinAddress,
    String kinPhoneNumber,
    String kinRelationship,
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
        vehicleModel,
        vehicleTypeId,
        kinFirstName,
        kinLastName,
        kinEmail,
        kinAddress,
        kinPhoneNumber,
        kinRelationship,
      );
      print('[][][][][][][][][][] REGISTER [][][][][][][][][][][][]');
      print('user is a ${response}');
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
      print('[][][][][][][][][][][][][][][][][][][][][][]');
      print('user is a ${response['data']['token']}');
      var box = await Hive.openBox('userData');
      box.putAll({
        "token": response['data']['token'],
      });
      
      // User user = User.fromJson(response);
      print('[][][][][][][][][] THERER [][][][][][][][][][][][][]');
      print(user);
      return response;
    } catch(err) {
      print('WE ARE THERE NOW');
      print(err);
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
/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SingletonData {
  static final SingletonData _instance = SingletonData.internal();

  factory SingletonData() => _instance;

  SingletonData._();

  static final SingletonData singletonData = SingletonData._();

  SingletonData.internal();

//  navigator key
  final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  // todo: shared preferences to be changed to hive for more robust storage
  static SharedPreferences? _preferences;

  Future<SharedPreferences> get preferences async {
    if (_preferences != null) return _preferences!;
    _preferences = await initPreferences();
    return _preferences!;
  }

  initPreferences() async {
    return await SharedPreferences.getInstance();
  }

//  Dio
  static Dio? _dio;

  Dio get dio {
    if (_dio != null) return _dio!;
    _dio = initDio();
    return _dio!;
  }

  initDio() {
    return Dio();
  }

  //baseurl
  static String? _baseURL;

  String? get baseURL {
    if (_baseURL != null) return _baseURL;
    _baseURL = '';
    return _baseURL;
  }

  initBaseURL(String baseURL) {
    _baseURL = baseURL;
    return _baseURL;
  }

  //ssoURL
  static String? _ssoURL;

  String? get ssoURL {
    if (_ssoURL != null) return _ssoURL;
    _ssoURL = '';
    return _ssoURL;
  }

  initSsoURL(String ssoURL) {
    _ssoURL = ssoURL;
    return _ssoURL;
  }
}

/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trakk/src/.env.dart';
import 'package:uploadcare_client/uploadcare_client.dart';

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

  //socketURL
  static String? _socketURL;

  String? get socketURL {
    if (_socketURL != null) return _socketURL;
    _socketURL = '';
    return _socketURL;
  }

  initSocketURL(String socketURL) {
    _socketURL = socketURL;
    return _socketURL;
  }

  //socketURL
  static String? _imageURL;

  String? get imageURL {
    if (_imageURL != null) return _imageURL;
    _imageURL = '';
    return _imageURL;
  }

  initImageURL(String imageURL) {
    _imageURL = imageURL;
    return _imageURL;
  }

//  uploadClient
  static UploadcareClient? _uploadCareClient;

  UploadcareClient? get uploadCareClient {
    if (_uploadCareClient != null) return _uploadCareClient;
    //if it's not initialize
    _uploadCareClient = UploadcareClient.withSimpleAuth(
      publicKey: uploadCarePublicKey,
      privateKey: uploadCarePrivateKey,
      apiVersion: 'v0.7',
    );
    return _uploadCareClient;
  }

  initUploadCareClient(UploadcareClient client) {
    _uploadCareClient = client;
    return _uploadCareClient;
  }

  //debug Flag
  static bool? _isDebug;

  bool get isDebug {
    if (_isDebug != null) return _isDebug ?? false;
    _isDebug = true;
    return _isDebug ?? false;
  }

  initIsDebug(bool isDebug) {
    _isDebug = isDebug;
    return _isDebug;
  }
}

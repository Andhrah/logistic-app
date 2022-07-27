/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:trakk/src/bloc/app_settings_bloc.dart';
import 'package:trakk/src/mixins/logout_helper.dart';
import 'package:trakk/src/models/app_settings.dart';
import 'package:trakk/src/models/message_only_response.dart';
import 'package:trakk/src/utils/app_toast.dart';
import 'package:trakk/src/utils/operation.dart';
import 'package:trakk/src/utils/singleton_data.dart';
import 'package:trakk/src/values/enums.dart';

//below are for network calls
const String kTimeoutText = 'Connection Timed out';
const String kPlatformText = 'Unable to process information';
const String kHttpErrorText = 'Please check you network settings';
const String kSocketExceptionText = 'Please check you network settings';
const String kNetworkGeneralText = 'Error occurred while connecting to server';
const String kLogoutText = 'Unauthorized user';

const String kConnectionTimedOut = '{"message":"$kTimeoutText"}';
const String kNetworkGeneralError = '{"message":"$kNetworkGeneralText"}';
const String kPlatformError = '{"message":"$kPlatformText"}';
const String kLogoutError = '{"message":"$kLogoutText"}';

const kShortTimeoutSec = 45;
const kMediumTimeout = 60;
const kLongTimeout = 120;

const kValidateCode = 600;

final kTimeoutResponse = Response(
    data: {"message": kTimeoutText},
    statusCode: 508,
    requestOptions: RequestOptions(path: ''));

final kPlatformExceptionResponse = Response(
    data: {"message": kPlatformText},
    statusCode: 507,
    requestOptions: RequestOptions(path: ''));
final kHTTPExceptionResponse = Response(
    data: {"message": kHttpErrorText},
    statusCode: 507,
    requestOptions: RequestOptions(path: ''));
final kSocketExceptionResponse = Response(
    data: {"message": kSocketExceptionText},
    statusCode: 508,
    requestOptions: RequestOptions(path: ''));
final kGeneralResponse = Response(
    data: {"message": kNetworkGeneralText},
    statusCode: 508,
    requestOptions: RequestOptions(path: ''));

Response networkErrorResponse(error) {
  if (error == HttpException) {
    return kHTTPExceptionResponse;
  } else if (error == SocketException) {
    return kSocketExceptionResponse;
  }
  return kGeneralResponse;
}

typedef Future<Operation> OnResponse(Operation operation);

class BaseNetworkCallHandler with LogoutHelper {
  late String _path;
  late HttpRequestType _httpRequestType;
  Map<String, dynamic> _body = const {};
  String _baseurl = '';
  OnResponse? _onResponse;
  OnResponse? _onNoDataResponse;
  OnResponse? _onTimeoutResponse;
  OnResponse? _onErrorResponse;
  bool _isRawData = false;

  Future<Operation> runAPI(String path, HttpRequestType httpRequestType,
      {Map<String, dynamic> body = const {},
      Map<String, dynamic> header = const {},
      bool useIsLoggedIn = true,
      String baseurl = '',
      OnResponse? onResponse,
      OnResponse? onNoDataResponse,
      OnResponse? onTimeoutResponse,
      OnResponse? onErrorResponse,
      bool isRawData = false}) async {
    _path = path;
    _httpRequestType = httpRequestType;
    _body = body;
    _baseurl = baseurl;
    _onResponse = onResponse;
    _onNoDataResponse = onNoDataResponse;
    _onTimeoutResponse = onTimeoutResponse;
    _onErrorResponse = onErrorResponse;
    _isRawData = isRawData;

    SingletonData.singletonData.dio.interceptors.clear();

    SingletonData.singletonData.dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      String url = SingletonData.singletonData.baseURL!;

      if (!options.path.contains('http')) {
        options.path = url + options.path;
      }
      AppSettings appSettings = await appSettingsBloc.fetchAppSettings();

      Map<String, dynamic> header = const {'Content-Type': 'application/json'};

      if (useIsLoggedIn &&
          appSettings.isLoggedIn &&
          appSettings.loginResponse != null &&
          appSettings.loginResponse!.data != null &&
          appSettings.loginResponse!.data!.token != null) {
        header = {
          'Authorization': 'Bearer ${appSettings.loginResponse!.data!.token}',
          'Content-Type': 'application/json'
        };
      }
      options.headers = header;
      return handler.next(options);
    }, onResponse: (response, handler) async {
      AppSettings appSettings = await appSettingsBloc.fetchAppSettings();

      if ((appSettings.isLoggedIn && response.statusCode == 401) ||
          response.data['message']
              .toString()
              .contains('Missing or invalid credentials')) {
        print('onResponse');
        print(response.statusCode);
        print(response.data);
        await appToast('Session expired', appToastType: AppToastType.failed);
        logoutGlobal();

        return;
      }
      // if (response.statusCode == 401) {
      //   AppSettings appSettings = await appSettingsBloc.fetchAppSettings();
      //   if (appSettings.loginResponse?.data?.refreshToken != null) {
      //     String url = '';
      //     if (Platform.isAndroid || Platform.isIOS) {
      //       url = SingletonData.singletonData.baseURL!;
      //     } else {
      //       url = SingletonData.singletonData.baseURL!;
      //     }
      //     if (await refreshToken(url)) {
      //       return handler.resolve(await _retry(response.requestOptions));
      //     }
      //   }
      // }
      return handler.next(response);
    }, onError: (DioError error, handler) async {
      AppSettings appSettings = await appSettingsBloc.fetchAppSettings();

      if ((appSettings.isLoggedIn && error.response?.statusCode == 401) ||
          (error.response?.data['message'] ?? '')
              .toString()
              .contains('Missing or invalid credentials')) {
        print('onError');
        print(error.response?.statusCode);
        print(error.response?.data);
        await appToast('Session expired', appToastType: AppToastType.failed);
        logoutGlobal();

        return;
      }
      // if (error.response?.statusCode == 401) {
      //   AppSettings appSettings = await appSettingsBloc.fetchAppSettings();
      //   if (appSettings.loginResponse?.data?.refreshToken != null) {
      //     String url = '';
      //     if (Platform.isAndroid || Platform.isIOS) {
      //       url = SingletonData.singletonData.baseURL!;
      //     } else {
      //       url = SingletonData.singletonData.baseURL!;
      //     }
      //     if (await refreshToken(url)) {
      //       return handler.resolve(await _retry(error.requestOptions));
      //     }
      //   }
      // }
      return handler.next(error);
    }));

    try {
      String url = baseurl;
      if (url.isEmpty) {
        if (Platform.isAndroid || Platform.isIOS) {
          url = SingletonData.singletonData.baseURL!;
        } else {
          url = SingletonData.singletonData.baseURL!;
        }

        if (url.isEmpty) {
          return Operation(500,
              MessageOnlyResponse.fromJson(json.decode(kNetworkGeneralError)));
        }
      }
      url = url + path;

      AppSettings appSettings = await appSettingsBloc.fetchAppSettings();

      Map<String, dynamic> masterHeader = header;

      if (masterHeader.isEmpty) {
        masterHeader = {'Content-Type': 'application/json'};

        if (useIsLoggedIn &&
            appSettings.isLoggedIn &&
            appSettings.loginResponse != null &&
            appSettings.loginResponse!.data != null &&
            appSettings.loginResponse!.data!.token != null) {
          masterHeader = {
            'Authorization': 'Bearer ${appSettings.loginResponse!.data!.token}',
            'Content-Type': 'application/json'
          };
        }
      }

      print(masterHeader);

      Response response;
      if (httpRequestType == HttpRequestType.post) {
        response = await _post(url, body, masterHeader);
      } else if (httpRequestType == HttpRequestType.get) {
        response = await _get(url, masterHeader);
      } else if (httpRequestType == HttpRequestType.patch) {
        response = await _patch(url, body, masterHeader);
      } else if (httpRequestType == HttpRequestType.put) {
        response = await _put(url, body, masterHeader);
      } else if (httpRequestType == HttpRequestType.delete) {
        response = await _delete(url, body, masterHeader);
      } else {
        if (onErrorResponse != null) {
          return onErrorResponse(json.decode(kNetworkGeneralError));
        } else {
          return Operation(500,
              MessageOnlyResponse.fromJson(json.decode(kNetworkGeneralError)));
        }
      }

      if (kDebugMode) {
        print('url $url');
        print('body $body');
        print('code ${response.statusCode}');
        log(response.data.toString());
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (onResponse != null) {
          return onResponse(Operation(response.statusCode, response.data));
        }
        return Operation(response.statusCode, response.data);
      } else {
        if (onNoDataResponse != null) {
          return onNoDataResponse(Operation(
              response.statusCode,
              isRawData
                  ? response.data
                  : MessageOnlyResponse.fromJson(response.data)));
        }
        return Operation(
            response.statusCode, MessageOnlyResponse.fromJson(response.data));
      }
    } catch (err) {
      if (onErrorResponse != null) {
        return onErrorResponse(
            Operation(500, json.decode(kNetworkGeneralError)));
      } else {
        return Operation(500,
            MessageOnlyResponse.fromJson(json.decode(kNetworkGeneralError)));
      }
    }
  }

  Future<Response> _post(String url, Map<String, dynamic> body,
      Map<String, dynamic> header) async {
    var response = await SingletonData.singletonData.dio
        .post(
      url,
      data: body,
      options: Options(
          headers: header,
          responseType: ResponseType.json,
          followRedirects: false,
          validateStatus: (status) {
            return status! < kValidateCode;
          }),
    )
        .timeout(const Duration(minutes: kLongTimeout), onTimeout: () {
      return kTimeoutResponse;
    }).catchError((error) {
      return networkErrorResponse(error);
    });

    return response;
  }

  Future<Response> _get(String url, Map<String, dynamic> header) async {
    var response = await SingletonData.singletonData.dio
        .get(
      url,
      options: Options(
          headers: header,
          responseType: ResponseType.json,
          followRedirects: false,
          validateStatus: (status) {
            return status! < kValidateCode;
          }),
    )
        .timeout(const Duration(minutes: kLongTimeout), onTimeout: () {
      return kTimeoutResponse;
    }).catchError((error) {
      return networkErrorResponse(error);
    });

    return response;
  }

  Future<Response> _patch(String url, Map<String, dynamic> body,
      Map<String, dynamic> header) async {
    var response = await SingletonData.singletonData.dio
        .patch(
      url,
      data: body,
      options: Options(
          headers: header,
          responseType: ResponseType.json,
          followRedirects: false,
          validateStatus: (status) {
            return status! < kValidateCode;
          }),
    )
        .timeout(const Duration(minutes: kLongTimeout), onTimeout: () {
      return kTimeoutResponse;
    }).catchError((error) {
      return networkErrorResponse(error);
    });

    return response;
  }

  Future<Response> _put(String url, Map<String, dynamic> body,
      Map<String, dynamic> header) async {
    var response = await SingletonData.singletonData.dio
        .put(
      url,
      data: body,
      options: Options(
          headers: header,
          responseType: ResponseType.json,
          followRedirects: false,
          validateStatus: (status) {
            return status! < kValidateCode;
          }),
    )
        .timeout(const Duration(minutes: kLongTimeout), onTimeout: () {
      return kTimeoutResponse;
    }).catchError((error) {
      return networkErrorResponse(error);
    });

    return response;
  }

  Future<Response> _delete(String url, Map<String, dynamic> body,
      Map<String, dynamic> header) async {
    var response = await SingletonData.singletonData.dio
        .delete(
      url,
      data: body,
      options: Options(
          headers: header,
          responseType: ResponseType.json,
          followRedirects: false,
          validateStatus: (status) {
            return status! < kValidateCode;
          }),
    )
        .timeout(const Duration(minutes: kLongTimeout), onTimeout: () {
      return kTimeoutResponse;
    }).catchError((error) {
      return networkErrorResponse(error);
    });

    return response;
  }

  //interceptors
  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return SingletonData.singletonData.dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  Future<bool> refreshToken(String baseUrl) async {
    final url = '${baseUrl}auth/token';

    AppSettings appSettings = await appSettingsBloc.fetchAppSettings();

    String refreshToken = '';

    if (appSettings.loginResponse != null &&
        appSettings.loginResponse!.data != null &&
        appSettings.loginResponse!.data!.refreshToken != null) {
      refreshToken = '${appSettings.loginResponse!.data!.refreshToken}';
    }

    var response = await _post(url, {
      "refreshToken": refreshToken
    }, {
      'Authorization': 'Bearer ${appSettings.loginResponse!.data!.token}',
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      String refreshToken = response.data['data'] != null
          ? response.data['data']['refreshToken'] ?? ''
          : '';
      String accessToken = response.data['data'] != null
          ? response.data['data']['token'] ?? ''
          : '';

      AppSettings appSettings = await appSettingsBloc.fetchAppSettings();
      appSettings.loginResponse!.data!.refreshToken = refreshToken;
      appSettings.loginResponse!.data!.token = accessToken;

      await appSettingsBloc.saveLoginDetails(appSettings.loginResponse!,
          isLoggedIn: true);

      return true;
    } else if (response.statusCode == 500) {
      //redirect To Homescreen
      logoutGlobal();
      return false;
    } else {
      // refresh token is wrong
      await appSettingsBloc.setLogOut();

      return false;
    }
  }
}

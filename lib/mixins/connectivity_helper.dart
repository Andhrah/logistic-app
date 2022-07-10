/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:trakk/services/base_network_call_handler.dart';
import 'package:trakk/utils/app_toast.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/utils/singleton_data.dart';

typedef ProcessCompleted = Function();

class ConnectivityHelper {
  Future<bool> checkInternetConnection(
      {ProcessCompleted? hasInternetCallback,
      ProcessCompleted? hasNoInternetCallback,
      bool loadInternet = false}) async {
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        if (loadInternet) {
          String url = SingletonData.singletonData.baseURL!;

          if (url.isEmpty) {
            checkInternetConnection(
                hasInternetCallback: hasInternetCallback,
                hasNoInternetCallback: hasNoInternetCallback,
                loadInternet: loadInternet);
            return false;
          }
          var response = await SingletonData.singletonData.dio
              .get(
            url,
            options: Options(
                headers: {},
                responseType: ResponseType.json,
                followRedirects: false,
                validateStatus: (status) {
                  return status! < kValidateCode;
                }),
          )
              .timeout(const Duration(minutes: kLongTimeout), onTimeout: () {
            return Response(
                data: {"message": kHttpErrorText},
                statusCode: null,
                requestOptions: RequestOptions(path: ''));
          }).catchError((error) {
            return Response(
                data: {"message": kNetworkGeneralText},
                statusCode: null,
                requestOptions: RequestOptions(path: ''));
          });

          if (response.statusCode != null) {
            if (hasInternetCallback != null) hasInternetCallback();

            return true;
          }
        } else {
          if (hasInternetCallback != null) hasInternetCallback();

          return true;
        }
      } catch (err) {
        if (hasNoInternetCallback != null) hasNoInternetCallback();

        _showNoInternet();

        return false;
      }

      return false;
    } else {
      if (hasNoInternetCallback != null) hasNoInternetCallback();

      _showNoInternet();

      return false;
    }
  }

  _showNoInternet() {
    appToast('No Internet Connection', redColor, isSuccess: false);
  }
}

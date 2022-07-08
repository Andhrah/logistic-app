import 'dart:convert';

//import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:http/http.dart';
import 'package:trakk/bloc/app_settings_bloc.dart';
import 'package:trakk/services/base_network_call_handler.dart';
import 'package:trakk/utils/enums.dart';
import 'package:trakk/utils/operation.dart';
import '../../Exceptions/api_failure_exception.dart';
import '../../utils/constant.dart';

class VehiclesListService extends BaseNetworkCallHandler {
  Future<Operation> getVehicles() {
    return runAPI(
        'api/vehicles?populate[riderId][populate][0]=merchantId&filters[riderId][merchantId][id][\$eq]=17',
        HttpRequestType.get);
  }
}

final vehiclesListService = VehiclesListService();

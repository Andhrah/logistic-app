/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:trakk/src/bloc/app_settings_bloc.dart';
import 'package:trakk/src/bloc/customer/customer_map_socket.dart';
import 'package:trakk/src/models/customer/customer_order_listener_response.dart';
import 'package:trakk/src/utils/app_toast.dart';
import 'package:trakk/src/utils/singleton_data.dart';
import 'package:trakk/src/values/enums.dart';

class CustomerMapProvider extends ChangeNotifier {
  static CustomerMapProvider customerMapProvider(BuildContext context,
      {bool listen = false}) {
    return Provider.of<CustomerMapProvider>(context, listen: listen);
  }

  bool isNewConnection = false;
  Socket? socket;

  String _orderToListenToID = '';

  String get orderToListenToID => _orderToListenToID;

  connectAndListenToSocket(
      {Function()? onConnected, Function()? onConnectionError}) async {
    var appSettings = await appSettingsBloc.fetchAppSettings();
    String? token = appSettings.loginResponse?.data?.token ?? '';

    socket = io(SingletonData.singletonData.socketURL, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
      'path': '/socket/v1/',
      'auth': {"token": token}
    }).connect();

    if (onConnected != null) onConnected();
    socket?.onConnect((data) {
      if (socket?.id != null) {
        customerStreamSocket.updateSocketID(socket?.id ?? '');
      }

      if (onConnected != null) onConnected();
      isNewConnection = true;
      if (kDebugMode) {
        print('connected: ${socket?.id}');
      }
    });

    socket?.onConnecting((_) {
      if (kDebugMode) {
        print('connecting');
      }
    });

    socket?.onConnectError((err) {
      if (onConnectionError != null) onConnectionError();
      if (kDebugMode) {
        print('connection error: ${err.toString()}');
      }
    });

    socket?.onError((data) {
      if (kDebugMode) print('error: ${data.toString()}');
    });

    socket?.onDisconnect((dis) {
      isNewConnection = false;

      if (kDebugMode) {
        print('disconnect: ${dis.toString()}');
      }
    });

    orderCancelledListener();
  }

  trackListener({required LatLng toLatLng, required String orderID}) {
    _orderToListenToID = orderID;
    notifyListeners();
    socket?.onAny((event, data) {
      log('new event $event ${jsonEncode(data)}');
    });

    socket?.on("customer_order_$orderID", (data) {
      log('order_request_data ${jsonEncode(data)}');

      CustomerOrderListenerResponse response =
          CustomerOrderListenerResponse.fromJson(data);

      // LatLng fromLatLng = LatLng(
      //     double.tryParse(response.info?.currentLatitude ?? '0.0') ?? 0.0,
      //     (double.tryParse(response.info?.currentLongitude ?? '0.0') ?? 0.0));

      debugPrint('order_request_data ${jsonEncode(data)}');
      // debugPrint(fromLatLng.latitude.toString());
      // debugPrint(fromLatLng.longitude.toString());
      customerStreamSocket.addResponseOnMove(response);
    });
  }

  removeTrackingListener() {
    socket?.off('customer_order_$_orderToListenToID');
  }

  orderCancelledListener() {
    socket?.onAny((event, data) {
      if (kDebugMode) {
        print('event: $event');
        print('event data: $data');
      }
    });
    //  when rider rejects an order, this is triggered

    socket?.on("order_cancelled", (data) {
      appToast(
          'An order has been rejected by a rider.\nPlease check order history to see details',
          appToastType: AppToastType.failed);
      log('order_id ${jsonEncode(data)}');
      // String orderID = data['order_id'] ?? '';
    });
  }

  disconnectSocket() {
    if (socket != null) {
      socket?.dispose();
    }
  }
}

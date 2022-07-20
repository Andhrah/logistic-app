import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:trakk/src/bloc/app_settings_bloc.dart';
import 'package:trakk/src/bloc/customer/customer_map_socket.dart';
import 'package:trakk/src/bloc/map_ui_extras_bloc.dart';
import 'package:trakk/src/models/customer/customer_order_listener_response.dart';

class CustomerMapProvider extends ChangeNotifier {
  static CustomerMapProvider customerMapProvider(BuildContext context,
      {bool listen = false}) {
    return Provider.of<CustomerMapProvider>(context, listen: listen);
  }

  bool isNewConnection = false;
  Socket? socket;

  connectAndListenToSocket(
      {required LatLng toLatLng,
      required String orderID,
      Function()? onConnected,
      Function()? onConnectionError}) async {
    var appSettings = await appSettingsBloc.fetchAppSettings();
    String? token = appSettings.loginResponse?.data?.token ?? '';
    // orderID = '355';

    if (kDebugMode) {
      print('token: $token');
    }

    socket = io("http://134.122.92.247:1440", <String, dynamic>{
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

    _listeners(toLatLng, orderID);
  }

  _listeners(LatLng toLatLng, String orderID) {
    socket?.onAny((event, data) {
      if (kDebugMode) {
        print('event: $event');
        print('orderID: $orderID');
      }
    });

    socket?.on("customer_order_$orderID", (data) {
      log('order_request_data ${jsonEncode(data)}');

      CustomerOrderListenerResponse response =
          CustomerOrderListenerResponse.fromJson(data);
      LatLng fromLatLng = LatLng(
          double.tryParse(response.info?.currentLatitude ?? '0.0') ?? 0.0,
          (double.tryParse(response.info?.currentLocation ?? '0.0') ?? 0.0));
      mapExtraUIBloc.updateMarkersWithCircle(
          [toLatLng], 'Destination', true, true,
          fromLatLng: fromLatLng);

      customerStreamSocket.addResponseOnMove(fromLatLng);
    });
  }

  disconnectSocket() {
    if (socket != null) {
      socket?.dispose();
    }
  }
}

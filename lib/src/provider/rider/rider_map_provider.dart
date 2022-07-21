import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:location/location.dart' as Loca;
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:trakk/src/bloc/app_settings_bloc.dart';
import 'package:trakk/src/bloc/misc_bloc.dart';
import 'package:trakk/src/bloc/rider/rider_map_socket.dart';
import 'package:trakk/src/bloc/rider_home_state_bloc.dart';
import 'package:trakk/src/models/rider/order_response.dart';
import 'package:trakk/src/values/enums.dart';
import 'package:trakk/src/utils/helper_utils.dart';

class RiderMapProvider extends ChangeNotifier {
  static RiderMapProvider riderMapProvider(BuildContext context,
      {bool listen = false}) {
    return Provider.of<RiderMapProvider>(context, listen: listen);
  }

  bool isNewConnection = false;
  Socket? socket;

  connectAndListenToSocket(
      {String? responseID,
      Function()? onConnected,
      Function()? onConnectionError}) async {
    var appSettings = await appSettingsBloc.fetchAppSettings();
    String? token = appSettings.loginResponse?.data?.token ?? '';
    String? riderID =
        '${appSettings.loginResponse?.data?.user?.rider?.id ?? ''}';

    print('token: $token');

    socket = io("http://134.122.92.247:1440", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
      'path': '/socket/v1/',
      'auth': {"token": token}
    }).connect();

    if (onConnected != null) onConnected();
    socket?.onConnect((data) {
      if (socket?.id != null)
        riderStreamSocket.updateSocketID(socket?.id ?? '');

      startUpdatingUserLocation(riderID);

      if (onConnected != null) onConnected();
      isNewConnection = true;
      print('connected: ${socket?.id}');
    });

    socket?.onConnecting((_) {
      print('connecting');
    });

    socket?.onConnectError((err) {
      if (onConnectionError != null) onConnectionError();
      print('connection error: ${err.toString()}');
    });

    socket?.onError((data) => print('error: ${data.toString()}'));

    socket?.onDisconnect((dis) {
      isNewConnection = false;

      print('disconnect: ${dis.toString()}');
    });

    _listeners(riderID);
  }

  _listeners(String riderID) async {
    socket?.onAny((event, data) {
      print('event: $event');
      print('riderID: $riderID');
    });
    socket?.on("rider_request_$riderID", (data) {
      log('rider_request_data ${jsonEncode(data)}');
      riderStreamSocket.addResponseOnMove(OrderResponse.fromJson(data));
      riderHomeStateBloc.updateState(RiderOrderState.isNewRequestIncoming);
    });

    // socket?.on('on:surrounding:packages', (data) {
    //   streamSocket.addSurroundingResponse([OrderResponse.fromJson(data)]);
    // });
  }

  disconnectSocket() {
    if (socket != null) {
      socket?.dispose();
    }
  }

  sendData(String riderID, Loca.LocationData? _loca, int? orderId) async {
    print('trying to emit');
    if (_loca != null) {
      if ((socket?.active ?? false) == true) {
        double lat =
            double.tryParse(_loca.latitude.toString().replaceAll(',', '')) ??
                0.0;
        double long =
            double.tryParse(_loca.longitude.toString().replaceAll(',', '')) ??
                0.0;
        String address = await getAddressFromLatLng(lat, long);
        Map<String, dynamic> _location = {
          'riderId': riderID,
          'orderId': orderId,
          'currentLatitude': _loca.latitude.toString(),
          'currentLongitude': _loca.longitude.toString(),
          'currentLocation': address == '...' ? '' : address
        };

        print(_location);
        _location.removeWhere((key, value) => value == null);

        if (socket?.id != null) {
          riderStreamSocket.updateSocketID(socket?.id ?? '');
        }

        socket?.emit('riders_location', _location);
        print('emitted riders_location: ${socket?.id}\n$_location');
      }
    }
  }

  startUpdatingUserLocation(String riderID) async {
    miscBloc.fetchLocation();
    miscBloc.location.onLocationChanged.listen((value) {
      Loca.LocationData? _loca = value;
      print('loation has changed');
      sendData(
          riderID,
          _loca,
          riderStreamSocket.behaviorSubject.hasValue
              ? riderStreamSocket.behaviorSubject.value.model?.order?.id
              : null);
    });
  }
}

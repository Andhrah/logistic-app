/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:location/location.dart' as Loca;
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:trakk/src/bloc/app_settings_bloc.dart';
import 'package:trakk/src/bloc/misc_bloc.dart';
import 'package:trakk/src/bloc/rider/rider_home_state_bloc.dart';
import 'package:trakk/src/bloc/rider/rider_map_socket.dart';
import 'package:trakk/src/bloc/socket_state_bloc.dart';
import 'package:trakk/src/models/rider/order_response.dart';
import 'package:trakk/src/utils/app_toast.dart';
import 'package:trakk/src/utils/helper_utils.dart';
import 'package:trakk/src/utils/singleton_data.dart';
import 'package:trakk/src/values/enums.dart';

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

    if (kDebugMode) {
      print('token: $token');
    }

    socket = io(SingletonData.singletonData.socketURL, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
      'path': '/socket/v1/',
      'auth': {"token": token}
    }).connect();

    socket?.onConnect((data) {
      socketStateBloc.updateState(NetworkState.connected);
      if (socket?.id != null) {
        riderStreamSocket.updateSocketID(socket?.id ?? '');
      }

      startUpdatingUserLocation(riderID);

      if (onConnected != null) onConnected();
      isNewConnection = true;
      if (kDebugMode) {
        print('connected: ${socket?.id}');
      }
      if (onConnected != null) onConnected();
    });

    socket?.onConnecting((_) {
      if (kDebugMode) {
        print('connecting');
      }
      socketStateBloc.updateState(NetworkState.connecting);
    });

    socket?.onConnectError((err) {
      socketStateBloc.updateState(NetworkState.connected);
      if (onConnectionError != null) onConnectionError();
      if (kDebugMode) {
        print('connection error: ${err.toString()}');
      }
    });

    socket?.onError((data) {
      if (kDebugMode) {
        print('error: ${data.toString()}');
      }
      socketStateBloc.updateState(NetworkState.noInternet);
    });

    socket?.onDisconnect((dis) {
      isNewConnection = false;
      socketStateBloc.updateState(NetworkState.disconnected);
      if (kDebugMode) {
        print('disconnect: ${dis.toString()}');
      }
    });

    _listeners(riderID);
  }

  _listeners(String riderID) async {
    // if (SingletonData.singletonData.isDebug) {
    //   socket?.onAny((event, data) {
    //     print('event: $event');
    //     print('riderID: $riderID');
    //   });
    // }
    socket?.on("rider_request_$riderID", (data) {
      log('rider_request_data ${jsonEncode(data)}');
      riderStreamSocket.addResponseOnMove(OrderResponse.fromJson(data));

      if (riderOrderStateBloc.newOrderState == NewOrderState.isOngoing) {
        appToast('New order. Swipe right to view Order');
        //  do stack order operation
      } else {
        riderHomeStateBloc.updateState(RiderOrderState.isNewRequestIncoming);
      }
      playNewRequestSound();
    });

    // socket?.on('on:surrounding:packages', (data) {
    //   streamSocket.addSurroundingResponse([OrderResponse.fromJson(data)]);
    // });
  }

  playNewRequestSound() async {
    await FlutterRingtonePlayer.stop();

    await FlutterRingtonePlayer.playNotification(looping: true);
    await Future.delayed(const Duration(seconds: 8), () {
      FlutterRingtonePlayer.stop();
    });
  }

  disconnectSocket() {
    if (socket != null) {
      socket?.dispose();
    }
  }

  sendData(String riderID, Loca.LocationData? _loca,
      {int? orderId, String? status}) async {
    if (kDebugMode) {
      print('trying to emit');
    }

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
          'currentLocation': address == '...' ? '' : address,
          'status': status
        };

        _location.removeWhere((key, value) => value == null);
        if (kDebugMode) {
          print(_location);
        }
        if (socket?.id != null) {
          riderStreamSocket.updateSocketID(socket?.id ?? '');
        }

        socket?.emit('riders_location', _location);
        if (kDebugMode) {
          print('emitted riders_location: ${socket?.id}\n$_location');
        }
      }
    }
  }

  startUpdatingUserLocation(String riderID) async {
    miscBloc.fetchLocation();
    miscBloc.location.onLocationChanged.listen((value) {
      Loca.LocationData? _loca = value;
      if (kDebugMode) {
        print('loation has changed');
      }

      //This makes sure rider location is emitted incase no order is found/ongoing
      sendData(riderID, _loca);

      //This broadcast rider location if order is ongoing
      if (riderStreamSocket.behaviorSubject.hasValue &&
          riderStreamSocket.behaviorSubject.value.model != null) {
        for (var data in riderStreamSocket.behaviorSubject.value.model ??
            <OrderResponse>[]) {
          sendData(riderID, _loca,
              orderId: data.order?.id, status: data.order?.status);
        }

        //This makes sure rider location is emitted incase no order is found/ongoing
        if ((riderStreamSocket.behaviorSubject.value.model ?? <OrderResponse>[])
            .isEmpty) {
          sendData(riderID, _loca);
        }
      }
    });
  }
}
// &pagination[pageSize]=25&pagination[page]=1

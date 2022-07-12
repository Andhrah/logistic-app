import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:location/location.dart' as Loca;
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:trakk/bloc/app_settings_bloc.dart';
import 'package:trakk/bloc/map_socket.dart';
import 'package:trakk/bloc/misc_bloc.dart';
import 'package:trakk/bloc/rider_home_state_bloc.dart';
import 'package:trakk/models/rider/order_response.dart';
import 'package:trakk/utils/enums.dart';

class RiderMapProvider extends ChangeNotifier {
  //final GetVehiclesListService _getVehiclesListService = GetVehiclesListService();

  static RiderMapProvider riderMapProvider(BuildContext context,
      {bool listen = false}) {
    return Provider.of<RiderMapProvider>(context, listen: listen);
  }

  bool isNewConnection = false;
  Socket? socket;

  // void connect() async {
  //   var appSettings = await appSettingsBloc.fetchAppSettings();
  //   String? token = appSettings.loginResponse?.data?.token ?? '';
  //
  //   socket = IO.io("http://134.122.92.247:1440", <String, dynamic>{
  //     "transports": ["websocket"],
  //     "autoConnect": false,
  //     'path': '/socket/v1/',
  //     'auth': {
  //       // put token here, it will be used to make authenticated calls
  //       "token": token
  //     }
  //   });
  //   socket?.connect();
  //   socket?.onConnect((data) => print(" the sever is connected"));
  //   // listenToRequest();
  //   print("this is the socket response " + socket!.connected.toString());
  //   //ride request with the rider id, so we will retrieve the rider's id and use it here
  //
  //   //socket.emit("message", "Test for riders");
  // }

  connectAndListenToSocket(
      {String? responseID,
      Function()? onConnected,
      Function()? onConnectionError}) async {
    var appSettings = await appSettingsBloc.fetchAppSettings();
    String? token = appSettings.loginResponse?.data?.token ?? '';
    String? riderID =
        '${appSettings.loginResponse?.data?.user?.rider?.id ?? ' '}';

    print('token: $token');

    socket = io("http://134.122.92.247:1440", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
      'path': '/socket/v1/',
      'auth': {"token": token}
    }).connect();

    if (onConnected != null) onConnected();
    socket?.onConnect((data) {
      if (socket?.id != null) streamSocket.updateSocketID(socket?.id ?? '');

      startUpdatingUserLocation(
          // userID
          );

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
    socket?.on("rider_request_$riderID", (data) {
      log('rider_request_data ${jsonEncode(data)}');
      streamSocket.addResponseOnMove(OrderResponse.fromJson(data));
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

//   emit to riders_location
//   with this payload
//
//   {
//   riderId:  :id
//   currentLongitude: currentLongitude,
//   currentLatitude: currentLatitude,
//   currentLocation: currentLocation
// }

  // rider_request_13

  sendData(// String userID,
      // Coord coord
      ) {
    if (socket?.id != null) {
      streamSocket.updateSocketID(socket?.id ?? '');
    }

    socket?.emit('rider', {
      // 'id': userID,
      'socketId': '${socket?.id}',
      // 'coords': coord.toJson(),
      'timestamp': DateTime.now().toIso8601String()
    });
    print('emitted: ${socket?.id}');
  }

  startUpdatingUserLocation(// String userID
      ) async {
    miscBloc.fetchLocation();
    miscBloc.location.onLocationChanged.listen((value) {
      Loca.LocationData? _loca = value;

      if (_loca != null) {
        // Coord coord = Coord(
        //     accuracy: _loca.accuracy.toString(),
        //     altitude: _loca.altitude.toString(),
        //     altitudeAccuracy: _loca.altitude.toString(),
        //     heading: _loca.heading.toString(),
        //     latitude: _loca.latitude.toString(),
        //     longitude: _loca.longitude.toString(),
        //     speed: _loca.speed.toString());

        if ((socket?.active ?? false) == true) {
          sendData(
              // userID,
              // coord
              );
        }
      }
    });
  }
}

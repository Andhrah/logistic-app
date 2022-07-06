import 'package:flutter/foundation.dart' as Foundation;
import 'package:flutter/material.dart';
import 'package:location/location.dart' as Loca;
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:trakk/bloc/map_socket.dart';
import 'package:trakk/bloc/misc_bloc.dart';
import 'package:trakk/models/rider/on_move_response.dart';
import 'package:trakk/utils/constant.dart';

class RiderMapProvider extends ChangeNotifier {
  //final GetVehiclesListService _getVehiclesListService = GetVehiclesListService();

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
    String? token;

    String? userID;

    socket = io(
            'http://134.122.92.247:1440/socket/v1/',
            OptionBuilder()
                .setAuth({'token': token})
                .setTransports(Foundation.kIsWeb ? ['polling'] : ['websocket'])
                .build())
        .connect();
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

    Loca.LocationData? riderLocationData = await fetchLocation();
    //When an event recieved from server, data is added to the stream
    // socket.on('on:move', (data) => print('on: ${data.toString()}'));

    socket?.on("rider_request_${box.get('riderId')}", (data) {
      streamSocket.addResponseOnMove(OnNewRequestResponse.fromJson(
          data,
          riderLocationData?.latitude ?? 0.0,
          riderLocationData?.longitude ?? 0.0));
    });

    socket?.on('on:surrounding:packages', (data) {
      streamSocket.addSurroundingResponse([
        OnNewRequestResponse.fromJson(data, riderLocationData?.latitude ?? 0.0,
            riderLocationData?.longitude ?? 0.0)
      ]);
    });

    socket?.onError((data) => print('error: ${data.toString()}'));

    socket?.onDisconnect((dis) {
      isNewConnection = false;

      print('disconnect: ${dis.toString()}');
    });
  }

  disconnectSocket() {
    if (socket != null) {
      socket?.dispose();
    }
  }

  sendData(// String userID,
      // Coord coord
      ) {
    if (socket?.id != null) {
      streamSocket.updateSocketID(socket?.id ?? '');
    }

    socket?.emit('user:online:location', {
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
    miscBloc.myLocationSubject.listen((value) {
      Loca.LocationData? _loca = value.model;

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

  Future<Loca.LocationData?> fetchLocation() async {
    Loca.LocationData? currentLocation;
    var location = Loca.Location();
    try {
      currentLocation = await location.getLocation();

      return currentLocation;
    } on Exception {
      currentLocation = null;

      return currentLocation;
    }
  }
}

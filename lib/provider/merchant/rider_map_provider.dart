import 'package:flutter/foundation.dart' as Foundation;
import 'package:flutter/material.dart';
import 'package:location/location.dart' as Loca;
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:trakk/bloc/map_socket.dart';
import 'package:trakk/models/rider/on_move_response.dart';

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

      startUpdatedUserLocation(userID);

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

    Loca.LocationData? locationData = await fetchLocation();
    //When an event recieved from server, data is added to the stream
    // socket.on('on:move', (data) => print('on: ${data.toString()}'));

    socket?.on('on:move', (data) {
      // if (isNewConnection && widget.flavor == Flavor.user) {
      //   print('fetch for user');
      //   getEmergencyResponseBloc.fetchCurrent( responseID);
      //   isNewConnection = false;
      //   // } else if (isNewConnection && widget.flavor == Flavor.user) {
      //   //   isNewConnection = false;
      // }

      streamSocket.addResponseOnMove(OnMoveResponse.fromJson(
          data, locationData?.latitude ?? 0.0, locationData?.longitude ?? 0.0));
    });

    socket?.on('on:surrounding:packages', (data) {
      streamSocket.addSurroundingResponse([
        OnMoveResponse.fromJson(
            data, locationData?.latitude ?? 0.0, locationData?.longitude ?? 0.0)
      ]);
    });
    socket?.on('response:already:accepted', (data) {});

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

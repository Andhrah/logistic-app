import 'dart:async';
import 'dart:typed_data';

import 'package:custom_bloc/custom_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as Loca;
import 'package:trakk/.env.dart';
import 'package:trakk/utils/assets.dart';
import 'package:trakk/utils/colors.dart';

class MapExtraUI {
  Set<Marker> marker;
  Set<Polyline> polyline;

  MapExtraUI({required this.marker, required this.polyline});
}

class MapExtraUIBloc with BaseBloc<MapExtraUI, String> {
  MapExtraUIBloc() {
    addToModel(MapExtraUI(marker: _markers, polyline: _polyLines));
  }

  final Locationpath _locationPath = Locationpath();

  Set<Marker> _markers = {};

  Set<Polyline> _polyLines = {};

  invalidate() {
    _markers = {};
    _polyLines = {};
    // updateMarker = true;
    // if (timer != null) timer.cancel();
    stopFetchingRoute();
    invalidateBaseBloc();
  }

  dispose() {
    disposeBaseBloc();
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

  updateMarkersWithCircle(
      List<LatLng> latLng, String snippet, bool createRoute) async {
    stopFetchingRoute();

    var data = await rootBundle.load(Assets.marker_icon);
    var bytes = data.buffer.asUint8List();
    final Uint8List markerIcon = bytes;

    if (latLng.any((element) => element != null)) {
      _markers.addAll(List.generate(
        latLng.length,
        (index) => Marker(
            markerId: MarkerId(latLng.toString()),
            position: latLng.elementAt(index),
            draggable: false,
            // zIndex: 2,
            // flat: true,
            // anchor: Offset(0.5, 0.5),
            // infoWindow: InfoWindow(
            //   title: '${user.firstName} ${user.lastName}',
            //   snippet: snippet,
            // ),

            icon: BitmapDescriptor.fromBytes(markerIcon)),
      ));

      addToModel(MapExtraUI(marker: _markers, polyline: _polyLines));

      if (createRoute) sendRequest(latLng.first);
    }
  }

  stopFetchingRoute() {
    //update function to add no content when available
    setAsLoading();
  }

  void sendRequest(LatLng destination) async {
    Loca.LocationData? currentLocation;
    var location = Loca.Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;

      return null;
    }
    LatLng myLocation = LatLng(
        currentLocation.latitude ?? 0.0, currentLocation.longitude ?? 0.0);

    String? route =
        await _locationPath.getRouteCoordinates(myLocation, destination);
    if (route != null) createRoute(route, destination);
  }

  void createRoute(String encondedPoly, LatLng latLng) {
    _polyLines = {};
    print('updating polyline');
    _polyLines.add(Polyline(
        polylineId: PolylineId(latLng.toString()),
        width: 4,
        points: _convertToLatLng(_decodePoly(encondedPoly)),
        color: secondaryColor));

    addToModel(MapExtraUI(marker: _markers, polyline: _polyLines));
  }

  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = [];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  // DECODE POLY
  List<double> _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = <double>[];
    int index = 0;
    int len = poly.length;
    int c = 0;

    do {
      var shift = 0;
      int result = 0;

      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);

      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

/*adding to previous value as done in encoding */
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    print(lList.toString());

    return lList;
  }
}

final mapExtraUIBloc = MapExtraUIBloc();

class Locationpath {
  Future getRouteCoordinates(LatLng l1, LatLng l2) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude}, ${l2.longitude}&key=$googleAPIKey";
    var response = await Dio().get(url);
    Map values = response.data;
    print('---route----');
    print(values);
    return values["routes"] != null &&
            values["routes"] is List &&
            values["routes"].length > 0
        ? values["routes"][0] != null
            ? values["routes"][0]["overview_polyline"] != null
                ? values["routes"][0]["overview_polyline"]["points"]
                : null
            : null
        : null;
  }
}

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
import 'package:trakk/utils/helper_utils.dart';

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
      List<LatLng> latLng, String snippet, bool createRoute, bool refreshMarker,
      {LatLng? fromLatLng}) async {
    stopFetchingRoute();

    print('updateMarkersWithCircle');
    var data = await rootBundle.load(Assets.marker_icon);
    var bytes = data.buffer.asUint8List();
    final Uint8List markerIcon = bytes;

    if (latLng.any((element) => element != null)) {
      // BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
      //   const ImageConfiguration(size: Size(14, 14)),
      //   Assets.marker_icon,
      // );

      final Uint8List? markerIcon = await getBytesFromAsset(
          snippet == 'Pickup' ? Assets.marker_icon : Assets.marker_icon, 55);
      BitmapDescriptor? markerbitmap =
          markerIcon == null ? null : BitmapDescriptor.fromBytes(markerIcon);
      if (refreshMarker) _markers = {};
      _markers.addAll(List.generate(
        latLng.length,
        (index) => markerbitmap != null
            ? Marker(
                markerId: MarkerId(latLng.toString()),
                position: latLng.elementAt(index),
                draggable: false,
                icon: markerbitmap)
            : Marker(
                markerId: MarkerId(latLng.toString()),
                position: latLng.elementAt(index),
                draggable: false),
      ));

      print('MapExtraUI');
      addToModel(MapExtraUI(marker: _markers, polyline: _polyLines));

      if (createRoute) sendRequest(latLng.first, fromLatLng: fromLatLng);
    }
  }

  stopFetchingRoute() {
    //update function to add no content when available
    setAsLoading();
  }

  void sendRequest(LatLng destination, {LatLng? fromLatLng}) async {
    Loca.LocationData? currentLocation;
    if (fromLatLng == null) {
      var location = Loca.Location();
      try {
        currentLocation = await location.getLocation();
      } on Exception {
        currentLocation = null;

        return null;
      }
    }
    LatLng myLocation = fromLatLng ??
        LatLng(currentLocation?.latitude ?? 0.0,
            currentLocation?.longitude ?? 0.0);

    print('sendRequest');
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

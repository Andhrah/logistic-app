import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/.env.dart';
import 'package:trakk/models/directions_model.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/.env.dart';

class PickUpScreen extends StatefulWidget {
  static const String id = 'pickup';

  const PickUpScreen({Key? key}) : super(key: key);

  @override
  _PickUpScreenState createState() => _PickUpScreenState();
}

class _PickUpScreenState extends State<PickUpScreen> {
  String currentText = "GO TO PICK-UP";
  final Completer<GoogleMapController> _controller = Completer();

  Directions? _info;

  final Set<Marker> markers = {}; //markers for google map
  static const LatLng _riderLatLng = LatLng(6.537827, 3.381352); // current rider location -latlng
  static const LatLng _pickUpLatLng = LatLng(6.539173, 3.384168); // pickup location -latlng
  static const double _cameraZoom = 17.5;
  static const double _cameraTilt = 150;
  static const double _cameraBearing = 45;

  final Set<Polyline> _polylines = <Polyline>{};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {}; //polylines to show direction


  //current rider location to show in map
  static const CameraPosition _riderLocation = CameraPosition(
    target: _riderLatLng,
    zoom: 14.4746,
  );

  static const CameraPosition _pickUpLocation = CameraPosition(
    // bearing: 192.8334901395799,
    target: _pickUpLatLng,
    // tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );

  @override
  void initState() {
    polylinePoints = PolylinePoints();

    // set up initial locations
    // this.setInitialLocation();
    getDirections(); //fetch direction polylines from Google API
      
    super.initState();
  }

  getDirections() async {
      List<LatLng> polylineCoordinates = [];
     
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPIKey,
        PointLatLng(_riderLatLng.latitude, _riderLatLng.longitude),
        PointLatLng(_pickUpLatLng.latitude, _pickUpLatLng.longitude),
        travelMode: TravelMode.driving,
      );

      if (result.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      } else {
        print(result.errorMessage);
      }
      addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: appPrimaryColor,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = const CameraPosition(
      zoom: _cameraZoom,
      tilt: _cameraTilt,
      bearing: _cameraBearing,
      target: _riderLatLng
    );
    
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal, //map type
        myLocationEnabled: true,
        tiltGesturesEnabled: false,
        initialCameraPosition: initialCameraPosition,
        markers: getmarkers(), // markers to show on map
        // polylines: _polylines,
        polylines: Set<Polyline>.of(polylines.values), //polylines
        onMapCreated: (
          GoogleMapController controller) { //method called when map is created
          _controller.complete(controller);
        },
      ),
       floatingActionButton: FloatingActionButton.extended(
         backgroundColor: appPrimaryColor,
        onPressed: () {
          setState(() {
            if(currentText == "GO TO PICK-UP"){
              currentText = "MARKED AS PICKED";
            } else if(currentText == "MARKED AS PICKED"){
              currentText = "GO TO DROP_OFF";
            } else if(currentText == "GO TO DROP_OFF"){
              currentText = "MARKED AS DELIVERED";
            }
          });
        },
        label: Text(
          currentText,
          textScaleFactor: 1.5,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        icon: const Icon(
          Remix.send_plane_fill,
          color: secondaryColor,
        ),
      )
    );
  }

  Set<Marker> getmarkers() { //markers to place on map
    setState(() {
      markers.add(Marker( //add first marker
        markerId: MarkerId(_riderLocation.toString()),
        position: _riderLatLng, //position of marker
        infoWindow: const InfoWindow( //popup info 
          title: 'Marker Title First ',
          snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      markers.add(Marker( //add second marker
        markerId: MarkerId(_pickUpLocation.toString()),
        position: _pickUpLatLng, //position of marker
        infoWindow: const InfoWindow( //popup info 
          title: 'Pickup location ',
          snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));
       //add more markers here 
    });

    return markers;
  }
}

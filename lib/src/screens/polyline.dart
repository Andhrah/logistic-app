// import 'dart:io';
// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// import 'package:socket_io_client/socket_io_client.dart';
// import 'package:trakk/src/utils/constant.dart';
//
// class PolylineScreen extends StatefulWidget {
//   static const String id = 'polyline';
//   var box = Hive.box('userData');
//
//   PolylineScreen({Key? key}) : super(key: key);
//
//   @override
//   _PolylineScreenState createState() => _PolylineScreenState();
// }
//
// class _PolylineScreenState extends State<PolylineScreen> {
//   var pickupLongitude = box.get("pickupLongitude").toString();
//   var pickupLatitude = box.get("pickupLongitude");
//
//   GoogleMapController? mapController; //contrller for Google map
//   PolylinePoints polylinePoints = PolylinePoints();
//
//   String googleAPiKey = "AIzaSyBvxkb0Gv6kwpiplPtmeQZhG4_V-KvLZ1U";
//
//   Set<Marker> markers = {}; //markers for google map
//   Map<PolylineId, Polyline> polylines = {}; //polylines to show direction
//
//   LatLng startLocation = LatLng(
//       double.parse(box.get("pickupLongitude")), double.parse(box.get("pickupLatitude")));
//   LatLng endLocation = LatLng(double.parse(box.get("destinationLatitude")),
//   // vaaa
//       double.parse(box.get("destinationLongitude")));
//
//   // LatLng startLocation = LatLng(27.6683619, 85.3101895);
//   // LatLng endLocation = LatLng(20.6875436, 80.2751138);
//
//   double distance = 0.0;
//
//   @override
//   void initState() {
//     markers.add(Marker(
//       //add start location marker
//       markerId: MarkerId(startLocation.toString()),
//
//       position: startLocation, //position of marker
//       infoWindow: const InfoWindow(
//         //popup info
//         title: 'Starting Point ',
//         snippet: 'Start Marker',
//       ),
//       icon: BitmapDescriptor.defaultMarker, //Icon for Marker
//     ));
//
//     markers.add(Marker(
//       //add distination location marker
//       markerId: MarkerId(endLocation.toString()),
//       position: endLocation, //position of marker
//       infoWindow: const InfoWindow(
//         //popup info
//         title: 'Destination Point ',
//         snippet: 'Destination Marker',
//       ),
//       icon: BitmapDescriptor.defaultMarker, //Icon for Marker
//     ));
//
//     getDirections(); //fetch direction polylines from Google API
//
//     super.initState();
//      print("${box.get(["destinationLongitude"].toString())} >>>>>>>>>long lat");
//   }
//
//   getDirections() async {
//     List<LatLng> polylineCoordinates = [];
//
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       googleAPiKey,
//       PointLatLng(startLocation.latitude, startLocation.longitude),
//       PointLatLng(endLocation.latitude, endLocation.longitude),
//       travelMode: TravelMode.driving,
//     );
//
//     if (result.points.isNotEmpty) {
//       result.points.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       });
//     } else {
//       print(result.errorMessage);
//     }
//     //polulineCoordinates is the List of longitute and latidtude.
//     double totalDistance = 0;
//     for (var i = 0; i < polylineCoordinates.length - 1; i++) {
//       totalDistance += calculateDistance(
//           polylineCoordinates[i].latitude,
//           polylineCoordinates[i].longitude,
//           polylineCoordinates[i + 1].latitude,
//           polylineCoordinates[i + 1].longitude);
//     }
//     print(totalDistance);
//
//     setState(() {
//       distance = totalDistance;
//     });
//     addPolyLine(polylineCoordinates);
//   }
//
//   addPolyLine(List<LatLng> polylineCoordinates) {
//     PolylineId id = const PolylineId("poly");
//     Polyline polyline = Polyline(
//       polylineId: id,
//       color: Colors.deepPurpleAccent,
//       points: polylineCoordinates,
//       width: 8,
//     );
//     polylines[id] = polyline;
//     setState(() {});
//   }
//
//   //it will return distance in KM
//   double calculateDistance(lat1, lon1, lat2, lon2) {
//     var p = 0.017453292519943295;
//     var a = 0.5 -
//         cos((lat2 - lat1) * p) / 2 +
//         cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
//     //showOrder(context, id,);
//     return 12742 * asin(sqrt(a));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Route Driection in Google Map"),
//         backgroundColor: Colors.deepPurpleAccent,
//       ),
//       body: Stack(children: [
//         GoogleMap(
//           //Map widget from google_maps_flutter package
//           zoomGesturesEnabled: true, //enable Zoom in, out on map
//           initialCameraPosition: CameraPosition(
//             //innital position in map
//             target: startLocation, //initial position
//             zoom: 16.0, //initial zoom level
//           ),
//           markers: markers, //markers to show on map
//           polylines: Set<Polyline>.of(polylines.values), //polylines
//           mapType: MapType.normal, //map type
//           onMapCreated: (controller) {
//             //method called when map is created
//             setState(() {
//               mapController = controller;
//             });
//           },
//         ),
//         Positioned(
//           bottom: 200,
//           left: 50,
//           child: Container(
//             child: Card(
//               child: Container(
//                 padding: const EdgeInsets.all(20),
//                 child: Text(
//                   "Total Distance: " + distance.toStringAsFixed(2) + " KM",
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ]),
//     );
//   }
// }
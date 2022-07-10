// import 'package:geolocator/geolocator.dart';
// import 'package:trakk/utils/constant.dart';
//
// class OnNewRequestResponse {
//   OnNewRequestResponse({this.order, this.arrivalTimeInMin, this.distanceInKM});
//
//   final RiderNewRequestOrder? order;
//   final int? arrivalTimeInMin;
//   final String? distanceInKM;
//
//   factory OnNewRequestResponse.fromJson(
//       Map<String, dynamic> json, double lat, double long) {
//     RiderNewRequestOrder? _onMoveLocation = json["order"] == null
//         ? null
//         : RiderNewRequestOrder.fromJson(json["order"]);
//     int _arrivalTime = json["arrivalTime"] ?? 0;
//     String _distanceInKm = '0.0';
//     if (_onMoveLocation != null &&
//         _onMoveLocation.pickupLatitude != null &&
//         _onMoveLocation.pickupLongitude != null) {
//       _distanceInKm =
//           '${(Geolocator.distanceBetween(lat, long, _onMoveLocation.pickupLatitude ?? 0.0, _onMoveLocation.pickupLongitude ?? 0.0).round() / 1000)}';
//       if (json["arrivalTime"] == null) {
//         _arrivalTime =
//             ((double.tryParse(_distanceInKm) ?? 0.0) / kSpeedInMinutes).round();
//       }
//     }
//
//     return OnNewRequestResponse(
//         order: _onMoveLocation,
//         arrivalTimeInMin: _arrivalTime,
//         distanceInKM: _distanceInKm);
//   }
//
//   Map<String, dynamic> toJson() => {
//         "order": order == null ? null : order!.toJson(),
//         "arrivalTime": arrivalTimeInMin,
//       };
// }
//
// // "pickupLongitude": data["order"]["pickupLongitude"],
// // "pickupLatitude": data["order"]["pickupLatitude"],
// // "destinationLatitude": data["order"]["destinationLatitude"],
// // "destinationLongitude": data["order"]["destinationLongitude"],
// // var id = data["order"]["id"];
// // var pickup = data["order"]["pickup"];
// // var destination = data["order"]["destination"];
// class RiderNewRequestOrder {
//   RiderNewRequestOrder({
//     this.pickupLongitude,
//     this.pickupLatitude,
//     this.destinationLatitude,
//     this.destinationLongitude,
//     this.id,
//     this.pickup,
//     this.destination,
//   });
//
//   final double? pickupLongitude;
//   final double? pickupLatitude;
//   final double? destinationLatitude;
//   final double? destinationLongitude;
//   final String? id;
//   final String? pickup;
//   final String? destination;
//
//   factory RiderNewRequestOrder.fromJson(Map<String, dynamic> json) {
//     return RiderNewRequestOrder(
//       pickupLongitude: json["pickupLongitude"] == null
//           ? null
//           : double.tryParse(
//                   json["pickupLongitude"].toString().replaceAll(',', '')) ??
//               0.0,
//       pickupLatitude: json["pickupLatitude"] == null
//           ? null
//           : double.tryParse(
//                   json["pickupLatitude"].toString().replaceAll(',', '')) ??
//               0.0,
//       destinationLatitude: json["destinationLatitude"] == null
//           ? null
//           : double.tryParse(
//                   json["destinationLatitude"].toString().replaceAll(',', '')) ??
//               0.0,
//       destinationLongitude: json["destinationLongitude"] == null
//           ? null
//           : double.tryParse(json["destinationLongitude"]
//                   .toString()
//                   .replaceAll(',', '')) ??
//               0.0,
//       id: json["id"] == null ? null : json["id"].toString(),
//       pickup: json["pickup"] == null ? null : json["pickup"].toString(),
//       destination:
//           json["destination"] == null ? null : json["destination"].toString(),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "pickupLongitude": pickupLongitude,
//         "pickupLatitude": pickupLatitude,
//         "destinationLatitude": destinationLatitude,
//         "destinationLongitude": destinationLongitude,
//         "id": id,
//         "pickup": pickup,
//         "destination": destination,
//       };
// }
//
//
//

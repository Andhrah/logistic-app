// import 'package:flutter/material.dart';
//
// import 'package:provider/provider.dart';
// import 'package:trakk/src/Exceptions/api_failure_exception.dart';
// import '../../services/merchant/vehicle_list_service.dart';
//
// class VehiclesProvider extends ChangeNotifier {
//    final GetVehiclesListService _getVehiclesListService = GetVehiclesListService();
//
//   static VehiclesProvider vehiclesProvider(BuildContext context,
//       {bool listen = false}) {
//     return Provider.of<VehiclesProvider>(context, listen: listen);
//   }
//
//   Future getVehiclesList() async {
//     try {
//       var response = await _getVehiclesListService.getVehiclesList();
//       print("Provider Test $response");
//       // _setInitialData(response);
//       return response;
//     } catch (err) {
//       throw ApiFailureException(err);
//     }
//   }
//
//
// }

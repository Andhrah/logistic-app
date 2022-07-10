import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:trakk/Exceptions/api_failure_exception.dart';
import '../../services/merchant/rider_profile_service.dart';

class RiderProfileProvider extends ChangeNotifier {
  //final GetVehiclesListService _getVehiclesListService = GetVehiclesListService();

  static RiderProfileProvider riderProfileProvider(BuildContext context,
      {bool listen = false}) {
    return Provider.of<RiderProfileProvider>(context, listen: listen);
  }

  Future getRiderProfile() async {
    try {
      var response = await RiderProfileService.getRiderProfile();
      print("Provider Test $response");
      // _setInitialData(response);
      return response;
    } catch (err) {
      throw ApiFailureException(err);
    }
  }
}

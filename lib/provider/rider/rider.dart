import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trakk/Exceptions/api_failure_exception.dart';
import 'package:trakk/services/rider/rider_auth.dart';

class RiderAuth extends ChangeNotifier {
  final RiderAuthService _riderAuthApi = RiderAuthService();

  static RiderAuth authProvider(BuildContext context, {bool listen = false}) {
    return Provider.of<RiderAuth>(context, listen: listen);
  }

  Future createRider(
    String firstName,
    String lastName,
    String email,
    String password,
    String phoneNumber,

    String stateOfOrigin,
    String stateOfResidence,
    String residentialAddress,

    String vehicleName,
    String vehicleColor,
    String vehicleNumber,
    String vehicleCapacity,
    String vehicleModel,
    int vehicleTypeId,
    List documents,

    String kinFirstName,
    String kinLastName,
    String kinPhoneNumber,
    String kinEmail,
    String kinAddress,
    String kinRelationship,
    ) async {
    try {
      var response = await _riderAuthApi.createRider(
        firstName,
        lastName,
        email,
        password,
        phoneNumber,
        stateOfOrigin,
        stateOfResidence,
        residentialAddress,
        vehicleName,
        vehicleColor,
        vehicleNumber,
        vehicleCapacity,
        vehicleModel,
        vehicleTypeId,
        documents,
        kinFirstName,
        kinLastName,
        kinPhoneNumber,
        kinEmail,
        kinAddress,
        kinRelationship,
      );
      print('[][][][][][][][][][] REGISTER [][][][][][][][][][][][]');
      print('user is a ${response}');
      return response;
    } catch(err) {
      throw ApiFailureException(err);
    }
  }
}
import 'package:trakk/bloc/app_settings_bloc.dart';
import 'package:trakk/models/rider/add_vehicle_to_merchant_model.dart';
import 'package:trakk/services/base_network_call_handler.dart';
import 'package:trakk/utils/enums.dart';
import 'package:trakk/utils/operation.dart';

class VehiclesListService extends BaseNetworkCallHandler {
  Future<Operation> addVehicleToRider(
      AddVehicleToMerchantModel addVehicle) async {
    return runAPI('api/vehicles', HttpRequestType.post,
        body: addVehicle.toJson());
  }

  Future<Operation> addVehicleDocument(
      String vehicleId, String documentName, String documentUrl) async {
    return runAPI('api/vehicle-documents', HttpRequestType.post, body: {
      "data": {
        "vehicleId": vehicleId,
        "documentName": documentName,
        "documentUrl": documentUrl
      }
    });
  }

  Future<Operation> deleteVehicleFromMerchant(String vehicleID) async {
    // String userID = await appSettingsBloc.getUserID;

    return runAPI('api/vehicles/$vehicleID', HttpRequestType.put, body: {
      "data": {"merchantId": ""}
    });
  }

  Future<Operation> getVehicles() async {
    String userID = await appSettingsBloc.getUserID;

    return runAPI(
        'api/vehicles?populate=riderId,riderId.userId,riderId.merchantId&filters[riderId][merchantId][id][\$eq]=$userID',
        HttpRequestType.get);
  }
}

final vehiclesListService = VehiclesListService();

import 'package:trakk/src/bloc/app_settings_bloc.dart';
import 'package:trakk/src/models/rider/add_vehicle_to_merchant_model.dart';
import 'package:trakk/src/services/base_network_call_handler.dart';
import 'package:trakk/src/utils/operation.dart';
import 'package:trakk/src/values/enums.dart';

class VehiclesListService extends BaseNetworkCallHandler {
  Future<Operation> addVehicleToRider(VehicleRequest addVehicle) async {
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
    return runAPI('api/vehicles/$vehicleID', HttpRequestType.delete);
  }

  Future<Operation> getVehiclesForMerchant(bool unassigned) async {
    String userID = await appSettingsBloc.getUserID;

    return runAPI(
        unassigned
            ? 'api/vehicles?populate=*&filters[merchantId][id][\$eq]=$userID'
            : 'api/vehicles?populate=riderId,riderId.userId,riderId.merchantId&filters[riderId][merchantId][id][\$eq]=$userID',
        HttpRequestType.get);
  }

  ///below are for rider
  Future<Operation> getVehiclesForRider() async {
    String userID = await appSettingsBloc.getUserID;

    return runAPI(
        'api/vehicles?populate=riderId,riderId.userId,riderId.merchantId&filters[riderId][id][\$eq]=$userID',
        HttpRequestType.get);
  }

  Future<Operation> updateVehiclesForRider(
      String vehicleID, VehicleRequest request) async {
    String userID = await appSettingsBloc.getUserID;

    return runAPI('api/vehicles/$vehicleID', HttpRequestType.put,
        body: request.toJson());
  }
}

final vehiclesListService = VehiclesListService();

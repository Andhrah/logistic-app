import 'package:trakk/bloc/app_settings_bloc.dart';
import 'package:trakk/models/rider/add_rider_to_merchant_model.dart';
import 'package:trakk/models/rider/add_vehicle_to_merchant_model.dart';
import 'package:trakk/models/update_profile/update_profile.dart';
import 'package:trakk/services/base_network_call_handler.dart';
import 'package:trakk/utils/enums.dart';
import 'package:trakk/utils/operation.dart';

class ProfileService extends BaseNetworkCallHandler {
  Future<Operation> getProfile() async {
    return runAPI('api/users/me', HttpRequestType.get);
  }

  Future<Operation> updateProfile(UpdateProfile updateProfile) async {
    var appSettings = await appSettingsBloc.fetchAppSettings();

    String id = '${(appSettings.loginResponse?.data?.user?.id)}';

    return runAPI('api/users/$id', HttpRequestType.put,
        body: updateProfile.toJson());
  }

  Future<Operation> addRiderToMerchant(
      AddRiderToMerchantModel addRiderToMerchantModel) async {
    return runAPI('api/riders?populate=*', HttpRequestType.post,
        body: addRiderToMerchantModel.toAddRiderToServerJson());
  }

  Future<Operation> addVehicleToRider(
      AddVehicleToMerchantModel addVehicle) async {
    return runAPI('api/riders?populate=*', HttpRequestType.post,
        body: addVehicle.toJson());
  }

  Future<Operation> addVehicleDocument(
      String vehicleId, Map<String, String> list) async {
    for (var data in list.keys) {
      var firstCall =
          await runAPI('api/vehicle-documents', HttpRequestType.post, body: {
        "data": {
          "vehicleId": vehicleId,
          "documentName": data,
          "documentUrl": "${list[data]}"
        }
      });
    }

    // todo: stack the API call
    return Operation(200, {'message': 'success'});
  }

  Future<Operation> getRiderRatings() async {
    return runAPI('api/ratings', HttpRequestType.get);
  }
}

final profileService = ProfileService();

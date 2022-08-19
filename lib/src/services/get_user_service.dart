import 'package:trakk/src/bloc/app_settings_bloc.dart';
import 'package:trakk/src/models/update_profile/update_profile.dart';
import 'package:trakk/src/services/base_network_call_handler.dart';
import 'package:trakk/src/utils/operation.dart';
import 'package:trakk/src/values/enums.dart';

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

  ///below are exclusive for rider
  Future<Operation> updateOnBoarding(
      {String? riderID,
      bool? completedContact,
      bool? completedNok,
      bool? completedVehicles}) async {
    String id = (riderID ?? await appSettingsBloc.getRootUserID);

    completedContact = completedContact ??
        (await appSettingsBloc.fetchAppSettings())
            .loginResponse
            ?.data
            ?.user
            ?.onBoardingSteps
            ?.riderContactCompleted ??
        false;
    completedNok = completedNok ??
        (await appSettingsBloc.fetchAppSettings())
            .loginResponse
            ?.data
            ?.user
            ?.onBoardingSteps
            ?.riderNOKCompleted ??
        false;
    completedVehicles = completedVehicles ??
        (await appSettingsBloc.fetchAppSettings())
            .loginResponse
            ?.data
            ?.user
            ?.onBoardingSteps
            ?.riderVehicleCompleted ??
        false;

    return runAPI('api/users/$id', HttpRequestType.put, body: {
      'onBoardingSteps': {
        'riderContactCompleted': completedContact,
        'riderNOKCompleted': completedNok,
        'riderVehicleCompleted': completedVehicles
      }
    });
  }

  Future<Operation> updateRider(UpdateProfile updateProfile) async {
    String id = await appSettingsBloc.getUserID;

    return runAPI('api/riders/$id', HttpRequestType.put,
        body: updateProfile.toUpdateRiderContactJson());
  }

  Future<Operation> updateRiderNextOfKin(UpdateProfile updateProfile) async {
    return runAPI('api/next-of-kins', HttpRequestType.post,
        body: updateProfile.toRiderNOKJson());
  }

  Future<Operation> updateRiderLocationManually(
      UpdateProfile updateProfile) async {
    String id = await appSettingsBloc.getUserID;

    return runAPI('api/riders/$id', HttpRequestType.put,
        body: updateProfile.toRiderLocationJson());
  }

  Future<Operation> getRiderRatings() async {
    return runAPI('api/ratings', HttpRequestType.get);
  }
}

final profileService = ProfileService();

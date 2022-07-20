import 'package:trakk/src/bloc/app_settings_bloc.dart';
import 'package:trakk/src/models/update_profile/update_profile.dart';
import 'package:trakk/src/services/base_network_call_handler.dart';
import 'package:trakk/src/values/enums.dart';
import 'package:trakk/src/utils/operation.dart';

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

  Future<Operation> getRiderRatings() async {
    return runAPI('api/ratings', HttpRequestType.get);
  }
}

final profileService = ProfileService();
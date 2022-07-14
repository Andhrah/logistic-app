import 'package:trakk/bloc/app_settings_bloc.dart';
import 'package:trakk/models/update_profile/update_profile.dart';
import 'package:trakk/services/base_network_call_handler.dart';
import 'package:trakk/utils/enums.dart';
import 'package:trakk/utils/operation.dart';

class ProfileService extends BaseNetworkCallHandler {
  Future<Operation> getProfile(String? authToken) async {
    Map<String, dynamic> masterHeader = authToken == null
        ? const {}
        : {
            'Authorization': 'Bearer $authToken',
            'Content-Type': 'application/json'
          };

    return runAPI('api/users/me', HttpRequestType.get, header: masterHeader);
  }

  Future<Operation> updateProfile(UpdateProfile updateProfile) async {
    var appSettings = await appSettingsBloc.fetchAppSettings();

    String id = '${(appSettings.loginResponse?.data?.user?.id)}';

    return runAPI('api/users/$id', HttpRequestType.put,
        body: updateProfile.toJson());
  }
}

final profileService = ProfileService();

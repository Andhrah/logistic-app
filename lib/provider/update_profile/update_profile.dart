
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:trakk/Exceptions/api_failure_exception.dart';

import 'package:trakk/services/update_profile_service.dart';
import 'package:trakk/utils/helper_utils.dart';


class UpdateUserProvider extends ChangeNotifier {
  final UpdateProfileService _updateProfileService = UpdateProfileService();

  static UpdateUserProvider updateUserProvider(BuildContext context,
      {bool listen = false}) {
    return Provider.of<UpdateUserProvider>(context, listen: listen);
  }

  Future updateUserProfile() async {
    try {
      var response = await _updateProfileService.updateUserProfile();
      print("Provider Test $response");
      // _setInitialData(response);
      return response;
    } catch (err) {
      throw ApiFailureException(err);
    }
  }
}
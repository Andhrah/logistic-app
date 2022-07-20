import 'package:flutter/material.dart';
import 'package:trakk/src/models/message_only_response.dart';
import 'package:trakk/src/services/merchant/add_rider_service.dart';
import 'package:trakk/src/services/merchant/vehicle_list_service.dart';
import 'package:trakk/src/utils/app_toast.dart';
import 'package:trakk/src/values/enums.dart';
import 'package:trakk/src/utils/helper_utils.dart';
import 'package:trakk/src/utils/operation.dart';
import 'package:trakk/src/utils/singleton_data.dart';
import 'package:trakk/src/values/styles.dart';

class MerchantUpdateRiderAndVehicleHelper {
  final BuildContext _authContext =
      SingletonData.singletonData.navKey.currentState!.context;
  final BuildContext _authContextOverLay =
      SingletonData.singletonData.navKey.currentState!.overlay!.context;

  doDeleteRider(String riderID, {Function()? onSuccessful}) async {
    showDialog(
        context: _authContext,
        builder: (context) => const Center(
              child: kCircularProgressIndicator,
            ));

    var operation = await addRiderService.deleteRiderFromMerchant(riderID);

    _completeDeleteRiderOperation(operation,
        onSuccessful: onSuccessful,
        onRetry: () => doDeleteRider(riderID, onSuccessful: onSuccessful));
  }

  _completeDeleteRiderOperation(Operation operation,
      {Function()? onSuccessful, Function()? onRetry}) async {
    Navigator.pop(_authContext);
    if (operation.code == 200 || operation.code == 201) {
      MessageOnlyResponse messageOnlyResponse =
          MessageOnlyResponse.fromJson(operation.result);

      await appToast(
          messageOnlyResponse.message ?? 'Rider removed successfully',
          appToastType: AppToastType.success);

      if (onSuccessful != null) onSuccessful();
    } else {
      MessageOnlyResponse messageOnlyResponse = operation.result;
      appToast(messageOnlyResponse.message ?? '',
          appToastType: AppToastType.failed);
      modalDialog(_authContext,
          title: 'Failed!. Retry?',
          positiveLabel: 'Yes',
          onPositiveCallback: () {
            Navigator.pop(_authContext);
            if (onRetry != null) onRetry();
          },
          negativeLabel: 'No',
          onNegativeCallback: () {
            Navigator.pop(_authContext);
          });
    }
  }

  doDeleteVehicle(String vehicleID, {Function()? onSuccessful}) async {
    showDialog(
        context: _authContext,
        builder: (context) => const Center(
              child: kCircularProgressIndicator,
            ));

    var operation =
        await vehiclesListService.deleteVehicleFromMerchant(vehicleID);

    _completeDeleteVehicleOperation(operation,
        onSuccessful: onSuccessful,
        onRetry: () => doDeleteVehicle(vehicleID, onSuccessful: onSuccessful));
  }

  _completeDeleteVehicleOperation(Operation operation,
      {Function()? onSuccessful, Function()? onRetry}) async {
    Navigator.pop(_authContext);
    if (operation.code == 200 || operation.code == 201) {
      MessageOnlyResponse messageOnlyResponse =
          MessageOnlyResponse.fromJson(operation.result);

      await appToast(
          messageOnlyResponse.message ?? 'Vehicle removed successfully',
          appToastType: AppToastType.success);

      if (onSuccessful != null) onSuccessful();
    } else {
      MessageOnlyResponse messageOnlyResponse = operation.result;
      appToast(messageOnlyResponse.message ?? '',
          appToastType: AppToastType.failed);
      modalDialog(_authContextOverLay,
          title: 'Failed!. Retry?',
          positiveLabel: 'Yes',
          onPositiveCallback: () {
            Navigator.pop(_authContext);
            if (onRetry != null) onRetry();
          },
          negativeLabel: 'No',
          onNegativeCallback: () {
            Navigator.pop(_authContext);
          });
    }
  }
}

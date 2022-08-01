import 'package:flutter/material.dart';
import 'package:trakk/src/bloc/merchant/get_riders_list_bloc.dart';
import 'package:trakk/src/mixins/profile_helper.dart';
import 'package:trakk/src/models/message_only_response.dart';
import 'package:trakk/src/models/rider/add_rider_to_merchant_model.dart';
import 'package:trakk/src/services/merchant/add_rider_service.dart';
import 'package:trakk/src/services/merchant/vehicle_list_service.dart';
import 'package:trakk/src/utils/app_toast.dart';
import 'package:trakk/src/utils/operation.dart';
import 'package:trakk/src/utils/singleton_data.dart';
import 'package:trakk/src/values/enums.dart';
import 'package:trakk/src/values/styles.dart';
import 'package:trakk/src/widgets/cancel_button.dart';
import 'package:trakk/src/widgets/general_widget.dart';

class MerchantUpdateRiderAndVehicleHelper with ProfileHelper {
  final BuildContext _authContext =
      SingletonData.singletonData.navKey.currentState!.context;
  final BuildContext _authContextOverLay =
      SingletonData.singletonData.navKey.currentState!.overlay!.context;

  updateRiderBioData(AddRiderToMerchantModel addRiderToMerchantModel) {
    showDialog(
        context: _authContext,
        builder: (context) => const Center(
              child: kCircularProgressIndicator,
            ));

    uploadProfilePic(addRiderToMerchantModel.data?.profilePicFile, ({url}) {
      addRiderToMerchantModel = addRiderToMerchantModel.copyWith(
          data: addRiderToMerchantModel.data!.copyWith(avatar: url));
      addRiderService
          .updateRiderUnderAMerchant(addRiderToMerchantModel)
          .then((value) => _completeUpdateRiderOperation(value));
    });
  }

  _completeUpdateRiderOperation(Operation operation) async {
    Navigator.pop(_authContext);
    if (operation.code == 200 || operation.code == 201) {
      getRidersListBloc.fetchCurrent();
      await appToast('Successful');
      Navigator.pop(_authContext);
    } else {
      MessageOnlyResponse messageOnlyResponse = operation.result;
      appToast(messageOnlyResponse.message ?? '',
          appToastType: AppToastType.failed);
    }
  }

  doDeleteRider(String riderID,
      {Function()? onSuccessful, bool isRemove = true}) async {
    showDialog(
        context: _authContext,
        builder: (context) => const Center(
              child: kCircularProgressIndicator,
            ));

    var operation = isRemove
        ? (await addRiderService.removeRiderFromMerchant(riderID))
        : (await addRiderService.deleteRiderByMerchant(riderID));

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

  suspendRider(
      {required String riderID,
      required String reasonForSuspension,
      required String suspensionEndDate,
      required String suspensionStartDate,
      required String status,
      required String name}) {
    showDialog(
        context: _authContext,
        builder: (context) => const Center(
              child: kCircularProgressIndicator,
            ));
    int days = DateTime.parse(suspensionEndDate)
        .difference(DateTime.parse(suspensionStartDate))
        .inDays;
    addRiderService
        .suspendRider(riderID, reasonForSuspension, suspensionEndDate,
            suspensionStartDate, status)
        .then((value) => _completeSuspendRiderOperation(
            value, name, '$days day${days > 1 ? 's' : ''}'));
  }

  _completeSuspendRiderOperation(
      Operation operation, String name, String duration) async {
    Navigator.pop(_authContext);
    if (operation.code == 200 || operation.code == 201) {
      await appToast('Successful', appToastType: AppToastType.success);
      Navigator.pop(_authContext);
      getRidersListBloc.fetchCurrent();
      showDialog<String>(
        // barrierDismissible: true,
        context: _authContext,
        builder: (BuildContext context) => AlertDialog(
          // title: const Text('AlertDialog Title'),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const CancelButton(),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Center(
                  child: Text(
                    'You have successfully suspended $name for $duration',
                    // maxLines: 2,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      MessageOnlyResponse messageOnlyResponse = operation.result;
      appToast(messageOnlyResponse.message ?? '',
          appToastType: AppToastType.failed);
    }
  }
}

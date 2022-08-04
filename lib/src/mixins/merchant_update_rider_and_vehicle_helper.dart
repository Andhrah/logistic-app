import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trakk/src/bloc/app_settings_bloc.dart';
import 'package:trakk/src/bloc/merchant/get_riders_list_bloc.dart';
import 'package:trakk/src/bloc/rider/get_vehicles_for_rider_list_bloc.dart';
import 'package:trakk/src/mixins/profile_helper.dart';
import 'package:trakk/src/models/message_only_response.dart';
import 'package:trakk/src/models/rider/add_rider_to_merchant_model.dart';
import 'package:trakk/src/models/rider/add_vehicle_to_merchant_model.dart';
import 'package:trakk/src/screens/merchant/add_rider_2/widgets/doc_selector_widget.dart';
import 'package:trakk/src/services/merchant/add_rider_service.dart';
import 'package:trakk/src/services/merchant/vehicle_list_service.dart';
import 'package:trakk/src/utils/app_toast.dart';
import 'package:trakk/src/utils/operation.dart';
import 'package:trakk/src/utils/singleton_data.dart';
import 'package:trakk/src/values/enums.dart';
import 'package:trakk/src/values/styles.dart';
import 'package:trakk/src/widgets/cancel_button.dart';
import 'package:trakk/src/widgets/general_widget.dart';
import 'package:uploadcare_client/uploadcare_client.dart';

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
      getRidersForMerchantListBloc.fetchCurrent();
      await appToast('Successful');
      Navigator.pop(_authContext);
    } else {
      MessageOnlyResponse messageOnlyResponse = operation.result;
      appToast(messageOnlyResponse.message ?? '',
          appToastType: AppToastType.failed);
    }
  }

  doDeleteRider(String riderID,
      {Function()? onSuccessful,
      RiderAccountRemovalType accountRemovalType =
          RiderAccountRemovalType.remove}) async {
    showDialog(
        context: _authContext,
        builder: (context) => const Center(
              child: kCircularProgressIndicator,
            ));

    var operation = (accountRemovalType == RiderAccountRemovalType.remove)
        ? (await addRiderService.removeRiderFromMerchant(riderID))
        : (await addRiderService.deleteRiderByMerchant(
            riderID,
            accountRemovalType == RiderAccountRemovalType.reactivate
                ? 'active'
                : 'deleted'));

    _completeDeleteRiderOperation(operation, accountRemovalType,
        onSuccessful: onSuccessful,
        onRetry: () => doDeleteRider(riderID,
            onSuccessful: onSuccessful,
            accountRemovalType: accountRemovalType));
  }

  _completeDeleteRiderOperation(
      Operation operation, RiderAccountRemovalType accountRemovalType,
      {Function()? onSuccessful, Function()? onRetry}) async {
    Navigator.pop(_authContext);
    if (operation.code == 200 || operation.code == 201) {
      MessageOnlyResponse messageOnlyResponse =
          MessageOnlyResponse.fromJson(operation.result);

      await appToast(
          messageOnlyResponse.message ??
              (accountRemovalType == RiderAccountRemovalType.delete
                  ? 'Rider deleted successfully'
                  : accountRemovalType == RiderAccountRemovalType.remove
                      ? 'Rider removed successfully'
                      : 'Rider activated successfully'),
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

  updateVehicle(String vehicleID, VehicleRequest request) {
    uploadToCloudinary(request.data!.files, (
        {Map<String, String>? images}) async {
      if (images != null) {
        request = request.copyWith(
            data: request.data!.copyWith(image: images[vehicleImageKey]));

        images.removeWhere((key, value) => key == vehicleImageKey);
      }
      request = request.copyWith(data: request.data!.copyWith(files: images));
      showDialog(
          context: _authContext,
          builder: (context) => const Center(
                child: kCircularProgressIndicator,
              ));

      vehiclesListService
          .updateVehiclesForRider(vehicleID, request)
          .then((value) => _completeUpdateVehicleOperation(value));
    });
  }

  _completeUpdateVehicleOperation(Operation operation) async {
    Navigator.pop(_authContext);
    if (operation.code == 200 || operation.code == 201) {
      if ((await appSettingsBloc.getUserType) == UserType.rider) {
        getVehiclesForRiderListBloc.fetchCurrent();
      }
      await appToast('Successful');
      Navigator.pop(_authContext);
    } else {
      MessageOnlyResponse messageOnlyResponse = operation.result;
      appToast(messageOnlyResponse.message ?? '',
          appToastType: AppToastType.failed);
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
      getRidersForMerchantListBloc.fetchCurrent();
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

  unSuspendRider({required String riderID}) {
    showDialog(
        context: _authContext,
        builder: (context) => const Center(
              child: kCircularProgressIndicator,
            ));

    addRiderService
        .removeSuspensionOfARider(
          riderID,
        )
        .then((value) => _completeUnSuspendRiderOperation(value));
  }

  _completeUnSuspendRiderOperation(Operation operation) async {
    Navigator.pop(_authContext);
    if (operation.code == 200 || operation.code == 201) {
      await appToast('Successful', appToastType: AppToastType.success);
      Navigator.pop(_authContext);
      getRidersForMerchantListBloc.fetchCurrent();
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
                child: const Center(
                  child: Text(
                    'You have successfully remove suspension',
                    // maxLines: 2,
                    style: TextStyle(
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

  uploadToCloudinary(Map<String, String>? files,
      Function({Map<String, String>? images}) callback) async {
    ///This checks if the image exist and upload, the proceeds to create order.
    ///If image is null, it proceeds to image order
    if (files != null && files.isNotEmpty) {
      files.removeWhere((key, value) => value.isEmpty);
      showDialog(
          context: _authContext,
          builder: (context) =>
              const Center(child: kCircularProgressIndicator));

      final CancelToken _cancelToken = CancelToken('canceled by user');
      try {
        final resources = await Future.wait(files.values.map((filePath) async =>
            await SingletonData.singletonData.uploadCareClient!.upload.auto(
              UCFile(File(filePath)),
              cancelToken: _cancelToken,
              storeMode: false,
              runInIsolate: true,
              onProgress: (progress) {
                // debugPrint('Uploading image from file with progress: $progress');
              },
              metadata: {
                'metakey': 'metavalue',
              },
            )));

        Navigator.pop(_authContext);

        for (int i = 0; i < resources.length; i++) {
          files[files.keys.elementAt(i)] =
              '${SingletonData.singletonData.imageURL}${resources.elementAt(i)}/';

          // responses.elementAt(i).secureUrl ?? '';
        }
        callback(images: files);
      } on CancelUploadException catch (e) {
        Navigator.pop(_authContext);

        debugPrint(e.toString());
        appToast('Could not process request at the moment.\nPlease try again',
            appToastType: AppToastType.failed);
      } catch (err) {
        Navigator.pop(_authContext);
        appToast('Could not process request at the moment.\nPlease try again',
            appToastType: AppToastType.failed);

        debugPrint(err.toString());
      }
    } else {
      callback();
    }
  }
}

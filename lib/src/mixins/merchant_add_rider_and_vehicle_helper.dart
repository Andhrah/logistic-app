import 'dart:developer';
import 'dart:io';

import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:flutter/material.dart';
import 'package:trakk/main.dart';
import 'package:trakk/src/models/auth/signup_model.dart';
import 'package:trakk/src/models/auth_response.dart';
import 'package:trakk/src/models/message_only_response.dart';
import 'package:trakk/src/models/rider/add_rider_to_merchant_model.dart';
import 'package:trakk/src/models/rider/add_vehicle_to_merchant_model.dart';
import 'package:trakk/src/screens/merchant/add_rider_2/widgets/doc_selector_widget.dart';
import 'package:trakk/src/screens/merchant/list_of_riders.dart';
import 'package:trakk/src/screens/merchant/list_of_vehicles.dart';
import 'package:trakk/src/services/auth/signup_service.dart';
import 'package:trakk/src/services/merchant/add_rider_service.dart';
import 'package:trakk/src/services/merchant/vehicle_list_service.dart';
import 'package:trakk/src/utils/app_toast.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/values/enums.dart';
import 'package:trakk/src/utils/helper_utils.dart';
import 'package:trakk/src/utils/operation.dart';
import 'package:trakk/src/utils/singleton_data.dart';
import 'package:trakk/src/widgets/button.dart';
import 'package:trakk/src/widgets/cancel_button.dart';

class MerchantAddRiderAndVehicleHelper {
  final BuildContext _authContext =
      SingletonData.singletonData.navKey.currentState!.context;
  final BuildContext _authContextOverLay =
      SingletonData.singletonData.navKey.currentState!.overlay!.context;
  AddRiderToMerchantModel? _riderToMerchantModel;

  AddVehicleToMerchantModel? _vehicleModel;

  ///step 1a
  doCreateRider(AddRiderToMerchantModel addRiderToMerchantModel,
      AddVehicleToMerchantModel vehicleModel,
      {Function()? onSuccess}) async {
    _riderToMerchantModel = addRiderToMerchantModel;
    _vehicleModel = vehicleModel;

    showDialog(
        context: _authContext,
        builder: (context) => const Center(
              child: kCircularProgressIndicator,
            ));

    var operation = await signupService.doSignUp(
      SignupModel(
          firstName: addRiderToMerchantModel.data?.firstName,
          lastName: addRiderToMerchantModel.data?.lastName,
          email: addRiderToMerchantModel.data?.email,
          phoneNumber: addRiderToMerchantModel.data?.phone,
          password: addRiderToMerchantModel.data?.password,
          userType: 'rider'),
    );

    _completeCreateRiderOperation(operation,
        onSuccess: onSuccess,
        onRetry: () => doCreateRider(addRiderToMerchantModel, vehicleModel,
            onSuccess: onSuccess));
    // });
  }

  ///step 1b
  _completeCreateRiderOperation(Operation operation,
      {Function()? onSuccess, Function()? onRetry}) async {
    Navigator.pop(_authContext);
    if (operation.code == 200 || operation.code == 201) {
      AuthResponse authResponse = AuthResponse.fromJson(operation.result);
      _riderToMerchantModel = _riderToMerchantModel!.copyWith(
          data: _riderToMerchantModel!.data!
              .copyWith(userId: '${authResponse.data?.user?.id ?? ''}'));

      addRiderBioData(_riderToMerchantModel!, _vehicleModel!,
          onSuccessCallback: onSuccess);
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

  ///step 2a
  addRiderBioData(AddRiderToMerchantModel addRiderToMerchantModel,
      AddVehicleToMerchantModel vehicleModel,
      {Function()? onSuccessCallback}) {
    _riderToMerchantModel = addRiderToMerchantModel;
    _vehicleModel = vehicleModel;

    showDialog(
        context: _authContext,
        builder: (context) => const Center(
              child: kCircularProgressIndicator,
            ));

    addRiderService.addRiderToMerchant(_riderToMerchantModel!).then((value) =>
        _completeAddRiderOperation(value,
            onSuccessCallback: onSuccessCallback,
            onRetry: () => addRiderBioData(
                addRiderToMerchantModel, vehicleModel,
                onSuccessCallback: onSuccessCallback)));
  }

  ///step 2b
  _completeAddRiderOperation(Operation operation,
      {Function()? onSuccessCallback, Function()? onRetry}) async {
    Navigator.pop(_authContext);
    if (operation.code == 200 || operation.code == 201) {
      _vehicleModel = _vehicleModel!.copyWith(
          data: _vehicleModel!.data!
              .copyWith(riderId: _riderToMerchantModel!.data!.userId));
      addVehicle(_vehicleModel!,
          addRiderToMerchantModel: _riderToMerchantModel,
          onSuccessCallback: onSuccessCallback);
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

  /// Step 3: upload for cloudinary
  uploadToCloudinary(Map<String, String>? files,
      Function({Map<String, String>? images}) callback) async {
    ///This checks if the image exist and upload, the proceeds to create order.
    ///If image is null, it proceeds to image order
    if (files != null && cloudinaryUploadPreset.isNotEmpty) {
      showDialog(
          context: _authContext,
          builder: (context) =>
              const Center(child: kCircularProgressIndicator));

      final resources = await Future.wait(files.values.map((filePath) async =>
          CloudinaryUploadResource(
              uploadPreset: cloudinaryUploadPreset,
              filePath: filePath,
              fileBytes: File(filePath).readAsBytesSync(),
              resourceType: CloudinaryResourceType.image,
              folder:
                  'rider_image_${_vehicleModel?.data?.riderId ?? 'unknown'}',
              progressCallback: (count, total) {
                // print('Uploading image from file with progress: $count/$total');
              })));
      List<CloudinaryResponse> responses =
          await cloudinary.uploadResources(resources);

      Navigator.pop(_authContext);

      if (responses.any((element) => !element.isSuccessful)) {
        //  show retry popup
        appToast('Could not process request at the moment.\nPlease try again',
            appToastType: AppToastType.failed);
        return;
      }

      for (int i = 0; i < files.length; i++) {
        files[files.keys.elementAt(i)] = responses.elementAt(i).secureUrl ?? '';
      }
      callback(images: files);
    } else {
      callback();
    }
  }

  ///step 4a, Note: This is also used for direct/single add vehicle only
  addVehicle(
    AddVehicleToMerchantModel vehicleModel, {
    Function()? onSuccessCallback,
    AddRiderToMerchantModel? addRiderToMerchantModel,
  }) {
    _vehicleModel = vehicleModel;
    _riderToMerchantModel = addRiderToMerchantModel;

    uploadToCloudinary(_vehicleModel!.data!.files, (
        {Map<String, String>? images}) async {
      if (images != null) {
        _vehicleModel = _vehicleModel!.copyWith(
            data:
                _vehicleModel!.data!.copyWith(image: images[vehicleImageKey]));

        images.removeWhere((key, value) => key == vehicleImageKey);
      }
      _vehicleModel = _vehicleModel!
          .copyWith(data: _vehicleModel!.data!.copyWith(files: images));
      showDialog(
          context: _authContext,
          builder: (context) => const Center(
                child: kCircularProgressIndicator,
              ));

      vehiclesListService.addVehicleToRider(_vehicleModel!).then((value) =>
          _completeAddVehicleOperation(value,
              onSuccessCallback: onSuccessCallback,
              onRetry: () => addVehicle(vehicleModel,
                  onSuccessCallback: onSuccessCallback,
                  addRiderToMerchantModel: addRiderToMerchantModel)));
    });
  }

  ///step 4b
  _completeAddVehicleOperation(Operation operation,
      {Function()? onSuccessCallback, Function()? onRetry}) async {
    Navigator.pop(_authContext);
    if (operation.code == 200 || operation.code == 201) {
      log('vehicle added: ${operation.result}');

      if ((_vehicleModel?.data?.files?.length ?? 0) > 0) {
        final operations = await Future.wait(_vehicleModel!.data!.files!.keys
            .map((key) => vehiclesListService.addVehicleDocument(
                operation.result['data']['id'].toString(),
                key,
                _vehicleModel!.data!.files![key] ?? '')));

        if (operations.any((element) => element.code != 200)) {
          //  show retry popup
          appToast('Could not process request at the moment.\nPlease try again',
              appToastType: AppToastType.failed);
          return;
        }
      }

      _finalStep(
          operation,
          onSuccessCallback,
          () => _completeAddVehicleOperation(operation,
              onSuccessCallback: onSuccessCallback, onRetry: onRetry));
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

  ///step 4c: finalStep of submitting doc
  _finalStep(
      operation, Function()? onSuccessCallback, Function()? onRetry) async {
    if (operation.code == 200 || operation.code == 201) {
      if (_riderToMerchantModel != null) {
        await _showSuccessfulDialog(
            '${_riderToMerchantModel?.data?.firstName ?? ''} has been added to rider list',
            'View All Riders', () {
          Navigator.pop(_authContext);
          if (onSuccessCallback != null) onSuccessCallback();
          Navigator.pushNamed(_authContext, ListOfRiders.id);
        }, nextAction: () async {
          Navigator.pop(_authContext);
          await _showSuccessfulDialog(
              '${camelCase(_vehicleModel?.data?.name ?? '')} has been added to vehicle list',
              'View All Vehicles', () {
            Navigator.pop(_authContext);
            if (onSuccessCallback != null) onSuccessCallback();
            Navigator.pushNamed(_authContext, ListOfVehicles.id);
          });
        });
      } else {
        await _showSuccessfulDialog(
            '${camelCase(_vehicleModel?.data?.name ?? '')} has been added to vehicle list',
            'View All Vehicles', () {
          Navigator.pop(_authContext);
          if (onSuccessCallback != null) onSuccessCallback();
          Navigator.pushNamed(_authContext, ListOfVehicles.id);
        });
      }

      appToast('Rider added successfully', appToastType: AppToastType.success);
    } else {
      Navigator.pop(_authContext);

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

  Future _showSuccessfulDialog(
      String title, String buttonText, Function() onClose,
      {Function()? nextAction}) async {
    return await showDialog<String>(
      // barrierDismissible: true,
      context: _authContext,
      builder: (BuildContext context) => AlertDialog(
        // title: const Text('AlertDialog Title'),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
        content: SizedBox(
          height: 250.0,
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                    onTap: () {
                      if (nextAction != null) nextAction();
                    },
                    child: const CancelButton())
              ],
            ),
            20.heightInPixel(),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 30),
                  Button(
                      text: buttonText,
                      onPress: () {
                        onClose();
                      },
                      color: appPrimaryColor,
                      textColor: whiteColor,
                      isLoading: false,
                      width: 300
                      //MediaQuery.of(context).size.width/1.6,
                      ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

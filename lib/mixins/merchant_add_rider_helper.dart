import 'dart:developer';
import 'dart:io';

import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:flutter/material.dart';
import 'package:trakk/main.dart';
import 'package:trakk/models/auth/signup_model.dart';
import 'package:trakk/models/auth_response.dart';
import 'package:trakk/models/message_only_response.dart';
import 'package:trakk/models/rider/add_rider_to_merchant_model.dart';
import 'package:trakk/models/rider/add_vehicle_to_merchant_model.dart';
import 'package:trakk/services/auth/signup_service.dart';
import 'package:trakk/services/get_user_service.dart';
import 'package:trakk/utils/app_toast.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/utils/constant.dart';
import 'package:trakk/utils/enums.dart';
import 'package:trakk/utils/helper_utils.dart';
import 'package:trakk/utils/operation.dart';
import 'package:trakk/utils/singleton_data.dart';
import 'package:trakk/utils/styles.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/widgets/cancel_button.dart';

class MerchantAddRiderHelper {
  final BuildContext _authContext =
      SingletonData.singletonData.navKey.currentState!.context;
  final BuildContext _authContextOverLay =
      SingletonData.singletonData.navKey.currentState!.overlay!.context;
  AddRiderToMerchantModel? _riderToMerchantModel;

  AddVehicleToMerchantModel? _vehicleModel;

  ///step 1a
  doCreateRider(AddRiderToMerchantModel addRiderToMerchantModel,
      AddVehicleToMerchantModel vehicleModel) async {
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

    _completeCreateRiderOperation(operation, onRetry: () => doCreateRider);
    // });
  }

  ///step 1b
  _completeCreateRiderOperation(Operation operation,
      {Function()? onRetry}) async {
    Navigator.pop(_authContext);
    if (operation.code == 200 || operation.code == 201) {
      AuthResponse authResponse = AuthResponse.fromJson(operation.result);
      _riderToMerchantModel = _riderToMerchantModel!.copyWith(
          data: _riderToMerchantModel!.data!
              .copyWith(userId: '${authResponse.data?.user?.rider?.id ?? ''}'));

      addRiderBioData(_riderToMerchantModel!, _vehicleModel!);
    } else {
      MessageOnlyResponse messageOnlyResponse = operation.result;
      appToast(messageOnlyResponse.message ?? '',
          appToastType: AppToastType.failed);
      //  do retry
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

    profileService.addRiderToMerchant(_riderToMerchantModel!).then((value) =>
        _completeAddRiderOperation(value,
            onSuccessCallback: onSuccessCallback,
            onRetry: () => addRiderBioData));
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
          addRiderToMerchantModel: _riderToMerchantModel);
    } else {
      MessageOnlyResponse messageOnlyResponse = operation.result;
      appToast(messageOnlyResponse.message ?? '',
          appToastType: AppToastType.failed);

      //  do retry
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
                print('Uploading image from file with progress: $count/$total');
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

  ///step 4a
  addVehicle(
    AddVehicleToMerchantModel vehicleModel, {
    Function()? onSuccessCallback,
    AddRiderToMerchantModel? addRiderToMerchantModel,
  }) {
    _vehicleModel = vehicleModel;
    _riderToMerchantModel = addRiderToMerchantModel;

    uploadToCloudinary(_vehicleModel!.data!.files, (
        {Map<String, String>? images}) async {
      showDialog(
          context: _authContext,
          builder: (context) => const Center(
                child: kCircularProgressIndicator,
              ));

      profileService.addVehicleToRider(_vehicleModel!).then((value) =>
          _completeAddVehicleOperation(value,
              onSuccessCallback: onSuccessCallback, onRetry: () => addVehicle));
    });
  }

  ///step 4b
  _completeAddVehicleOperation(Operation operation,
      {Function()? onSuccessCallback, Function()? onRetry}) async {
    Navigator.pop(_authContext);
    if (operation.code == 200 || operation.code == 201) {
      log('vehicle added: ${operation.result}');

      profileService
          .addVehicleDocument(operation.result['data']['attributes']['id'],
              _vehicleModel!.data!.files!)
          .then((value) => (operation) async {
                if (operation.code == 200 || operation.code == 201) {
                  if (_riderToMerchantModel != null) {
                    await _showSuccessfulDialog(
                        '${_riderToMerchantModel?.data?.firstName ?? ''} has been added to rider list',
                        'View All Riders',
                        () {}, nextAction: () async {
                      await _showSuccessfulDialog(
                          '${_vehicleModel?.data?.name ?? ''} has been added to vehicle list',
                          'View All Vehicles',
                          () {});
                    });
                  } else {
                    await _showSuccessfulDialog(
                        '${_vehicleModel?.data?.name ?? ''} has been added to vehicle list',
                        'View All Vehicles',
                        () {});
                  }

                  appToast('Rider added successfully',
                      appToastType: AppToastType.success);
                } else {
                  Navigator.pop(_authContext);

                  MessageOnlyResponse messageOnlyResponse = operation.result;
                  appToast(messageOnlyResponse.message ?? '',
                      appToastType: AppToastType.failed);

                  //  do retry
                }
              });
    } else {
      MessageOnlyResponse messageOnlyResponse = operation.result;
      appToast(messageOnlyResponse.message ?? '',
          appToastType: AppToastType.failed);

      //  do retry
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

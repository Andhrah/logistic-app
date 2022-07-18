import 'dart:io';

import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:flutter/material.dart';
import 'package:trakk/bloc/app_settings_bloc.dart';
import 'package:trakk/main.dart';
import 'package:trakk/models/message_only_response.dart';
import 'package:trakk/models/order/order.dart';
import 'package:trakk/models/order/user_order_history_response.dart';
import 'package:trakk/screens/dispatch/track/customer_track_screen.dart';
import 'package:trakk/screens/tab.dart';
import 'package:trakk/services/order/order_api.dart';
import 'package:trakk/utils/app_toast.dart';
import 'package:trakk/utils/constant.dart';
import 'package:trakk/utils/enums.dart';
import 'package:trakk/utils/operation.dart';
import 'package:trakk/utils/singleton_data.dart';
import 'package:trakk/utils/styles.dart';

class MerchantAddRiderHelper {
  final BuildContext _authContext =
      SingletonData.singletonData.navKey.currentState!.context;
  final BuildContext _authContextOverLay =
      SingletonData.singletonData.navKey.currentState!.overlay!.context;

  ///upload for cloudinary
  uploadToCloudinary(
      String? filePath, Function({String? imageUrl}) callback) async {
    ///This checks if the image exist and upload, the proceeds to create order.
    ///If image is null, it proceeds to image order
    if (filePath != null && cloudinaryUploadPreset.isNotEmpty) {
      File file = File(filePath);
      showDialog(
          context: _authContext,
          builder: (context) =>
              const Center(child: kCircularProgressIndicator));

      String userid = await appSettingsBloc.getUserID;

      final response =
          await cloudinary.unsignedUploadResource(CloudinaryUploadResource(
              uploadPreset: cloudinaryUploadPreset,
              filePath: file.path,
              fileBytes: file.readAsBytesSync(),
              resourceType: CloudinaryResourceType.image,
              folder: 'order_images_$userid',
              fileName: '${userid}_${DateTime.now().millisecondsSinceEpoch}',
              progressCallback: (count, total) {
                print('Uploading image from file with progress: $count/$total');
              }));

      Navigator.pop(_authContext);
      if (response.isSuccessful) {
        callback(imageUrl: response.secureUrl);
      } else {
        appToast('Could not process request at the moment.\nPlease try again',
            appToastType: AppToastType.failed);
      }
    } else {
      callback();
    }
  }

  doCreateRider(OrderModel orderModel, Function() showLoading,
      Function() closeLoading) async {
    uploadToCloudinary(orderModel.data?.itemImage, ({String? imageUrl}) async {
      orderModel.data!.itemImage = imageUrl;

      showLoading();

      var operation = await orderAPI.createOrder(orderModel);

      _completeCreateOrderOperation(operation, closeLoading);
    });
  }

  _completeCreateOrderOperation(
      Operation operation, Function() closeLoading) async {
    closeLoading();

    if (operation.code == 200 || operation.code == 201) {
      UserType userType = await appSettingsBloc.getUserType;
      if (userType == UserType.customer) {
        Navigator.pushNamedAndRemoveUntil(
            _authContext, Tabs.id, ModalRoute.withName(Tabs.id),
            arguments: {'_selectedIndex': 2});
      } else {
        //  navigate back to screen for other user types
      }

      UserOrderHistoryDatum? datum = operation.result['data'] != null
          ? UserOrderHistoryDatum.fromJson(operation.result['data'])
          : null;

      dialogOrderPaymentSuccess(
          context: _authContext,
          datum: datum,
          onPositiveCallback: () {
            if (datum != null) {
              Navigator.pushNamed(_authContext, CustomerTrackScreen.id,
                  arguments: datum.toJson());
            }
            appToast('Order placed', appToastType: AppToastType.success);
          },
          onNegativeCallback: () {
            appToast('Order placed', appToastType: AppToastType.success);
          });
    } else {
      MessageOnlyResponse messageOnlyResponse = operation.result;
      appToast(
        messageOnlyResponse.message ?? '',
        appToastType: AppToastType.failed,
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trakk/models/message_only_response.dart';
import 'package:trakk/models/order/available_rider_response.dart';
import 'package:trakk/models/order/order.dart';
import 'package:trakk/screens/tab.dart';
import 'package:trakk/services/order/order_api.dart';
import 'package:trakk/utils/app_toast.dart';
import 'package:trakk/utils/enums.dart';
import 'package:trakk/utils/operation.dart';
import 'package:trakk/utils/singleton_data.dart';

class CustomerOrderHelper {
  final BuildContext _authContext =
      SingletonData.singletonData.navKey.currentState!.context;
  final BuildContext _authContextOverLay =
      SingletonData.singletonData.navKey.currentState!.overlay!.context;

  doGetAvailableRiders(LatLng pickup, LatLng dropOff,
      {required Function() loadingModal,
      required Function() closeModal,
      required Function(List<AvailableRiderDataRider> riders)
          successfulModal}) async {
    loadingModal();

    var operation = await orderAPI.getNearbyRiders(pickup, dropOff);

    _completeFetchRidersOperation(operation, closeModal, successfulModal);
  }

  _completeFetchRidersOperation(Operation operation, Function() closeModal,
      Function(List<AvailableRiderDataRider> riders) successfulModal) {
    closeModal();

    if (operation.code == 200 || operation.code == 201) {
      AvailableRiderResponse availableRiderResponse =
          AvailableRiderResponse.fromJson(operation.result);

      if ((availableRiderResponse.data?.riders?.length ?? 0) > 0) {
        successfulModal(availableRiderResponse.data!.riders!);
        return;
      }
      appToast(
        availableRiderResponse.data!.message ?? '',
        appToastType: AppToastType.failed,
      );
    } else {
      MessageOnlyResponse messageOnlyResponse = operation.result;
      appToast(
        messageOnlyResponse.message ?? '',
        appToastType: AppToastType.failed,
      );
    }
  }

  doCreateOrder(OrderModel orderModel, Function() showLoading,
      Function() closeLoading) async {
    showLoading();

    var operation = await orderAPI.createOrder(orderModel);

    _completeCreateOrderOperation(operation, closeLoading);
  }

  _completeCreateOrderOperation(Operation operation, Function() closeLoading) {
    closeLoading();

    if (operation.code == 200 || operation.code == 201) {
      Navigator.pushNamedAndRemoveUntil(
          _authContext, Tabs.id, ModalRoute.withName(Tabs.id));
      appToast('Order placed', appToastType: AppToastType.success);

      //  todo: route to map and trakking
    } else {
      MessageOnlyResponse messageOnlyResponse = operation.result;
      appToast(
        messageOnlyResponse.message ?? '',
        appToastType: AppToastType.failed,
      );
    }
  }
}

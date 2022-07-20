import 'package:flutter/material.dart';
import 'package:trakk/src/bloc/rider_home_state_bloc.dart';
import 'package:trakk/src/models/message_only_response.dart';
import 'package:trakk/src/services/order/order_api.dart';
import 'package:trakk/src/utils/app_toast.dart';
import 'package:trakk/src/values/enums.dart';
import 'package:trakk/src/utils/operation.dart';
import 'package:trakk/src/utils/singleton_data.dart';
import 'package:trakk/src/values/styles.dart';

class RiderOrderHelper {
  final BuildContext _authContext =
      SingletonData.singletonData.navKey.currentState!.overlay!.context;

  doAcceptOrder(String orderID) async {
    showDialog(
        context: _authContext,
        builder: (context) => const Center(
              child: kCircularProgressIndicator,
            ));

    var operation = await orderAPI.acceptOrder(orderID);

    _completeAcceptOperation(operation);
  }

  _completeAcceptOperation(Operation operation) {
    Navigator.pop(_authContext);

    if (operation.code == 200 || operation.code == 201) {
      appToast('Request Accepted', appToastType: AppToastType.success);
      riderHomeStateBloc.updateState(RiderOrderState.isRequestAccepted);
    } else {
      MessageOnlyResponse messageOnlyResponse = operation.result;
      appToast(
        messageOnlyResponse.message ?? '',
        appToastType: AppToastType.failed,
      );
    }
  }

  doDeclineOrder(String orderID) async {
    Navigator.pop(_authContext);
    showDialog(
        context: _authContext,
        builder: (context) => const Center(child: kCircularProgressIndicator));

    var operation = await orderAPI.declineOrder(orderID);

    _completeDeclineOperation(operation);
  }

  _completeDeclineOperation(Operation operation) {
    Navigator.pop(_authContext);

    if (operation.code == 200 || operation.code == 201) {
      appToast('Request Declined', appToastType: AppToastType.success);
      riderHomeStateBloc.updateState(RiderOrderState.isHomeScreen);
    } else {
      MessageOnlyResponse messageOnlyResponse = operation.result;
      appToast(messageOnlyResponse.message ?? '',
          appToastType: AppToastType.failed);
    }
  }

  doPickupOrder(String orderID) async {
    Navigator.pop(_authContext);
    showDialog(
        context: _authContext,
        builder: (context) => const Center(child: kCircularProgressIndicator));

    var operation = await orderAPI.pickupOrder(orderID);

    _completePickupOperation(operation);
  }

  _completePickupOperation(Operation operation) {
    Navigator.pop(_authContext);

    if (operation.code == 200 || operation.code == 201) {
      appToast('Item Picked Up', appToastType: AppToastType.success);
      riderHomeStateBloc
          .updateState(RiderOrderState.isItemPickedUpLocationAndEnRoute);
    } else {
      MessageOnlyResponse messageOnlyResponse = operation.result;
      appToast(
        messageOnlyResponse.message ?? '',
        appToastType: AppToastType.failed,
      );
    }
  }

  doDeliverOrder(String orderID) async {
    Navigator.pop(_authContext);
    showDialog(
        context: _authContext,
        builder: (context) => const Center(child: kCircularProgressIndicator));

    var operation = await orderAPI.deliverOrder(orderID);

    _completeDeliverOperation(operation);
  }

  _completeDeliverOperation(Operation operation) {
    Navigator.pop(_authContext);

    if (operation.code == 200 || operation.code == 201) {
      appToast('Item Delivered', appToastType: AppToastType.success);
      riderHomeStateBloc.updateState(RiderOrderState.isOrderCompleted);
    } else {
      MessageOnlyResponse messageOnlyResponse = operation.result;
      appToast(messageOnlyResponse.message ?? '',
          appToastType: AppToastType.failed);
    }
  }
}

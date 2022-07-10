import 'package:flutter/material.dart';
import 'package:trakk/bloc/rider_home_state_bloc.dart';
import 'package:trakk/models/message_only_response.dart';
import 'package:trakk/services/order/order_api.dart';
import 'package:trakk/utils/app_toast.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/utils/enums.dart';
import 'package:trakk/utils/operation.dart';
import 'package:trakk/utils/singleton_data.dart';

class OrderHelper {
  final BuildContext _authContext =
      SingletonData.singletonData.navKey.currentState!.overlay!.context;

  doAcceptOrder(String orderID) async {
    showDialog(
        context: _authContext,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    var operation = await orderAPI.acceptOrder(orderID);

    _completeAcceptOperation(operation);
  }

  _completeAcceptOperation(Operation operation) {
    Navigator.pop(_authContext);

    if (operation.code == 200 || operation.code == 201) {
      appToast('Request Accepted', green);
      riderHomeStateBloc.updateState(RiderOrderState.isRequestAccepted);
    } else {
      MessageOnlyResponse messageOnlyResponse = operation.result;
      appToast(messageOnlyResponse.message ?? '', redColor, isSuccess: false);
    }
  }

  doDeclineOrder(String orderID) async {
    Navigator.pop(_authContext);
    showDialog(
        context: _authContext,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    var operation = await orderAPI.declineOrder(orderID);

    _completeDeclineOperation(operation);
  }

  _completeDeclineOperation(Operation operation) {
    Navigator.pop(_authContext);

    if (operation.code == 200 || operation.code == 201) {
      appToast('Request Declined', green);
      riderHomeStateBloc.updateState(RiderOrderState.isHomeScreen);
    } else {
      MessageOnlyResponse messageOnlyResponse = operation.result;
      appToast(messageOnlyResponse.message ?? '', redColor, isSuccess: false);
    }
  }

  doPickupOrder(String orderID) async {
    Navigator.pop(_authContext);
    showDialog(
        context: _authContext,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    var operation = await orderAPI.pickupOrder(orderID);

    _completePickupOperation(operation);
  }

  _completePickupOperation(Operation operation) {
    Navigator.pop(_authContext);

    if (operation.code == 200 || operation.code == 201) {
      appToast('Item Picked Up', green);
      riderHomeStateBloc
          .updateState(RiderOrderState.isItemPickedUpLocationAndEnRoute);
    } else {
      MessageOnlyResponse messageOnlyResponse = operation.result;
      appToast(messageOnlyResponse.message ?? '', redColor, isSuccess: false);
    }
  }

  doDeliverOrder(String orderID) async {
    Navigator.pop(_authContext);
    showDialog(
        context: _authContext,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    var operation = await orderAPI.deliverOrder(orderID);

    _completeDeliverOperation(operation);
  }

  _completeDeliverOperation(Operation operation) {
    Navigator.pop(_authContext);

    if (operation.code == 200 || operation.code == 201) {
      appToast('Item Delivered', green);
      riderHomeStateBloc.updateState(RiderOrderState.isOrderCompleted);
    } else {
      MessageOnlyResponse messageOnlyResponse = operation.result;
      appToast(messageOnlyResponse.message ?? '', redColor, isSuccess: false);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trakk/bloc/rider_home_state_bloc.dart';
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
      riderHomeStateBloc.updateState(RiderOrderState.isRequestAccepted);
    } else {
      appToast(operation.result['message'] ?? '', green, isSuccess: false);
    }
  }

  doDeclineOrder(String orderID) async {
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
      //this is redundant but still make the update as a fail-safe
      riderHomeStateBloc.updateState(RiderOrderState.isHomeScreen);
    } else {
      appToast(operation.result['message'] ?? '', green, isSuccess: false);
    }
  }

  doPickupOrder(String orderID) async {
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
      riderHomeStateBloc.updateState(RiderOrderState.isEnRoute);
    } else {
      appToast(operation.result['message'] ?? '', green, isSuccess: false);
    }
  }

  doDeliverOrder(String orderID) async {
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
      riderHomeStateBloc.updateState(RiderOrderState.isOrderCompleted);
    } else {
      appToast(operation.result['message'] ?? '', green, isSuccess: false);
    }
  }
}

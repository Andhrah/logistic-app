/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'package:custom_bloc/custom_bloc.dart';
import 'package:trakk/src/models/rider/order_response.dart';

class RiderStreamSocket with BaseBloc<List<OrderResponse>, String> {
  String? _socketID;

  String? get socketID => _socketID;

  List<OrderResponse> orders = [];

  void addResponseOnMove(OrderResponse event) {
    orders.add(event);
    addToModel(orders);
  }

  remove({OrderResponse? data}) {
    if (data != null ||
        (orders
                .where((element) =>
                    element.order?.id == orderInFocus.acceptedOrderID)
                .isNotEmpty &&
            orders
                    .where((element) =>
                        element.order?.id == orderInFocus.acceptedOrderID)
                    .first
                    .order !=
                null)) {
      orders.remove(data ??
          orders
              .where((element) =>
                  element.order?.id == orderInFocus.acceptedOrderID)
              .first
              .order
              ?.id);
    }
    orderInFocus.invalidate();
    addToModel(orders);
  }

  updateSocketID(String socketID) => _socketID = socketID;

  invalidate() {
    orders = [];
    invalidateBaseBloc();
  }

  void dispose() {
    disposeBaseBloc();
  }
}

RiderStreamSocket riderStreamSocket = RiderStreamSocket();

class OrderInFocus with BaseBloc<int, String> {
  OrderInFocus() {
    setOrderInFocusID(acceptedOrderID);
  }

  int acceptedOrderID = -1;

  setOrderInFocusID(int value) {
    acceptedOrderID = value;
    addToModel(acceptedOrderID);
  }

  invalidate() {
    acceptedOrderID = -1;
    invalidateBaseBloc();
  }

  void dispose() {
    disposeBaseBloc();
  }
}

OrderInFocus orderInFocus = OrderInFocus();

/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'package:custom_bloc/custom_bloc.dart';
import 'package:trakk/src/models/rider/order_response.dart';
import 'package:trakk/src/values/enums.dart';

class RiderStreamSocket with BaseBloc<List<OrderResponse>, String> {
  String? _socketID;

  String? get socketID => _socketID;

  List<OrderResponse> orders = [];

  void addResponseOnMove(OrderResponse event) {
    print('called addResponseOnMove');
    if (!orders.contains(event)) {
      orders.add(event);
    }
    addToModel(orders);
  }

  updateStatus(RiderOrderStatus status) {
    var itemList = orders
        .where((element) => element.order?.id == orderInFocus.acceptedOrderID);
    if (itemList.isNotEmpty) {
      int index = orders.indexOf(itemList.first);
      var first = itemList.first;
      first.order?.status = status.name;
      orders[index] = first;
      addToModel(orders);
    }
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
      orders.remove((data) ??
          orders
              .where((element) =>
                  element.order?.id == orderInFocus.acceptedOrderID)
              .first);
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

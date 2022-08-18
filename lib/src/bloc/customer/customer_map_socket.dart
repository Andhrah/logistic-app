/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'package:custom_bloc/custom_bloc.dart';
import 'package:trakk/src/models/customer/customer_order_listener_response.dart';

class CustomerStreamSocket
    with BaseBloc<CustomerOrderListenerResponse, String> {
  String? _socketID;

  String? get socketID => _socketID;

  void addResponseOnMove(CustomerOrderListenerResponse data) {
    addToModel(data);
  }

  updateSocketID(String socketID) => _socketID = socketID;

  invalidate() => invalidateBaseBloc();

  void dispose() async {
    disposeBaseBloc();
  }
}

CustomerStreamSocket customerStreamSocket = CustomerStreamSocket();

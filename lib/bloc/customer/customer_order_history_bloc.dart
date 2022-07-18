/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'package:async/async.dart';
import 'package:custom_bloc/custom_bloc.dart';
import 'package:trakk/mixins/connectivity_helper.dart';
import 'package:trakk/models/message_only_response.dart';
import 'package:trakk/models/order/user_order_history_response.dart';
import 'package:trakk/services/base_network_call_handler.dart';
import 'package:trakk/services/order/order_api.dart';

class GetCustomersOrderHistoryBloc
    with BaseBloc<List<UserOrderHistoryDatum>, String>, ConnectivityHelper {
  CancelableOperation? _cancelableOperation;

  fetchCurrent() async {
    setAsLoading();
    checkInternetConnection(
        hasInternetCallback: () async {
          var operation = await orderAPI.getCustomerOrders();

          if (operation.code == 200 || operation.code == 201) {
            UserOrderHistoryResponse response =
                UserOrderHistoryResponse.fromJson(operation.result);

            if (response.data != null && response.data!.isNotEmpty) {
              response.data!.sort((a, b) =>
                  b.attributes!.createdAt!.compareTo(a.attributes!.createdAt!));
              addToModel(response.data!);
            } else {
              addToError("History not found");
            }
          } else {
            addToError((operation.result as MessageOnlyResponse).message!);
          }
        },
        hasNoInternetCallback: () => addToError(kNetworkGeneralText));
  }

  cancelOperation() async {
    if (_cancelableOperation != null) await _cancelableOperation!.cancel();
  }

  invalidate() {
    invalidateBaseBloc();
  }

  dispose() {
    disposeBaseBloc();
  }
}

final getCustomersOrderHistoryBloc = GetCustomersOrderHistoryBloc();

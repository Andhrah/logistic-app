/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'package:async/async.dart';
import 'package:custom_bloc/custom_bloc.dart';
import 'package:trakk/mixins/connectivity_helper.dart';
import 'package:trakk/models/message_only_response.dart';
import 'package:trakk/models/order/order_history_response.dart';
import 'package:trakk/services/base_network_call_handler.dart';
import 'package:trakk/services/order/order_api.dart';

class GetOrderHistoryBloc
    with BaseBloc<List<OrderHistoryDatum>, String>, ConnectivityHelper {
  CancelableOperation? _cancelableOperation;

  fetchCurrent() async {
    setAsLoading();
    checkInternetConnection(
        hasInternetCallback: () async {
          var operation = await orderAPI.getOrderHistory();

          if (operation.code == 200 || operation.code == 201) {
            OrderHistoryResponse response =
                OrderHistoryResponse.fromJson(operation.result);

            if (response.data != null &&
                response.data!.attributes != null &&
                response.data!.attributes!.attributes != null &&
                response.data!.attributes!.attributes!.data != null &&
                response.data!.attributes!.attributes!.data!.isNotEmpty) {
              response.data!.attributes!.attributes!.data!.sort((a, b) =>
                  b.attributes!.createdAt!.compareTo(a.attributes!.createdAt!));
              addToModel(response.data!.attributes!.attributes!.data!);
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

final getOrderHistoryBloc = GetOrderHistoryBloc();

/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'package:async/async.dart';
import 'package:custom_bloc/custom_bloc.dart';
import 'package:trakk/src/mixins/connectivity_helper.dart';
import 'package:trakk/src/models/message_only_response.dart';
import 'package:trakk/src/models/order/order_history_response.dart';
import 'package:trakk/src/services/base_network_call_handler.dart';
import 'package:trakk/src/services/order/order_api.dart';
import 'package:trakk/src/values/enums.dart';

class RiderNewRequestOrderHistoryBloc
    with BaseBloc<List<OrderHistoryDatum>, String>, ConnectivityHelper {
  CancelableOperation? _cancelableOperation;

  OrderHistoryType _type = OrderHistoryType.all;

  fetchCurrent(String startDate, String endDate,
      {OrderHistoryType? type}) async {
    if (type != null) _type = type;
    setAsLoading();
    checkInternetConnection(
        hasInternetCallback: () async {
          var operation =
              await orderAPI.getRiderOrderHistory(_type, startDate, endDate);

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

final riderNewRequestOrderHistoryBloc = RiderNewRequestOrderHistoryBloc();

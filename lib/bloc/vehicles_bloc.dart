/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'package:async/async.dart';
import 'package:custom_bloc/custom_bloc.dart';
import 'package:trakk/mixins/connectivity_helper.dart';
import 'package:trakk/models/message_only_response.dart';
import 'package:trakk/models/vehicles_list_response.dart';
import 'package:trakk/services/base_network_call_handler.dart';
import 'package:trakk/services/merchant/vehicle_list_service.dart';

class GetVehiclesListBloc
    with BaseBloc<List<VehiclesList>, String>, ConnectivityHelper {
  CancelableOperation? _cancelableOperation;

  fetchCurrent() async {
    setAsLoading();
    checkInternetConnection(
        hasInternetCallback: () async {
          var operation = await vehiclesListService.getVehicles();

          if (operation.code == 200 || operation.code == 201) {
            VehiclesListResponse response =
                VehiclesListResponse.fromJson(operation.result);

            if (response.data != null && response.data!.isNotEmpty) {
              addToModel(response.data!);
            } else {
              addToError("Sellers not found");
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

final getVehiclesListBloc = GetVehiclesListBloc();
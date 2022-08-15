/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'package:async/async.dart';
import 'package:custom_bloc/custom_bloc.dart';
import 'package:trakk/src/mixins/connectivity_helper.dart';
import 'package:trakk/src/models/message_only_response.dart';
import 'package:trakk/src/services/base_network_call_handler.dart';
import 'package:trakk/src/services/get_user_service.dart';

class GetRiderRatingBloc with BaseBloc<int, String>, ConnectivityHelper {
  CancelableOperation? _cancelableOperation;

  fetchCurrent() async {
    setAsLoading();
    checkInternetConnection(
        hasInternetCallback: () async {
          var operation = await profileService.getRiderRatings();

          if (operation.code == 200 || operation.code == 201) {
            int? average = operation.result['data'] != null
                ? int.tryParse(
                        operation.result['data']['ratings'].toString()) ??
                    0
                : null;
            if (average != null) {
              addToModel(average);
            } else {
              addToError('Could not get ratings');
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

final getRiderRatingBloc = GetRiderRatingBloc();

import 'package:trakk/bloc/app_settings_bloc.dart';
import 'package:trakk/models/rider/add_rider_to_merchant_model.dart';
import 'package:trakk/services/base_network_call_handler.dart';
import 'package:trakk/utils/enums.dart';
import 'package:trakk/utils/operation.dart';

class AddRiderService extends BaseNetworkCallHandler {
  Future<Operation> addRiderToMerchant(
      AddRiderToMerchantModel addRiderToMerchantModel) async {
    return runAPI('api/riders?populate=*', HttpRequestType.post,
        body: addRiderToMerchantModel.toAddRiderToServerJson());
  }

  Future<Operation> deleteRiderFromMerchant(String riderID) async {
    String userID = await appSettingsBloc.getUserID;

    return runAPI('api/riders/$riderID', HttpRequestType.put, body: {
      "data": {"status": "deleted"}
    });
  }

  Future<Operation> getRiders() async {
    String userID = await appSettingsBloc.getUserID;

    return runAPI(
        'api/riders?populate=*&[filters][merchantId][id][\$eq]=$userID',
        HttpRequestType.get);
  }
}

final addRiderService = AddRiderService();

import 'package:trakk/services/base_network_call_handler.dart';
import 'package:trakk/utils/enums.dart';
import 'package:trakk/utils/operation.dart';

class OrderAPI extends BaseNetworkCallHandler {
  /// *
  ///   below are for Rider

  Future<Operation> acceptOrder(String orderID) async {
    return runAPI('api/orders/$orderID', HttpRequestType.put, body: {
      "data": {"status": "accepted"}
    });
  }

  Future<Operation> declineOrder(String orderID) async {
    return runAPI('api/orders/$orderID', HttpRequestType.put, body: {
      "data": {"status": "pending"}
    });
  }

  Future<Operation> pickupOrder(String orderID) async {
    return runAPI('api/orders/$orderID', HttpRequestType.put, body: {
      "data": {"status": "intransit"}
    });
  }

  Future<Operation> deliverOrder(String orderID) async {
    return runAPI('api/orders/$orderID', HttpRequestType.put, body: {
      "data": {"status": "delivered"}
    });
  }
}

final orderAPI = OrderAPI();

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trakk/bloc/app_settings_bloc.dart';
import 'package:trakk/models/order/order.dart';
import 'package:trakk/services/base_network_call_handler.dart';
import 'package:trakk/utils/enums.dart';
import 'package:trakk/utils/operation.dart';

class OrderAPI extends BaseNetworkCallHandler {
  /// * start
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

  Future<Operation> getRiderOrderHistory() async {
    String userID = await appSettingsBloc.getUserID;

    return runAPI('api/riders/$userID?populate=*', HttpRequestType.get);
  }

  ///  below are for customers

  Future<Operation> getNearbyRiders(LatLng pickup, LatLng dropOff) async {
    return runAPI(
        'api/nearest-riders?latitude=6.43647509542&longitude=3.44761820108&pickUp=6.43647509542%7C3.44761820108&dropOff=6.603160%7C3.239020',
        // 'api/nearest-riders?latitude=${pickup.latitude}&longitude=${pickup.longitude}&pickUp=${pickup.latitude}|${pickup.longitude}&dropOff=${dropOff.latitude}|${dropOff.longitude}',
        HttpRequestType.get);
  }

  Future<Operation> createOrder(OrderModel orderModel) async {
    return runAPI('api/orders?populate=*', HttpRequestType.post,
        body: orderModel.toJson());
  }

  Future<Operation> getCustomerOrders() async {
    return runAPI('api/orders?populate=*', HttpRequestType.get);
  }
}

final orderAPI = OrderAPI();

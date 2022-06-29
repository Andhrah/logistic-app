import 'package:flutter/material.dart';
import 'package:trakk/models/order/order.dart';

class Order extends ChangeNotifier {
  // add global variable
  List<OrderModel> _orders = [];
  List<OrderModel> _cart = [];

  // OrderModel = _orderDetails = null;


  // Order _activeOrder
  // constructor to initialize the
  setOrder(OrderModel order){
    _orders.add(order);
    print("{}{}{}{}{}{}{}{}{}{}{}{}}{}{}{}}");
    print('order: ${_orders.map((e) => e.orderItem!.description)}');
    // send notification to the provider
    notifyListeners();
  }

  // in order for the outside world of the UI to have access
  // to this global variables, that will be done through the
  // use of getter function
  List<OrderModel> get orders => _orders;
  List<OrderModel> get cart => _cart;

  // OrderModel get orderDetails => _orderDetails;
}
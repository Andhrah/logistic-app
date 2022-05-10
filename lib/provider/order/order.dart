import 'package:flutter/material.dart';
import 'package:trakk/models/order/order.dart';

class Order extends ChangeNotifier {
  List<Order> _orders = [];
  List<Order> _cart = [];


  // Order _activeOrder
  Order(){
    _orders = [];
  }
}
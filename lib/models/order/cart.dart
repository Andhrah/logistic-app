import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  /// Internal, private state of the cart. Stores the ids of each item.
  final List<int> _itemIds = [];

}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:trakk/provider/auth/auth_provider.dart';
import 'package:trakk/provider/order/order.dart';
import 'package:trakk/provider/rider/rider.dart';
import 'package:trakk/provider/support/support.dart';
import 'package:trakk/provider/update_profile/update_profile.dart';

List<SingleChildWidget> appProviders = [
  // ChangeNotifierProvider notifies the UI/Widget to update its
  // content to the latest data whenever there is any notification
  // about the change of data.
  ChangeNotifierProvider<Auth>(create: (_) => Auth()),
  ChangeNotifierProvider<Order>(create: (_) => Order()),
  ChangeNotifierProvider<RiderAuth>(create: (_) => RiderAuth()),
  ChangeNotifierProvider<SupportProvider>(create: (_) => SupportProvider()),
  ChangeNotifierProvider<UpdateUserProvider>(create: (_) => UpdateUserProvider()),
];
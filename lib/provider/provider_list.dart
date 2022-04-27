import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:trakk/provider/auth/auth_provider.dart';

List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider<Auth>(create: (_) => Auth()),
];
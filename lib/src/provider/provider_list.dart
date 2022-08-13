import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:trakk/src/provider/customer/customer_map_provider.dart';
import 'package:trakk/src/provider/rider/rider_map_provider.dart';
import 'package:trakk/src/provider/settings_options/settings_options.dart';

List<SingleChildWidget> appProviders = [
  // ChangeNotifierProvider notifies the UI/Widget to update its
  // content to the latest data whenever there is any notification
  // about the change of data.
  ChangeNotifierProvider<RiderMapProvider>(create: (_) => RiderMapProvider()),
  ChangeNotifierProvider<CustomerMapProvider>(
      create: (_) => CustomerMapProvider()),
  ChangeNotifierProvider<SettingsProvider>(create: (_) => SettingsProvider()),
];

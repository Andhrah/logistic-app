import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:trakk/provider/merchant/add_company_data_provider.dart';
import 'package:trakk/provider/merchant/rider_map_provider.dart';
import 'package:trakk/provider/merchant/rider_profile_provider.dart';
import 'package:trakk/provider/order/order.dart';
import 'package:trakk/provider/rider/rider.dart';
import 'package:trakk/provider/support/support.dart';
import 'package:trakk/provider/update_profile/update_profile.dart';

import 'merchant/vehicles_provider.dart';

List<SingleChildWidget> appProviders = [
  // ChangeNotifierProvider notifies the UI/Widget to update its
  // content to the latest data whenever there is any notification
  // about the change of data.
  // ChangeNotifierProvider<Auth>(create: (_) => Auth()),
  // ChangeNotifierProvider<SignupProvider>(create: (_) => SignupProvider()),
  // ChangeNotifierProvider<VerifyAccountProvider>(
  //     create: (_) => VerifyAccountProvider()),
  // ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
  // ChangeNotifierProvider<ForgotPasswordProvider>(
  //     create: (_) => ForgotPasswordProvider()),
  ChangeNotifierProvider<AddCompanyDataProvider>(
      create: (_) => AddCompanyDataProvider()),
  ChangeNotifierProvider<Order>(create: (_) => Order()),
  ChangeNotifierProvider<RiderAuth>(create: (_) => RiderAuth()),
  ChangeNotifierProvider<SupportProvider>(create: (_) => SupportProvider()),
  ChangeNotifierProvider<UpdateUserProvider>(
      create: (_) => UpdateUserProvider()),
  ChangeNotifierProvider<RiderProfileProvider>(
      create: (_) => RiderProfileProvider()),
  // ChangeNotifierProvider<VehiclesProvider>(create: (_) => VehiclesProvider()),
  ChangeNotifierProvider<RiderMapProvider>(create: (_) => RiderMapProvider()),
];

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:trakk/src/provider/customer/customer_map_provider.dart';
import 'package:trakk/src/provider/merchant/add_company_data_provider.dart';
import 'package:trakk/src/provider/order/order.dart';
import 'package:trakk/src/provider/rider/rider_map_provider.dart';
import 'package:trakk/src/provider/settings_options/settings_options.dart';
import 'package:trakk/src/provider/support/support.dart';

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
  // ChangeNotifierProvider<RiderAuth>(create: (_) => RiderAuth()),
  ChangeNotifierProvider<SupportProvider>(create: (_) => SupportProvider()),
  // ChangeNotifierProvider<UpdateUserProvider>(
  //     create: (_) => UpdateUserProvider()),
  // ChangeNotifierProvider<RiderProfileProvider>(
  //     create: (_) => RiderProfileProvider()),
  // ChangeNotifierProvider<VehiclesProvider>(create: (_) => VehiclesProvider()),
  ChangeNotifierProvider<RiderMapProvider>(create: (_) => RiderMapProvider()),
  ChangeNotifierProvider<CustomerMapProvider>(
      create: (_) => CustomerMapProvider()),
  ChangeNotifierProvider<SettingsProvider>(create: (_) => SettingsProvider()),
];

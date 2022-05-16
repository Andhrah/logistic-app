import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as pp;

import 'package:trakk/models/auth/first_time_user.dart';
import 'package:trakk/models/auth/user.dart';
import 'package:trakk/provider/provider_list.dart';
import 'package:trakk/screens/auth/forgot_password.dart';
import 'package:trakk/screens/auth/forgot_password_pin.dart';
import 'package:trakk/screens/auth/login.dart';
import 'package:trakk/screens/auth/reset_password.dart';
import 'package:trakk/screens/auth/rider/next_of_kin.dart';
import 'package:trakk/screens/auth/rider/personal_data.dart';
import 'package:trakk/screens/auth/rider/vehicle_data.dart';
import 'package:trakk/screens/auth/signup.dart';
import 'package:trakk/screens/country.dart';
import 'package:trakk/screens/date_picker.dart';
import 'package:trakk/screens/dispatch/cart.dart';
import 'package:trakk/screens/dispatch/checkout.dart';
import 'package:trakk/screens/dispatch/dispatch_summary.dart';
import 'package:trakk/screens/dispatch/item_details.dart';
import 'package:trakk/screens/dispatch/order.dart';
import 'package:trakk/screens/dispatch/payment.dart';
import 'package:trakk/screens/dispatch/pick_ride.dart';
import 'package:trakk/screens/home.dart';
import 'package:trakk/screens/onboarding/onboarding.dart';
import 'package:trakk/screens/onboarding/splashscreen.dart';
import 'package:trakk/screens/polyline.dart';
import 'package:trakk/screens/riders/pick_up.dart';
import 'package:trakk/screens/riders/rider_home.dart';
import 'package:trakk/screens/tab.dart';
import 'package:trakk/utils/colors.dart';

void main() async {
  await _openHive();
  runApp(const MyApp());
}

_openHive() async {
  WidgetsFlutterBinding.ensureInitialized();
  var appDocDir = await pp.getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocDir.path);
  // await Hive.openBox();
  // Register the generated adapter
  Hive.registerAdapter(FirstTimeUserAdapter());
  Hive.registerAdapter(UserAdapter());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: appPrimaryColor
    ));
    return MultiProvider(
      providers: appProviders,
      child: OverlaySupport(
        child: MaterialApp(
          title: 'Trakk',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
            // canvasColor: Colors.transparent,
            // bottomSheetTheme: const BottomSheetThemeData(
            //   backgroundColor: Color(0xFFFFFF), // valid for transparent view (invisible white)
            // ),
          ),
          // home: const MyHomePage(title: 'Flutter Demo Home Page'),
          // home: const SplashScreen(),
          initialRoute: Home.id,
          routes: {
            SplashScreen.id: (context) => const SplashScreen(),
            Onboarding.id: (context) => const Onboarding(),
            Tabs.id: (context) => const Tabs(),
            Home.id: (context) => const Home(),
            Signup.id: (context) => const Signup(),
            ItemDetails.id: (context) => const ItemDetails(),
            PickRide.id: (context) => const PickRide(),
            Checkout.id: (context) => const Checkout(),
            DispatchSummary.id: (context) => const DispatchSummary(),
            Payment.id: (context) => const Payment(),
            Login.id: (context) => const Login(),
            ForgetPassword.id: (context) => const ForgetPassword(),
            ForgetPasswordPin.id: (context) => const ForgetPasswordPin(),
            ResetPassword.id: (context) => const ResetPassword(),
            PersonalData.id: (context) => const PersonalData(),
            VehicleData.id: (context) => const VehicleData(),
            NextOfKin.id: (context) => const NextOfKin(),
            PickUpScreen.id: (context) => const PickUpScreen(),
            CartScreen.id: (context) => const CartScreen(),
            PolylineScreen.id: (context) => const PolylineScreen(),
            UserOrderScreen.id: (context) => const UserOrderScreen(),
            // MyDatePicker.id: (context) => MyDatePicker(),
            // Country.id: (context) => const Country(),
          },
          // home: const GetStarted(),
        ),
      ),
    );
  }
}
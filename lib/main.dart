import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trakk/screens/auth/signup.dart';
import 'package:trakk/screens/dispatch/checkout.dart';
import 'package:trakk/screens/dispatch/dispatch_summary.dart';
import 'package:trakk/screens/dispatch/item_details.dart';
import 'package:trakk/screens/dispatch/payment.dart';
import 'package:trakk/screens/dispatch/pick_ride.dart';
import 'package:trakk/screens/home.dart';
import 'package:trakk/screens/onboarding/onboarding.dart';
import 'package:trakk/screens/onboarding/splashscreen.dart';
import 'package:trakk/screens/tab.dart';
import 'package:trakk/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: appPrimaryColor
    ));
    return MaterialApp(
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
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      // home: const SplashScreen(),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => const SplashScreen(),
        Onboarding.id: (context) => const Onboarding(),
        Tabs.id: (context) => const Tabs(),
        Home.id: (context) => const Home(),
        Signup.id: (context) => const Signup(),
        ItemDetails.id: (context) => const ItemDetails(),
        PickRide.id: (context) => const PickRide(),
        Payment.id: (context) => const Payment(),
        DispatchSummary.id:(context) => const DispatchSummary(),
        Checkout.id: (context) => const Checkout(),
      },
      // home: const GetStarted(),
    );
  }
}
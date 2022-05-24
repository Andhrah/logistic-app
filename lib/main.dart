import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as pp;

import 'package:trakk/models/auth/first_time_user.dart';
import 'package:trakk/models/auth/is_logged_in.dart';
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
import 'package:trakk/screens/merchant/add_rider.dart';
import 'package:trakk/screens/merchant/all_vehicle_container.dart';
import 'package:trakk/screens/merchant/company_home.dart';
import 'package:trakk/screens/merchant/dispatch_history.dart';
import 'package:trakk/screens/merchant/list_of_riders.dart';
import 'package:trakk/screens/merchant/list_of_vehicles.dart';
import 'package:trakk/screens/merchant/edit_rider_profile.dart';
import 'package:trakk/screens/merchant/referred_rides.dart';
import 'package:trakk/screens/merchant/register_new_vehicle.dart';
import 'package:trakk/screens/merchant/riders.dart';
import 'package:trakk/screens/merchant/signup_merchant.dart';
import 'package:trakk/screens/merchant/vehicles.dart';
import 'package:trakk/screens/onboarding/onboarding.dart';
import 'package:trakk/screens/onboarding/splashscreen.dart';
import 'package:trakk/screens/polyline.dart';
import 'package:trakk/screens/profile/profile_menu.dart';
import 'package:trakk/screens/riders/pick_up.dart';
import 'package:trakk/screens/riders/rider_home.dart';
import 'package:trakk/screens/support/help.dart';
import 'package:trakk/screens/tab.dart';
import 'package:trakk/screens/profile/edit_profile.dart';
import 'package:trakk/screens/wallet/fund_wallet.dart';
import 'package:trakk/screens/wallet/fund_wallet.dart';
import 'package:trakk/utils/colors.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


void main() async {
  await _openHive();
  
  // To load the .env file contents into dotenv.
  // NOTE: fileName defaults to .env and can be omitted in this case.
  // Ensure that the filename corresponds to the path in step 1 and 2.
  await dotenv.load(fileName: ".env");
    
  runApp(const MyApp());
}

_openHive() async {
  WidgetsFlutterBinding.ensureInitialized();
  var appDocDir = await pp.getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocDir.path);
  // Register the generated adapter
  Hive.registerAdapter(FirstTimeUserAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(IsLoggedInAdapter());
}

class MyApp extends StatefulWidget {

  //final String _pusher = "ec680890477ff06ecb9a";

  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  PusherOptions options = PusherOptions(
    host: "https://trakk-server.herokuapp.com",
    encrypted: false,
  );

  PusherClient pusher = PusherClient(
    _pusher!,
    
    PusherOptions(
      encrypted: false,
    ),
    autoConnect: true,
  );

  static final String?  _pusher = dotenv.env["PUSHER_TOKEN"];

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: appPrimaryColor));
    pusher.onConnectionStateChange((state) {
      print(
        "previousState: ${state != null ? state.previousState : ""}, currentState: ${state != null ? state.currentState : ""}");
    });

    pusher.onConnectionError((error) {
      print("error: ${error != null ? error.message : ""}");
    });

    Channel channel = pusher.subscribe("adelowomi@gmail.com");
    channel.bind("user", (event) {
      print(event != null ? event.data : "O ti fail");
    });
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
          initialRoute: SplashScreen.id,
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
            ProfileMenu.id:(context) => const ProfileMenu(),
            EditProfile.id:(context) => const EditProfile(),
            Help.id:(context) => const Help(),
            FundWalletScreen.id: (context) => const FundWalletScreen(),
            CompanyHome.id:(context) => const CompanyHome(),
            Vehicles.id:(context) => const Vehicles(),
            Riders.id:(context) => const Riders(),
            DispatchHistory.id:(context) => const DispatchHistory(),
            ListOfVehicles.id:(context) => const ListOfVehicles(),
            RegisterNewVehicle.id:(context) => const RegisterNewVehicle(),
            AddRider.id:(context) => const AddRider(),
            ReferredRides.id:(context) => const ReferredRides(),
            AllVehicleContainer.id:(context) => const AllVehicleContainer(),
            EditRiderProfile.id:(context) => const EditRiderProfile(),
            ListOfRiders.id:(context) => const ListOfRiders(),
          },
          // home: const GetStarted(),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:trakk/provider/provider_list.dart';
import 'package:trakk/screens/auth/forgot_password.dart';
import 'package:trakk/screens/auth/forgot_password_pin.dart';
import 'package:trakk/screens/auth/login.dart';
import 'package:trakk/screens/auth/merchant/company_data.dart';
import 'package:trakk/screens/auth/reset_password.dart';
import 'package:trakk/screens/auth/rider/next_of_kin.dart';
import 'package:trakk/screens/auth/rider/personal_data.dart';
import 'package:trakk/screens/auth/rider/vehicle_data.dart';
import 'package:trakk/screens/auth/signup.dart';
import 'package:trakk/screens/auth/verify_account.dart';
import 'package:trakk/screens/dispatch/cart.dart';
import 'package:trakk/screens/dispatch/checkout.dart';
import 'package:trakk/screens/dispatch/dispatch_summary.dart';
import 'package:trakk/screens/dispatch/item_detail/item_details.dart';
import 'package:trakk/screens/dispatch/order.dart';
import 'package:trakk/screens/dispatch/pay_with_transfer.dart';
import 'package:trakk/screens/dispatch/payment.dart';
import 'package:trakk/screens/dispatch/pick_ride.dart';
import 'package:trakk/screens/merchant/add_rider.dart';
import 'package:trakk/screens/merchant/company_home.dart';
import 'package:trakk/screens/merchant/dispatch_history.dart';
import 'package:trakk/screens/merchant/fulfilled_dispatch.dart';
import 'package:trakk/screens/merchant/list_of_riders.dart';
import 'package:trakk/screens/merchant/list_of_vehicles.dart';
import 'package:trakk/screens/merchant/merchant_rider_profile.dart';
import 'package:trakk/screens/merchant/referred_rides.dart';
import 'package:trakk/screens/merchant/register_new_vehicle.dart';
import 'package:trakk/screens/merchant/rejected_rides.dart';
import 'package:trakk/screens/merchant/riders.dart';
import 'package:trakk/screens/merchant/vehicles.dart';
import 'package:trakk/screens/onboarding/get_started.dart';
import 'package:trakk/screens/onboarding/onboarding.dart';
import 'package:trakk/screens/onboarding/splashscreen.dart';
import 'package:trakk/screens/profile/dispatch_history_screen/user_dispatch_history.dart';
import 'package:trakk/screens/profile/edit_profile.dart';
import 'package:trakk/screens/profile/profile_menu.dart';
import 'package:trakk/screens/profile/settings.dart';
import 'package:trakk/screens/riders/home/rider_home.dart';
import 'package:trakk/screens/riders/pick_up.dart';
import 'package:trakk/screens/riders/rider_order.dart';
import 'package:trakk/screens/tab.dart';
import 'package:trakk/screens/wallet/all_cards.dart';
import 'package:trakk/screens/wallet/buy_airtime.dart';
import 'package:trakk/screens/wallet/fund_wallet.dart';
import 'package:trakk/screens/wallet/payments.dart';
import 'package:trakk/screens/wallet/qr_code_payment.dart';
import 'package:trakk/screens/wallet/qr_payment.dart';
import 'package:trakk/screens/wallet/transfers.dart';
import 'package:trakk/screens/wallet/wallet.dart';
import 'package:trakk/screens/wallet/wallet_history.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/utils/singleton_data.dart';

import 'screens/profile/dispatch_history_screen/user_dispatch_history.dart';
import 'screens/profile/profile_menu.dart';

void main() async {
  SingletonData.singletonData.initBaseURL('https://zebrra.itskillscenter.com/');
  SingletonData.singletonData.initSsoURL('https://zebrrasso.herokuapp.com/');

  await _openHive();

  // To load the .env file contents into dotenv.
  // NOTE: fileName defaults to .env and can be omitted in this case.
  // Ensure that the filename corresponds to the path in step 1 and 2.
  // await dotenv.load(fileName: ".env");

  await dotenv.load(fileName: ".env");
  //await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

_openHive() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Register the generated adapter
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

  @override
  void dispose() {
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: appPrimaryColor));

    return MultiProvider(
      providers: appProviders,
      child: OverlaySupport(
        child: MaterialApp(
          navigatorKey: SingletonData.singletonData.navKey,
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
            GetStarted.id: (context) => const GetStarted(),
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
            // PolylineScreen.id: (context) => PolylineScreen(),
            UserOrderScreen.id: (context) => const UserOrderScreen(),
            ProfileMenu.id: (context) => const ProfileMenu(),
            EditProfile.id: (context) => const EditProfile(),
            FundWalletScreen.id: (context) => const FundWalletScreen(),
            CompanyHome.id: (context) => const CompanyHome(),
            Vehicles.id: (context) => const Vehicles(),
            Riders.id: (context) => const Riders(),
            DispatchHistory.id: (context) => const DispatchHistory(),
            ListOfVehicles.id: (context) => const ListOfVehicles(),
            RegisterNewVehicle.id: (context) => const RegisterNewVehicle(),
            AddRider.id: (context) => const AddRider(),
            ReferredRides.id: (context) => const ReferredRides(),
            MerchantRiderProfile.id: (context) => const MerchantRiderProfile(),
            ListOfRiders.id: (context) => const ListOfRiders(),
            RejectedRides.id: (context) => const RejectedRides(),
            FulfilledDispatch.id: (context) => const FulfilledDispatch(),
            RiderOrderScreen.id: (context) => const RiderHomeScreen(),
            PickUpScreen.id: (context) => const PickUpScreen(),
            RejectedRides.id: (context) => const RejectedRides(),
            FulfilledDispatch.id: (context) => const FulfilledDispatch(),
            RiderOrderScreen.id: (context) => const RiderHomeScreen(),
            PickUpScreen.id: (context) => const PickUpScreen(),
            RejectedRides.id: (context) => const RejectedRides(),
            FulfilledDispatch.id: (context) => const FulfilledDispatch(),
            RiderHomeScreen.id: (context) => const RiderHomeScreen(),
            RejectedRides.id: (context) => const RejectedRides(),
            FulfilledDispatch.id: (context) => const FulfilledDispatch(),

            // MyDatePicker.id: (context) => MyDatePicker(),
            // Country.id: (context) => const Country(),
            ProfileMenu.id: (context) => const ProfileMenu(),
            WalletScreen.id: (context) => const WalletScreen(),
            UserDispatchHistory.id: (context) => const UserDispatchHistory(),
            Settings.id: (context) => const Settings(),
            Payments.id: (context) => const Payments(),
            // RideIssues.id:(context) => const RideIssues(),
            EditProfile.id: (context) => const EditProfile(),
            FundWalletScreen.id: (context) => const FundWalletScreen(),
            CompanyHome.id: (context) => const CompanyHome(),
            Vehicles.id: (context) => const Vehicles(),
            Riders.id: (context) => const Riders(),
            DispatchHistory.id: (context) => const DispatchHistory(),
            ListOfVehicles.id: (context) => const ListOfVehicles(),

            RegisterNewVehicle.id: (context) => const RegisterNewVehicle(),
            MerchantRiderProfile.id: (context) => const MerchantRiderProfile(),
            ListOfRiders.id: (context) => const ListOfRiders(),
            RejectedRides.id: (context) => const RejectedRides(),
            FulfilledDispatch.id: (context) => const FulfilledDispatch(),
            WalletScreen.id: (context) => const WalletScreen(),
            Transfers.id: (context) => const Transfers(),
            PayWithTransfer.id: (context) => const PayWithTransfer(),
            AllCards.id: (context) => const AllCards(),
            BuyAirtime.id: (context) => const BuyAirtime(),
            WalletHistory.id: (context) => const WalletHistory(),
            QrPayment.id: (context) => const QrPayment(),
            QrCodePayment.id: (context) => const QrCodePayment(),
            VerifiyAccountScreen.id: (context) => const VerifiyAccountScreen(),
            CompanyData.id: (context) => const CompanyData(),
          },
          // home: const GetStarted(),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:trakk/src/.env.dart';
import 'package:trakk/src/provider/provider_list.dart';
import 'package:trakk/src/provider/settings_options/settings_options.dart';
import 'package:trakk/src/screens/auth/forgot_password.dart';
import 'package:trakk/src/screens/auth/forgot_password_pin.dart';
import 'package:trakk/src/screens/auth/login.dart';
import 'package:trakk/src/screens/auth/merchant/company_data.dart';
import 'package:trakk/src/screens/auth/reset_password.dart';
import 'package:trakk/src/screens/auth/rider/next_of_kin.dart';
import 'package:trakk/src/screens/auth/signup.dart';
import 'package:trakk/src/screens/auth/verify_account.dart';
import 'package:trakk/src/screens/dispatch/cart.dart';
import 'package:trakk/src/screens/dispatch/checkout.dart';
import 'package:trakk/src/screens/dispatch/dispatch_summary.dart';
import 'package:trakk/src/screens/dispatch/item_detail/item_details.dart';
import 'package:trakk/src/screens/dispatch/order/order.dart';
import 'package:trakk/src/screens/dispatch/pay_with_transfer.dart';
import 'package:trakk/src/screens/dispatch/payment.dart';
import 'package:trakk/src/screens/dispatch/pick_ride.dart';
import 'package:trakk/src/screens/dispatch/track/customer_track_screen.dart';
import 'package:trakk/src/screens/merchant/add_rider.dart';
import 'package:trakk/src/screens/merchant/add_rider1.dart';
import 'package:trakk/src/screens/merchant/add_rider_2/add_rider2.dart';
import 'package:trakk/src/screens/merchant/company_home.dart';
import 'package:trakk/src/screens/merchant/dispatch_history.dart';
import 'package:trakk/src/screens/merchant/fulfilled_dispatch.dart';
import 'package:trakk/src/screens/merchant/list_of_riders.dart';
import 'package:trakk/src/screens/merchant/list_of_vehicles.dart';
import 'package:trakk/src/screens/merchant/merchant_rider_profile.dart';
import 'package:trakk/src/screens/merchant/referred_rides.dart';
import 'package:trakk/src/screens/merchant/rejected_rides.dart';
import 'package:trakk/src/screens/merchant/rider_profile.dart';
import 'package:trakk/src/screens/merchant/riders.dart';
import 'package:trakk/src/screens/merchant/vehicles.dart';
import 'package:trakk/src/screens/onboarding/get_started.dart';
import 'package:trakk/src/screens/onboarding/onboarding.dart';
import 'package:trakk/src/screens/onboarding/splashscreen.dart';
import 'package:trakk/src/screens/profile/dispatch_history_screen/user_dispatch_history.dart';
import 'package:trakk/src/screens/profile/edit_profile_screen/edit_profile.dart';
import 'package:trakk/src/screens/profile/privacy_and_policy.dart';
import 'package:trakk/src/screens/profile/profile_menu.dart';
import 'package:trakk/src/screens/riders/home/rider_home.dart';
import 'package:trakk/src/screens/riders/pick_up.dart';
import 'package:trakk/src/screens/riders/rider_order.dart';
import 'package:trakk/src/screens/support/help_and_support.dart';
import 'package:trakk/src/screens/tab.dart';
import 'package:trakk/src/screens/wallet/all_cards.dart';
import 'package:trakk/src/screens/wallet/beneficiaries.dart';
import 'package:trakk/src/screens/wallet/buy_airtime.dart';
import 'package:trakk/src/screens/wallet/fund_wallet.dart';
import 'package:trakk/src/screens/wallet/payments.dart';
import 'package:trakk/src/screens/wallet/qr_code_payment.dart';
import 'package:trakk/src/screens/wallet/qr_payment.dart';
import 'package:trakk/src/screens/wallet/transfers.dart';
import 'package:trakk/src/screens/wallet/wallet.dart';
import 'package:trakk/src/screens/wallet/wallet_history.dart';
import 'package:trakk/src/utils/singleton_data.dart';
import 'package:trakk/src/values/values.dart';
import 'package:uploadcare_client/uploadcare_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _openHive();
  SingletonData.singletonData.initBaseURL('https://zebrra.itskillscenter.com/');
  SingletonData.singletonData.initSocketURL('https://zebrrasso.herokuapp.com/');
  SingletonData.singletonData.initImageURL('https://ucarecdn.com/');
  SingletonData.singletonData
      .initUploadCareClient(UploadcareClient.withSimpleAuth(
    publicKey: uploadCarePublicKey,
    privateKey: uploadCarePrivateKey,
    apiVersion: 'v0.7',
  ));

  // To load the .env file contents into dotenv.
  // NOTE: fileName defaults to .env and can be omitted in this case.
  // Ensure that the filename corresponds to the path in step 1 and 2.
  // await dotenv.load(fileName: ".env");

  await dotenv.load(fileName: ".env");
  //await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

_openHive() async {
// create client with simple auth scheme
  // Register the generated adapter
}

class MyApp extends StatefulWidget {
  //final String _pusher = "ec680890477ff06ecb9a";

  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PusherOptions pusherOptions = PusherOptions(
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
        child: Builder(builder: (context) {
          var provider = SettingsProvider.settingsProvider(context);
          return MaterialApp(
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
            builder: (BuildContext context, Widget? child) {
              return Directionality(
                textDirection: provider.options.textDirection,
                child: provider.applyTextScaleFactor(
                  // Specifically use a blank Cupertino theme here and do not transfer
                  // over the Material primary color etc except the brightness to
                  // showcase standard iOS looks.
                  CupertinoTheme(
                    data: CupertinoThemeData(
                      brightness: provider.options.theme!.data.brightness,
                    ),
                    child: child!,
                  ),
                ),
              );
            },
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
              // PersonalData.id: (context) => const PersonalData(),
              // VehicleData.id: (context) => const VehicleData(),
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
              // RegisterNewVehicle.id: (context) => const RegisterNewVehicle(),
              AddRider.id: (context) => const AddRider(),
              AddRider1.id: (context) => const AddRider1(),
              AddRider2.id: (context) => const AddRider2(),
              ReferredRides.id: (context) => const ReferredRides(),
              MerchantRiderProfile.id: (context) =>
                  const MerchantRiderProfile(),
              ListOfRiders.id: (context) => const ListOfRiders(),
              RejectedRides.id: (context) => const RejectedRides(),
              FulfilledDispatch.id: (context) => const FulfilledDispatch(),
              RiderOrderScreen.id: (context) => const RiderHomeScreen(),
              RiderHomeScreen.id: (context) => const RiderHomeScreen(),
              CustomerTrackScreen.id: (context) => const CustomerTrackScreen(),
              RiderProfile.id: (context) => const RiderProfile(),
              Beneficiaries.id: (context) => const Beneficiaries(),
              // MyDatePicker.id: (context) => MyDatePicker(),
              // Country.id: (context) => const Country(),
              HelpAndSupport.id: (context) => const HelpAndSupport(),
              PrivacyAndPolicy.id: (context) => const PrivacyAndPolicy(),
              WalletScreen.id: (context) => const WalletScreen(),
              UserDispatchHistory.id: (context) => const UserDispatchHistory(),
              Payments.id: (context) => const Payments(),
              // RideIssues.id:(context) => const RideIssues(),
              EditProfile.id: (context) => const EditProfile(),
              FundWalletScreen.id: (context) => const FundWalletScreen(),
              // RegisterNewVehicle.id: (context) => const RegisterNewVehicle(),
              MerchantRiderProfile.id: (context) =>
                  const MerchantRiderProfile(),
              Transfers.id: (context) => const Transfers(),
              PayWithTransfer.id: (context) => const PayWithTransfer(),
              AllCards.id: (context) => const AllCards(),
              BuyAirtime.id: (context) => const BuyAirtime(),
              WalletHistory.id: (context) => const WalletHistory(),
              QrPayment.id: (context) => const QrPayment(),
              QrCodePayment.id: (context) => const QrCodePayment(),
              VerifiyAccountScreen.id: (context) =>
                  const VerifiyAccountScreen(),
              CompanyData.id: (context) => const CompanyData(),
            },
            // home: const GetStarted(),
          );
        }),
      ),
    );
  }
}

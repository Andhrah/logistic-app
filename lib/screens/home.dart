import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:trakk/screens/auth/login.dart';
import 'package:trakk/screens/auth/signup.dart';
import 'package:trakk/screens/dispatch/checkout.dart';
import 'package:trakk/screens/dispatch/item_details.dart';
import 'package:trakk/screens/dispatch/pick_ride.dart';
import 'package:trakk/screens/merchant/company_home.dart';
import 'package:trakk/screens/merchant/signup_merchant.dart';
import 'package:trakk/screens/riders/rider_home.dart';
import 'package:trakk/screens/riders/rider_order.dart';
import 'package:trakk/screens/wallet/wallet.dart';
import 'package:trakk/services/get_user_service.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/button.dart';

import '../provider/auth/auth_provider.dart';

class Home extends StatefulWidget {
  static const String id = 'home';

  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  _isFirstTimeUser() async {
   var box = await Hive.openBox('userData');
    box.putAll({
      "firstTimeUser": true,
    });
    print("WE ARE HERE, AT HOME");
  }

  @override
  void initState() {
    super.initState();
    _isFirstTimeUser();
    GetUserData.getUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 30.0, top: 30.0),
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    ItemDetails.id,
                    arguments: {
                      "userType": "guest",
                    }
                  );
                },
                customBorder: const CircleBorder(),
                child: const Text(
                  'Continue As A guest',
                  textScaleFactor: 1.0,
                  style: TextStyle(
                    color: appPrimaryColor,
                    fontWeight: FontWeight.bold,
                    // decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 70.0),
              child: Image.asset(
                'assets/images/home_delivery_img.png',
                height: 200.0,
              ),
            ),

            const SizedBox(height: 70.0),

            Button(
              text: 'Sign Up To Dispatch An Item',
              onPress: () {
                // Provider.of<Auth>(context, listen: false).guestLogin();
                Navigator.of(context).pushNamed(
                  Signup.id,
                  arguments: {
                    "userType": "user",
                  }
                );
              },
              color: appPrimaryColor,
              isLoading: false,
              textColor: whiteColor,
              width: 300,
            ),
            const SizedBox(height: 15.0),
            Button(
              text: 'Sign Up As A Rider',
              onPress: () {
                Navigator.of(context).pushNamed(
                  RiderHomeScreen.id,
                  // arguments: {
                  //   "userType": "rider",
                  // }
                );
              },
              color: whiteColor,
              isLoading: false,
              textColor: appPrimaryColor, 
              width: 300,
            ),
            const SizedBox(height: 15.0),
            Button(
              text: 'Sign Up As A Merchant',
              onPress: () {
                Navigator.of(context).pushNamed(CompanyHome.id);
              },
              color: whiteColor,
              isLoading: false,
              textColor: appPrimaryColor,
              width: 300,
            ),
            const SizedBox(height: 15.0),
            InkWell(
              onTap: (){
                Navigator.of(context).pushNamed(Login.id);
              },
              child: Align(
                child: RichText(
                  textScaleFactor: 0.9,
                  text: const TextSpan(
                    text: 'Already have an account? ',
                    style: TextStyle(
                      color: appPrimaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: 'Log in', style: TextStyle(fontWeight: FontWeight.bold, color: secondaryColor)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      )
    );
  }
}

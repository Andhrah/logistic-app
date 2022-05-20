import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trakk/screens/auth/login.dart';
import 'package:trakk/screens/auth/signup.dart';
import 'package:trakk/screens/dispatch/checkout.dart';
import 'package:trakk/screens/dispatch/item_details.dart';
import 'package:trakk/screens/dispatch/pick_ride.dart';
import 'package:trakk/screens/merchant/company_home.dart';
import 'package:trakk/screens/merchant/signup_merchant.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/button.dart';

import '../provider/auth/auth_provider.dart';
import 'user_profile/user_profile _menu.dart';

class Home extends StatefulWidget {
  static const String id = 'home';

  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                    Signup.id,
                    arguments: {
                      "userType": "user",
                    }
                  );
                },
                customBorder: const CircleBorder(),
                child: const Text(
                  'Sign up',
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
              text: 'Dispatch an Item',
              onPress: () {
                Provider.of<Auth>(context, listen: false).guestLogin();
                Navigator.of(context).pushNamed(PickRide.id);
              },
              color: appPrimaryColor,
              isLoading: false,
              textColor: whiteColor,
              width: 300,
            ),
            const SizedBox(height: 15.0),
            Button(
              text: 'Become a Rider',
              onPress: () {
                Navigator.of(context).pushNamed(
                  Signup.id,
                  arguments: {
                    "userType": "rider",
                  }
                );
              },
              color: whiteColor,
              isLoading: false,
              textColor: appPrimaryColor, 
              width: 300,
            ),
            const SizedBox(height: 15.0),
            Button(
              text: 'Become a Merchant',
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

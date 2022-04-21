import 'package:flutter/material.dart';
import 'package:trakk/screens/auth/signup.dart';
import 'package:trakk/screens/dispatch/checkout.dart';
import 'package:trakk/screens/dispatch/dispatch_summary.dart';
import 'package:trakk/screens/dispatch/item_details.dart';
import 'package:trakk/screens/dispatch/payment.dart';
import 'package:trakk/screens/dispatch/pick_ride.dart';
import 'package:trakk/screens/onboarding/onboarding.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/button.dart';

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
                  Navigator.of(context).pushNamed(Signup.id);
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
              margin: const EdgeInsets.only(top: 40.0),
              decoration: const BoxDecoration(
                //   AssetImage('assets/images/home.png'),
                //   fit: BoxFit.cover,
                // )
              ),
              child: Image.asset(
                'assets/images/home_delivery_img.png',
                height: 200.0,
              ),
            ),

            const SizedBox(height: 70.0),

            Button(
              text: 'Dispatch an Item',
              onPress: () {
                Navigator.of(context).pushNamed(ItemDetails.id);
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
                Navigator.of(context).pushNamed(Checkout.id);
              },
              color: whiteColor,
              isLoading: false,
              textColor: appPrimaryColor, 
              width: 300,
            ),
            const SizedBox(height: 15.0),
            Button(
              text: 'Become a Merchant',
              onPress: () {},
              color: whiteColor,
              isLoading: false,
              textColor: appPrimaryColor,
              width: 300,
            ),
            const SizedBox(height: 15.0),
            const Text(
              'Already have an account ? Log in',
              textScaleFactor: 0.9,
              style: TextStyle(
                color: appPrimaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        )
      )
    );
  }
}

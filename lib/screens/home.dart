import 'package:flutter/material.dart';
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
                onTap: () {},
                customBorder: const CircleBorder(),
                child: const Text(
                  'Sign up',
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: appPrimaryColor,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 70.0),
              decoration: const BoxDecoration(
                //   AssetImage('assets/images/home.png'),
                //   fit: BoxFit.cover,
                // )
              ),
              child: Image.asset(
                'assets/images/home_delivery_img.png',
                height: 250.0,
              ),
            ),

            const SizedBox(height: 70.0),

            Button(
              text: 'Dispatch an item',
              onPress: () {},
              color: appPrimaryColor,
              isLoading: false,
              textColor: whiteColor,
            ),
            const SizedBox(height: 15.0),
            Button(
              text: 'Become a Rider',
              onPress: () {},
              color: whiteColor,
              isLoading: false,
              textColor: appPrimaryColor,
            ),
            const SizedBox(height: 15.0),
            Button(
              text: 'Become a marchant',
              onPress: () {},
              color: whiteColor,
              isLoading: false,
              textColor: appPrimaryColor,
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
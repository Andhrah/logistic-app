import 'package:flutter/material.dart';
import 'package:trakk/screens/auth/login.dart';
import 'package:trakk/screens/auth/signup.dart';
import 'package:trakk/screens/dispatch/item_detail/item_details.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/button.dart';

class GetStarted extends StatefulWidget {
  static const String id = 'getStarted';

  const GetStarted({Key? key}) : super(key: key);

  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  _isFirstTimeUser() async {}

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage('assets/images/get_started_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 30.0, top: 30.0),
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(ItemDetails.id, arguments: {
                    "userType": "guest",
                  });
                },
                customBorder: const CircleBorder(),
                child: const Text(
                  'Continue as a Guest',
                  textScaleFactor: 1.0,
                  style: TextStyle(
                    color: appPrimaryColor,
                    fontWeight: FontWeight.bold,
                    // decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40.0),
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.4,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                Button(
                  text: 'Sign up to dispatch an item',
                  onPress: () {
                    Navigator.of(context).pushNamed(Signup.id, arguments: {
                      "userType": "customer",
                    });
                  },
                  color: appPrimaryColor,
                  isLoading: false,
                  textColor: whiteColor,
                  width: 300,
                ),
                const SizedBox(height: 15.0),
                Button(
                  text: 'Sign up as a Rider',
                  onPress: () {
                    Navigator.of(context).pushNamed(Signup.id, arguments: {
                      "userType": "rider",
                    });
                  },
                  color: whiteColor,
                  isLoading: false,
                  textColor: appPrimaryColor,
                  width: 300,
                ),
                const SizedBox(height: 15.0),
                Button(
                  text: 'Sign up as a Company',
                  onPress: () {
                    // Navigator.of(context).pushNamed(CompanyGetStarted.id);
                    Navigator.of(context).pushNamed(Signup.id, arguments: {
                      "userType": "merchant",
                    });
                  },
                  color: whiteColor,
                  isLoading: false,
                  textColor: appPrimaryColor,
                  width: 300,
                ),
                const SizedBox(height: 25.0),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(Login.id);
                  },
                  child: Align(
                    child: RichText(
                      textScaleFactor: 0.9,
                      text: const TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(
                          color: appPrimaryColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Log in',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: secondaryColor)),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    ));
  }
}

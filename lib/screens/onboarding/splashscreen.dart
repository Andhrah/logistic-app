import 'package:flutter/material.dart';
import 'package:trakk/utils/colors.dart';

class SplashScreen extends StatefulWidget {
  static String id = 'splash_screen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: appPrimaryColor,
      child: Container(
        margin: const EdgeInsets.fromLTRB(0.0, 0.0, 90.0, 110.0),
        child:  Center(
          child: Image.asset(
            "assets/images/trakk_logo.png",
            height: 250.0,
          ),
        ),
      ),
    );
  }
}
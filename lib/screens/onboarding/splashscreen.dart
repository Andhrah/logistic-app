import 'package:flutter/material.dart';
import 'package:trakk/screens/onboarding/onboarding.dart';
import 'package:trakk/utils/colors.dart';

class SplashScreen extends StatefulWidget {
  static String id = 'splashScreen';

  const SplashScreen({ Key? key }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 2), 
      vsync: this, // the SingleTickerProviderStateMixin
    );
    
    controller.forward();
    // add listner to animation status and
    // navigate to getStarted screen if animation status is completed
    controller.addStatusListener((status) { 
      if (status == AnimationStatus.completed){
        Navigator.of(context).pushNamedAndRemoveUntil(
          Onboarding.id, (route) => false
        );
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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

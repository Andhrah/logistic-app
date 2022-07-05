import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:trakk/repository/hive_repository.dart';
import 'package:trakk/screens/onboarding/get_started.dart';
import 'package:trakk/screens/onboarding/onboarding.dart';
import 'package:trakk/screens/tab.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/utils/constant.dart';

class SplashScreen extends StatefulWidget {
  static String id = 'splashScreen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
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
      if (status == AnimationStatus.completed) {
        _prepareAppState();
      }
    });
  }

  _prepareAppState() async {
    await HiveRepository.openHives([
      kFirstTimeUser,
    ]);
    bool? firstTimeUser;
    String? token;

    try {
      var box = await Hive.openBox('appState');
      token = await box.get("token");
      firstTimeUser = await box.get("firstTimeUser");
      firstTimeUser = box.get("firstTimeUser");
      if (firstTimeUser == null) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Onboarding.id, (route) => false);
      } else if (token != null) {
        Navigator.of(context).pushNamedAndRemoveUntil(Tabs.id, (route) => false
            // GetStarted.id, (route) => false
            );
      } else {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(GetStarted.id, (route) => false
                // Onboarding.id, (route) => false
                );
      }
    } catch (err) {
      rethrow;
    }
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
      child: Center(
        child: Image.asset(
          "assets/images/trakk_logo.png",
          height: MediaQuery.of(context).size.height / 8,
          width: MediaQuery.of(context).size.width / 3,
        ),
      ),
    );
  }
}

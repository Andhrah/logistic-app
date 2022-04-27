import 'package:flutter/material.dart';
import 'package:trakk/models/auth/first_time_user.dart';
import 'package:trakk/provider/auth/auth_provider.dart';
import 'package:trakk/repository/hive_repository.dart';
import 'package:trakk/screens/home.dart';
import 'package:trakk/screens/onboarding/onboarding.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/utils/constant.dart';

class SplashScreen extends StatefulWidget {
  static String id = 'splashScreen';

  const SplashScreen({ Key? key }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation animation;

  final HiveRepository _hiveRepository = HiveRepository();
  // FirstTimeUser? firstTimeUser;

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
      print('status:$status');
      if (status == AnimationStatus.completed){
        _prepareAppState();
      }
    });
  }

  _prepareAppState() async {
    await HiveRepository.openHives([
      kFirstTimeUser,
    ]);

    FirstTimeUser? firstTimeUser;

    try {
      print('<<<<<<<<<< DEBUGGING >>>>>>>>>>>>>>>>');
      print('<<<<<<<<<<  >>>>>>>>>>>>>>>>');
      // print(firstTimeUser);
      firstTimeUser = _hiveRepository.get<FirstTimeUser>(key: 'firstTimeUser', name: kFirstTimeUser);
      print(firstTimeUser);
      print('<<<<<<<<<< DEBUGGING 2>>>>>>>>>>>>>>>>');
      print(firstTimeUser);
      Auth.authProvider(context).setFirstTimerUser(firstTimeUser);
    } catch(err) {
      print('<<<<<<<<<< Logging error >>>>>>>>>>>>>>>>');
      print(err.toString());
      rethrow;
    }

    if(firstTimeUser == null) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        Onboarding.id, (route) => false
      );
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(
        Home.id, (route) => false
      );
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

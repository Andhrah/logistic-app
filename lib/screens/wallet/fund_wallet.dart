import 'package:flutter/material.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/back_icon.dart';

class FundWalletScreen extends StatefulWidget {
  static const String id = 'fund';

  const FundWalletScreen({Key? key}) : super(key: key);

  @override
  _FundWalletScreenState createState() => _FundWalletScreenState();
}

class _FundWalletScreenState extends State<FundWalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFF8F9FF),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackIcon(
                    onPress: () {Navigator.pop(context);},
                  ),
                  const Text(
                    'WALLET TOP UP',
                    style: TextStyle(
                      color: appPrimaryColor,
                      fontSize: 20.0, 
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                margin: const EdgeInsets.only(top: 18.0),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Select your top up source',
                        style: TextStyle(
                          color: appPrimaryColor,
                          fontSize: 17.0, 
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    
                    // const Text(
                    //   'Select your top up source',
                    //   style: TextStyle(
                    //     color: appPrimaryColor,
                    //     fontSize: 17.0, 
                    //     fontWeight: FontWeight.w600
                    //   ),
                    //   textAlign: TextAlign.start,
                    // ),
                  ],
                )
              ),
            ],
          ),
        )
      ),
    );
  }
}
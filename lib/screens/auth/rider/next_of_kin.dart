import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/screens/tab.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/back_icon.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/widgets/input_field.dart';

class NextOfKin extends StatefulWidget {
  static const String id = 'nextOfKin';

  const NextOfKin({Key? key}) : super(key: key);

  @override
  _NextOfKinState createState() => _NextOfKinState();
}

class _NextOfKinState extends State<NextOfKin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              Row(
                children: [
                  BackIcon(
                    onPress: () {Navigator.pop(context);},
                  ),

                  Container(
                    margin: const EdgeInsets.only(left: 40.0),
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {},
                      customBorder: const CircleBorder(),
                      child: const Text(
                        'CREATE AN ACCOUNT',
                        textScaleFactor: 1.2,
                        style: TextStyle(
                          color: appPrimaryColor,
                          fontWeight: FontWeight.bold,
                          // decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30.0),

              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Next Of Kin',
                      textScaleFactor: 1.2,
                      style: TextStyle(
                        color: appPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    const SizedBox(height: 30.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InputField(
                            obscureText: false,
                            text: 'First Name of Kin',
                            hintText: 'John',
                            textHeight: 10.0,
                            borderColor: appPrimaryColor.withOpacity(0.9),
                            suffixIcon: const Icon(
                              Remix.user_line,
                              size: 18.0,
                              color: Color(0xFF909090),
                            ),
                          ),
                        ),

                        const SizedBox(width: 8.0),

                        Expanded(
                          child: InputField(
                            obscureText: false,
                            text: ' Last Name of Kin',
                            hintText: 'Doe',
                            textHeight: 10.0,
                            borderColor: appPrimaryColor.withOpacity(0.9),
                            suffixIcon: const Icon(
                              Remix.user_line,
                              size: 18.0,
                              color: Color(0xFF909090),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30.0),
                    InputField(
                      obscureText: false,
                      text: 'Email Address of Kin',
                      hintText: 'johndoe@email.com',
                      textHeight: 10.0,
                      borderColor: appPrimaryColor.withOpacity(0.9),
                      suffixIcon: const Icon(
                        Remix.mail_line,
                        size: 18.0,
                        color: Color(0xFF909090),
                      ),
                    ),

                    const SizedBox(height: 30.0),
                    InputField(
                      obscureText: false,
                      text: 'Address of Kin',
                      hintText: 'Address of next of kin',
                      textHeight: 10.0,
                      borderColor: appPrimaryColor.withOpacity(0.9),
                      suffixIcon: const Icon(
                        Remix.home_7_line,
                        size: 18.0,
                        color: Color(0xFF909090),
                      ),
                    ),

                    const SizedBox(height: 30.0),
                    InputField(
                      obscureText: false,
                      text: 'Phone number of Kin',
                      hintText: '08000000000',
                      textHeight: 10.0,
                      borderColor: appPrimaryColor.withOpacity(0.9),
                      suffixIcon: const Icon(
                        Remix.phone_line,
                        size: 18.0,
                        color: Color(0xFF909090),
                      ),
                    ),

                    const SizedBox(height: 40.0),
                    Align(
                      alignment: Alignment.center,
                      child: Button(
                        text: 'Create account', 
                        onPress: () {
                          Navigator.of(context).pushNamed(Tabs.id);
                        }, 
                        color: appPrimaryColor, 
                        textColor: whiteColor, 
                        isLoading: false,
                        width: 350.0
                      )
                    ),
                  ],
                ),
              ),
            ],
          )
        ),
      )
    );
  }
}

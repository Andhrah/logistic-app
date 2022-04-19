import 'package:flutter/material.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/back_icon.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/widgets/input_field.dart';

class Signup extends StatefulWidget {
  static const String id = 'signup';

  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 30.0),
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

              const SizedBox(height: 70.0),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputField(
                      text: 'Full Name',
                      hintText: 'name',
                      textHeight: 15.0,
                      borderColor: secondaryColor.withOpacity(0.6),
                      suffixIcon: const Icon(
                        Icons.supervised_user_circle_outlined,
                        color: Color(0xFFCDCDCD),
                      ),
                    ),

                    const SizedBox(height: 30.0),
                    InputField(
                      text: 'Username',
                      hintText: 'username',
                      textHeight: 15.0,
                      borderColor: secondaryColor.withOpacity(0.6),
                    ),

                    const SizedBox(height: 30.0),
                    InputField(
                      text: 'Email',
                      hintText: '@email.com',
                      textHeight: 15.0,
                      borderColor: secondaryColor.withOpacity(0.6),
                    ),

                    const SizedBox(height: 40.0),
                    Align(
                      alignment: Alignment.center,
                      child: Button(
                        text: 'Proceed', 
                        onPress: () {}, 
                        color: secondaryColor, 
                        textColor: appPrimaryColor, 
                        isLoading: false,
                        width: 300.0
                      )
                    ),
                    

                    const SizedBox(height: 15.0),
                    const Align(
                      child: Text(
                        'Already have an account ? Log in',
                        textScaleFactor: 0.9,
                        style: TextStyle(
                          color: appPrimaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                )
              )
            ],
          )
        ),
      )
    );
  }
}

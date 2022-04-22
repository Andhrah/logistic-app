import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/screens/auth/forgot_password_pin.dart';
import 'package:trakk/screens/auth/login.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/back_icon.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/widgets/input_field.dart';

class ForgetPassword extends StatefulWidget {
  static const String id = 'forgotPassword';

  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackIcon(
                    onPress: () {Navigator.pop(context);},
                  ),

                  Container(
                    margin: const EdgeInsets.only(right: 70.0),
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {},
                      customBorder: const CircleBorder(),
                      child: const Text(
                        'FORGOT PASSWORD',
                        textScaleFactor: 1.2,
                        style: TextStyle(
                          color: appPrimaryColor,
                          fontWeight: FontWeight.bold,
                          // decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(),
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
                      'Please enter the email address associated\nwith your trakk account, we will send a\nreset link to you',
                      textScaleFactor: 1.2,
                        style: TextStyle(
                          color: appPrimaryColor,
                          // fontWeight: FontWeight.bold,
                        ),
                    ),
                    const SizedBox(height: 50.0),

                    InputField(
                      text: 'Email Address',
                      hintText: 'jane@email.com',
                      textHeight: 10.0,
                      borderColor: appPrimaryColor.withOpacity(0.9),
                      suffixIcon: const Icon(
                        Remix.mail_line,
                        size: 18.0,
                        color: Color(0xFF909090),
                      ),
                    ),

                    const SizedBox(height: 50.0),
                    Align(
                      alignment: Alignment.center,
                      child: Button(
                        text: 'Request reset code', 
                        onPress: () {
                          Navigator.of(context).pushNamed(ForgetPasswordPin.id);
                        }, 
                        color: appPrimaryColor, 
                        textColor: whiteColor, 
                        isLoading: false,
                        width: 350.0
                      )
                    ),

                    const SizedBox(height: 15.0),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pushNamed(Login.id);
                      },
                      child: Align(
                        child: RichText(
                          textScaleFactor: 0.9,
                          text: const TextSpan(
                            text: 'Don’t have an account? ',
                            style: TextStyle(
                              color: appPrimaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                            children: <TextSpan>[
                              TextSpan(text: 'Sign up', style: TextStyle(fontWeight: FontWeight.bold, color: secondaryColor)),
                            ],
                          ),
                        ),
                      ),
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

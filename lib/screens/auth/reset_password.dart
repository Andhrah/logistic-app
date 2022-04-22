import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/screens/auth/login.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/back_icon.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/widgets/input_field.dart';

class ResetPassword extends StatefulWidget {
  static const String id = 'resetPassword';

  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
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
                        'RESET PASSWORD',
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
                    InputField(
                      text: 'Enter new password',
                      hintText: 'password',
                      textHeight: 10.0,
                      borderColor: appPrimaryColor.withOpacity(0.9),
                      suffixIcon: const Icon(
                        Remix.eye_close_line,
                        size: 18.0,
                        color: Color(0xFF909090),
                      ),
                    ),

                    const SizedBox(height: 30.0),
                    InputField(
                      text: 'Confirm password',
                      hintText: 'password',
                      textHeight: 10.0,
                      borderColor: appPrimaryColor.withOpacity(0.9),
                      suffixIcon: const Icon(
                        Remix.eye_close_line,
                        size: 18.0,
                        color: Color(0xFF909090),
                      ),
                    ),

                    const SizedBox(height: 50.0),
                    Align(
                      alignment: Alignment.center,
                      child: Button(
                        text: 'Reset Password', 
                        onPress: () {
                          Navigator.of(context).pushNamed(Login.id);
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

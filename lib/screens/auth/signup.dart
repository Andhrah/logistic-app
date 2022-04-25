import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/screens/auth/login.dart';
import 'package:trakk/screens/auth/rider/personal_data.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/back_icon.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/widgets/elevated_container.dart';
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InputField(
                            text: 'First Name',
                            hintText: 'Jane',
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
                            text: 'Last Name',
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

                    const SizedBox(height: 30.0),
                    InputField(
                      text: 'Phone Number',
                      hintText: '08000000000',
                      textHeight: 10.0,
                      borderColor: appPrimaryColor.withOpacity(0.9),
                      suffixIcon: const Icon(
                        Remix.phone_line,
                        size: 18.0,
                        color: Color(0xFF909090),
                      ),
                    ),

                    const SizedBox(height: 30.0),
                    InputField(
                      text: 'Password',
                      hintText: 'password',
                      textHeight: 10.0,
                      borderColor: appPrimaryColor.withOpacity(0.9),
                      suffixIcon: const Icon(
                        Remix.eye_close_line,
                        size: 18.0,
                        color: Color(0xFF909090),
                      ),
                    ),

                    const SizedBox(height: 40.0),
                    Align(
                      alignment: Alignment.center,
                      child: Button(
                        text: 'Create an account', 
                        onPress: () {
                          Navigator.of(context).pushNamed(PersonalData.id);
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
                            text: 'Already have an account? ',
                            style: TextStyle(
                              color: appPrimaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                            children: <TextSpan>[
                              TextSpan(text: 'Log in', style: TextStyle(fontWeight: FontWeight.bold, color: secondaryColor)),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25.0),
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            color: appPrimaryColor,
                          ),
                        ),

                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                          'Or continue with',
                            textScaleFactor: 1.2,
                            style: TextStyle(
                              color: appPrimaryColor,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                        ),

                        const Expanded(
                          child: Divider(
                            color: appPrimaryColor,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        ElevatedContainer(
                          onPress: (){},
                          radius: 5.0, 
                          color: whiteColor,
                          height: 55.0,
                          width: 55.0,
                          child: Image.asset(
                            'assets/images/google_icon.png',
                            height: 15,
                            width: 15,
                          ),
                        ),

                        ElevatedContainer(
                          onPress: (){},
                          radius: 5.0, 
                          color: whiteColor,
                          height: 55.0,
                          width: 55.0,
                          child: Image.asset(
                            'assets/images/apple_icon.png',
                            height: 20,
                            width: 20,
                          ),
                        ),

                        ElevatedContainer(
                          onPress: (){},
                          radius: 5.0, 
                          color: whiteColor,
                          height: 55.0,
                          width: 55.0,
                          child: Image.asset(
                            'assets/images/facebook_icon.png',
                            height: 18,
                            width: 18,
                          ),
                        ),
                      ],
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
// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/src/mixins/connectivity_helper.dart';
import 'package:trakk/src/mixins/logout_helper.dart';
import 'package:trakk/src/mixins/signup_helper.dart';
import 'package:trakk/src/screens/auth/login.dart';
import 'package:trakk/src/screens/auth/terms_and_condition_widget.dart';
import 'package:trakk/src/utils/app_toast.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/widgets/back_icon.dart';
import 'package:trakk/src/widgets/button.dart';
import 'package:trakk/src/widgets/input_field.dart';

class Signup extends StatefulWidget {
  static const String id = 'signup';

  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup>
    with SignupHelper, ConnectivityHelper, LogoutHelper {
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _phoneNumber;
  String? _password;
  String? userType;

  bool _loading = false;
  bool _passwordIsValid = false;
  bool _hidePassword = true;
  bool _emailIsValid = false;
  bool termsAndCondition = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  /// This function handles email validation
  _validateEmail() {
    RegExp regex;
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    String email = emailController.text;
    if (email.trim().isEmpty) {
      setState(() {
        _emailIsValid = false;
      });
      return "Email address cannot be empty";
    } else {
      regex = RegExp(pattern);
      setState(() {
        _emailIsValid = regex.hasMatch(email);
      });
      if (_emailIsValid == false) {
        return "Enter a valid email address";
      }
    }
  }

  _onSubmit(String userType) async {
    if (!termsAndCondition) {
      runToast('Please accept terms and condition to continue');
      return;
    }

    doSignUpOperation(
        userType,
        () => setState(() {
              _loading = true;
            }),
        () => setState(() {
              _loading = false;
            }));
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    String userType = arg["userType"];

    return Scaffold(
        backgroundColor: whiteColor,
        body: SingleChildScrollView(
          child: SafeArea(
              child: Column(
            children: [
              kSizeBox,
              Row(
                children: [
                  BackIcon(
                    onPress: () {
                      Navigator.pop(context);
                    },
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
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputField(
                        key: const Key('firstName'),
                        textController: firstNameController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: false,
                        text: 'First Name',
                        hintText: 'Jane',
                        textHeight: 10.0,
                        borderColor: appPrimaryColor.withOpacity(0.9),
                        suffixIcon: const Icon(
                          Remix.user_line,
                          size: 18.0,
                          color: Color(0xFF909090),
                        ),
                        validator: (value) {
                          if (value!.trim().length > 2) {
                            return null;
                          }
                          return "Enter a valid first name";
                        },
                        onSaved: (value) {
                          _firstName = value!.trim();
                          return null;
                        },
                      ),
                      const SizedBox(height: 30.0),
                      InputField(
                        key: const Key('lastName'),
                        textController: lastNameController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: false,
                        text: 'Last Name',
                        hintText: 'Doe',
                        textHeight: 10.0,
                        borderColor: appPrimaryColor.withOpacity(0.9),
                        suffixIcon: const Icon(
                          Remix.user_line,
                          size: 18.0,
                          color: Color(0xFF909090),
                        ),
                        validator: (value) {
                          if (value!.trim().length > 2) {
                            return null;
                          }
                          return "Enter a valid last name";
                        },
                        onSaved: (value) {
                          _lastName = value!.trim();
                          return null;
                        },
                      ),
                      const SizedBox(height: 30.0),
                      InputField(
                        key: const Key('email'),
                        textController: emailController,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        text: 'Email Address',
                        hintText: 'jane@email.com',
                        textHeight: 5.0,
                        borderColor: appPrimaryColor.withOpacity(0.9),
                        suffixIcon: const Icon(
                          Remix.mail_line,
                          size: 18.0,
                          color: Color(0xFF909090),
                        ),
                        validator: (value) {
                          return _validateEmail();
                        },
                        onSaved: (value) {
                          _email = value!.trim();
                          return null;
                        },
                      ),
                      const SizedBox(height: 30.0),
                      InputField(
                        key: const Key('phoneNumber'),
                        textController: phoneNumberController,
                        keyboardType: TextInputType.phone,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: false,
                        text: 'Phone Number',
                        hintText: '08000000000',
                        textHeight: 5.0,
                        borderColor: appPrimaryColor.withOpacity(0.9),
                        suffixIcon: const Icon(
                          Remix.phone_line,
                          size: 18.0,
                          color: Color(0xFF909090),
                        ),
                        validator: (value) {
                          if (value!.trim().length == 11) {
                            return null;
                          }
                          return "Enter a valid phone number";
                        },
                        onSaved: (value) {
                          _phoneNumber = value!.trim();
                          return null;
                        },
                      ),
                      const SizedBox(height: 30.0),
                      InputField(
                        key: const Key('password'),
                        textController: passwordController,
                        obscureText: _hidePassword,
                        maxLines: 1,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        text: 'Password',
                        hintText: 'password',
                        textHeight: 5.0,
                        borderColor: appPrimaryColor.withOpacity(0.9),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _hidePassword == false
                                ? Remix.eye_line
                                : Remix.eye_close_line,
                            size: 18.0,
                            color: const Color(0xFF909090),
                          ),
                          onPressed: () {
                            setState(() {
                              _hidePassword = !_hidePassword;
                            });
                          },
                        ),
                        validator: (value) {
                          // This statements handles password validation
                          RegExp regex;
                          String strongRegex =
                              r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*])(?=.{8,})';
                          if (value!.isEmpty) {
                            _passwordIsValid = false;
                            return "Password cannot be empty";
                          } else {
                            regex = RegExp(strongRegex);
                            _passwordIsValid = regex.hasMatch(value);
                            if (_passwordIsValid == false) {
                              return "Password should be 8 characters or more,\ncontain at least a number, \na lowercase, \na capital letter and a special character";
                            }
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _password = value!.trim();
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      TermsAndConditionWidget((bool _value) {
                        termsAndCondition = _value;
                      }),
                      const SizedBox(height: 40.0),
                      Align(
                          alignment: Alignment.center,
                          child: Button(
                              text: 'Create an account',
                              onPress: () => _onSubmit(userType),
                              // onPress: () {
                              //   Navigator.of(context).pushNamed(PersonalData.id);
                              // },
                              color: appPrimaryColor,
                              textColor: whiteColor,
                              isLoading: _loading,
                              width: 350.0)),
                      const SizedBox(height: 15.0),
                      InkWell(
                        onTap: () {
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
                                TextSpan(
                                    text: 'Log in',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: secondaryColor)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25.0),
                      // userType != "merchant"
                      //     ? Row(
                      //         children: const [
                      //           Expanded(
                      //             child: Divider(
                      //               color: appPrimaryColor,
                      //             ),
                      //           ),
                      //           Padding(
                      //             padding:
                      //                 EdgeInsets.symmetric(horizontal: 8.0),
                      //             child: Text(
                      //               'Or continue with',
                      //               textScaleFactor: 1.2,
                      //               style: TextStyle(
                      //                   color: appPrimaryColor,
                      //                   fontWeight: FontWeight.w400),
                      //             ),
                      //           ),
                      //           Expanded(
                      //             child: Divider(
                      //               color: appPrimaryColor,
                      //             ),
                      //           ),
                      //         ],
                      //       )
                      //     : Container(),
                      // userType != "merchant"
                      //     ? Row(
                      //         children: [
                      //           Expanded(
                      //             child: ElevatedContainer(
                      //               onPress: () {},
                      //               radius: 5.0,
                      //               color: whiteColor,
                      //               height: 55.0,
                      //               width: 55.0,
                      //               child: Image.asset(
                      //                 'assets/images/google_icon.png',
                      //                 height: 15,
                      //                 width: 15,
                      //               ),
                      //             ),
                      //           ),
                      //           Expanded(
                      //             child: ElevatedContainer(
                      //               onPress: () {},
                      //               radius: 5.0,
                      //               color: whiteColor,
                      //               height: 55.0,
                      //               width: 55.0,
                      //               child: Image.asset(
                      //                 'assets/images/apple_icon.png',
                      //                 height: 20,
                      //                 width: 20,
                      //               ),
                      //             ),
                      //           ),
                      //           Expanded(
                      //             child: ElevatedContainer(
                      //               onPress: () {},
                      //               radius: 5.0,
                      //               color: whiteColor,
                      //               height: 55.0,
                      //               width: 55.0,
                      //               child: Image.asset(
                      //                 'assets/images/facebook_icon.png',
                      //                 height: 18,
                      //                 width: 18,
                      //               ),
                      //             ),
                      //           ),
                      //           kSizeBox,
                      //           kSizeBox,
                      //         ],
                      //       )
                      //     : Container(),
                    ],
                  ),
                ),
              ),
            ],
          )),
        ));
  }
}

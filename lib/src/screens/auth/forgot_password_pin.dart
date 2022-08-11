import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:trakk/src/mixins/connectivity_helper.dart';
import 'package:trakk/src/mixins/forgot_password_helper.dart';
import 'package:trakk/src/screens/auth/reset_password.dart';
import 'package:trakk/src/utils/helper_utils.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/widgets/back_icon.dart';

class ForgetPasswordPin extends StatefulWidget {
  static const String id = 'forgotPasswordPin';

  const ForgetPasswordPin({Key? key}) : super(key: key);

  @override
  _ForgetPasswordPinState createState() => _ForgetPasswordPinState();
}

class _ForgetPasswordPinState extends State<ForgetPasswordPin>
    with ForgotPasswordHelper, ConnectivityHelper {
  final _formKey = GlobalKey<FormState>();

  TextEditingController textEditingController = TextEditingController();

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  bool _loading = false;
  bool _resendOtpLoading = false;

  String code = "";
  String? _email;

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  // snackBar Widget
  snackBar(String? message, Color? color) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
        backgroundColor: color,
      ),
    );
  }

  _onSubmit() async {
    Navigator.of(context).pushNamed(ResetPassword.id, arguments: {
      "email": _email,
      "code": code,
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    _email = arg["email"];

    return Scaffold(
        backgroundColor: whiteColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SafeArea(child: 12.heightInPixel()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackIcon(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultLayoutPadding),
                    onPress: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    'FORGOT PASSWORD',
                    style: theme.textTheme.subtitle1!.copyWith(
                        fontWeight: kBoldWeight,
                        fontFamily: kDefaultFontFamilyHeading
                        // decoration: TextDecoration.underline,
                        ),
                  ),
                  BackIcon(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultLayoutPadding),
                    isPlaceHolder: true,
                    onPress: () {},
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
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/forgot_password.png',
                        height: 160,
                        width: 160,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 8),
                      child: RichText(
                        textScaleFactor: 1.0,
                        text: TextSpan(
                            text: "Enter the code sent to ",
                            children: [
                              TextSpan(
                                  // text: "your email address",
                                  text: _email,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    // fontSize: 15
                                  )),
                            ],
                            style: const TextStyle(
                                color: Colors.black54, fontSize: 15)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Form(
                      key: _formKey,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 0),
                          child: PinCodeTextField(
                            appContext: context,
                            pastedTextStyle: const TextStyle(
                              // color: Colors.green.shade600,
                              fontWeight: FontWeight.bold,
                            ),
                            length: 6,
                            obscureText: true,
                            blinkWhenObscuring: true,
                            animationType: AnimationType.fade,
                            // validator: (v) {
                            //   if (v! == int) {
                            //     return "I'm from validator";
                            //   } else {
                            //     return null;
                            //   }
                            // },
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(5),
                              fieldHeight: 50,
                              fieldWidth: 50,
                              inactiveColor: appPrimaryColor,
                              activeColor: secondaryColor,
                              selectedColor: secondaryColor,
                              inactiveFillColor: whiteColor,
                              activeFillColor: whiteColor,
                              selectedFillColor: whiteColor,
                              errorBorderColor: appPrimaryColor,
                            ),
                            cursorColor: Colors.black,
                            animationDuration:
                                const Duration(milliseconds: 300),
                            enableActiveFill: true,
                            errorAnimationController: errorController,
                            controller: textEditingController,
                            keyboardType: TextInputType.emailAddress,
                            onCompleted: (v) {
                              debugPrint("Completed");
                              // snackBar(
                              //   "Code Verified!!",
                              //   green,
                              // );
                              _onSubmit();
                            },
                            // onTap: () {
                            //   print("Pressed");
                            // },
                            onChanged: (value) {
                              debugPrint(value);
                              setState(() {
                                code = value;
                              });
                            },
                            beforeTextPaste: (text) {
                              debugPrint("Allowing to paste $text");
                              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                              //but you can show anything you want here, like your pop up saying wrong paste format or etc
                              return true;
                            },
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        hasError
                            ? "*Please fill up all the cells properly"
                            : "",
                        style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Didn't receive the code? ",
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                          textScaleFactor: 1.0,
                        ),
                        TextButton(
                          onPressed: _onSubmit,
                          child: _loading
                              ? const Text(
                                  "RESENDING...",
                                  style: TextStyle(
                                      color: secondaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                )
                              : const Text(
                                  "RESEND",
                                  style: TextStyle(
                                      color: secondaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

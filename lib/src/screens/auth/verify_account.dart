import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:trakk/src/mixins/connectivity_helper.dart';
import 'package:trakk/src/mixins/logout_helper.dart';
import 'package:trakk/src/mixins/signup_helper.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/widgets/back_icon.dart';
import 'package:trakk/src/widgets/button.dart';

class VerifiyAccountScreen extends StatefulWidget {
  static const String id = 'otp';

  const VerifiyAccountScreen({Key? key}) : super(key: key);

  @override
  _VerifiyAccountScreenState createState() => _VerifiyAccountScreenState();
}

class _VerifiyAccountScreenState extends State<VerifiyAccountScreen>
    with SignupHelper, ConnectivityHelper, LogoutHelper {
  final _formKey = GlobalKey<FormState>();

  TextEditingController textEditingController = TextEditingController();

// ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  bool _loading = false;
  bool _resendOtpLoading = false;

  String _code = "";
  String? _email;
  String? _phoneNumber;
  String? _userType;
  String currentText = "";

  Color inactiveColor = appPrimaryColor;

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

  /// this method validates user's input
  _handleUserInput() {
    _formKey.currentState!.validate();
    // conditions for validating
    if (_code.length != 6) {
      errorController!
          .add(ErrorAnimationType.shake); // Triggering error shake animation
      setState(() => {
            inactiveColor = redColor,
            hasError = true,
          });
    } else {
      setState(
        () {
          hasError = false;
          // snackBar("OTP Verified!!");
        },
      );
      _onSubmit();
    }
  }

  /// This method handles the onsubmit event annd validates users input. It triggers validation and sends data to the API
  _onSubmit() async {
    doVerifyOperation(
        _code.toString(),
        _email.toString(),
        () => setState(() {
              _loading = true;
            }),
        () => setState(() {
              _loading = false;
            }));
  }

  /// This method handles the resend otp event and sends data to the API
  _resendOtp() async {
    doResendOTPOperation(
        _email.toString(),
        _phoneNumber.toString(),
        () => setState(() {
              _resendOtpLoading = true;
            }),
        () => setState(() {
              _resendOtpLoading = false;
            }));
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    _email = arg["email"];
    _phoneNumber = arg["phoneNumber"];
    _userType = arg["userType"];

    return Scaffold(
        backgroundColor: whiteColor,
        body: SingleChildScrollView(
          child: SafeArea(
              child: Column(
            children: [
              const SizedBox(height: 10.0),
              kSizeBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackIcon(
                    onPress: () {
                      Navigator.pop(context);
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 70.0),
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {},
                      customBorder: const CircleBorder(),
                      child: const Text(
                        'VERIFY ACCOUNT',
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
                                  text: _email! + ' or ' + _phoneNumber!,
                                  style: const TextStyle(
                                    color: appPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                    // fontSize: 15
                                  )),
                              const TextSpan(
                                  text: " to verify your account",
                                  style: TextStyle()),
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
                            keyboardType: TextInputType.phone,
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
                              errorBorderColor: redColor,
                            ),
                            cursorColor: Colors.black,
                            animationDuration:
                                const Duration(milliseconds: 300),
                            enableActiveFill: true,
                            errorAnimationController: errorController,
                            controller: textEditingController,
                            onCompleted: (v) {
                              debugPrint("Completed");
                            },
                            onTap: () {},
                            onChanged: (value) {
                              debugPrint(value);
                              setState(() {
                                _code = value;
                                hasError = false;
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
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: Text(
                        hasError ? "* Please, enter the code sent to you." : "",
                        style: const TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(height: 50.0),
                    Align(
                        alignment: Alignment.center,
                        child: Button(
                            text: 'Verify account',
                            onPress: _handleUserInput,
                            color: appPrimaryColor,
                            textColor: whiteColor,
                            isLoading: _loading,
                            width: 350.0)),
                    kSizeBox,
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
                          onPressed: _resendOtp,
                          child: _resendOtpLoading
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
          )),
        ));
  }
}

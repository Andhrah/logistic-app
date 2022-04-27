import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:trakk/provider/auth/auth_provider.dart';
import 'package:trakk/screens/auth/forgot_password.dart';
import 'package:trakk/screens/auth/reset_password.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/back_icon.dart';

class ForgetPasswordPin extends StatefulWidget {
  static const String id = 'forgotPasswordPin';

  const ForgetPasswordPin({Key? key}) : super(key: key);

  @override
  _ForgetPasswordPinState createState() => _ForgetPasswordPinState();
}

class _ForgetPasswordPinState extends State<ForgetPasswordPin> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  bool _loading = false;

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
    setState(() {
      _loading = true;
    });
    
    final FormState? form = _formKey.currentState;
    if(form!.validate()){

      form.save();
      
      try {
        var response = await Auth.authProvider(context).forgetPassword(
          _email.toString(), 
        );
        setState(() {
          _loading = false;
        });
        if (response["statusCode"] == "OK") {
          form.reset();
          await Flushbar(
            messageText: Text(
              response["message"],
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: whiteColor,
                fontSize: 18,
              ),
            ),
            backgroundColor: green,
            maxWidth: MediaQuery.of(context).size.width/1.2,
            flushbarPosition: FlushbarPosition.TOP,
            borderRadius: BorderRadius.circular(10),
            duration: const Duration(seconds: 2),
          ).show(context);
          // Navigator.of(context).pushNamed(ForgetPasswordPin.id);
        } else {
          await Flushbar(
            messageText: Text(
              response["message"],
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: whiteColor,
                fontSize: 18,
              ),
            ),
            backgroundColor: redColor,
            maxWidth: MediaQuery.of(context).size.width/1.2,
            flushbarPosition: FlushbarPosition.TOP,
            borderRadius: BorderRadius.circular(10),
            duration: const Duration(seconds: 5),
          ).show(context);
        }
        // Auth.authProvider(context)
      } catch(err){
        setState(() {
          _loading = false;
        });
        await Flushbar(
          messageText: Text(
            err.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: whiteColor,
              fontSize: 18,
            ),
          ),
          backgroundColor: redColor,
          maxWidth: MediaQuery.of(context).size.width/1.2,
          flushbarPosition: FlushbarPosition.TOP,
          borderRadius: BorderRadius.circular(10),
          duration: const Duration(seconds: 5),
        ).show(context);
        rethrow;
      }
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    _email = arg["email"];

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
                      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8),
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
                              )
                            ),
                          ],
                          style: const TextStyle(color: Colors.black54, fontSize: 15)
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    
                    const SizedBox(height: 10.0),

                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
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
                          animationDuration: const Duration(milliseconds: 300),
                          enableActiveFill: true,
                          errorAnimationController: errorController,
                          controller: textEditingController,
                          keyboardType: TextInputType.emailAddress,
                          onCompleted: (v) {
                            debugPrint("Completed");
                            snackBar(
                              "Code Verified!!",
                              green,
                            );
                            Navigator.of(context).pushNamed(
                              ResetPassword.id,
                              arguments: {
                                "code": code,
                              }
                            );
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
                        )
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        hasError ? "*Please fill up all the cells properly" : "",
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
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
                          child: _loading ? const Text(
                            "RESENDING...",
                            style: TextStyle(
                              color: secondaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                            ),
                          ) : const Text(
                            "RESEND",
                            style: TextStyle(
                              color: secondaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                            ),
                          ), 
                        )
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

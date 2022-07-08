import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/provider/auth/forgot_password_provider.dart';
import 'package:trakk/screens/auth/login.dart';
import 'package:trakk/utils/app_toast.dart';
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
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _emailController;

  FocusNode? _emailNode;

  bool _loading = false;
  bool _emailIsValid = false;

  String? _email;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  /*
   * This method handles the onsubmit event annd validates users input. It triggers validation and sends data to the API
  */
  _onSubmit() async {
    setState(() {
      _loading = true;
    });

    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      form.save();

      try {
        var response =
            await ForgotPasswordProvider.authProvider(context).forgetPassword(
          _email.toString(),
        );
        setState(() {
          _loading = false;
        });
        await appToast(
          response["data"]["message"],
          green,
        );
        // if (response["statusCode"] == "OK") {
        //   form.reset();
        //   await Flushbar(
        //     messageText: Text(
        //       response["message"],
        //       textAlign: TextAlign.center,
        //       style: const TextStyle(
        //         color: whiteColor,
        //         fontSize: 18,
        //       ),
        //     ),
        //     backgroundColor: green,
        //     maxWidth: MediaQuery.of(context).size.width/1.2,
        //     flushbarPosition: FlushbarPosition.TOP,
        //     borderRadius: BorderRadius.circular(10),
        //     duration: const Duration(seconds: 4),
        //   ).show(context);
        //   Navigator.of(context).pushNamed(
        //     ForgetPasswordPin.id,
        //     arguments: {
        //       "email": _email,
        //     }
        //   );
        // } else {
        //   await Flushbar(
        //     messageText: Text(
        //       response["message"],
        //       textAlign: TextAlign.center,
        //       style: const TextStyle(
        //         color: whiteColor,
        //         fontSize: 18,
        //       ),
        //     ),
        //     backgroundColor: redColor,
        //     maxWidth: MediaQuery.of(context).size.width/1.2,
        //     flushbarPosition: FlushbarPosition.TOP,
        //     borderRadius: BorderRadius.circular(10),
        //     duration: const Duration(seconds: 5),
        //   ).show(context);
        // }
        // Auth.authProvider(context)
      } catch (err) {
        setState(() {
          _loading = false;
        });
        await appToast(err.toString(), redColor);
        rethrow;
      }
    }
    setState(() {
      _loading = false;
    });
  }

  _validateEmail() {
    RegExp regex;
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    String email = _emailController.text;
    if (email.trim().isEmpty) {
      setState(() {
        _emailIsValid = false;
      });
      return "Email address cannot be empty";
    } else {
      regex = RegExp(pattern);
      setState(() {
        _emailIsValid = regex.hasMatch(email);
        print(_emailIsValid);
      });
      if (_emailIsValid == false) {
        return "Enter a valid email address";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        body: SingleChildScrollView(
          child: SafeArea(
              child: Column(
            children: [
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Please enter the email address associated\nwith your trakk account, we will send a\nreset code to you',
                        textScaleFactor: 1.2,
                        style: TextStyle(
                          color: appPrimaryColor.withOpacity(0.5),
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 50.0),
                      InputField(
                        key: const Key('email'),
                        obscureText: false,
                        textController: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        node: _emailNode,
                        text: 'Email Address',
                        hintText: 'jane@email.com',
                        textHeight: 10.0,
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
                      const SizedBox(height: 50.0),
                      Align(
                          alignment: Alignment.center,
                          child: Button(
                              text: 'Request reset code',
                              onPress: _onSubmit,
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
                            textScaleFactor: 1,
                            text: const TextSpan(
                              text: 'Don’t have an account? ',
                              style: TextStyle(
                                color: appPrimaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Sign up',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: secondaryColor)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
        ));
  }
}

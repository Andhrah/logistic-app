import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/src/mixins/connectivity_helper.dart';
import 'package:trakk/src/mixins/forgot_password_helper.dart';
import 'package:trakk/src/utils/helper_utils.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/widgets/back_icon.dart';
import 'package:trakk/src/widgets/button.dart';
import 'package:trakk/src/widgets/input_field.dart';

class ForgetPassword extends StatefulWidget {
  static const String id = 'forgotPassword';

  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword>
    with ForgotPasswordHelper, ConnectivityHelper {
  FocusNode? _emailNode;

  bool _loading = false;
  bool _emailIsValid = false;

  String? _email;

  @override
  void initState() {
    super.initState();
  }

  /*
   * This method handles the onsubmit event annd validates users input. It triggers validation and sends data to the API
  */
  _onSubmit() async {
    doForgotPasswordOperation(
        () => setState(() {
              _loading = true;
            }),
        () => setState(() {
              _loading = false;
            }));
  }

  _validateEmail() {
    RegExp regex;
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    String email = emailCC.text;
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
    var theme = Theme.of(context);

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
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultLayoutPadding),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Please enter the email address associated\nwith your trakk account, we will send a\nreset code to you.',
                        textAlign: TextAlign.start,
                        style: theme.textTheme.bodyText1!.copyWith(
                          color: appPrimaryColor,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 50.0),
                      InputField(
                        key: const Key('email'),
                        obscureText: false,
                        textController: emailCC,
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
                              width: double.infinity)),
                      const SizedBox(height: 15.0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

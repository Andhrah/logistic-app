import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/src/mixins/connectivity_helper.dart';
import 'package:trakk/src/mixins/forgot_password_helper.dart';
import 'package:trakk/src/utils/helper_utils.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/widgets/back_icon.dart';
import 'package:trakk/src/widgets/button.dart';
import 'package:trakk/src/widgets/input_field.dart';

class ResetPassword extends StatefulWidget {
  static const String id = 'resetPassword';

  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword>
    with ForgotPasswordHelper, ConnectivityHelper {
  bool _loading = false;
  bool _hidePassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    passwordCC.dispose();
    confirmPasswordCC.dispose();
    super.dispose();
  }

  _onSubmit() async {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    String email = arg["email"];
    String code = arg["code"];

    doResetPasswordOperation(
        email,
        code,
        () => setState(() {
              _loading = true;
            }),
        () => setState(() {
              _loading = false;
            }));
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
                    'RESET PASSWORD',
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
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputField(
                          key: const Key('password'),
                          textController: passwordCC,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          text: 'Enter new password',
                          hintText: 'password',
                          obscureText: _hidePassword,
                          textHeight: 10.0,
                          maxLines: 1,
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
                            if (value!.trim().length < 7) {
                              return "Password should be 8 characters or more";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30.0),
                        InputField(
                          key: const Key('confirmPassword'),
                          textController: confirmPasswordCC,
                          maxLines: 1,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          text: 'Confirm password',
                          hintText: 'password',
                          obscureText: _hidePassword,
                          textHeight: 10.0,
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
                            if (confirmPasswordCC.text != passwordCC.text) {
                              return "Password does not match";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 50.0),
                        Align(
                            alignment: Alignment.center,
                            child: Button(
                                text: 'Reset Password',
                                // onPress: () {
                                //   Navigator.of(context).pushNamed(Login.id);
                                // },
                                onPress: _onSubmit,
                                color: appPrimaryColor,
                                textColor: whiteColor,
                                isLoading: _loading,
                                width: 350.0)),
                      ],
                    ),
                  )),
            ],
          ),
        ));
  }
}

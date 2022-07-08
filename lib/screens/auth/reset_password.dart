import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/mixins/forgot_password_helper.dart';
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

class _ResetPasswordState extends State<ResetPassword>
    with ForgotPasswordHelper {
  final _formKey = GlobalKey<FormState>();

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
    String code = arg["code"];

    doResetPasswordOperation(
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
                  child: Form(
                    key: _formKey,
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
                                  ? Remix.eye_fill
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
                                  ? Remix.eye_fill
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
          )),
        ));
  }
}

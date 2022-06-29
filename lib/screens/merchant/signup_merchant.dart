// ignore_for_file: unnecessary_null_comparison

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/provider/auth/auth_provider.dart';
import 'package:trakk/screens/auth/login.dart';
import 'package:trakk/screens/merchant/company_home.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/back_icon.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/widgets/input_field.dart';

class SignupMerchant extends StatefulWidget {
  static const String id = 'signup';

  const SignupMerchant({Key? key}) : super(key: key);

  @override
  _SignupMerchantState createState() => _SignupMerchantState();
}

class _SignupMerchantState extends State<SignupMerchant> {
  static String userType = "user";

  final _formKey = GlobalKey<FormState>();

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  FocusNode? _firstNameNode;
  FocusNode? _lastNameNode;
  FocusNode? _phoneNumberNode;
  FocusNode? _emailNode;
  FocusNode? _passwordNode;
  FocusNode? _confirmPasswordNode;

  String? _firstName;
  String? _lastName;
  String? _email;
  String? _phoneNumber;
  String? _password;
  String? _confirmPassword;

  bool _loading = false;
  bool _passwordIsValid = false;
  bool _confirmPasswordIsValid = false;
  bool _hidePassword = true;
  bool _autoValidate = false;
  bool _emailIsValid = false;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
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

  isConfirmPasswordValid() {
    setState(() {
      _confirmPasswordIsValid = _confirmPasswordController.text != null &&
          _confirmPasswordController.text == _passwordController.text;
      print(_confirmPasswordIsValid);
    });
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
              const SizedBox(height: 20.0),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Text(
                    'Company\'s data:',
                    textScaleFactor: 1.2,
                    style: TextStyle(
                      fontSize: 18,
                      color: appPrimaryColor,
                      fontWeight: FontWeight.bold,
                      // decoration: TextDecoration.underline,
                    ),
                  ),
                ),
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
                        key: const Key('Company\'s name'),
                        textController: _firstNameController,
                        node: _firstNameNode,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: false,
                        text: 'Company\'s name',
                        hintText: 'Company\'s name',
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
                          return "Enter a valid Company's  name";
                        },
                        onSaved: (value) {
                          _firstName = value!.trim();
                          return null;
                        },
                      ),
                      const SizedBox(height: 30.0),
                      InputField(
                        key: const Key('Company\'s email address'),
                        textController: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        node: _emailNode,
                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: false,
                        text: 'Company\'s email address',
                        hintText: 'Company\'s email address',
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
                      const SizedBox(height: 30.0),
                      InputField(
                        key: const Key('phoneNumber'),
                        textController: _phoneNumberController,
                        keyboardType: TextInputType.phone,
                        node: _phoneNumberNode,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: false,
                        text: 'Phone Number',
                        hintText: '08000000000',
                        textHeight: 10.0,
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
                        textController: _passwordController,
                        node: _passwordNode,
                        obscureText: _hidePassword,
                        maxLines: 1,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        text: 'Password',
                        hintText: 'password',
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
                          if (value!.trim().length < 7) {
                            return "Password should be 8\ncharacters or more";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _password = value!.trim();
                          return null;
                        },
                      ),
                      const SizedBox(height: 30.0),
                      InputField(
                        key: const Key('CAC  RC number (Optional)'),
                        textController: _confirmPasswordController,
                        node: _confirmPasswordNode,
                        maxLines: 1,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: _hidePassword,
                        text: 'CAC  RC number (Optional)',
                        hintText: 'CAC  RC number',
                        textHeight: 10.0,
                        borderColor: appPrimaryColor.withOpacity(0.9),
                        
                        
                      ),
                      const SizedBox(height: 40.0),
                      Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: appPrimaryColor.withOpacity(0.3),
                              width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 1.2,
                          height: 170,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  splashColor: Colors.black12.withAlpha(30),
                                  child: const Icon(Remix.upload_2_line),
                                  onTap: () {},
                                ),
                                const SizedBox(height: 26.0),
                                const Text(
                                    'Upload CAC Certificate\nnot more than 5mb',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: appPrimaryColor,
                                        fontWeight: FontWeight.w400))
                              ]),
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      Align(
                          alignment: Alignment.center,
                          child: Button(
                              text: 'Next',
                              //onPress:// _onSubmit,
                              onPress: () {
                                Navigator.of(context).pushNamed(CompanyHome.id);
                              },
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
                    ],
                  ),
                ),
              ),
            ],
          )),
        ));
  }
}

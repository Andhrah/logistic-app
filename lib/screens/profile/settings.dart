import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remixicon/remixicon.dart';

import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/back_icon.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/widgets/input_field.dart';
import 'package:flutter_switch/flutter_switch.dart';

class Settings extends StatefulWidget {
  static String id = "settings";

  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool status = false;

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

  /*
   * This method handles the onsubmit event annd validates users input. It triggers validation and sends data to the API
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 2.0,
      //   backgroundColor: Colors.white,
      //   leading: BackIcon(
      //     onPress: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      //   title: Container(
      //     // margin: const EdgeInsets.only(left: 0.0),
      //     alignment: Alignment.center,
      //     child: InkWell(
      //       onTap: () {},
      //       customBorder: const CircleBorder(),
      //       child: const Text(
      //         'SETTINGS',
      //         textScaleFactor: 1.0,
      //         style: TextStyle(
      //           color: appPrimaryColor,
      //           fontWeight: FontWeight.bold,
      //           // decoration: TextDecoration.underline,
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                BackIcon(
                  onPress: () {
                    Navigator.pop(context);
                  },
                ),
                Container(
                  height: 98,
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.3),
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {},
                    customBorder: const CircleBorder(),
                    child: const Text(
                      'SETTINGS',
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
            Expanded(
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  divider(),
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 30, bottom: 17),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              top: 8,
                              bottom: 12,
                            ),
                            height: 80,
                            width: 80,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/malik.png'))),
                          ),
                          const Text(
                            'Malik Johnson',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600),
                          ),
                          Row(crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('+234816559234'),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text('malhohn11@gmail.com'),
                                ],
                              ),
                              Button(
                                  text: "Edit profile",
                                  onPress: () {},
                                  color: appPrimaryColor,
                                  width: 100,
                                  textColor: grayColor,
                                  isLoading: false),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  divider(),
                  Container(
                    height: 150,
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 230, 230, 230),
                            spreadRadius: 1,
                            offset: Offset(2.0, 2.0), //(x,y)
                            blurRadius: 8.0,
                          ),
                        ],
                        color: whiteColor),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //SizedBox(height: 10.0),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: <Widget>[
                          //     // Container(
                          //     //   alignment: Alignment.centerRight,
                          //     //   child: Text(
                          //     //     "Value: $status",
                          //     //   ),
                          //     // ),
                          //   ],
                          // ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Remix.account_circle_line),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Text(
                                      "Account",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                Icon(Remix.arrow_right_s_line, size: 28,),
                              ]),
                          SettingsRow(
                            icon: FlutterSwitch(
                              height: 20.0,
                              width: 40.0,
                              padding: 4.0,
                              toggleSize: 15.0,
                              borderRadius: 10.0,
                              activeColor: secondaryColor,
                              value: status,
                              onToggle: (value) {
                                setState(() {
                                  status = value;
                                });
                              },
                            ),
                            statusIcon: Icon(Remix.notification_4_line),
                            title: 'Notifications',
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Remix.shield_keyhole_line),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Text(
                                      "Privacy & Security",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                Icon(Remix.arrow_right_s_line, size: 28,),
                              ]),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    padding: EdgeInsets.only(left: 30),
                    height: 64,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: whiteColor,
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 2,
                          color: Color.fromARGB(255, 224, 224, 224),
                          offset: Offset(2.0, 2.0), //(x,y)
                          blurRadius: 16,
                        ),
                      ],
                    ),
                    child: Align(
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/Logout.svg',
                              color: redColor,
                            ),
                            const SizedBox(
                              width: 22,
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Text(
                                "Log out",
                                style: TextStyle(
                                    color: redColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}

class divider extends StatelessWidget {
  const divider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 1.0,
      color: Color(0xff909090),
    );
  }
}

class SettingsRow extends StatelessWidget {
  final String title;
  final Widget statusIcon;
  final Widget icon;

  const SettingsRow({
    Key? key,
    required this.title,
    required this.statusIcon,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(
        children: [
          statusIcon,
          SizedBox(
            width: 25,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ],
      ),
      icon,
    ]);
  }
}

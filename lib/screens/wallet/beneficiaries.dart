import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remixicon/remixicon.dart';

import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/back_icon.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/widgets/cancel_button.dart';
import 'package:trakk/widgets/input_field.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../widgets/divider.dart';

class Beneficiaries extends StatefulWidget {
  static String id = "beneficiaries";

  const Beneficiaries({Key? key}) : super(key: key);

  @override
  State<Beneficiaries> createState() => _BeneficiariesState();
}

class _BeneficiariesState extends State<Beneficiaries> {
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
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                   onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: CancelButton(
                     
                    ),
                  ),
                ),
                Container(
                  height: 98,
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.2),
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {},
                    customBorder: const CircleBorder(),
                    child: const Text(
                      'BENEFICIARIES',
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            SizedBox(
              //height: 200,
              child: Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                 separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 20,), 
                 itemCount: 5,
                 itemBuilder: (BuildContext context, index) {
                   return Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4),),
                    color: Color(0xffEEEEEE)),
                    height: 114,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Expanded(child: Text("First Bank of Nigeria (FBN)\n00212564", textScaleFactor: 1, style: TextStyle(color: Colors.grey.shade600),)),
                            Icon(Remix.close_line, color: Colors.grey.shade600,)
                          ],
                        ),
                        SizedBox(height: 10,),
                        Expanded(
                          child: const Text("Ijeoma Uduma", 
                          textScaleFactor: 1.2,
                          style: TextStyle(fontWeight: FontWeight.w500),),
                        ),
                      ],
                    ));
                 }),
              ),
            ),
              ],
            ),
          ],
        ),
      ),
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

import 'dart:ui';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/provider/auth/auth_provider.dart';
import 'package:trakk/screens/auth/login.dart';
import 'package:trakk/screens/merchant/company_home.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/back_icon.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/widgets/cancel_button.dart';
import 'package:trakk/widgets/input_field.dart';

enum ProfileOptions {
  Edit,
  Suspend,
  Delete,
  Null,
}

class TransferWidget extends StatefulWidget {
  const TransferWidget({Key? key}) : super(key: key);

  @override
  State<TransferWidget> createState() => _TransferWidgetState();
}

class _TransferWidgetState extends State<TransferWidget> {
  ProfileOptions selectedProfileOptions = ProfileOptions.Edit;

  final _formKey = GlobalKey<FormState>();

  late TextEditingController _firstNameController;

  bool _selectedProfile = false;

  FocusNode? _firstNameNode;

  String? _firstName;

  static String userType = "user";

  var duration = [
    "Choose duration",
    "1 week",
    "1 month",
    "2 months",
    "indefinite",
    "add",
  ];

  bool _isButtonPress = false;
  bool _isActive = false;
  bool _isActive1 = false;
  bool _isActive2 = false;

  String _suspensionDuration = 'Choose duration';

  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _passwordController;
  late TextEditingController _homeAddressController;
  late TextEditingController _assignedvehicleController;

  FocusNode? _lastNameNode;
  FocusNode? _phoneNumberNode;
  FocusNode? _emailNode;
  FocusNode? _passwordNode;
  FocusNode? _homeAddressNode;
  FocusNode? _assignedvehicleNode;

  String? _lastName;
  String? _email;
  String? _phoneNumber;
  String? _password;
  String? _confirmPassword;
  String? _assignedvehicle;

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
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _passwordController = TextEditingController();
    _homeAddressController = TextEditingController();
    _assignedvehicleController = TextEditingController();
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
      _confirmPasswordIsValid = _homeAddressController.text != null &&
          _homeAddressController.text == _passwordController.text;
      print(_confirmPasswordIsValid);
    });
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
        var response = await Auth.authProvider(context).createUser(
            _firstName.toString(),
            _lastName.toString(),
            _email.toString(),
            _password.toString(),
            _phoneNumber.toString(),
            userType);
        setState(() {
          _loading = false;
        });
        if (response["code"] == 201) {
          form.reset();
          await Flushbar(
            messageText: Text(
              response["message"] + ' Please login',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: whiteColor,
                fontSize: 18,
              ),
            ),
            backgroundColor: green,
            flushbarPosition: FlushbarPosition.TOP,
            duration: const Duration(seconds: 2),
          ).show(context);
          Navigator.of(context).pushNamed(Login.id);
        }
        // Auth.authProvider(context)
      } catch (err) {
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
          flushbarPosition: FlushbarPosition.TOP,
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
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return SingleChildScrollView(
      
      child: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  height: 59,
                  width: 100,
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8),),
                  border: Border.all(style: BorderStyle.solid,color: grayColor),),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          (selectedProfileOptions == ProfileOptions.Edit)
                              ? MaterialStateProperty.all(appPrimaryColor)
                              : MaterialStateProperty.all(whiteColor),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedProfileOptions = ProfileOptions.Edit;
                        _selectedProfile = true;
                      });
                    },
                    child: Text(
                      "Edit",
                      style: TextStyle(
                          color: (selectedProfileOptions == ProfileOptions.Edit)
                              ? whiteColor
                              : appPrimaryColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10,),
              Expanded(
                child: Container(
                  height: 59,
                  width: 100,
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8),),
                  border: Border.all(style: BorderStyle.solid,color: grayColor),),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          (selectedProfileOptions == ProfileOptions.Suspend)
                              ? MaterialStateProperty.all(appPrimaryColor)
                              : MaterialStateProperty.all(whiteColor),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedProfileOptions = ProfileOptions.Suspend;
                      });
                    },
                    child: Text(
                      "Suspend",
                      style: TextStyle(
                          color: (selectedProfileOptions == ProfileOptions.Suspend)
                              ? whiteColor
                              : appPrimaryColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10,),
              Expanded(
                child: Container(
                  height: 59,
                  width: 100,
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8),),
                  border: Border.all(style: BorderStyle.solid,color: grayColor),),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          (selectedProfileOptions == ProfileOptions.Delete)
                              ? MaterialStateProperty.all(appPrimaryColor)
                              : MaterialStateProperty.all(whiteColor),
                    ),
                    onPressed: () => showDialog<String>(
                      // barrierDismissible: true,
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        // title: const Text('AlertDialog Title'),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15.0),
                        content: SizedBox(
                          height: 220.0,
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushNamed(CompanyHome.id);
                                    },
                                    child: const CancelButton())
                              ],
                            ),
                            Container(
                              width: 300,
                              child: const Text(
                                'You are about to delete Malik\nJohnson from the list of riders',
                                // maxLines: 2,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            Button(
                              text: 'Delete',
                              onPress: () => showDialog<String>(
                                // barrierDismissible: true,
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  // title: const Text('AlertDialog Title'),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 15.0),
                                  content: SizedBox(
                                    height: 220.0,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.of(context)
                                                    .pushNamed(CompanyHome.id);
                                              },
                                              child: const CancelButton(),
                                            )
                                          ],
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 30),
                                          child: const Center(
                                            child: Text(
                                              'You have succefully deleted Malik Johnson from the list of riders',
                                              // maxLines: 2,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              color: redColor,
                              textColor: whiteColor,
                              isLoading: false,
                              width: MediaQuery.of(context).size.width / 1.6,
                            ),
                            const SizedBox(height: 30.0),
                            Button(
                              text: 'Don\'t delete',
                              onPress: () {
                                Navigator.of(context).pop();
                              },
                              color: appPrimaryColor,
                              textColor: whiteColor,
                              isLoading: false,
                              width: MediaQuery.of(context).size.width / 1.6,
                            )
                          ]),
                        ),
                      ),
                    ),
                    child: Text(
                      "Delete",
                      style: TextStyle(
                          color: (selectedProfileOptions == ProfileOptions.Delete)
                              ? whiteColor
                              : appPrimaryColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
          getCustomContainer(),
        ],
      ),
    );
  }

  Widget getCustomContainer() {
    //var selectedOptions;
    switch (selectedProfileOptions) {
      case ProfileOptions.Edit:
        return editContainer();
      case ProfileOptions.Suspend:
        return suspendContainer();
      case ProfileOptions.Delete:
        return deleteContainer();
      case ProfileOptions.Null:
        // TODO: Handle this case.
        break;
    }
    return editContainer();
  }

  Widget editContainer() {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return _selectedProfile
        ? Column(
            //physics: NeverScrollableScrollPhysics(),
            //shrinkWrap: true,
            children: [

                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      InputField(
                        key: const Key('First name'),
                        textController: _firstNameController,
                        node: _firstNameNode,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: false,
                        text: 'First name',
                        hintText: 'First name',
                        textHeight: 10.0,
                        borderColor: appPrimaryColor.withOpacity(0.9),
                        // suffixIcon: const Icon(
                        //   Remix.user_line,
                        //   size: 18.0,
                        //   color: Color(0xFF909090),
                        // ),
                        validator: (value) {
                          if (value!.trim().length > 2) {
                            return null;
                          }
                          return "Enter a valid first name";
                        },
                        onSaved: (value) {
                          _firstName = value!.trim();
                          return null;
                        },
                      ),
                      const SizedBox(height: 30.0),
                      InputField(
                        key: const Key('Last name'),
                        textController: _lastNameController,
                        node: _lastNameNode,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: false,
                        text: 'Last name',
                        hintText: 'Last name',
                        textHeight: 10.0,
                        borderColor: appPrimaryColor.withOpacity(0.9),
                        // suffixIcon: const Icon(
                        //   Remix.user_line,
                        //   size: 18.0,
                        //   color: Color(0xFF909090),
                        // ),
                        validator: (value) {
                          if (value!.trim().length > 2) {
                            return null;
                          }
                          return "Enter a valid last name";
                        },
                        onSaved: (value) {
                          _firstName = value!.trim();
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
                        hintText: '+234-807-675-8970',
                        textHeight: 10.0,
                        borderColor: appPrimaryColor.withOpacity(0.9),
                        // suffixIcon: const Icon(
                        //   Remix.phone_line,
                        //   size: 18.0,
                        //   color: Color(0xFF909090),
                        // ),
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
                        key: const Key('Company\'s email address'),
                        textController: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        node: _emailNode,
                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: false,
                        text: 'Email Address',
                        hintText: 'malikjohn11@gmail.com',
                        textHeight: 10.0,
                        borderColor: appPrimaryColor.withOpacity(0.9),
                        // suffixIcon: const Icon(
                        //   Remix.mail_line,
                        //   size: 18.0,
                        //   color: Color(0xFF909090),
                        // ),
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
                        key: const Key('Home address'),
                        textController: _homeAddressController,
                        node: _homeAddressNode,
                        maxLines: 1,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: false,
                        text: 'Home address',
                        hintText: 'N0. Mcneil Street, Yaba',
                        textHeight: 10.0,
                        borderColor: appPrimaryColor.withOpacity(0.9),
                      ),
                      const SizedBox(height: 30.0),
                      InputField(
                        key: const Key('Assigned vehicle'),
                        textController: _assignedvehicleController,
                        node: _assignedvehicleNode,
                        maxLines: 1,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: false,
                        text: 'Assigned vehicle',
                        hintText: 'Yamaha 4567658',
                        textHeight: 10.0,
                        borderColor: appPrimaryColor.withOpacity(0.9),
                      ),
                      const SizedBox(height: 48.0),
                      Align(
                          alignment: Alignment.center,
                          child: Button(
                              text: 'Save',
                              //onPress:// _onSubmit,
                              onPress: () {
                                setState(() {
                                  _isActive = false;
                                });

                                //Navigator.of(context).pop();
                              },
                              color: appPrimaryColor,
                              textColor: whiteColor,
                              isLoading: _loading,
                              width: mediaQuery.size.width* 1)),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ])
        : Column(
            children: const [
              SizedBox(
                height: 20,
              ),
              Profillebox(
                title: 'First name',
                detail: 'Malik',
              ),
              Profillebox(
                title: 'Last name',
                detail: 'Johnson',
              ),
              Profillebox(
                title: 'Phone',
                detail: '0806-333-2255',
              ),
              Profillebox(
                title: 'Email address',
                detail: 'malikjohn11@gmail.com',
              ),
              Profillebox(
                title: 'Home address',
                detail: 'N0. Mcneil Street, Yaba',
              ),
              Profillebox(
                title: 'Assigned vehicle',
                detail: 'Yamaha 4567658',
              ),
            ],
          );
  }

  Widget suspendContainer() {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return SingleChildScrollView(
      // crossAxisAlignment: CrossAxisAlignment.start,
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 0.0),
            const Text(
              'Reason for suspension',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 20.0),
            Container(
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
                border: Border.all(color: Color(0xffEEEEEE)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 231, 229, 229).withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(2, 2), // changes position of shadow
                  ),
                ],
              ),
              child: const TextField(
                maxLines: 7,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: 14,
            ),
            const Text(
              'Choose suspension duration',
              textScaleFactor: 1.2,
              style: TextStyle(
                color: appPrimaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 5.0),
            DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                    color: appPrimaryColor.withOpacity(0.9),
                    width: 0.3), //border of dropdown button
                borderRadius: BorderRadius.circular(
                    5.0), //border raiuds of dropdown button
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: DropdownButton<String>(
                  value: _suspensionDuration,
                  icon: const Icon(Remix.arrow_down_s_line),
                  elevation: 16,
                  isExpanded: true,
                  style: TextStyle(
                    color: appPrimaryColor.withOpacity(0.8),
                    fontSize: 18.0,
                  ),
                  underline: Container(), //empty line
                  onChanged: (String? newValue) {
                    setState(() {
                      _suspensionDuration = newValue!;
                    });
                  },
                  items: duration.map((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 5.0),
            _isButtonPress && _suspensionDuration == "Choose duration"
                ? const Text(
                    " Choose suspention duration",
                    textScaleFactor: 0.9,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  )
                : Container(),
            const SizedBox(height: 35),
            Button(
                text: 'send',
                onPress: () => showDialog<String>(
                      // barrierDismissible: true,
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        // title: const Text('AlertDialog Title'),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15.0),
                        content: SizedBox(
                          height: 220.0,
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const CancelButton())
                              ],
                            ),
                            Container(
                              width: 300,
                              child: const Text(
                                'You are about to suspend Malik\nJohnson for the period of 1 month',
                                // maxLines: 2,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Button(
                              text: 'Suspend',
                              onPress: () => showDialog<String>(
                                // barrierDismissible: true,
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  // title: const Text('AlertDialog Title'),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 15.0),
                                  content: SizedBox(
                                      height: 220.0,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const CancelButton(),),
                                            ],
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20.0),
                                            child: const Center(
                                              child: Text(
                                                'You have succefully suspended Malik Johnson for 1 month',
                                                // maxLines: 2,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),),
                                ),
                              ),
                              color: redColor,
                              textColor: whiteColor,
                              isLoading: false,
                              width: MediaQuery.of(context).size.width / 1.6,
                            ),
                            const SizedBox(height: 30.0),
                            Button(
                              text: 'Don\'t suspend',
                              onPress: () {
                                Navigator.of(context).pop();
                              },
                              color: appPrimaryColor,
                              textColor: whiteColor,
                              isLoading: false,
                              width: MediaQuery.of(context).size.width / 1.6,
                            )
                          ]),
                        ),
                      ),
                    ),
                color: Colors.black,
                width: mediaQuery.size.width*1,
                textColor: Colors.white,
                isLoading: false),
          ],
        ),
      ),
    );
  }

  Widget deleteContainer() {
    return Container(
      color: Colors.black,
      height: 200,
    );
  }
}

class Profillebox extends StatelessWidget {
  final String title;
  final String detail;

  const Profillebox({
    Key? key,
    required this.title,
    required this.detail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            border: Border.all(color: grayColor),
          ),
          height: 56,
          width: 344,
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                detail,
                style: TextStyle(color: grayColor),
              )),
        ),
      ],
    );
  }
}

class Transfers extends StatefulWidget {
  static String id = "transfers";

  const Transfers({Key? key}) : super(key: key);

  @override
  State<Transfers> createState() => _Transfers();
}

class _Transfers extends State<Transfers> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
                padding:
                    const EdgeInsets.only(left: 0.0, right: 30, bottom: 17),
                child: 
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
                child: const Text(
                  'TRANSFERS',
                  style: TextStyle(
                      color: appPrimaryColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),),
            Expanded(
              child: SingleChildScrollView(
                //physics: NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                      child: TransferWidget(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_switch/flutter_switch.dart';
// import 'package:remixicon/remixicon.dart';
// import 'package:trakk/screens/wallet/qr_code_payment.dart';
// import 'package:trakk/screens/wallet/wallet.dart';
// import 'package:trakk/utils/colors.dart';
// import 'package:trakk/widgets/back_icon.dart';
// import 'package:trakk/widgets/button.dart';
// import 'package:trakk/widgets/cancel_button.dart';
// import 'package:trakk/widgets/input_field.dart';
// import 'package:pin_code_text_field/pin_code_text_field.dart';

// class Transfers extends StatefulWidget {
//   static const String id = "transfers";

//   const Transfers({Key? key}) : super(key: key);

//   @override
//   _TransfersState createState() => _TransfersState();
// }

// class _TransfersState extends State<Transfers> {
//   String? _nuban;

//   late TextEditingController _nubanController;
//   late TextEditingController _otpController;

//   FocusNode? _nubanNode;

//   @override
//   void initState() {
//     super.initState();
//     _nubanController = TextEditingController();
//   }

//   bool _isButtonPress = false;
//   bool _isToggled = false;

//   String _sourceWallets = 'Select Source Wallet';
//   String _wallets = 'Select Wallet';
//   String _banks = 'Select Bank';

//   var sourceWallets = [
//     "Select Source Wallet",
//     "Trakk wallet",
//     "Zebrra wallet",
//   ];

//   var wallets = [
//     "Select Wallet",
//     "Trakk wallet",
//     "Zebrra wallet",
//   ];
//   var banks = [
//     "Select Bank",
//     "Access Bank",
//     "First City Monument Bank (FCMB)",
//     "First Bank",
//     "Union Bank",
//     "Guarranty Trust Bank"
//   ];
//   @override
//   Widget build(BuildContext context) {
//     MediaQueryData mediaQuery = MediaQuery.of(context);
//     return Scaffold(
//         body: SafeArea(
//       child: Column(
//         children: [
//           Row(
//             children: [
//               BackIcon(
//                 onPress: () {
//                   Navigator.pop(context);
//                 },
//               ),
//               Container(
//                 margin: const EdgeInsets.only(left: 40.0),
//                 alignment: Alignment.center,
//                 child: const Text(
//                   'TRANSFERS',
//                   style: TextStyle(
//                       color: appPrimaryColor,
//                       fontSize: 20.0,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ],
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               physics: ScrollPhysics(),
//               child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                
//                 Container(
//                   margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
//                   padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15.0),
//                   height: 160,
//                   //  height: MediaQuery.of(context).size.height * 0.5/3,
//                   width: MediaQuery.of(context).size.width,
//                   decoration: const BoxDecoration(
//                     color: appPrimaryColor,
//                     borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Color(0XFFBDBDBD),
//                         offset: Offset(0.0, 1.0), //(x,y)
//                         blurRadius: 2.0,
//                       ),
//                     ],
//                   ),
//                   child:
//                       Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: const [
//                         Text(
//                           'Transfer limit',
//                           textScaleFactor: 1.1,
//                           style: TextStyle(
//                               color: Color(0xFFFFFFFF), fontWeight: FontWeight.w400),
//                         ),
//                         SizedBox(
//                           width: 40,
//                         ),
//                         Expanded(
//                           child: Text(
//                             '₦300,000.00',
//                             textScaleFactor: 1.9,
//                             style: TextStyle(
//                                 color: Color(0xFFFFFFFF),
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 10.0),
//                     Button(
//                         text: "Edit limit",
//                         onPress: () {},
//                         color: whiteColor,
//                         width: 104,
//                         textColor: appPrimaryColor,
//                         isLoading: false)
//                   ]),
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.only(left: 20),
//                   child: Text(
//                     "I want to transfer to",
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 DefaultTabController(
//                   length: 3,
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 20, right: 20),
//                           child: TabBar(
//                             labelStyle: const TextStyle(fontWeight: FontWeight.bold),
//                             //indicatorPadding: EdgeInsets.symmetric(horizontal: 10,),
//                             //indicatorColor: Colors.red,
//                             indicator: const BoxDecoration(
//                                 borderRadius: BorderRadius.all(
//                                   Radius.circular(8),
//                                 ),
//                                 color: Color(0xffCA9E0D)),
//                             //labelPadding: EdgeInsets.only(left: 20,right: 10),
//                             labelColor: appPrimaryColor,
//                             unselectedLabelColor: appPrimaryColor,
//                             unselectedLabelStyle: TextStyle(fontSize: 16),
          
//                             tabs: [
//                               Tab(
//                                 height: 100,
//                                 //text: 'Edit',
//                                 child: Container(
//                                     height: 100,
//                                     width: 200,
//                                     padding: EdgeInsets.only(top: 0, bottom: 10),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Align(
//                                           alignment: Alignment.topRight,
//                                           child: Image.asset(
//                                             "assets/images/zebrraLogo.png",
//                                             height: 46,
//                                           ),
//                                         ),
//                                         const Align(
//                                           alignment: Alignment.bottomLeft,
//                                           child: Text(
//                                             "Own\nZebrra wallet",
//                                             textScaleFactor: 0.7,
//                                             textAlign: TextAlign.start,
//                                             //style: TextStyle(fontSize: 12),
//                                           ),
//                                         ),
//                                       ],
//                                     )),
//                               ),
//                               Tab(
//                                 height: 100,
          
//                                 //text: 'Edit',
//                                 child: Container(
//                                     height: 100,
//                                     width: 200,
//                                     padding: EdgeInsets.only(top: 0, bottom: 10),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Align(
//                                           alignment: Alignment.topRight,
//                                           child: Image.asset(
//                                             "assets/images/zebrraLogo.png",
//                                             height: 46,
//                                           ),
//                                         ),
//                                         const Align(
//                                           alignment: Alignment.bottomLeft,
//                                           child: Text(
//                                             "Other\nZebrra wallets",
//                                             textScaleFactor: 0.7,
//                                             textAlign: TextAlign.start,
//                                             //style: TextStyle(fontSize: 12),
//                                           ),
//                                         ),
//                                       ],
//                                     )),
//                               ),
//                               Tab(
//                                 height: 100,
          
//                                 //text: 'Edit',
//                                 child: Container(
//                                     height: 100,
//                                     width: 200,
//                                     padding: EdgeInsets.symmetric(vertical: 10),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: const [
//                                         Align(
//                                           alignment: Alignment.topRight,
//                                           child: Icon(Remix.home_8_line),
//                                         ),
//                                         Align(
//                                           alignment: Alignment.bottomLeft,
//                                           child: Text(
//                                             "Other\nBanks",
//                                             textScaleFactor: 0.7,
//                                             textAlign: TextAlign.start,
//                                             //style: TextStyle(fontSize: 12),
//                                           ),
//                                         ),
//                                       ],
//                                     )),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 30,
//                       ),
//                       SizedBox(
//                         //width: double.maxFinite,
//                         height: mediaQuery.size.height * 1.4,
//                         child: TabBarView(children: [
//                           ListView(
//                               shrinkWrap: true,
//                               physics: const NeverScrollableScrollPhysics(),
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(
//                                     left: 20,
//                                     right: 20,
//                                   ),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       const SizedBox(
//                                         height: 15,
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Button(
//                                                 text: "Saved Beneficiary",
//                                                 onPress: () {},
//                                                 color: whiteColor,
//                                                 width: 160,
//                                                 textColor: appPrimaryColor,
//                                                 isLoading: false),
//                                           ),
//                                           const SizedBox(
//                                             width: 5,
//                                           ),
//                                           Expanded(
//                                             child: Button(
//                                                 text: "New Beneficiary",
//                                                 onPress: () {},
//                                                 color: appPrimaryColor,
//                                                 width: 160,
//                                                 textColor: whiteColor,
//                                                 isLoading: false),
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 20.0),
//                                       const Text("Select Source Wallet",
//                                           textScaleFactor: 1.2,
//                                           style: TextStyle(
//                                               color: grayColor,
//                                               //fontSize: 16,
//                                               fontWeight: FontWeight.w500)),
//                                       const SizedBox(height: 10.0),
//                                       DecoratedBox(
//                                           decoration: BoxDecoration(
//                                             color: whiteColor,
//                                             border: Border.all(
//                                                 color:
//                                                     appPrimaryColor.withOpacity(0.9),
//                                                 width:
//                                                     0.3), //border of dropdown button
//                                             borderRadius: BorderRadius.circular(
//                                                 5.0), //border raiuds of dropdown button
//                                           ),
//                                           child: Padding(
//                                             padding: const EdgeInsets.symmetric(
//                                                 horizontal: 10.0),
//                                             child: DropdownButton<String>(
//                                               value: _sourceWallets,
//                                               icon:
//                                                   const Icon(Remix.arrow_down_s_line),
//                                               elevation: 16,
//                                               isExpanded: true,
//                                               style: TextStyle(
//                                                 color:
//                                                     appPrimaryColor.withOpacity(0.8),
//                                                 fontSize: 18.0,
//                                               ),
//                                               underline: Container(), //empty line
//                                               onChanged: (String? newValue) {
//                                                 setState(() {
//                                                   _sourceWallets = newValue!;
//                                                 });
//                                               },
//                                               items:
//                                                   sourceWallets.map((String value) {
//                                                 return DropdownMenuItem(
//                                                   value: value,
//                                                   child: Text(value),
//                                                 );
//                                               }).toList(),
//                                             ),
//                                           )),
//                                       const SizedBox(height: 5.0),
//                                       _isButtonPress &&
//                                               _sourceWallets == "Select Wallet Source"
//                                           ? const Text(
//                                               "Choose Wallet Source",
//                                               textScaleFactor: 0.9,
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                 color: Colors.red,
//                                               ),
//                                             )
//                                           : Container(),
//                                       const SizedBox(height: 20.0),
//                                       const Text("Select Destination Wallet",
//                                           textScaleFactor: 1.2,
//                                           style: TextStyle(
//                                               color: grayColor,
//                                               //fontSize: 16,
//                                               fontWeight: FontWeight.w500)),
//                                       const SizedBox(height: 10.0),
//                                       DecoratedBox(
//                                           decoration: BoxDecoration(
//                                             color: whiteColor,
//                                             border: Border.all(
//                                                 color:
//                                                     appPrimaryColor.withOpacity(0.9),
//                                                 width:
//                                                     0.3), //border of dropdown button
//                                             borderRadius: BorderRadius.circular(
//                                                 5.0), //border raiuds of dropdown button
//                                           ),
//                                           child: Padding(
//                                             padding: const EdgeInsets.symmetric(
//                                                 horizontal: 10.0),
//                                             child: DropdownButton<String>(
//                                               value: _wallets,
//                                               icon:
//                                                   const Icon(Remix.arrow_down_s_line),
//                                               elevation: 16,
//                                               isExpanded: true,
//                                               style: TextStyle(
//                                                 color:
//                                                     appPrimaryColor.withOpacity(0.8),
//                                                 fontSize: 18.0,
//                                               ),
//                                               underline: Container(), //empty line
//                                               onChanged: (String? newValue) {
//                                                 setState(() {
//                                                   _wallets = newValue!;
//                                                 });
//                                               },
//                                               items: wallets.map((String value) {
//                                                 return DropdownMenuItem(
//                                                   value: value,
//                                                   child: Text(value),
//                                                 );
//                                               }).toList(),
//                                             ),
//                                           )),
//                                       const SizedBox(height: 5.0),
//                                       _isButtonPress && _wallets == "Select Wallet"
//                                           ? const Text(
//                                               " Choose Destination Wallet",
//                                               textScaleFactor: 0.9,
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                 color: Colors.red,
//                                               ),
//                                             )
//                                           : Container(),
//                                       const SizedBox(height: 20.0),
//                                       InputField(
//                                         key: const Key('nuban'),
//                                         textController: _nubanController,
//                                         keyboardType: TextInputType.phone,
//                                         node: _nubanNode,
//                                         autovalidateMode:
//                                             AutovalidateMode.onUserInteraction,
//                                         obscureText: false,
//                                         text: 'Enter Destination Nuban',
//                                         textColor: grayColor,
//                                         hintText: 'Wallet Nuban',
//                                         textHeight: 5.0,
//                                         borderColor: appPrimaryColor.withOpacity(0.9),
//                                         validator: (value) {
//                                           if (value!.trim().length == 16) {
//                                             return null;
//                                           }
//                                           return "Enter a valid nuban";
//                                         },
//                                         onSaved: (value) {
//                                           _nuban = value!.trim();
//                                           return null;
//                                         },
//                                       ),
//                                       const SizedBox(height: 25.0),
//                                       InputField(
//                                         key: const Key('wallet destination'),
//                                         //textController: _walletControler,
//                                         //node: _amountNode,
//                                         autovalidateMode:
//                                             AutovalidateMode.onUserInteraction,
//                                         obscureText: false,
//                                         text: 'Select Destination Wallet',
//                                         textColor: grayColor,
//                                         hintText: 'name',
//                                         textHeight: 10.0,
//                                         borderColor: appPrimaryColor.withOpacity(0.9),
//                                         // suffixIcon: const Icon(
//                                         //   Remix.user_line,
//                                         //   size: 18.0,
//                                         //   color: Color(0xFF909090),
//                                         // ),
//                                         // validator: (value) {
//                                         //   if (value!.trim().length > 2) {
//                                         //     return null;
//                                         //   }
//                                         //   return "Enter a valid last  name";
//                                         // },
//                                         onSaved: (value) {
//                                           //_wallet = value!.trim();
//                                           return null;
//                                         },
//                                       ),
//                                       SizedBox(
//                                         height: 20,
//                                       ),
//                                       InputField(
//                                         key: const Key('amount'),
//                                         //textController: _amountController,
//                                         keyboardType: TextInputType.phone,
//                                         //node: _amountNode,
//                                         autovalidateMode:
//                                             AutovalidateMode.onUserInteraction,
//                                         obscureText: false,
//                                         text: 'Amount',
//                                         textColor: grayColor,
//                                         hintText: '₦00.00',
//                                         textHeight: 10.0,
//                                         borderColor: appPrimaryColor.withOpacity(0.9),
          
//                                         // validator: (value) {
//                                         //   if (value!.trim().length == 11) {
//                                         //     return null;
//                                         //   }
//                                         //   return "Enter a valid phone number";
//                                         // },
//                                         onSaved: (value) {
//                                           // _amount = value!.trim();
//                                           return null;
//                                         },
//                                       ),
//                                       const SizedBox(height: 25.0),
//                                       InputField(
//                                         key: const Key('transactionDescription'),
//                                         //textController: _walletControler,
//                                         //node: _amountNode,
//                                         //autovalidateMode: AutovalidateMode.onUserInteraction,
//                                         obscureText: false,
//                                         text: 'Transaction Description',
//                                         textColor: grayColor,
//                                         hintText: 'Why am i transferring',
//                                         textHeight: 10.0,
//                                         borderColor: appPrimaryColor.withOpacity(0.9),
//                                         // suffixIcon: const Icon(
//                                         //   Remix.user_line,
//                                         //   size: 18.0,
//                                         //   color: Color(0xFF909090),
//                                         // ),
//                                         // validator: (value) {
//                                         //   if (value!.trim().length > 2) {
//                                         //     return null;
//                                         //   }
//                                         //   return "Enter a valid last  name";
//                                         // },
//                                         onSaved: (value) {
//                                           //_wallet = value!.trim();
//                                           return null;
//                                         },
//                                       ),
//                                       const SizedBox(
//                                         height: 20,
//                                       ),
//                                       const Text(
//                                         "Save as Beneficiary",
//                                         textScaleFactor: 1.2,
//                                         style: TextStyle(
//                                             color: grayColor,
//                                             //fontSize: 16,
//                                             fontWeight: FontWeight.w500),
//                                       ),
//                                       const SizedBox(
//                                         height: 5,
//                                       ),
//                                       Container(
//                                         padding: EdgeInsets.symmetric(horizontal: 15),
//                                         height: 56,
//                                         width: 300,
//                                         decoration: BoxDecoration(
//                                           border: Border.all(color: grayColor),
//                                           color: whiteColor,
//                                           borderRadius:
//                                               BorderRadius.all(Radius.circular(4)),
//                                         ),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text(_isToggled ? "Saved" : "Save"),
//                                             FlutterSwitch(
//                                               height: 20.0,
//                                               width: 40.0,
//                                               padding: 4.0,
//                                               toggleSize: 15.0,
//                                               borderRadius: 10.0,
//                                               inactiveColor: whiteColor,
//                                               activeColor: whiteColor,
//                                               activeSwitchBorder: Border.all(
//                                                   color: secondaryColor,
//                                                   style: BorderStyle.solid),
//                                               activeToggleBorder:
//                                                   Border.all(color: secondaryColor),
//                                               activeToggleColor: secondaryColor,
//                                               inactiveToggleBorder:
//                                                   Border.all(color: appPrimaryColor),
//                                               inactiveToggleColor: appPrimaryColor,
//                                               inactiveSwitchBorder:
//                                                   Border.all(color: appPrimaryColor),
//                                               value: _isToggled,
//                                               onToggle: (value) {
//                                                 print("VALUE : $value");
//                                                 setState(() {
//                                                   _isToggled = value;
//                                                 });
//                                               },
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                         height: 20,
//                                       ),
//                                       const SizedBox(
//                                         height: 40,
//                                       ),
//                                       Button(
//                                           text: "Continue",
//                                           onPress: () => showDialog<String>(
//                                                 // barrierDismissible: true,
//                                                 context: context,
//                                                 builder: (BuildContext context) =>
//                                                     AlertDialog(
//                                                   contentPadding:
//                                                       const EdgeInsets.symmetric(
//                                                           horizontal: 15,
//                                                           vertical: 20),
//                                                   content: SizedBox(
//                                                     height: 400.0,
//                                                     width: 350,
//                                                     child: Column(children: [
//                                                       const Text(
//                                                         'Review and Confirm Transaction',
//                                                         //textAlign: Alignment.center,
//                                                         style: TextStyle(
//                                                             fontSize: 16,
//                                                             fontWeight:
//                                                                 FontWeight.bold),
//                                                       ),
//                                                       const SizedBox(
//                                                         height: 10,
//                                                       ),
//                                                       // Image.asset(
//                                                       //     "assets/images/confirmPayment.png"),
//                                                       SizedBox(
//                                                         height: 10,
//                                                       ),
//                                                       //Text(
//                                                       //  "You are about to Fund your Wallet 00556 with  ₦5000 from your Zebrra Wallet with Nuban 00556"),
//                                                       RichText(
//                                                         textAlign: TextAlign.start,
//                                                         text: const TextSpan(
//                                                           text:
//                                                               "You are about to transfer",
//                                                           style: TextStyle(
//                                                               color: Colors.black),
//                                                           children: <TextSpan>[
//                                                             TextSpan(
//                                                               text: "\" ₦2000\" ",
//                                                               style: TextStyle(
//                                                                 color: secondaryColor,
//                                                                 fontWeight:
//                                                                     FontWeight.bold,
//                                                               ),
//                                                               //recognizer: _longPressRecognizer,
//                                                             ),
//                                                             TextSpan(
//                                                                 text: "from your "),
//                                                             TextSpan(
//                                                               text:
//                                                                   "\" Trakk Wallet\" ",
//                                                               style: TextStyle(
//                                                                 color: secondaryColor,
//                                                                 fontWeight:
//                                                                     FontWeight.bold,
//                                                               ),
//                                                               //recognizer: _longPressRecognizer,
//                                                             ),
//                                                             TextSpan(
//                                                                 text:
//                                                                     " to Malik Johnson with the account number"),
//                                                             TextSpan(
//                                                               text: "\" 002122658\" ",
//                                                               style: TextStyle(
//                                                                 color: secondaryColor,
//                                                                 fontWeight:
//                                                                     FontWeight.bold,
//                                                               ),
//                                                               //recognizer: _longPressRecognizer,
//                                                             ),
          
//                                                             //recognizer: _longPressRecognizer,
//                                                           ],
//                                                         ),
//                                                       ),
//                                                       SizedBox(
//                                                         height: 20,
//                                                       ),
//                                                       const SizedBox(
//                                                         width: 300,
//                                                         child: Text(
//                                                           "If the above statement is correct, enter your 4-digit pin to continue",
//                                                           // maxLines: 2,
//                                                           style: TextStyle(
//                                                             fontSize: 12,
//                                                             fontWeight:
//                                                                 FontWeight.w500,
//                                                           ),
//                                                           textAlign: TextAlign.center,
//                                                         ),
//                                                       ),
                                                      
//                                                       const SizedBox(height: 30,),
//                                                       Text("Enter 4-digit PIN",
//                                                       textScaleFactor: 1.1,
//                                                        style: TextStyle(
//                                                          fontWeight: FontWeight.w600
//                                                       ),),
//                                                       const SizedBox(height: 10,),
//                                                       PinCodeTextField(
//                                                         pinBoxHeight: 50.0,
//                                                         pinBoxWidth: 50,
//                                                         autofocus: false,
//                                                         //controller: controller,
//                                                         hideCharacter: false,
//                                                         highlight: true,
//                                                         pinBoxColor: Colors.white,
//                                                         keyboardType:
//                                                             TextInputType.number,
//                                                         highlightColor:
//                                                             Colors.black45,
//                                                         defaultBorderColor: grayColor,
//                                                         pinTextStyle: const TextStyle(
//                                                             fontSize: 22.0),
//                                                         //defaultBorderColor: kGreyDark,
//                                                         hasTextBorderColor:
//                                                             Colors.orange,
//                                                         pinBoxRadius: 2,
//                                                         maxLength: 4,
          
//                                                         onTextChanged:
//                                                             (String value) {
//                                                           // input value status
//                                                           print(value);
//                                                         },
//                                                         onDone: (text) {
//                                                           print('done with ' + text);
//                                                           // call function from controller to confirm OTP here
//                                                           // _otpController.verifyOTP(text);
//                                                         },
//                                                       ),
                                                      
//                                                       const SizedBox(height: 30,),
                                                      
                                                     
//                                                       Row(
//                                                         children: [
//                                                           Expanded(
//                                                             child: Button(
//                                                               text: 'Continue',
//                                                               onPress: () =>
//                                                                  showDialog<
//                                                                     String>(
//                                                                 context: context,
//                                                                 builder: (BuildContext
//                                                                         context) =>
//                                                                     AlertDialog(
//                                                                       content:
//                                                                           SizedBox(
//                                                                         height:
//                                                                             mediaQuery
//                                                                                 .size
//                                                                                 .height,
//                                                                         //width: mediaQuery.size.width,
//                                                                         child: Column(
//                                                                           // crossAxisAlignment:
//                                                                           //     CrossAxisAlignment
//                                                                           //         .start,
//                                                                           children: [
//                                                                             Row(
//                                                                               crossAxisAlignment:
//                                                                                   CrossAxisAlignment.end,
//                                                                               mainAxisAlignment:
//                                                                                   MainAxisAlignment.end,
//                                                                               children: [
//                                                                                 CancelButton(),
//                                                                               ],
//                                                                             ),
//                                                                             Align(
//                                                                               alignment:
//                                                                                   Alignment.center,
//                                                                               child:
//                                                                                   Column(
//                                                                                 children: [
//                                                                                   Image.asset(
//                                                                                     "assets/images/confirmPayment.png",
//                                                                                     height: 40,
//                                                                                     width: 40,
//                                                                                   ),
//                                                                                   Text("Transaction Successful",
//                                                                                       textScaleFactor: 1,
//                                                                                       style: TextStyle(color: deepGreen, fontWeight: FontWeight.w600)),
//                                                                                 ],
//                                                                               ),
//                                                                             ),
//                                                                             const SizedBox(
//                                                                               height:
//                                                                                   10,
//                                                                             ),
//                                                                             Button(
//                                                                                 text:
//                                                                                     "Transaction Receipt",
//                                                                                 onPress:
//                                                                                     () {},
//                                                                                 color:
//                                                                                     appPrimaryColor,
//                                                                                 width:
//                                                                                     300,
//                                                                                 textColor:
//                                                                                     whiteColor,
//                                                                                 isLoading:
//                                                                                     false),
//                                                                             const SizedBox(
//                                                                               height:
//                                                                                   10,
//                                                                             ),
//                                                                             const ReceiptContainer(
//                                                                               transactionDate:
//                                                                                   '12/06/2022',
//                                                                               transactionType:
//                                                                                   'Local Transfer',
//                                                                               sender:
//                                                                                   'Malik Johnson',
//                                                                               beneficiary:
//                                                                                   'Ijeoma Uduma',
//                                                                               beneficiaryBank:
//                                                                                   'Union Bank',
//                                                                               beneficiaryAccount:
//                                                                                   '00213456787',
//                                                                               amount:
//                                                                                   '₦2000.00',
//                                                                             ),
//                                                                             Container(
//                                                                               padding:
//                                                                                   EdgeInsets.symmetric(horizontal: 10),
//                                                                               margin: EdgeInsets.only(
//                                                                                   top:
//                                                                                       15,
//                                                                                   bottom:
//                                                                                       20),
//                                                                               height:
//                                                                                   80,
//                                                                               width: mediaQuery.size.width *
//                                                                                   0.8,
//                                                                               decoration: BoxDecoration(
//                                                                                   borderRadius: BorderRadius.all(
//                                                                                     Radius.circular(4),
//                                                                                   ),
//                                                                                   border: Border.all(),
//                                                                                   color: appPrimaryColor),
//                                                                               child:
//                                                                                   Column(
//                                                                                 crossAxisAlignment:
//                                                                                     CrossAxisAlignment.center,
//                                                                                 mainAxisAlignment:
//                                                                                     MainAxisAlignment.center,
//                                                                                 children: [
//                                                                                   RichText(
//                                                                                     textAlign: TextAlign.start,
//                                                                                     text: const TextSpan(
//                                                                                       text: "For any complaint or assistance\ncontact our",
//                                                                                       style: TextStyle(color: whiteColor, fontSize: 12),
//                                                                                       children: <TextSpan>[
//                                                                                         TextSpan(
//                                                                                           text: "\" customer support\" ",
//                                                                                           style: TextStyle(
//                                                                                             fontSize: 12,
//                                                                                             color: secondaryColor,
//                                                                                             fontWeight: FontWeight.bold,
//                                                                                           ),
//                                                                                           //recognizer: _longPressRecognizer,
//                                                                                         ),
          
//                                                                                         //recognizer: _longPressRecognizer,
//                                                                                       ],
//                                                                                     ),
//                                                                                   ),
//                                                                                 ],
//                                                                               ),
//                                                                             ),
//                                                                             Row(
//                                                                               children: [
//                                                                                 Expanded(
//                                                                                   child: Button(
//                                                                                       text: "Download",
//                                                                                       onPress: () => showDialog<String>(
//                                                                                             context: context,
//                                                                                             builder: (BuildContext context) => AlertDialog(
//                                                                                               content: SizedBox(
//                                                                                                 height: mediaQuery.size.height * 0.4,
//                                                                                                 child: Column(
//                                                                                                   children: [
//                                                                                                     Row(
//                                                                                                       crossAxisAlignment: CrossAxisAlignment.end,
//                                                                                                       mainAxisAlignment: MainAxisAlignment.end,
//                                                                                                       children: [
//                                                                                                         CancelButton(),
//                                                                                                       ],
//                                                                                                     ),
//                                                                                                     Align(
//                                                                                                       alignment: Alignment.center,
//                                                                                                       child: Column(
//                                                                                                         children: [
//                                                                                                           Image.asset(
//                                                                                                             "assets/images/confirmPayment.png",
//                                                                                                             height: 40,
//                                                                                                             width: 40,
//                                                                                                           ),
//                                                                                                           const SizedBox(
//                                                                                                             height: 10,
//                                                                                                           ),
//                                                                                                           Text("Receipt saved", textScaleFactor: 1, style: TextStyle(color: deepGreen, fontWeight: FontWeight.w600)),
//                                                                                                           const SizedBox(
//                                                                                                             height: 30,
//                                                                                                           ),
//                                                                                                           Button(text: "Back to wallet", onPress: () {}, color: appPrimaryColor, width: 121, textColor: whiteColor, isLoading: false),
//                                                                                                         ],
//                                                                                                       ),
//                                                                                                     ),
//                                                                                                     const SizedBox(
//                                                                                                       height: 10,
//                                                                                                     ),
//                                                                                                   ],
//                                                                                                 ),
//                                                                                               ),
//                                                                                             ),
//                                                                                           ),
//                                                                                       color: appPrimaryColor,
//                                                                                       width: 120,
//                                                                                       textColor: whiteColor,
//                                                                                       isLoading: false),
//                                                                                 ),
//                                                                                 const SizedBox(
//                                                                                   width:
//                                                                                       15,
//                                                                                 ),
//                                                                                 Expanded(
//                                                                                   child: Button(
//                                                                                       text: "Share",
//                                                                                       onPress: () {},
//                                                                                       color: whiteColor,
//                                                                                       width: 120,
//                                                                                       textColor: appPrimaryColor,
//                                                                                       isLoading: false),
//                                                                                 ),
//                                                                               ],
//                                                                             ),
//                                                                           ],
//                                                                         ),
//                                                                       ),
//                                                                     )),
                                                              
//                                                               color: appPrimaryColor,
//                                                               textColor: whiteColor,
//                                                               isLoading: false,
//                                                               width: 121,
//                                                             ),
//                                                           ),
//                                                           const SizedBox(
//                                                             width: 20,
//                                                           ),
//                                                           Expanded(
//                                                             child: Button(
//                                                                 text: "Cancel",
//                                                                 onPress: () {},
//                                                                 color: whiteColor,
//                                                                 width: 121,
//                                                                 textColor:
//                                                                     appPrimaryColor,
//                                                                 isLoading: false),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ]),
//                                                   ),
//                                                 ),
//                                               ),
//                                           color: appPrimaryColor,
//                                           width: 338,
//                                           textColor: whiteColor,
//                                           isLoading: false),
//                                     ],
//                                   ),
//                                 ),
//                               ]),
//                           ListView(physics: ScrollPhysics(), children: [
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                 left: 20,
//                                 right: 20,
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const SizedBox(
//                                     height: 15,
//                                   ),
//                                   Row(
//                                     children: [
//                                       Expanded(
//                                         child: Button(
//                                             text: "Saved Beneficiary",
//                                             onPress: () {},
//                                             color: whiteColor,
//                                             width: 160,
//                                             textColor: appPrimaryColor,
//                                             isLoading: false),
//                                       ),
//                                       const SizedBox(
//                                         width: 5,
//                                       ),
//                                       Expanded(
//                                         child: Button(
//                                             text: "New Beneficiary",
//                                             onPress: () {},
//                                             color: appPrimaryColor,
//                                             width: 160,
//                                             textColor: whiteColor,
//                                             isLoading: false),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 20.0),
//                                   const Text("Select Source Wallet",
//                                       textScaleFactor: 1.2,
//                                       style: TextStyle(
//                                           color: grayColor,
//                                           //fontSize: 16,
//                                           fontWeight: FontWeight.w500)),
//                                   const SizedBox(height: 10.0),
//                                   DecoratedBox(
//                                       decoration: BoxDecoration(
//                                         color: whiteColor,
//                                         border: Border.all(
//                                             color: appPrimaryColor.withOpacity(0.9),
//                                             width: 0.3), //border of dropdown button
//                                         borderRadius: BorderRadius.circular(
//                                             5.0), //border raiuds of dropdown button
//                                       ),
//                                       child: Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 10.0),
//                                         child: DropdownButton<String>(
//                                           value: _sourceWallets,
//                                           icon: const Icon(Remix.arrow_down_s_line),
//                                           elevation: 16,
//                                           isExpanded: true,
//                                           style: TextStyle(
//                                             color: appPrimaryColor.withOpacity(0.8),
//                                             fontSize: 18.0,
//                                           ),
//                                           underline: Container(), //empty line
//                                           onChanged: (String? newValue) {
//                                             setState(() {
//                                               _sourceWallets = newValue!;
//                                             });
//                                           },
//                                           items: sourceWallets.map((String value) {
//                                             return DropdownMenuItem(
//                                               value: value,
//                                               child: Text(value),
//                                             );
//                                           }).toList(),
//                                         ),
//                                       )),
//                                   const SizedBox(height: 5.0),
//                                   _isButtonPress &&
//                                           _sourceWallets == "Select Wallet Source"
//                                       ? const Text(
//                                           "Choose Wallet Source",
//                                           textScaleFactor: 0.9,
//                                           textAlign: TextAlign.center,
//                                           style: TextStyle(
//                                             color: Colors.red,
//                                           ),
//                                         )
//                                       : Container(),
//                                   const SizedBox(height: 20.0),
//                                   const Text("Select Destination Wallet",
//                                       textScaleFactor: 1.2,
//                                       style: TextStyle(
//                                           color: grayColor,
//                                           //fontSize: 16,
//                                           fontWeight: FontWeight.w500)),
//                                   const SizedBox(height: 10.0),
//                                   DecoratedBox(
//                                       decoration: BoxDecoration(
//                                         color: whiteColor,
//                                         border: Border.all(
//                                             color: appPrimaryColor.withOpacity(0.9),
//                                             width: 0.3), //border of dropdown button
//                                         borderRadius: BorderRadius.circular(
//                                             5.0), //border raiuds of dropdown button
//                                       ),
//                                       child: Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 10.0),
//                                         child: DropdownButton<String>(
//                                           value: _wallets,
//                                           icon: const Icon(Remix.arrow_down_s_line),
//                                           elevation: 16,
//                                           isExpanded: true,
//                                           style: TextStyle(
//                                             color: appPrimaryColor.withOpacity(0.8),
//                                             fontSize: 18.0,
//                                           ),
//                                           underline: Container(), //empty line
//                                           onChanged: (String? newValue) {
//                                             setState(() {
//                                               _wallets = newValue!;
//                                             });
//                                           },
//                                           items: wallets.map((String value) {
//                                             return DropdownMenuItem(
//                                               value: value,
//                                               child: Text(value),
//                                             );
//                                           }).toList(),
//                                         ),
//                                       )),
//                                   const SizedBox(height: 5.0),
//                                   _isButtonPress && _wallets == "Select Wallet"
//                                       ? const Text(
//                                           " Choose Destination Wallet",
//                                           textScaleFactor: 0.9,
//                                           textAlign: TextAlign.center,
//                                           style: TextStyle(
//                                             color: Colors.red,
//                                           ),
//                                         )
//                                       : Container(),
//                                   const SizedBox(height: 20.0),
//                                   InputField(
//                                     key: const Key('nuban'),
//                                     textController: _nubanController,
//                                     keyboardType: TextInputType.phone,
//                                     node: _nubanNode,
//                                     autovalidateMode:
//                                         AutovalidateMode.onUserInteraction,
//                                     obscureText: false,
//                                     text: 'Enter Destination Nuban',
//                                     textColor: grayColor,
//                                     hintText: 'Wallet Nuban',
//                                     textHeight: 5.0,
//                                     borderColor: appPrimaryColor.withOpacity(0.9),
//                                     validator: (value) {
//                                       if (value!.trim().length == 16) {
//                                         return null;
//                                       }
//                                       return "Enter a valid nuban";
//                                     },
//                                     onSaved: (value) {
//                                       _nuban = value!.trim();
//                                       return null;
//                                     },
//                                   ),
//                                   const SizedBox(height: 25.0),
//                                   InputField(
//                                     key: const Key('wallet destination'),
//                                     //textController: _walletControler,
//                                     //node: _amountNode,
//                                     autovalidateMode:
//                                         AutovalidateMode.onUserInteraction,
//                                     obscureText: false,
//                                     text: ' Wallet Name',
//                                     textColor: grayColor,
//                                     hintText: 'name',
//                                     textHeight: 10.0,
//                                     borderColor: appPrimaryColor.withOpacity(0.9),
//                                     // suffixIcon: const Icon(
//                                     //   Remix.user_line,
//                                     //   size: 18.0,
//                                     //   color: Color(0xFF909090),
//                                     // ),
//                                     // validator: (value) {
//                                     //   if (value!.trim().length > 2) {
//                                     //     return null;
//                                     //   }
//                                     //   return "Enter a valid last  name";
//                                     // },
//                                     onSaved: (value) {
//                                       //_wallet = value!.trim();
//                                       return null;
//                                     },
//                                   ),
//                                   SizedBox(
//                                     height: 20,
//                                   ),
//                                   InputField(
//                                     key: const Key('amount'),
//                                     //textController: _amountController,
//                                     keyboardType: TextInputType.phone,
//                                     //node: _amountNode,
//                                     autovalidateMode:
//                                         AutovalidateMode.onUserInteraction,
//                                     obscureText: false,
//                                     text: 'Amount',
//                                     textColor: grayColor,
//                                     hintText: '₦00.00',
//                                     textHeight: 10.0,
//                                     borderColor: appPrimaryColor.withOpacity(0.9),
          
//                                     // validator: (value) {
//                                     //   if (value!.trim().length == 11) {
//                                     //     return null;
//                                     //   }
//                                     //   return "Enter a valid phone number";
//                                     // },
//                                     onSaved: (value) {
//                                       // _amount = value!.trim();
//                                       return null;
//                                     },
//                                   ),
//                                   const SizedBox(height: 25.0),
//                                   InputField(
//                                     key: const Key('transactionDescription'),
//                                     //textController: _walletControler,
//                                     //node: _amountNode,
//                                     //autovalidateMode: AutovalidateMode.onUserInteraction,
//                                     obscureText: false,
//                                     text: 'Transaction Description',
//                                     textColor: grayColor,
//                                     hintText: 'Why am i transferring',
//                                     textHeight: 10.0,
//                                     borderColor: appPrimaryColor.withOpacity(0.9),
//                                     // suffixIcon: const Icon(
//                                     //   Remix.user_line,
//                                     //   size: 18.0,
//                                     //   color: Color(0xFF909090),
//                                     // ),
//                                     // validator: (value) {
//                                     //   if (value!.trim().length > 2) {
//                                     //     return null;
//                                     //   }
//                                     //   return "Enter a valid last  name";
//                                     // },
//                                     onSaved: (value) {
//                                       //_wallet = value!.trim();
//                                       return null;
//                                     },
//                                   ),
//                                   const SizedBox(
//                                     height: 20,
//                                   ),
//                                   const Text(
//                                     "Save as Beneficiary",
//                                     textScaleFactor: 1.2,
//                                     style: TextStyle(
//                                         color: grayColor,
//                                         //fontSize: 16,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                   const SizedBox(
//                                     height: 5,
//                                   ),
//                                   Container(
//                                     padding: EdgeInsets.symmetric(horizontal: 15),
//                                     height: 56,
//                                     width: 300,
//                                     decoration: BoxDecoration(
//                                       border: Border.all(color: grayColor),
//                                       color: whiteColor,
//                                       borderRadius:
//                                           BorderRadius.all(Radius.circular(4)),
//                                     ),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(_isToggled ? "Saved" : "Save"),
//                                         FlutterSwitch(
//                                           height: 20.0,
//                                           width: 40.0,
//                                           padding: 4.0,
//                                           toggleSize: 15.0,
//                                           borderRadius: 10.0,
//                                           inactiveColor: whiteColor,
//                                           activeColor: whiteColor,
//                                           activeSwitchBorder: Border.all(
//                                               color: secondaryColor,
//                                               style: BorderStyle.solid),
//                                           activeToggleBorder:
//                                               Border.all(color: secondaryColor),
//                                           activeToggleColor: secondaryColor,
//                                           inactiveToggleBorder:
//                                               Border.all(color: appPrimaryColor),
//                                           inactiveToggleColor: appPrimaryColor,
//                                           inactiveSwitchBorder:
//                                               Border.all(color: appPrimaryColor),
//                                           value: _isToggled,
//                                           onToggle: (value) {
//                                             print("VALUE : $value");
//                                             setState(() {
//                                               _isToggled = value;
//                                             });
//                                           },
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     height: 20,
//                                   ),
//                                   const SizedBox(
//                                     height: 40,
//                                   ),
//                                   Button(
//                                       text: "Continue",
//                                       onPress: () => showDialog<String>(
//                                             // barrierDismissible: true,
//                                             context: context,
//                                             builder: (BuildContext context) =>
//                                                 AlertDialog(
//                                               contentPadding:
//                                                   const EdgeInsets.symmetric(
//                                                       horizontal: 15, vertical: 20),
//                                               content: SizedBox(
//                                                 height: 400.0,
//                                                 width: 350,
//                                                 child: Column(children: [
//                                                   const Text(
//                                                     'Review and Confirm Transaction',
//                                                     //textAlign: Alignment.center,
//                                                     style: TextStyle(
//                                                         fontSize: 16,
//                                                         fontWeight: FontWeight.bold),
//                                                   ),
//                                                   const SizedBox(
//                                                     height: 10,
//                                                   ),
//                                                   // Image.asset(
//                                                   //     "assets/images/confirmPayment.png"),
//                                                   SizedBox(
//                                                     height: 10,
//                                                   ),
//                                                   //Text(
//                                                   //  "You are about to Fund your Wallet 00556 with  ₦5000 from your Zebrra Wallet with Nuban 00556"),
//                                                   RichText(
//                                                     textAlign: TextAlign.start,
//                                                     text: const TextSpan(
//                                                       text:
//                                                           "You are about to transfer",
//                                                       style: TextStyle(
//                                                           color: Colors.black),
//                                                       children: <TextSpan>[
//                                                         TextSpan(
//                                                           text: "\" ₦2000\" ",
//                                                           style: TextStyle(
//                                                             color: secondaryColor,
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                           ),
//                                                           //recognizer: _longPressRecognizer,
//                                                         ),
//                                                         TextSpan(text: "from your "),
//                                                         TextSpan(
//                                                           text: "\" Trakk Wallet\" ",
//                                                           style: TextStyle(
//                                                             color: secondaryColor,
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                           ),
//                                                           //recognizer: _longPressRecognizer,
//                                                         ),
//                                                         TextSpan(
//                                                             text:
//                                                                 " to Malik Johnson with the account number"),
//                                                         TextSpan(
//                                                           text: "\" 002122658\" ",
//                                                           style: TextStyle(
//                                                             color: secondaryColor,
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                           ),
//                                                           //recognizer: _longPressRecognizer,
//                                                         ),
          
//                                                         //recognizer: _longPressRecognizer,
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   SizedBox(
//                                                     height: 20,
//                                                   ),
//                                                   const SizedBox(
//                                                     width: 300,
//                                                     child: Text(
//                                                       "If the above statement is correct, enter your 4-digit pin to continue",
//                                                       // maxLines: 2,
//                                                       style: TextStyle(
//                                                         fontSize: 12,
//                                                         fontWeight: FontWeight.w500,
//                                                       ),
//                                                       textAlign: TextAlign.center,
//                                                     ),
//                                                   ),
          
//                                                   const SizedBox(
//                                                     height: 30,
//                                                   ),
//                                                   Text(
//                                                     "Enter 4-digit PIN",
//                                                     textScaleFactor: 1.1,
//                                                     style: TextStyle(
//                                                         fontWeight: FontWeight.w600),
//                                                   ),
//                                                   const SizedBox(
//                                                     height: 10,
//                                                   ),
//                                                   PinCodeTextField(
//                                                     pinBoxHeight: 50.0,
//                                                     pinBoxWidth: 50,
//                                                     autofocus: false,
//                                                     //controller: controller,
//                                                     hideCharacter: false,
//                                                     highlight: true,
//                                                     pinBoxColor: Colors.white,
//                                                     keyboardType:
//                                                         TextInputType.number,
//                                                     highlightColor: Colors.black45,
//                                                     defaultBorderColor: grayColor,
//                                                     pinTextStyle: const TextStyle(
//                                                         fontSize: 22.0),
//                                                     //defaultBorderColor: kGreyDark,
//                                                     hasTextBorderColor: Colors.orange,
//                                                     pinBoxRadius: 2,
//                                                     maxLength: 4,
          
//                                                     onTextChanged: (String value) {
//                                                       // input value status
//                                                       print(value);
//                                                     },
//                                                     onDone: (text) {
//                                                       print('done with ' + text);
//                                                       // call function from controller to confirm OTP here
//                                                       // _otpController.verifyOTP(text);
//                                                     },
//                                                   ),
          
//                                                   const SizedBox(
//                                                     height: 30,
//                                                   ),
          
//                                                   Row(
//                                                     children: [
//                                                       Expanded(
//                                                         child: Button(
//                                                           text: 'Continue',
//                                                           onPress: () {
//                                                             Navigator.of(context)
//                                                                 .pushNamed(
//                                                                     WalletScreen.id);
//                                                           },
//                                                           color: appPrimaryColor,
//                                                           textColor: whiteColor,
//                                                           isLoading: false,
//                                                           width: 121,
//                                                         ),
//                                                       ),
//                                                       const SizedBox(
//                                                         width: 20,
//                                                       ),
//                                                       Expanded(
//                                                         child: Button(
//                                                             text: "Cancel",
//                                                             onPress: () {},
//                                                             color: whiteColor,
//                                                             width: 121,
//                                                             textColor:
//                                                                 appPrimaryColor,
//                                                             isLoading: false),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ]),
//                                               ),
//                                             ),
//                                           ),
//                                       color: appPrimaryColor,
//                                       width: 338,
//                                       textColor: whiteColor,
//                                       isLoading: false),
//                                 ],
//                               ),
//                             ),
          
//                             //Divider()
//                           ]),
//                           ListView(
//                             physics: ScrollPhysics(),
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                   left: 20,
//                                   right: 20,
//                                 ),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const SizedBox(
//                                       height: 15,
//                                     ),
//                                     Row(
//                                       children: [
//                                         Expanded(
//                                           child: Button(
//                                               text: "Saved Beneficiary",
//                                               onPress: () {},
//                                               color: whiteColor,
//                                               width: 160,
//                                               textColor: appPrimaryColor,
//                                               isLoading: false),
//                                         ),
//                                         const SizedBox(
//                                           width: 5,
//                                         ),
//                                         Expanded(
//                                           child: Button(
//                                               text: "New Beneficiary",
//                                               onPress: () {},
//                                               color: appPrimaryColor,
//                                               width: 160,
//                                               textColor: whiteColor,
//                                               isLoading: false),
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(height: 20.0),
//                                     const Text("Select Source Wallet",
//                                         textScaleFactor: 1.2,
//                                         style: TextStyle(
//                                             color: grayColor,
//                                             //fontSize: 16,
//                                             fontWeight: FontWeight.w500)),
//                                     const SizedBox(height: 10.0),
//                                     DecoratedBox(
//                                         decoration: BoxDecoration(
//                                           color: whiteColor,
//                                           border: Border.all(
//                                               color: appPrimaryColor.withOpacity(0.9),
//                                               width: 0.3), //border of dropdown button
//                                           borderRadius: BorderRadius.circular(
//                                               5.0), //border raiuds of dropdown button
//                                         ),
//                                         child: Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 10.0),
//                                           child: DropdownButton<String>(
//                                             value: _sourceWallets,
//                                             icon: const Icon(Remix.arrow_down_s_line),
//                                             elevation: 16,
//                                             isExpanded: true,
//                                             style: TextStyle(
//                                               color: appPrimaryColor.withOpacity(0.8),
//                                               fontSize: 18.0,
//                                             ),
//                                             underline: Container(), //empty line
//                                             onChanged: (String? newValue) {
//                                               setState(() {
//                                                 _sourceWallets = newValue!;
//                                               });
//                                             },
//                                             items: sourceWallets.map((String value) {
//                                               return DropdownMenuItem(
//                                                 value: value,
//                                                 child: Text(value),
//                                               );
//                                             }).toList(),
//                                           ),
//                                         )),
//                                     const SizedBox(height: 5.0),
//                                     _isButtonPress &&
//                                             _sourceWallets == "Select Wallet Source"
//                                         ? const Text(
//                                             "Choose Wallet Source",
//                                             textScaleFactor: 0.9,
//                                             textAlign: TextAlign.center,
//                                             style: TextStyle(
//                                               color: Colors.red,
//                                             ),
//                                           )
//                                         : Container(),
//                                     const SizedBox(height: 20.0),
//                                     const Text("Select Destination Bank",
//                                         textScaleFactor: 1.2,
//                                         style: TextStyle(
//                                             color: grayColor,
//                                             //fontSize: 16,
//                                             fontWeight: FontWeight.w500)),
//                                     const SizedBox(height: 10.0),
//                                     DecoratedBox(
//                                         decoration: BoxDecoration(
//                                           color: whiteColor,
//                                           border: Border.all(
//                                               color: appPrimaryColor.withOpacity(0.9),
//                                               width: 0.3), //border of dropdown button
//                                           borderRadius: BorderRadius.circular(
//                                               5.0), //border raiuds of dropdown button
//                                         ),
//                                         child: Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 10.0),
//                                           child: DropdownButton<String>(
//                                             value: _banks,
//                                             icon: const Icon(Remix.arrow_down_s_line),
//                                             elevation: 16,
//                                             isExpanded: true,
//                                             style: TextStyle(
//                                               color: appPrimaryColor.withOpacity(0.8),
//                                               fontSize: 18.0,
//                                             ),
//                                             underline: Container(), //empty line
//                                             onChanged: (String? newValue) {
//                                               setState(() {
//                                                 _banks = newValue!;
//                                               });
//                                             },
//                                             items: banks.map((String value) {
//                                               return DropdownMenuItem(
//                                                 value: value,
//                                                 child: Text(value),
//                                               );
//                                             }).toList(),
//                                           ),
//                                         )),
//                                     const SizedBox(height: 5.0),
//                                     _isButtonPress && _banks == "Select Bank"
//                                         ? const Text(
//                                             " Choose Destination Account",
//                                             textScaleFactor: 0.9,
//                                             textAlign: TextAlign.center,
//                                             style: TextStyle(
//                                               color: Colors.red,
//                                             ),
//                                           )
//                                         : Container(),
//                                     const SizedBox(height: 20.0),
//                                     InputField(
//                                       key: const Key('destinationAccount'),
//                                       textController: _nubanController,
//                                       keyboardType: TextInputType.phone,
//                                       node: _nubanNode,
//                                       autovalidateMode:
//                                           AutovalidateMode.onUserInteraction,
//                                       obscureText: false,
//                                       text: 'Enter Destination Account',
//                                       textColor: grayColor,
//                                       hintText: 'Account Number',
//                                       textHeight: 5.0,
//                                       borderColor: appPrimaryColor.withOpacity(0.9),
//                                       validator: (value) {
//                                         if (value!.trim().length == 16) {
//                                           return null;
//                                         }
//                                         return "Enter a accounnt number";
//                                       },
//                                       onSaved: (value) {
//                                         _nuban = value!.trim();
//                                         return null;
//                                       },
//                                     ),
//                                     const SizedBox(height: 25.0),
//                                     InputField(
//                                       key: const Key('Account destination'),
//                                       //textController: _walletControler,
//                                       //node: _amountNode,
//                                       autovalidateMode:
//                                           AutovalidateMode.onUserInteraction,
//                                       obscureText: false,
//                                       text: 'Account Name',
//                                       textColor: grayColor,
//                                       hintText: 'john doe',
//                                       textHeight: 10.0,
//                                       borderColor: appPrimaryColor.withOpacity(0.9),
//                                       // suffixIcon: const Icon(
//                                       //   Remix.user_line,
//                                       //   size: 18.0,
//                                       //   color: Color(0xFF909090),
//                                       // ),
//                                       // validator: (value) {
//                                       //   if (value!.trim().length > 2) {
//                                       //     return null;
//                                       //   }
//                                       //   return "Enter a valid last  name";
//                                       // },
//                                       onSaved: (value) {
//                                         //_wallet = value!.trim();
//                                         return null;
//                                       },
//                                     ),
//                                     SizedBox(
//                                       height: 20,
//                                     ),
//                                     InputField(
//                                       key: const Key('amount'),
//                                       //textController: _amountController,
//                                       keyboardType: TextInputType.phone,
//                                       //node: _amountNode,
//                                       autovalidateMode:
//                                           AutovalidateMode.onUserInteraction,
//                                       obscureText: false,
//                                       text: 'Amount',
//                                       textColor: grayColor,
//                                       hintText: '₦00.00',
//                                       textHeight: 10.0,
//                                       borderColor: appPrimaryColor.withOpacity(0.9),
          
//                                       // validator: (value) {
//                                       //   if (value!.trim().length == 11) {
//                                       //     return null;
//                                       //   }
//                                       //   return "Enter a valid phone number";
//                                       // },
//                                       onSaved: (value) {
//                                         // _amount = value!.trim();
//                                         return null;
//                                       },
//                                     ),
//                                     const SizedBox(height: 25.0),
//                                     InputField(
//                                       key: const Key('transactionDescription'),
//                                       //textController: _walletControler,
//                                       //node: _amountNode,
//                                       //autovalidateMode: AutovalidateMode.onUserInteraction,
//                                       obscureText: false,
//                                       text: 'Transaction Description',
//                                       textColor: grayColor,
//                                       hintText: 'Why am i transferring',
//                                       textHeight: 10.0,
//                                       borderColor: appPrimaryColor.withOpacity(0.9),
//                                       // suffixIcon: const Icon(
//                                       //   Remix.user_line,
//                                       //   size: 18.0,
//                                       //   color: Color(0xFF909090),
//                                       // ),
//                                       // validator: (value) {
//                                       //   if (value!.trim().length > 2) {
//                                       //     return null;
//                                       //   }
//                                       //   return "Enter a valid last  name";
//                                       // },
//                                       onSaved: (value) {
//                                         //_wallet = value!.trim();
//                                         return null;
//                                       },
//                                     ),
//                                     const SizedBox(
//                                       height: 20,
//                                     ),
//                                     const Text(
//                                       "Save as Beneficiary",
//                                       textScaleFactor: 1.2,
//                                       style: TextStyle(
//                                           color: grayColor,
//                                           //fontSize: 16,
//                                           fontWeight: FontWeight.w500),
//                                     ),
//                                     const SizedBox(
//                                       height: 5,
//                                     ),
//                                     Container(
//                                       padding: EdgeInsets.symmetric(horizontal: 15),
//                                       height: 56,
//                                       width: 300,
//                                       decoration: BoxDecoration(
//                                         border: Border.all(color: grayColor),
//                                         color: whiteColor,
//                                         borderRadius:
//                                             BorderRadius.all(Radius.circular(4)),
//                                       ),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(_isToggled ? "Saved" : "Save"),
//                                           FlutterSwitch(
//                                             height: 20.0,
//                                             width: 40.0,
//                                             padding: 4.0,
//                                             toggleSize: 15.0,
//                                             borderRadius: 10.0,
//                                             inactiveColor: whiteColor,
//                                             activeColor: whiteColor,
//                                             activeSwitchBorder: Border.all(
//                                                 color: secondaryColor,
//                                                 style: BorderStyle.solid),
//                                             activeToggleBorder:
//                                                 Border.all(color: secondaryColor),
//                                             activeToggleColor: secondaryColor,
//                                             inactiveToggleBorder:
//                                                 Border.all(color: appPrimaryColor),
//                                             inactiveToggleColor: appPrimaryColor,
//                                             inactiveSwitchBorder:
//                                                 Border.all(color: appPrimaryColor),
//                                             value: _isToggled,
//                                             onToggle: (value) {
//                                               print("VALUE : $value");
//                                               setState(() {
//                                                 _isToggled = value;
//                                               });
//                                             },
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       height: 20,
//                                     ),
//                                     const SizedBox(
//                                       height: 40,
//                                     ),
//                                     Button(
//                                         text: "Continue",
//                                         onPress: () => showDialog<String>(
//                                               // barrierDismissible: true,
//                                               context: context,
//                                               builder: (BuildContext context) =>
//                                                   AlertDialog(
//                                                 contentPadding:
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 15, vertical: 20),
//                                                 content: SizedBox(
//                                                   height: 400.0,
//                                                   width: 350,
//                                                   child: Column(children: [
//                                                     const Text(
//                                                       'Review and Confirm Transaction',
//                                                       //textAlign: Alignment.center,
//                                                       style: TextStyle(
//                                                           fontSize: 16,
//                                                           fontWeight:
//                                                               FontWeight.bold),
//                                                     ),
//                                                     const SizedBox(
//                                                       height: 10,
//                                                     ),
//                                                     // Image.asset(
//                                                     //     "assets/images/confirmPayment.png"),
//                                                     const SizedBox(
//                                                       height: 10,
//                                                     ),
//                                                     //Text(
//                                                     //  "You are about to Fund your Wallet 00556 with  ₦5000 from your Zebrra Wallet with Nuban 00556"),
//                                                     RichText(
//                                                       textAlign: TextAlign.start,
//                                                       text: const TextSpan(
//                                                         text:
//                                                             "You are about to transfer",
//                                                         style: TextStyle(
//                                                             color: Colors.black),
//                                                         children: <TextSpan>[
//                                                           TextSpan(
//                                                             text: "\" ₦2000\" ",
//                                                             style: TextStyle(
//                                                               color: secondaryColor,
//                                                               fontWeight:
//                                                                   FontWeight.bold,
//                                                             ),
//                                                             //recognizer: _longPressRecognizer,
//                                                           ),
//                                                           TextSpan(
//                                                               text: "from your "),
//                                                           TextSpan(
//                                                             text:
//                                                                 "\" Trakk Wallet\" ",
//                                                             style: TextStyle(
//                                                               color: secondaryColor,
//                                                               fontWeight:
//                                                                   FontWeight.bold,
//                                                             ),
//                                                             //recognizer: _longPressRecognizer,
//                                                           ),
//                                                           TextSpan(
//                                                               text:
//                                                                   " to Malik Johnson with the account number"),
//                                                           TextSpan(
//                                                             text: "\" 002122658\" ",
//                                                             style: TextStyle(
//                                                               color: secondaryColor,
//                                                               fontWeight:
//                                                                   FontWeight.bold,
//                                                             ),
//                                                             //recognizer: _longPressRecognizer,
//                                                           ),
          
//                                                           //recognizer: _longPressRecognizer,
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     SizedBox(
//                                                       height: 20,
//                                                     ),
//                                                     const SizedBox(
//                                                       width: 300,
//                                                       child: Text(
//                                                         "If the above statement is correct, enter your 4-digit pin to continue",
//                                                         // maxLines: 2,
//                                                         style: TextStyle(
//                                                           fontSize: 12,
//                                                           fontWeight: FontWeight.w500,
//                                                         ),
//                                                         textAlign: TextAlign.center,
//                                                       ),
//                                                     ),
          
//                                                     const SizedBox(
//                                                       height: 30,
//                                                     ),
//                                                     Text(
//                                                       "Enter 4-digit PIN",
//                                                       textScaleFactor: 1.1,
//                                                       style: TextStyle(
//                                                           fontWeight:
//                                                               FontWeight.w600),
//                                                     ),
//                                                     const SizedBox(
//                                                       height: 10,
//                                                     ),
//                                                     PinCodeTextField(
//                                                       pinBoxHeight: 50.0,
//                                                       pinBoxWidth: 50,
//                                                       autofocus: false,
//                                                       //controller: controller,
//                                                       hideCharacter: false,
//                                                       highlight: true,
//                                                       pinBoxColor: Colors.white,
//                                                       keyboardType:
//                                                           TextInputType.number,
//                                                       highlightColor: Colors.black45,
//                                                       defaultBorderColor: grayColor,
//                                                       pinTextStyle: const TextStyle(
//                                                           fontSize: 22.0),
//                                                       //defaultBorderColor: kGreyDark,
//                                                       hasTextBorderColor:
//                                                           Colors.orange,
//                                                       pinBoxRadius: 2,
//                                                       maxLength: 4,
          
//                                                       onTextChanged: (String value) {
//                                                         // input value status
//                                                         print(value);
//                                                       },
//                                                       onDone: (text) {
//                                                         print('done with ' + text);
//                                                         // call function from controller to confirm OTP here
//                                                         // _otpController.verifyOTP(text);
//                                                       },
//                                                     ),
          
//                                                     const SizedBox(
//                                                       height: 30,
//                                                     ),
          
//                                                     Row(
//                                                       children: [
//                                                         Expanded(
//                                                           child: Button(
//                                                             text: 'Continue',
//                                                             onPress: () {
//                                                               Navigator.of(context)
//                                                                   .pushNamed(
//                                                                       WalletScreen
//                                                                           .id);
//                                                             },
//                                                             color: appPrimaryColor,
//                                                             textColor: whiteColor,
//                                                             isLoading: false,
//                                                             width: 121,
//                                                           ),
//                                                         ),
//                                                         const SizedBox(
//                                                           width: 20,
//                                                         ),
//                                                         Expanded(
//                                                           child: Button(
//                                                               text: "Cancel",
//                                                               onPress: () {},
//                                                               color: whiteColor,
//                                                               width: 121,
//                                                               textColor:
//                                                                   appPrimaryColor,
//                                                               isLoading: false),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ]),
//                                                 ),
//                                               ),
//                                             ),
//                                         color: appPrimaryColor,
//                                         width: 338,
//                                         textColor: whiteColor,
//                                         isLoading: false),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ]),
//                       ),
//                     ],
//                   ),
//                 ),
//               ]),
//             ),
//           ),
//         ],
//       ),
//     ));
//   }
// }

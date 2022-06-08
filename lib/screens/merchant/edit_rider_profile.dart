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

class ProfileIdget extends StatefulWidget {
  const ProfileIdget({Key? key}) : super(key: key);

  @override
  State<ProfileIdget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileIdget> {
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

  void _handleTap() {
    setState(() {
      _isActive = !_isActive;
      // _isActive1 = !_isActive1;
      // _isActive2 = !_isActive2;
    });
  }

  String _suspensionDuration = 'Choose duration';

  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _assignedvehicleController;

  FocusNode? _lastNameNode;
  FocusNode? _phoneNumberNode;
  FocusNode? _emailNode;
  FocusNode? _passwordNode;
  FocusNode? _confirmPasswordNode;
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
    _confirmPasswordController = TextEditingController();
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
      _confirmPasswordIsValid = _confirmPasswordController.text != null &&
          _confirmPasswordController.text == _passwordController.text;
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
    return SingleChildScrollView(
      child: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
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
                Container(
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
                Container(
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
              ],
            ),
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
                      SizedBox(
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
                          return "Enter a valid first  name";
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
                        node: _firstNameNode,
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
                          return "Enter a valid last  name";
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
                        textController: _confirmPasswordController,
                        node: _confirmPasswordNode,
                        maxLines: 1,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: _hidePassword,
                        text: 'Home address',
                        hintText: 'N0. Mcneil Street, Yaba',
                        textHeight: 10.0,
                        borderColor: appPrimaryColor.withOpacity(0.9),
                      ),
                      const SizedBox(height: 30.0),
                      InputField(
                        key: const Key('Assigned vehicle'),
                        textController: _confirmPasswordController,
                        node: _confirmPasswordNode,
                        maxLines: 1,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: _hidePassword,
                        text: 'Assigned vehicle',
                        hintText: 'Yamaha 4567658',
                        textHeight: 10.0,
                        borderColor: appPrimaryColor.withOpacity(0.9),
                      ),
                      const SizedBox(height: 10.0),
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
                              width: 350.0)),
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
              profillebox(
                title: 'First name',
                detail: 'Malik',
              ),
              profillebox(
                title: 'Last name',
                detail: 'Johnson',
              ),
              profillebox(
                title: 'Phone',
                detail: '0806-333-2255',
              ),
              profillebox(
                title: 'Email address',
                detail: 'malikjohn11@gmail.com',
              ),
              profillebox(
                title: 'Home address',
                detail: 'N0. Mcneil Street, Yaba',
              ),
              profillebox(
                title: 'Assigned vehicle',
                detail: 'Yamaha 4567658',
              ),
            ],
          );
  }

  Widget suspendContainer() {
    return SingleChildScrollView(
      // crossAxisAlignment: CrossAxisAlignment.start,
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 0.0),
            const Text(
              'What issue do you have with ride?',
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
                width: 300,
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

class profillebox extends StatelessWidget {
  final String title;
  final String detail;

  const profillebox({
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

class EditRiderProfile extends StatefulWidget {
  static String id = "mriderprofile";

  const EditRiderProfile({Key? key}) : super(key: key);

  @override
  State<EditRiderProfile> createState() => _EditRiderProfile();
}

class _EditRiderProfile extends State<EditRiderProfile> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          //physics: NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 0.0, right: 30, bottom: 17),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BackIcon(
                      onPress: () {
                        Navigator.pop(context);
                      },
                    ),
                    //Text('data'),
                    SizedBox(

                      width: mediaQuery.size.width * 0.15,

                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                top: 30,
                                bottom: 12,
                              ),
                              height: 80,
                              width: 80,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(

                                          'assets/images/malik.png'),),),

                            ),
                            const Text(
                              'Malik Johnson',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 25),

                child: ProfileIdget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
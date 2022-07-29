import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/src/bloc/app_settings_bloc.dart';
import 'package:trakk/src/models/app_settings.dart';
import 'package:trakk/src/models/auth_response.dart';
import 'package:trakk/src/screens/merchant/company_home.dart';
import 'package:trakk/src/values/enums.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/widgets/back_icon.dart';
import 'package:trakk/src/widgets/button.dart';
import 'package:trakk/src/widgets/cancel_button.dart';
import 'package:trakk/src/widgets/input_field.dart';

class MerchantRiderProfile extends StatefulWidget {
  static String id = "mriderprofile";

  const MerchantRiderProfile({Key? key}) : super(key: key);

  @override
  State<MerchantRiderProfile> createState() => _MerchantRiderProfile();
}

class _MerchantRiderProfile extends State<MerchantRiderProfile> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 0.0, right: 30, bottom: 17, top: 20),
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
                    width: mediaQuery.size.width / 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              top: 30,
                              bottom: 0,
                            ),
                            height: 80,
                            width: 80,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/malik.png'))),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                //physics: NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                      child: ProfileIdget(),
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

class ProfileIdget extends StatefulWidget {
  const ProfileIdget({Key? key}) : super(key: key);

  @override
  State<ProfileIdget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileIdget> {
  RiderProfileOptions selectedProfileOptions = RiderProfileOptions.Edit;

  final _formKey = GlobalKey<FormState>();

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

  late TextEditingController _firstNameController;
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

  bool _loading = false;
  bool _passwordIsValid = false;
  bool _confirmPasswordIsValid = false;
  bool _hidePassword = true;
  bool _autoValidate = false;
  bool _emailIsValid = false;

  @override
  void initState() {
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _passwordController = TextEditingController();
    _homeAddressController = TextEditingController();
    _assignedvehicleController = TextEditingController();
    super.initState();
  }

  Map<String, dynamic>? responseKey;

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

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return StreamBuilder<AppSettings>(
        stream: appSettingsBloc.appSettings,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "${snapshot.data?.loginResponse?.data?.user?.firstName ?? ""} "
                    "${snapshot.data?.loginResponse?.data?.user?.lastName ?? ""} ",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 59,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          border: Border.all(color: grayColor),
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: (selectedProfileOptions ==
                                    RiderProfileOptions.Edit)
                                ? MaterialStateProperty.all(appPrimaryColor)
                                : MaterialStateProperty.all(whiteColor),
                          ),
                          onPressed: () {
                            setState(() {
                              selectedProfileOptions = RiderProfileOptions.Edit;
                              _selectedProfile = true;
                            });
                          },
                          child: Text(
                            "Edit",
                            style: TextStyle(
                                color: (selectedProfileOptions ==
                                        RiderProfileOptions.Edit)
                                    ? whiteColor
                                    : appPrimaryColor),
                          ),
                        ),
                      ),
                      Container(
                        height: 59,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          border: Border.all(color: grayColor),
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: (selectedProfileOptions ==
                                    RiderProfileOptions.Suspend)
                                ? MaterialStateProperty.all(appPrimaryColor)
                                : MaterialStateProperty.all(whiteColor),
                          ),
                          onPressed: () {
                            setState(() {
                              selectedProfileOptions =
                                  RiderProfileOptions.Suspend;
                            });
                          },
                          child: Text(
                            "Suspend",
                            style: TextStyle(
                                color: (selectedProfileOptions ==
                                        RiderProfileOptions.Suspend)
                                    ? whiteColor
                                    : appPrimaryColor),
                          ),
                        ),
                      ),
                      Container(
                        height: 59,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          border: Border.all(color: grayColor),
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: (selectedProfileOptions ==
                                    RiderProfileOptions.Delete)
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
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        // title: const Text('AlertDialog Title'),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                                vertical: 15.0),
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
                                                      Navigator.of(context)
                                                          .pushNamed(
                                                              CompanyHome.id);
                                                    },
                                                    child: const CancelButton(),
                                                  )
                                                ],
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 30),
                                                child: const Center(
                                                  child: Text(
                                                    'You have succefully deleted Malik Johnson from the list of riders',
                                                    // maxLines: 2,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    color: redColor,
                                    textColor: whiteColor,
                                    isLoading: false,
                                    width:
                                        MediaQuery.of(context).size.width / 1.6,
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
                                    width:
                                        MediaQuery.of(context).size.width / 1.6,
                                  )
                                ]),
                              ),
                            ),
                          ),
                          child: Text(
                            "Delete",
                            style: TextStyle(
                                color: (selectedProfileOptions ==
                                        RiderProfileOptions.Delete)
                                    ? whiteColor
                                    : appPrimaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                  getCustomContainer(snapshot.data!.loginResponse!.data!.user!),
                ],
              ),
            );
          }
          return SizedBox();
        });
  }

  Widget getCustomContainer(User user) {
    //var selectedOptions;
    switch (selectedProfileOptions) {
      case RiderProfileOptions.Edit:
        return editContainer(user);
      case RiderProfileOptions.Suspend:
        return suspendContainer();
      case RiderProfileOptions.Delete:
        return deleteContainer();
      case RiderProfileOptions.Null:
        // TODO: Handle this case.
        break;
    }
    return editContainer(user);
  }

  Widget editContainer(User user) {
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
                              width: mediaQuery.size.width * 1)),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ])
        : Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Profillebox(
                title: 'First name',
                detail: user.firstName ?? "",
              ),
              Profillebox(
                title: 'Last name',
                detail: user.lastName ?? "",
              ),
              Profillebox(
                title: 'Phone',
                detail: user.phoneNumber ?? "",
              ),
              Profillebox(
                title: 'Email address',
                detail: user.email ?? "",
              ),
              Profillebox(
                title: 'Home address',
                detail: user.address ?? "",
              ),
              Profillebox(
                title: 'Assigned vehicle',
                detail: "${user.rider?.id ?? ""} " "${user.rider?.phone ?? ""}",
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
                  underline: Container(),
                  //empty line
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
                                              child: const CancelButton(),
                                            ),
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
                width: mediaQuery.size.width * 1,
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

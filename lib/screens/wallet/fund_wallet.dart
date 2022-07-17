import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/screens/wallet/wallet.dart';
import 'package:trakk/utils/assets.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/back_icon.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/widgets/cancel_button.dart';
import 'package:trakk/widgets/custom_input_field.dart';

enum ProfileOptions {
  ZebrraWallet,
  DebitCard,

  Null,
}

class FundWalletWidget extends StatefulWidget {
  const FundWalletWidget({Key? key}) : super(key: key);

  @override
  State<FundWalletWidget> createState() => _FundWalletWidetState();
}

class _FundWalletWidetState extends State<FundWalletWidget> {
  ProfileOptions selectedProfileOptions = ProfileOptions.ZebrraWallet;

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
  late TextEditingController _walletControler;
  late TextEditingController _amountController;
  late TextEditingController _cardNumberController;

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

  String _wallets = 'Select wallet';
  int geee = 2;
  String _cards = "XXXX-XXXX-2356";

  List<Map> cards = [
    {
      "id": 0,
      "cardNumber": "XXXX-XXXX-2356",
      "image": "assets/images/master_card.svg",
    },
    {
      "id": 1,
      "cardNumber": "XXXX-XXXX-0863",
      "image": "assets/images/visaCard.svg",
    },
    {
      "id": 2,
      "cardNumber": "XXXX-XXXX-7552",
      "image": "assets/images/verve_card.svg",
    },
    // {
    //   "id": 3,
    // "cardNumber": "Add new card",
    // "image": "assets/images/verve_card.svg",
    // },
    // {
    //   "id": 4,
    // "cardNumber":  "Add new card",
    //  "image": "assets/images/mastercard_Logo.svg",
    // },
  ];

  var wallets = [
    "Select wallet",
    "Trakk wallet",
    "Zebrra wallet",
  ];

  String? _wallet;
  String? _amount;
  String? _cardNumber;

  FocusNode? _walletNode;
  FocusNode? _amountNode;

  @override
  void initState() {
    super.initState();
    _walletControler = TextEditingController();
    _amountController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _amountController = TextEditingController();
    _walletControler = TextEditingController();
    _phoneNumberController = TextEditingController();
    _emailController = TextEditingController();
    _homeAddressController = TextEditingController();
    _assignedvehicleController = TextEditingController();
    _cardNumberController = TextEditingController();
    // _kinAddressController = TextEditingController();
    // _kinPhoneNumberController = TextEditingController();
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
                  height: 160,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                    border: Border.all(
                        style: BorderStyle.solid, color: secondaryColor),
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: (selectedProfileOptions ==
                              ProfileOptions.ZebrraWallet)
                          ? MaterialStateProperty.all(secondaryColor)
                          : MaterialStateProperty.all(whiteColor),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedProfileOptions = ProfileOptions.ZebrraWallet;
                        _selectedProfile = true;
                      });
                    },
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Image.asset(
                            "assets/images/logo.png",
                            height: 46,
                          ),
                        ),
                        Text(
                          "Top up from\nZebrra wallet",
                          textScaleFactor: (selectedProfileOptions ==
                                  ProfileOptions.ZebrraWallet)
                              ? 1.5
                              : 0.9,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: appPrimaryColor,
                          ),
                        ),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Image.asset("assets/images/logo.png")),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Container(
                  height: 160,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                    border: Border.all(
                        style: BorderStyle.solid, color: secondaryColor),
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          (selectedProfileOptions == ProfileOptions.DebitCard)
                              ? MaterialStateProperty.all(secondaryColor)
                              : MaterialStateProperty.all(whiteColor),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedProfileOptions = ProfileOptions.DebitCard;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Image.asset(
                              "assets/images/mastercard.png",
                              height: 46,
                            ),
                          ),
                          Text(
                            "Top up with\nyour card",
                            textScaleFactor: (selectedProfileOptions ==
                                    ProfileOptions.DebitCard)
                                ? 1.5
                                : 0.9,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: appPrimaryColor),
                          ),
                          Image.asset("assets/images/PP.png"),
                        ],
                      ),
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
      case ProfileOptions.ZebrraWallet:
        return ZebrraWalletContainer();
      case ProfileOptions.DebitCard:
        return DebitCardContainer();
      case ProfileOptions.Null:
        // TODO: Handle this case.
        break;
    }
    return ZebrraWalletContainer();
  }

  Widget ZebrraWalletContainer() {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Column(
        //physics: NeverScrollableScrollPhysics(),
        //shrinkWrap: true,
        children: [
          Container(
            decoration: const BoxDecoration(
              //color: Color.fromARGB(0, 202, 138, 41),
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 199, 190, 152),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color.fromARGB(255, 235, 227, 195),
                        Color.fromARGB(255, 163, 153, 107),
                      ],
                    )),
                height: 556,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 15,
                    bottom: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Choose your card",
                          textScaleFactor: 1.2,
                          style: TextStyle(
                              //fontSize: 16,
                              fontWeight: FontWeight.w500)),
                      SizedBox(
                        height: 15,
                      ),
                      DecoratedBox(
                          decoration: BoxDecoration(
                            color: whiteColor,
                            border: Border.all(
                                color: appPrimaryColor.withOpacity(0.9),
                                width: 0.3), //border of dropdown button
                            borderRadius: BorderRadius.circular(
                                5.0), //border raiuds of dropdown button
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: DropdownButton<String>(
                              value: _wallets,
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
                                  _wallets = newValue!;
                                });
                              },
                              items: wallets.map((String value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          )),
                      const SizedBox(height: 20.0),
                      const Text(
                        "Wallet to be funded",
                        textScaleFactor: 1.2,
                        style: TextStyle(
                            //fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      // const SizedBox(height: 10.0),
                      CustomInputField(
                          key: const Key('Trakk wallet'),
                          textController: _walletControler,
                          node: _amountNode,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          hintText: 'Trakk wallet',
                          text: "",
                          textHeight: 10.0,
                          borderColor: appPrimaryColor.withOpacity(0.9),
                          onSaved: (value) {
                            _wallet = value!.trim();
                            return null;
                          },
                          obscureText: false),

                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Amount",
                          textScaleFactor: 1.2,
                          style: TextStyle(
                              //fontSize: 16,
                              fontWeight: FontWeight.w500)),
                      CustomInputField(
                        key: const Key('amount'),
                        textController: _amountController,
                        keyboardType: TextInputType.phone,
                        node: _amountNode,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: false,
                        text: '',
                        hintText: '₦00.00',
                        textHeight: 10.0,
                        borderColor: appPrimaryColor.withOpacity(0.9),

                        // validator: (value) {
                        //   if (value!.trim().length == 11) {
                        //     return null;
                        //   }
                        //   return "Enter a valid phone number";
                        // },
                        onSaved: (value) {
                          _amount = value!.trim();
                          return null;
                        },
                      ),

                      SizedBox(
                        height: 40,
                      ),
                      Button(
                          text: "Top Up",
                          onPress: () => showDialog<String>(
                              // barrierDismissible: true,
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    content: SizedBox(
                                      height: 250.0,
                                      child: Column(children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: const [CancelButton()]),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Image.asset(
                                            Assets.check_success_outline),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: 300,
                                          child: const Text(
                                            "You have successfully funded your Trakk wallet with ₦5000",
                                            // maxLines: 2,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 14,
                                        ),
                                        const SizedBox(height: 10.0),
                                        Button(
                                          text: 'Back to wallet',
                                          onPress: () {
                                            Navigator.of(context)
                                                .pushNamed(WalletScreen.id);
                                          },
                                          color: appPrimaryColor,
                                          textColor: whiteColor,
                                          isLoading: false,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.3,
                                        ),
                                      ]),
                                    ),
                                  )),
                          color: appPrimaryColor,
                          width: mediaQuery.size.width * 0.9,
                          textColor: whiteColor,
                          isLoading: false),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]);
  }

  Widget DebitCardContainer() {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return SingleChildScrollView(
      // crossAxisAlignment: CrossAxisAlignment.start,
      child: Container(
        height: mediaQuery.size.height,
        decoration: const BoxDecoration(
          //color: Color.fromARGB(0, 202, 138, 41),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(255, 163, 153, 107),
                Color.fromARGB(255, 248, 244, 209),
              ],
            )),
            height: 556,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 15,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Choose your card",
                      textScaleFactor: 1.2,
                      style: TextStyle(
                          //fontSize: 16,
                          fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: 15,
                  ),
                  DecoratedBox(
                      decoration: BoxDecoration(
                        color: whiteColor,
                        border: Border.all(
                            color: appPrimaryColor.withOpacity(0.9),
                            width: 0.3), //border of dropdown button
                        borderRadius: BorderRadius.circular(
                            5.0), //border raiuds of dropdown button
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            hint: const Text("Add new card"),
                            value: _cards,
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
                                _cards = newValue!;
                              });
                              print(_cards);
                            },
                            items: cards.map((Map map) {
                              return DropdownMenuItem<String>(
                                value: map["cardNumber"].toString(),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      child: Text(map["cardNumber"]),
                                    ),
                                    SvgPicture.asset(
                                      map["image"],
                                      height: 30,
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      )),
                  const SizedBox(height: 20.0),
                  const Text("Fill in your card details",
                      textScaleFactor: 1.2,
                      style: TextStyle(
                          //fontSize: 16,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(height: 10.0),
                  const Text("Card holder's name",
                      textScaleFactor: 1,
                      style: TextStyle(
                          //fontSize: 16,
                          fontWeight: FontWeight.w400)),
                  CustomInputField(
                      key: const Key('Trakk wallet'),
                      textController: _walletControler,
                      node: _amountNode,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      hintText: 'Name',
                      text: "",
                      textHeight: 10.0,
                      borderColor: appPrimaryColor.withOpacity(0.9),
                      validator: (value) {
                        if (value!.trim().length > 2) {
                          return null;
                        }
                        return "Enter a valid  name";
                      },
                      onSaved: (value) {
                        _wallet = value!.trim();
                        return null;
                      },
                      obscureText: false),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Card Number",
                      textScaleFactor: 1.2,
                      style: TextStyle(
                          //fontSize: 16,
                          fontWeight: FontWeight.w500)),
                  CustomInputField(
                    key: const Key('cardNumber'),
                    textController: _cardNumberController,
                    keyboardType: TextInputType.phone,
                    node: _amountNode,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: false,
                    text: '',
                    hintText: '0000-0000-0000-0000',
                    textHeight: 10.0,
                    borderColor: appPrimaryColor.withOpacity(0.9),

                    // validator: (value) {
                    //   if (value!.trim().length == 11) {
                    //     return null;
                    //   }
                    //   return "Enter a valid phone number";
                    // },
                    onSaved: (value) {
                      _amount = value!.trim();
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Expire Date",
                      textScaleFactor: 1.2,
                      style: TextStyle(
                          //fontSize: 16,
                          fontWeight: FontWeight.w500)),
                  Row(
                    children: [
                      Expanded(
                        child: CustomInputField(
                            key: const Key('Trakk wallet'),
                            textController: _walletControler,
                            node: _amountNode,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            hintText: 'mm/yy',
                            text: "",
                            textHeight: 10.0,
                            borderColor: appPrimaryColor.withOpacity(0.9),
                            onSaved: (value) {
                              _wallet = value!.trim();
                              return null;
                            },
                            obscureText: false),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Expanded(
                        child: CustomInputField(
                            key: const Key('Trakk wallet'),
                            textController: _walletControler,
                            node: _amountNode,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            hintText: 'cvv',
                            text: "",
                            textHeight: 10.0,
                            borderColor: appPrimaryColor.withOpacity(0.9),
                            onSaved: (value) {
                              _wallet = value!.trim();
                              return null;
                            },
                            obscureText: false),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Amount",
                      textScaleFactor: 1.2,
                      style: TextStyle(
                          //fontSize: 16,
                          fontWeight: FontWeight.w500)),
                  CustomInputField(
                    key: const Key('amount'),
                    textController: _amountController,
                    keyboardType: TextInputType.phone,
                    node: _amountNode,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: false,
                    text: '',
                    hintText: '₦00.00',
                    textHeight: 10.0,
                    borderColor: appPrimaryColor.withOpacity(0.9),

                    // validator: (value) {
                    //   if (value!.trim().length == 11) {
                    //     return null;
                    //   }
                    //   return "Enter a valid phone number";
                    // },
                    onSaved: (value) {
                      _amount = value!.trim();
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Button(
                      text: "Top Up",
                      onPress: () => showDialog<String>(
                          // barrierDismissible: true,
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                // title: const Text('AlertDialog Title'),
                                // contentPadding:
                                //     const EdgeInsets
                                //             .symmetric(
                                //         horizontal: 50.0,
                                //         vertical: 50.0),
                                content: SizedBox(
                                  height: 250.0,
                                  child: Column(children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: const [CancelButton()]),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Image.asset(
                                        Assets.check_success_outline),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: 300,
                                      child: const Text(
                                        "You have successfully funded your Trakk wallet with ₦5000",
                                        // maxLines: 2,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 14,
                                    ),
                                    const SizedBox(height: 10.0),
                                    Button(
                                      text: 'Back to wallet',
                                      onPress: () {
                                        Navigator.of(context)
                                            .pushNamed(WalletScreen.id);
                                      },
                                      color: appPrimaryColor,
                                      textColor: whiteColor,
                                      isLoading: false,
                                      width: MediaQuery.of(context).size.width /
                                          1.3,
                                    )
                                  ]),
                                ),
                              )),
                      color: appPrimaryColor,
                      width: mediaQuery.size.width * 0.9,
                      textColor: whiteColor,
                      isLoading: false),
                ],
              ),
            ),
          ),
        ),
      ),
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

class FundWalletScreen extends StatefulWidget {
  static String id = "fundwallet";

  const FundWalletScreen({Key? key}) : super(key: key);

  @override
  State<FundWalletScreen> createState() => _FundWalletScreen();
}

class _FundWalletScreen extends State<FundWalletScreen> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0.0, right: 30, bottom: 17),
              child: Row(
                children: [
                  BackIcon(
                    onPress: () {
                      Navigator.pop(context);
                    },
                  ),
                  Container(
                    margin: EdgeInsets.only(left: mediaQuery.size.width / 6),
                    alignment: Alignment.center,
                    child: const Text(
                      'WALLET TOP-UP',
                      style: TextStyle(
                          color: appPrimaryColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
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
                      child: FundWalletWidget(),
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

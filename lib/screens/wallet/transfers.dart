import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/screens/wallet/wallet.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/back_icon.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/widgets/cancel_button.dart';
import 'package:trakk/widgets/input_field.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class Transfers extends StatefulWidget {
  static const String id = "transfers";

  const Transfers({Key? key}) : super(key: key);

  @override
  _TransfersState createState() => _TransfersState();
}

class _TransfersState extends State<Transfers> {
  String? _nuban;

  late TextEditingController _nubanController;
  late TextEditingController _otpController;

  FocusNode? _nubanNode;

  @override
  void initState() {
    super.initState();
    _nubanController = TextEditingController();
  }

  bool _isButtonPress = false;
  bool _isToggled = false;

  String _sourceWallets = 'Select Source Wallet';
  String _wallets = 'Select Wallet';

  var sourceWallets = [
    "Select Source Wallet",
    "Trakk wallet",
    "Zebrra wallet",
  ];

  var wallets = [
    "Select Wallet",
    "Trakk wallet",
    "Zebrra wallet",
  ];
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15.0),
            height: 160,
            //  height: MediaQuery.of(context).size.height * 0.5/3,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: appPrimaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                  color: Color(0XFFBDBDBD),
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 2.0,
                ),
              ],
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Transfer limit',
                    textScaleFactor: 1.1,
                    style: TextStyle(
                        color: Color(0xFFFFFFFF), fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Expanded(
                    child: Text(
                      '₦300,000.00',
                      textScaleFactor: 1.9,
                      style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Button(
                  text: "Edit limit",
                  onPress: () {},
                  color: whiteColor,
                  width: 104,
                  textColor: appPrimaryColor,
                  isLoading: false)
            ]),
          ),
          const SizedBox(
            height: 30,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "I want to transfer to",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          DefaultTabController(
            length: 3,
            child: Column(
              children: [
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TabBar(
                      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                      //indicatorPadding: EdgeInsets.symmetric(horizontal: 10,),
                      //indicatorColor: Colors.red,
                      indicator: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          color: Color(0xffCA9E0D)),
                      //labelPadding: EdgeInsets.only(left: 20,right: 10),
                      labelColor: appPrimaryColor,
                      unselectedLabelColor: appPrimaryColor,
                      unselectedLabelStyle: TextStyle(fontSize: 16),

                      tabs: [
                        Tab(
                          height: 100,
                          //text: 'Edit',
                          child: Container(
                              height: 100,
                              width: 200,
                              padding: EdgeInsets.only(top: 0, bottom: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Image.asset(
                                      "assets/images/zebrraLogo.png",
                                      height: 46,
                                    ),
                                  ),
                                  const Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      "Own\nZebrra wallet",
                                      textScaleFactor: 0.7,
                                      textAlign: TextAlign.start,
                                      //style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        Tab(
                          height: 100,

                          //text: 'Edit',
                          child: Container(
                              height: 100,
                              width: 200,
                              padding: EdgeInsets.only(top: 0, bottom: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Image.asset(
                                      "assets/images/zebrraLogo.png",
                                      height: 46,
                                    ),
                                  ),
                                  const Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      "Other\nZebrra wallets",
                                      textScaleFactor: 0.7,
                                      textAlign: TextAlign.start,
                                      //style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        Tab(
                          height: 100,

                          //text: 'Edit',
                          child: Container(
                              height: 100,
                              width: 200,
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Icon(Remix.home_8_line),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      "Other\nBanks",
                                      textScaleFactor: 0.7,
                                      textAlign: TextAlign.start,
                                      //style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  //width: double.maxFinite,
                  height: mediaQuery.size.height * 1.4,
                  child: TabBarView(children: [
                    ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Button(
                                          text: "Saved Beneficiary",
                                          onPress: () {},
                                          color: whiteColor,
                                          width: 160,
                                          textColor: appPrimaryColor,
                                          isLoading: false),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Button(
                                          text: "New Beneficiary",
                                          onPress: () {},
                                          color: appPrimaryColor,
                                          width: 160,
                                          textColor: whiteColor,
                                          isLoading: false),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20.0),
                                const Text("Select Source Wallet",
                                    textScaleFactor: 1.2,
                                    style: TextStyle(
                                        color: grayColor,
                                        //fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                                const SizedBox(height: 10.0),
                                DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: whiteColor,
                                      border: Border.all(
                                          color:
                                              appPrimaryColor.withOpacity(0.9),
                                          width:
                                              0.3), //border of dropdown button
                                      borderRadius: BorderRadius.circular(
                                          5.0), //border raiuds of dropdown button
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: DropdownButton<String>(
                                        value: _sourceWallets,
                                        icon:
                                            const Icon(Remix.arrow_down_s_line),
                                        elevation: 16,
                                        isExpanded: true,
                                        style: TextStyle(
                                          color:
                                              appPrimaryColor.withOpacity(0.8),
                                          fontSize: 18.0,
                                        ),
                                        underline: Container(), //empty line
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            _sourceWallets = newValue!;
                                          });
                                        },
                                        items:
                                            sourceWallets.map((String value) {
                                          return DropdownMenuItem(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    )),
                                const SizedBox(height: 5.0),
                                _isButtonPress &&
                                        _sourceWallets == "Select Wallet Source"
                                    ? const Text(
                                        "Choose Wallet Source",
                                        textScaleFactor: 0.9,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      )
                                    : Container(),
                                const SizedBox(height: 20.0),
                                const Text("Select Destination Wallet",
                                    textScaleFactor: 1.2,
                                    style: TextStyle(
                                        color: grayColor,
                                        //fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                                const SizedBox(height: 10.0),
                                DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: whiteColor,
                                      border: Border.all(
                                          color:
                                              appPrimaryColor.withOpacity(0.9),
                                          width:
                                              0.3), //border of dropdown button
                                      borderRadius: BorderRadius.circular(
                                          5.0), //border raiuds of dropdown button
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: DropdownButton<String>(
                                        value: _wallets,
                                        icon:
                                            const Icon(Remix.arrow_down_s_line),
                                        elevation: 16,
                                        isExpanded: true,
                                        style: TextStyle(
                                          color:
                                              appPrimaryColor.withOpacity(0.8),
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
                                const SizedBox(height: 5.0),
                                _isButtonPress && _wallets == "Select Wallet"
                                    ? const Text(
                                        " Choose Destination Wallet",
                                        textScaleFactor: 0.9,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      )
                                    : Container(),
                                const SizedBox(height: 20.0),
                                InputField(
                                  key: const Key('nuban'),
                                  textController: _nubanController,
                                  keyboardType: TextInputType.phone,
                                  node: _nubanNode,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  obscureText: false,
                                  text: 'Enter Destination Nuban',
                                  textColor: grayColor,
                                  hintText: 'Wallet Nuban',
                                  textHeight: 5.0,
                                  borderColor: appPrimaryColor.withOpacity(0.9),
                                  validator: (value) {
                                    if (value!.trim().length == 16) {
                                      return null;
                                    }
                                    return "Enter a valid nuban";
                                  },
                                  onSaved: (value) {
                                    _nuban = value!.trim();
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 25.0),
                                InputField(
                                  key: const Key('wallet destination'),
                                  //textController: _walletControler,
                                  //node: _amountNode,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  obscureText: false,
                                  text: 'Select Destination Wallet',
                                  textColor: grayColor,
                                  hintText: 'name',
                                  textHeight: 10.0,
                                  borderColor: appPrimaryColor.withOpacity(0.9),
                                  // suffixIcon: const Icon(
                                  //   Remix.user_line,
                                  //   size: 18.0,
                                  //   color: Color(0xFF909090),
                                  // ),
                                  // validator: (value) {
                                  //   if (value!.trim().length > 2) {
                                  //     return null;
                                  //   }
                                  //   return "Enter a valid last  name";
                                  // },
                                  onSaved: (value) {
                                    //_wallet = value!.trim();
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                InputField(
                                  key: const Key('amount'),
                                  //textController: _amountController,
                                  keyboardType: TextInputType.phone,
                                  //node: _amountNode,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  obscureText: false,
                                  text: 'Amount',
                                  textColor: grayColor,
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
                                    // _amount = value!.trim();
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 25.0),
                                InputField(
                                  key: const Key('transactionDescription'),
                                  //textController: _walletControler,
                                  //node: _amountNode,
                                  //autovalidateMode: AutovalidateMode.onUserInteraction,
                                  obscureText: false,
                                  text: 'Transaction Description',
                                  textColor: grayColor,
                                  hintText: 'Why am i transferring',
                                  textHeight: 10.0,
                                  borderColor: appPrimaryColor.withOpacity(0.9),
                                  // suffixIcon: const Icon(
                                  //   Remix.user_line,
                                  //   size: 18.0,
                                  //   color: Color(0xFF909090),
                                  // ),
                                  // validator: (value) {
                                  //   if (value!.trim().length > 2) {
                                  //     return null;
                                  //   }
                                  //   return "Enter a valid last  name";
                                  // },
                                  onSaved: (value) {
                                    //_wallet = value!.trim();
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "Save as Beneficiary",
                                  textScaleFactor: 1.2,
                                  style: TextStyle(
                                      color: grayColor,
                                      //fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  height: 56,
                                  width: 300,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: grayColor),
                                    color: whiteColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(_isToggled ? "Saved" : "Save"),
                                      FlutterSwitch(
                                        height: 20.0,
                                        width: 40.0,
                                        padding: 4.0,
                                        toggleSize: 15.0,
                                        borderRadius: 10.0,
                                        inactiveColor: whiteColor,
                                        activeColor: whiteColor,
                                        activeSwitchBorder: Border.all(
                                            color: secondaryColor,
                                            style: BorderStyle.solid),
                                        activeToggleBorder:
                                            Border.all(color: secondaryColor),
                                        activeToggleColor: secondaryColor,
                                        inactiveToggleBorder:
                                            Border.all(color: appPrimaryColor),
                                        inactiveToggleColor: appPrimaryColor,
                                        inactiveSwitchBorder:
                                            Border.all(color: appPrimaryColor),
                                        value: _isToggled,
                                        onToggle: (value) {
                                          print("VALUE : $value");
                                          setState(() {
                                            _isToggled = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                Button(
                                    text: "Continue",
                                    onPress: () => showDialog<String>(
                                          // barrierDismissible: true,
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 15,
                                                    vertical: 20),
                                            content: SizedBox(
                                              height: 400.0,
                                              width: 350,
                                              child: Column(children: [
                                                const Text(
                                                  'Review and Confirm Transaction',
                                                  //textAlign: Alignment.center,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                // Image.asset(
                                                //     "assets/images/confirmPayment.png"),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                //Text(
                                                //  "You are about to Fund your Wallet 00556 with  ₦5000 from your Zebrra Wallet with Nuban 00556"),
                                                RichText(
                                                  textAlign: TextAlign.start,
                                                  text: const TextSpan(
                                                    text:
                                                        "You are about to transfer",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: "\" ₦2000\" ",
                                                        style: TextStyle(
                                                          color: secondaryColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        //recognizer: _longPressRecognizer,
                                                      ),
                                                      TextSpan(
                                                          text: "from your "),
                                                      TextSpan(
                                                        text:
                                                            "\" Trakk Wallet\" ",
                                                        style: TextStyle(
                                                          color: secondaryColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        //recognizer: _longPressRecognizer,
                                                      ),
                                                      TextSpan(
                                                          text:
                                                              " to Malik Johnson with the account number"),
                                                      TextSpan(
                                                        text: "\" 002122658\" ",
                                                        style: TextStyle(
                                                          color: secondaryColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        //recognizer: _longPressRecognizer,
                                                      ),

                                                      //recognizer: _longPressRecognizer,
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                const SizedBox(
                                                  width: 300,
                                                  child: Text(
                                                    "If the above statement is correct, enter your 4-digit pin to continue",
                                                    // maxLines: 2,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                
                                                const SizedBox(height: 30,),
                                                Text("Enter 4-digit PIN",
                                                textScaleFactor: 1.1,
                                                 style: TextStyle(
                                                   fontWeight: FontWeight.w600
                                                ),),
                                                const SizedBox(height: 10,),
                                                PinCodeTextField(
                                                  pinBoxHeight: 50.0,
                                                  pinBoxWidth: 50,
                                                  autofocus: false,
                                                  //controller: controller,
                                                  hideCharacter: false,
                                                  highlight: true,
                                                  pinBoxColor: Colors.white,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  highlightColor:
                                                      Colors.black45,
                                                  defaultBorderColor: grayColor,
                                                  pinTextStyle: const TextStyle(
                                                      fontSize: 22.0),
                                                  //defaultBorderColor: kGreyDark,
                                                  hasTextBorderColor:
                                                      Colors.orange,
                                                  pinBoxRadius: 2,
                                                  maxLength: 4,

                                                  onTextChanged:
                                                      (String value) {
                                                    // input value status
                                                    print(value);
                                                  },
                                                  onDone: (text) {
                                                    print('done with ' + text);
                                                    // call function from controller to confirm OTP here
                                                    // _otpController.verifyOTP(text);
                                                  },
                                                ),
                                                
                                                const SizedBox(height: 30,),
                                                
                                               
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Button(
                                                        text: 'Continue',
                                                        onPress: () {
                                                          Navigator.of(context)
                                                              .pushNamed(
                                                                  WalletScreen.id);
                                                        },
                                                        color: appPrimaryColor,
                                                        textColor: whiteColor,
                                                        isLoading: false,
                                                        width: 121,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 20,),
                                                    Expanded(
                                                      child: Button(text: "Cancel", onPress: () {}, color: whiteColor,
                                                       width: 121, textColor: appPrimaryColor, isLoading: false),
                                                    ),
                                                  ],
                                                ),
                                              ]
                                              ),
                                            ),
                                          ),
                                        ),
                                    color: appPrimaryColor,
                                    width: 338,
                                    textColor: whiteColor,
                                    isLoading: false),
                              ],
                            ),
                          ),
                        ]),
                    ListView(physics: ScrollPhysics(), children: [
                      Container(
                          decoration: BoxDecoration(
                            //color: Color.fromARGB(0, 202, 138, 41),
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              color: Color.fromARGB(255, 231, 226, 202),
                              height: 650,
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
                                              color: appPrimaryColor
                                                  .withOpacity(0.9),
                                              width:
                                                  0.3), //border of dropdown button
                                          borderRadius: BorderRadius.circular(
                                              5.0), //border raiuds of dropdown button
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          // child: DropdownButton<String>(
                                          //   value: _cards.toString(),
                                          //   icon: const Icon(
                                          //       Remix.arrow_down_s_line),
                                          //   elevation: 16,
                                          //   isExpanded: true,
                                          //   style: TextStyle(
                                          //     color: appPrimaryColor
                                          //         .withOpacity(0.8),
                                          //     fontSize: 18.0,
                                          //   ),
                                          //   underline:
                                          //       Container(), //empty line
                                          //   onChanged: (String? newValue) {
                                          //     setState(() {
                                          //       _cards = newValue!;
                                          //     });
                                          //   },
                                          //   items: cards.map((String value) {
                                          //     return DropdownMenuItem(
                                          //       value: value,
                                          //       child: Text(value),
                                          //     );
                                          //   }).toList(),
                                          // ),
                                        )),
                                    const SizedBox(height: 20.0),
                                    const Text("Fill in your card details",
                                        textScaleFactor: 1.2,
                                        style: TextStyle(
                                            //fontSize: 16,
                                            fontWeight: FontWeight.w500)),
                                    const SizedBox(height: 15.0),
                                    InputField(
                                      key: const Key('name'),
                                      // textController: _walletControler,
                                      // node: _amountNode,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      obscureText: false,
                                      text: 'Card holder\'s name',
                                      hintText: 'Name',
                                      textHeight: 10.0,
                                      borderColor:
                                          appPrimaryColor.withOpacity(0.9),
                                      // suffixIcon: const Icon(
                                      //   Remix.user_line,
                                      //   size: 18.0,
                                      //   color: Color(0xFF909090),
                                      // ),
                                      // validator: (value) {
                                      //   if (value!.trim().length > 2) {
                                      //     return null;
                                      //   }
                                      //   return "Enter a valid last  name";
                                      // },
                                      onSaved: (value) {
                                        // _card = value!.trim();
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    InputField(
                                      key: const Key('Card number'),
                                      // textController: _amountController,
                                      keyboardType: TextInputType.phone,
                                      // node: _amountNode,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      obscureText: false,
                                      text: 'Card number',
                                      hintText: '0000-0000-0000-0000',
                                      textHeight: 10.0,
                                      borderColor:
                                          appPrimaryColor.withOpacity(0.9),

                                      // validator: (value) {
                                      //   if (value!.trim().length == 11) {
                                      //     return null;
                                      //   }
                                      //   return "Enter a valid phone number";
                                      // },
                                      onSaved: (value) {
                                        //_cardNumber = value!.trim() as int?;
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: InputField(
                                            key: const Key('Expirydate'),
                                            // textController: _firstNameController,
                                            // node: _firstNameNode,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            obscureText: false,
                                            text: 'Expiry date',
                                            hintText: 'mm/yy',
                                            textHeight: 10.0,
                                            borderColor: appPrimaryColor
                                                .withOpacity(0.9),

                                            validator: (value) {
                                              if (value!.trim().length > 2) {
                                                return null;
                                              }
                                              return "Enter a valid first name";
                                            },
                                            onSaved: (value) {
                                              // _firstName = value!.trim();
                                              return null;
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 40.0),
                                        Expanded(
                                          child: InputField(
                                            key: const Key('cvv'),
                                            // textController: _lastNameController,
                                            // node: _lastNameNode,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            obscureText: false,
                                            text: '',
                                            hintText: 'cvv',
                                            textHeight: 10.0,
                                            borderColor: appPrimaryColor
                                                .withOpacity(0.9),

                                            validator: (value) {
                                              if (value!.trim().length > 2) {
                                                return null;
                                              }
                                              return "Enter a valid last name";
                                            },
                                            onSaved: (value) {
                                              //_lastName = value!.trim();
                                              return null;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    // InputField(
                                    //   key: const Key('amount'),
                                    //   textController: _amountController,
                                    //   keyboardType: TextInputType.phone,
                                    //   node: _amountNode,
                                    //   autovalidateMode:
                                    //       AutovalidateMode.onUserInteraction,
                                    //   obscureText: false,
                                    //   text: 'Amount',
                                    //   hintText: '₦00.00',
                                    //   textHeight: 10.0,
                                    //   borderColor:
                                    //       appPrimaryColor.withOpacity(0.9),

                                    //   // validator: (value) {
                                    //   //   if (value!.trim().length == 11) {
                                    //   //     return null;
                                    //   //   }
                                    //   //   return "Enter a valid phone number";
                                    //   // },
                                    //   onSaved: (value) {
                                    //     _amount = value!.trim();
                                    //     return null;
                                    //   },
                                    // ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Button(
                                        text: "Top Up",
                                        onPress: () => showDialog<String>(
                                            // barrierDismissible: true,
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
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
                                                              MainAxisAlignment
                                                                  .end,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: const [
                                                            CancelButton()
                                                          ]),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Image.asset(
                                                          "assets/images/confirmPayment.png"),
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
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 14,
                                                      ),
                                                      const SizedBox(
                                                          height: 10.0),
                                                      Button(
                                                        text: 'Back to wallet',
                                                        onPress: () {
                                                          Navigator.of(context)
                                                              .pushNamed(
                                                                  WalletScreen
                                                                      .id);
                                                        },
                                                        color: appPrimaryColor,
                                                        textColor: whiteColor,
                                                        isLoading: false,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            1.3,
                                                      ),
                                                    ]),
                                                  ),
                                                )),
                                        color: appPrimaryColor,
                                        width: 308,
                                        textColor: whiteColor,
                                        isLoading: false),
                                  ],
                                ),
                              ),
                            ),
                          ))
                      //Divider()
                    ]),
                    ListView(
                      children: [
                        Center(
                          child: Text("data"),
                        )
                      ],
                    )
                  ]),
                ),
              ],
            ),
          ),
        ]),
      ),
    ));
  }
}

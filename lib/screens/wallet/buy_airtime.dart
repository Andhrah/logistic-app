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

class BuyAirtime extends StatefulWidget {
  static const String id = "buyAirtime";

  const BuyAirtime({Key? key}) : super(key: key);

  @override
  _BuyAirtimeState createState() => _BuyAirtimeState();
}

class _BuyAirtimeState extends State<BuyAirtime> {

  String? _phoneNumber;

  late TextEditingController _nubanController;
  late TextEditingController _otpController;
  late TextEditingController _phoneNumberController;

  FocusNode? _phoneNumberNode;


   @override
  void initState() {
    super.initState();
   _phoneNumberController = TextEditingController();

  }


  
  bool _isButtonPress = false;
  bool _isToggled = false;

  String _sourceWallets = 'Select Source Wallet';
  String _airtimeType = 'VTU (Airtime or Data)';
  String _airtimeCategory = 'Airtime';
  String _airtimeNetwork = 'MTN';


  var airtimeNetwork = [
    "MTN",
    "GLO",
    "9MOBILE",
  ];


  var sourceWallets = [
    "Select Source Wallet",
    "Trakk wallet",
    "Zebrra wallet",
  ];

  var airtimeTypes = [
    "VTU (Airtime or Data)",

  ];
  var airtimeCategory = [
   "Airtime"
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
          Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
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
                          color: appPrimaryColor.withOpacity(0.9),
                          width: 0.3), //border of dropdown button
                      borderRadius: BorderRadius.circular(
                          5.0), //border raiuds of dropdown button
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: DropdownButton<String>(
                        value: _sourceWallets,
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
                            _sourceWallets = newValue!;
                          });
                        },
                        items: sourceWallets.map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    )),
                const SizedBox(height: 5.0),
                _isButtonPress && _sourceWallets == "Select Wallet Source"
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
                const Text("Select Type",
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
                          color: appPrimaryColor.withOpacity(0.9),
                          width: 0.3), //border of dropdown button
                      borderRadius: BorderRadius.circular(
                          5.0), //border raiuds of dropdown button
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: DropdownButton<String>(
                        value: _airtimeType,
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
                            _airtimeType = newValue!;
                          });
                        },
                        items: airtimeTypes.map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    )),
                const SizedBox(height: 5.0),
                _isButtonPress && _airtimeType == "VTU (Airtime or Data)"
                    ? const Text(
                        " Choose Airtime Type",
                        textScaleFactor: 0.9,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      )
                    : Container(),
                const SizedBox(height: 20.0),
                const Text("Select Category",
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
                          color: appPrimaryColor.withOpacity(0.9),
                          width: 0.3), //border of dropdown button
                      borderRadius: BorderRadius.circular(
                          5.0), //border raiuds of dropdown button
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: DropdownButton<String>(
                        value: _airtimeCategory,
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
                            _airtimeCategory = newValue!;
                          });
                        },
                        items: airtimeCategory.map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    )),
                const SizedBox(height: 5.0),
                _isButtonPress && _airtimeCategory == "Airtime"
                    ? const Text(
                        " Choose Airtime Category",
                        textScaleFactor: 0.9,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      )
                    : Container(),
                const SizedBox(height: 25.0),
                const Text("Select Network",
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
                          color: appPrimaryColor.withOpacity(0.9),
                          width: 0.3), //border of dropdown button
                      borderRadius: BorderRadius.circular(
                          5.0), //border raiuds of dropdown button
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: DropdownButton<String>(
                        value: _airtimeNetwork,
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
                            _airtimeNetwork = newValue!;
                          });
                        },
                        items: airtimeNetwork.map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    )),
                const SizedBox(height: 5.0),
                _isButtonPress && _airtimeNetwork == "Airtime"
                    ? const Text(
                        " Choose Airtime Category",
                        textScaleFactor: 0.9,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 20,
                ),
                InputField(
                  key: const Key('amount'),
                  //textController: _amountController,
                  keyboardType: TextInputType.phone,
                  //node: _amountNode,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        key: const Key('mobileNumber'),
                        textController: _phoneNumberController,
                        keyboardType: TextInputType.phone,
                        node: _phoneNumberNode,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: false,
                        text: 'Input Mobile Number',
                        hintText: 'Mobile number',
                        textHeight: 5.0,
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

               
                
                const SizedBox(
                  height: 40,
                ),
                Button(
                    text: "Continue",
                    onPress: () => showDialog<String>(
                          // barrierDismissible: true,
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            content: SizedBox(
                              height: 400.0,
                              width: 350,
                              child: Column(children: [
                                const Text(
                                  'Review and Confirm Transaction',
                                  //textAlign: Alignment.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
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
                                    text: "You are about to recharge",
                                    style: TextStyle(color: Colors.black),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "\" ₦2000\" ",
                                        style: TextStyle(
                                          color: secondaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        //recognizer: _longPressRecognizer,
                                      ),
                                      TextSpan(text: "from your "),
                                      TextSpan(
                                        text: "\" Trakk Wallet\" ",
                                        style: TextStyle(
                                          color: secondaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        //recognizer: _longPressRecognizer,
                                      ),
                                      TextSpan(
                                          text:
                                              " o phone number"),
                                      TextSpan(
                                        text: "\" 08105319288\" ",
                                        style: TextStyle(
                                          color: secondaryColor,
                                          fontWeight: FontWeight.bold,
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
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),

                                const SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  "Enter 4-digit PIN",
                                  textScaleFactor: 1.1,
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                PinCodeTextField(
                                  pinBoxHeight: 50.0,
                                  pinBoxWidth: 50,
                                  autofocus: false,
                                  //controller: controller,
                                  hideCharacter: false,
                                  highlight: true,
                                  pinBoxColor: Colors.white,
                                  keyboardType: TextInputType.number,
                                  highlightColor: Colors.black45,
                                  defaultBorderColor: grayColor,
                                  pinTextStyle: const TextStyle(fontSize: 22.0),
                                  //defaultBorderColor: kGreyDark,
                                  hasTextBorderColor: Colors.orange,
                                  pinBoxRadius: 2,
                                  maxLength: 4,

                                  onTextChanged: (String value) {
                                    // input value status
                                    print(value);
                                  },
                                  onDone: (text) {
                                    print('done with ' + text);
                                    // call function from controller to confirm OTP here
                                    // _otpController.verifyOTP(text);
                                  },
                                ),

                                const SizedBox(
                                  height: 30,
                                ),

                                Row(
                                  children: [
                                    Expanded(
                                      child: Button(
                                        text: 'Continue',
                                        onPress: () => showDialog<String>(
                                          // barrierDismissible: true,
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 10),
                                            content: SizedBox(
                                              height:
                                                  mediaQuery.size.height * 0.4,
                                              width: 350,
                                              child: Column(children: [
                                                Row(crossAxisAlignment: CrossAxisAlignment.end,
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                  CancelButton(),
                                                ],),
                                                SizedBox(
                                    height: 10,
                                  ),
                                  Image.asset(
                                      "assets/images/confirmPayment.png"),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  const SizedBox(
                                    width: 250,
                                    child: Text(
                                      "You have successfully recharged the sum of ₦200 on 08063225964",
                                      // maxLines: 2,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff23710F),
                                        fontWeight: FontWeight.w400,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Button(text: "Back to Wallet", onPress: (){}, color: appPrimaryColor, 
                                  width: mediaQuery.size.width * 0.4, textColor: whiteColor, isLoading: false)
                                                //add the transaction receipt
                                              ]),
                                            ),
                                          ),
                                        ),
                                        color: appPrimaryColor,
                                        textColor: whiteColor,
                                        isLoading: false,
                                        width: 121,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Button(
                                          text: "Cancel",
                                          onPress: () {},
                                          color: whiteColor,
                                          width: 121,
                                          textColor: appPrimaryColor,
                                          isLoading: false),
                                    ),
                                  ],
                                ),
                              ]),
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
      ),
    ));
  }
}

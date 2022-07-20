import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/src/screens/wallet/wallet.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/widgets/back_icon.dart';
import 'package:trakk/src/widgets/button.dart';
import 'package:trakk/src/widgets/cancel_button.dart';
import 'package:trakk/src/widgets/input_field.dart';
import 'package:trakk/src/widgets/qr_box_tab.dart';

class QrCodePayment extends StatefulWidget {
  static const String id = "qrcodePayment";

  const QrCodePayment({Key? key}) : super(key: key);

  @override
  _QrCodePaymentState createState() => _QrCodePaymentState();
}

class _QrCodePaymentState extends State<QrCodePayment> {
  bool shouldRepaint(CustomPainter oldDelegate) => false;

  String? _nuban;

  late TextEditingController _nubanController;
  late TextEditingController _otpController;

  FocusNode? _nubanNode;

  bool _isButtonPress = false;
  bool _isSelected = false;
  bool _isToggled = false;

  String _sourceWallets = 'Select Source Wallet';
  String _wallets = 'Select Wallet';
  String _banks = 'Select Bank';

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
  var banks = [
    "Select Bank",
    "Access Bank",
    "First City Monument Bank (FCMB)",
    "First Bank",
    "Union Bank",
    "Guarranty Trust Bank"
  ];

  String? _pickUpDate;
  String? _dropOffDate;

  late TextEditingController _pickUpController;
  late TextEditingController _dropOffController;
  late TextEditingController _itemController;
  late TextEditingController _itemDescriptionController;
  TextEditingController? _receiverNameController;
  late TextEditingController _senderNameController;
  late TextEditingController _receiverPhoneNumberController;
  late TextEditingController _senderPhoneNumberController;
  late TextEditingController _pickUpDateController;
  late TextEditingController _dropOffDateController;

  FocusNode? _pickUpNode;
  FocusNode? _dropOffNode;
  FocusNode? _receiverNameNode;
  FocusNode? _senderNameNode;
  FocusNode? _receiverphoneNumberNode;
  FocusNode? _senderphoneNumberNode;
  FocusNode? _itemNode;
  FocusNode? _itemDescriptionNode;
  FocusNode? _pickUpDateNode;
  FocusNode? _dropOffDateNode;

  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.blue;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      math.pi,
      math.pi,
      false,
      paint,
    );
  }

  @override
  void initState() {
    super.initState();
    String apiKey = "AIzaSyBvxkb0Gv6kwpiplPtmeQZhG4_V-KvLZ1U";

    _pickUpController = TextEditingController();
    _dropOffController = TextEditingController();
    _itemController = TextEditingController();
    _itemDescriptionController = TextEditingController();
    _receiverNameController = TextEditingController();
    _senderNameController = TextEditingController();
    _receiverPhoneNumberController = TextEditingController();
    _senderPhoneNumberController = TextEditingController();
    _pickUpDateController = TextEditingController();
    _dropOffDateController = TextEditingController();
    _nubanController = TextEditingController();

    _pickUpNode = FocusNode();
    _dropOffNode = FocusNode();
    _itemNode = FocusNode();
    _itemDescriptionNode = FocusNode();
    _pickUpDateNode = FocusNode();
    _dropOffDateNode = FocusNode();
    _receiverNameNode = FocusNode();
    _senderNameNode = FocusNode();
    _receiverphoneNumberNode = FocusNode();
    _senderphoneNumberNode = FocusNode();
  }

  _parseDate(value) {
    var transactionDate = DateTime.parse(value);
    var formattedDate =
        "${transactionDate.day}-${transactionDate.month}-${transactionDate.year}";
    return formattedDate;

    // print(formattedDate);
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
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
                    'QR PAYMENT',
                    style: TextStyle(
                        color: appPrimaryColor,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Select QR Source",
                    textScaleFactor: 1.3,
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {},
                            child: const QrBoxTab(
                              title: "Scan with\nCamera",
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                            onTap: () {},
                            child: const QrBoxTab(
                              title: "Scan from\nGallery",
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                            onTap: () {},
                            child: const QrBoxTab(
                              title: "Enter\nMerchnat ID",
                              color: paymentContainerColor,
                            )),
                      ]),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TabBar(
                        labelStyle:
                            const TextStyle(fontWeight: FontWeight.bold),
                        indicatorPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        //indicatorColor: Colors.red,
                        indicator: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                            color: paymentContainerColor),
                        //labelPadding: EdgeInsets.only(left: 20,right: 10),
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor: appPrimaryColor,
                        unselectedLabelColor: appPrimaryColor,
                        unselectedLabelStyle: TextStyle(fontSize: 16),

                        tabs: [
                          Tab(
                            height: 120,
                            child: Container(
                              height: 120,
                              width: 160,
                              decoration: const BoxDecoration(
                                //border: Border.all(),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              padding: EdgeInsets.only(top: 10, bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    "assets/images/masterCardP.png",
                                    height: 70,
                                  ),
                                  const Text(
                                    "Mastercard",
                                    textScaleFactor: 0.8,
                                    textAlign: TextAlign.start,
                                    //style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Tab(
                            height: 120,

                            //text: 'Edit',
                            child: Container(
                              height: 120,
                              width: 160,
                              decoration: const BoxDecoration(
                                //border: Border.all(),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              padding: EdgeInsets.only(top: 10, bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    "assets/images/visaCard.png",
                                    height: 70,
                                  ),
                                  const Text(
                                    "VisaCard",
                                    textScaleFactor: 0.8,
                                    textAlign: TextAlign.start,
                                    //style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
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
                      ListView(physics: ScrollPhysics(), children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 25.0),
                              InputField(
                                key: const Key('merchantID'),
                                //textController: _walletControler,
                                //node: _amountNode,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                obscureText: false,
                                text: ' Enter Merchant ID',
                                textColor: grayColor,
                                hintText: 'ID',
                                textHeight: 10.0,
                                borderColor: appPrimaryColor.withOpacity(0.9),

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
                              const SizedBox(height: 25.0),
                              InputField(
                                key: const Key('merchant name'),
                                //textController: _walletControler,
                                //node: _amountNode,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                obscureText: false,
                                text: ' Merchant Name',
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
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
                                        color: appPrimaryColor.withOpacity(0.9),
                                        width: 0.3), //border of dropdown button
                                    borderRadius: BorderRadius.circular(
                                        5.0), //border raiuds of dropdown button
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
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
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              // Image.asset(
                                              //   Assets.check_success_outline),
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
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600),
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
                                                keyboardType:
                                                    TextInputType.number,
                                                highlightColor: Colors.black45,
                                                defaultBorderColor: grayColor,
                                                pinTextStyle: const TextStyle(
                                                    fontSize: 22.0),
                                                //defaultBorderColor: kGreyDark,
                                                hasTextBorderColor:
                                                    Colors.orange,
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
                                                      onPress: () => showDialog<
                                                              String>(
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              AlertDialog(
                                                                content:
                                                                    SizedBox(
                                                                  height:
                                                                      mediaQuery
                                                                          .size
                                                                          .height,
                                                                  //width: mediaQuery.size.width,
                                                                  child: Column(
                                                                    // crossAxisAlignment:
                                                                    //     CrossAxisAlignment
                                                                    //         .start,
                                                                    children: [
                                                                      Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.end,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        children: [
                                                                          CancelButton(),
                                                                        ],
                                                                      ),
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Image.asset(
                                                                              Assets.check_success_outline,
                                                                              height: 40,
                                                                              width: 40,
                                                                            ),
                                                                            Text("Transaction Successful",
                                                                                textScaleFactor: 1,
                                                                                style: TextStyle(color: deepGreen, fontWeight: FontWeight.w600)),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Button(
                                                                          text:
                                                                              "Transaction Receipt",
                                                                          onPress:
                                                                              () {},
                                                                          color:
                                                                              appPrimaryColor,
                                                                          width:
                                                                              300,
                                                                          textColor:
                                                                              whiteColor,
                                                                          isLoading:
                                                                              false),
                                                                      const SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      const ReceiptContainer(
                                                                        transactionDate:
                                                                            '12/06/2022',
                                                                        transactionType:
                                                                            'Local Transfer',
                                                                        sender:
                                                                            'Malik Johnson',
                                                                        beneficiary:
                                                                            'Ijeoma Uduma',
                                                                        beneficiaryBank:
                                                                            'Union Bank',
                                                                        beneficiaryAccount:
                                                                            '00213456787',
                                                                        amount:
                                                                            '₦2000.00',
                                                                      ),
                                                                      Container(
                                                                        padding:
                                                                            EdgeInsets.symmetric(horizontal: 10),
                                                                        margin: EdgeInsets.only(
                                                                            top:
                                                                                15,
                                                                            bottom:
                                                                                20),
                                                                        height:
                                                                            80,
                                                                        width: mediaQuery.size.width *
                                                                            0.8,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.all(
                                                                              Radius.circular(4),
                                                                            ),
                                                                            border: Border.all(),
                                                                            color: appPrimaryColor),
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            RichText(
                                                                              textAlign: TextAlign.start,
                                                                              text: const TextSpan(
                                                                                text: "For any complaint or assistance\ncontact our",
                                                                                style: TextStyle(color: whiteColor, fontSize: 12),
                                                                                children: <TextSpan>[
                                                                                  TextSpan(
                                                                                    text: "\" customer support\" ",
                                                                                    style: TextStyle(
                                                                                      fontSize: 12,
                                                                                      color: secondaryColor,
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                                    //recognizer: _longPressRecognizer,
                                                                                  ),

                                                                                  //recognizer: _longPressRecognizer,
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Expanded(
                                                                            child: Button(
                                                                                text: "Download",
                                                                                onPress: () => showDialog<String>(
                                                                                      context: context,
                                                                                      builder: (BuildContext context) => AlertDialog(
                                                                                        content: SizedBox(
                                                                                          height: mediaQuery.size.height * 0.4,
                                                                                          child: Column(
                                                                                            children: [
                                                                                              Row(
                                                                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                                                children: [
                                                                                                  CancelButton(),
                                                                                                ],
                                                                                              ),
                                                                                              Align(
                                                                                                alignment: Alignment.center,
                                                                                                child: Column(
                                                                                                  children: [
                                                                                                    Image.asset(
                                                                                                      Assets.check_success_outline,
                                                                                                      height: 40,
                                                                                                      width: 40,
                                                                                                    ),
                                                                                                    const SizedBox(
                                                                                                      height: 10,
                                                                                                    ),
                                                                                                    Text("Receipt saved", textScaleFactor: 1, style: TextStyle(color: deepGreen, fontWeight: FontWeight.w600)),
                                                                                                    const SizedBox(
                                                                                                      height: 30,
                                                                                                    ),
                                                                                                    Button(text: "Back to wallet", onPress: () {}, color: appPrimaryColor, width: 121, textColor: whiteColor, isLoading: false),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                              const SizedBox(
                                                                                                height: 10,
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                color: appPrimaryColor,
                                                                                width: 120,
                                                                                textColor: whiteColor,
                                                                                isLoading: false),
                                                                          ),
                                                                          const SizedBox(
                                                                            width:
                                                                                15,
                                                                          ),
                                                                          Expanded(
                                                                            child: Button(
                                                                                text: "Share",
                                                                                onPress: () {},
                                                                                color: whiteColor,
                                                                                width: 120,
                                                                                textColor: appPrimaryColor,
                                                                                isLoading: false),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              )),
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
                                                        textColor:
                                                            appPrimaryColor,
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

                        //Divider()
                      ]),
                      ListView(
                        physics: ScrollPhysics(),
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
                                const Text("Select Destination Bank",
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
                                        value: _banks,
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
                                            _banks = newValue!;
                                          });
                                        },
                                        items: banks.map((String value) {
                                          return DropdownMenuItem(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    )),
                                const SizedBox(height: 5.0),
                                _isButtonPress && _banks == "Select Bank"
                                    ? const Text(
                                        " Choose Destination Account",
                                        textScaleFactor: 0.9,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      )
                                    : Container(),
                                const SizedBox(height: 20.0),
                                InputField(
                                  key: const Key('destinationAccount'),
                                  textController: _nubanController,
                                  keyboardType: TextInputType.phone,
                                  node: _nubanNode,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  obscureText: false,
                                  text: 'Enter Destination Account',
                                  textColor: grayColor,
                                  hintText: 'Account Number',
                                  textHeight: 5.0,
                                  borderColor: appPrimaryColor.withOpacity(0.9),
                                  validator: (value) {
                                    if (value!.trim().length == 16) {
                                      return null;
                                    }
                                    return "Enter a accounnt number";
                                  },
                                  onSaved: (value) {
                                    _nuban = value!.trim();
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 25.0),
                                InputField(
                                  key: const Key('Account destination'),
                                  //textController: _walletControler,
                                  //node: _amountNode,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  obscureText: false,
                                  text: 'Account Name',
                                  textColor: grayColor,
                                  hintText: 'john doe',
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
                                                //    Assets.check_success_outline),
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

                                                const SizedBox(
                                                  height: 30,
                                                ),
                                                Text(
                                                  "Enter 4-digit PIN",
                                                  textScaleFactor: 1.1,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600),
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

                                                const SizedBox(
                                                  height: 30,
                                                ),

                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Button(
                                                        text: 'Continue',
                                                        onPress: () {
                                                          Navigator.of(context)
                                                              .pushNamed(
                                                                  WalletScreen
                                                                      .id);
                                                        },
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
                                                          textColor:
                                                              appPrimaryColor,
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
                        ],
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class ReceiptContainer extends StatelessWidget {
  final String transactionDate;
  final String transactionType;
  final String sender;
  final String beneficiary;
  final String beneficiaryBank;
  final String beneficiaryAccount;
  final String amount;

  const ReceiptContainer({
    Key? key,
    required this.transactionDate,
    required this.transactionType,
    required this.sender,
    required this.beneficiary,
    required this.beneficiaryBank,
    required this.beneficiaryAccount,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Transaction Date :",
                  textScaleFactor: 0.8,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Text(
                transactionDate,
                style: TextStyle(fontSize: 12),
              )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Transaction Type :",
                  textScaleFactor: 0.8,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Text(
                transactionType,
                style: TextStyle(fontSize: 12),
              )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Sender :",
                  textScaleFactor: 0.8,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Text(
                sender,
                style: TextStyle(fontSize: 12),
              )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Beneficiary :",
                  textScaleFactor: 0.8,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Text(
                beneficiary,
                style: TextStyle(fontSize: 12),
              )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Beneficiary Bank :",
                  textScaleFactor: 0.8,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Text(
                beneficiaryBank,
                style: TextStyle(fontSize: 12),
              )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Beneficiary Account :",
                  textScaleFactor: 0.8,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Text(
                beneficiaryAccount,
                style: TextStyle(fontSize: 12),
              )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Amount :",
                  textScaleFactor: 0.8,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Text(
                amount,
                style: TextStyle(fontSize: 12),
              )),
            ],
          ),
        ],
      ),
    );
  }
}

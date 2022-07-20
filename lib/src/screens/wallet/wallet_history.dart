import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/src/screens/wallet/all_cards.dart';
import 'package:trakk/src/screens/wallet/buy_airtime.dart';
import 'package:trakk/src/screens/wallet/fund_wallet.dart';
import 'package:trakk/src/screens/wallet/payments.dart';
import 'package:trakk/src/screens/wallet/transfers.dart';

import 'dart:math' as math;
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/widgets/back_icon.dart';
import 'package:trakk/src/widgets/icon_container.dart';
import 'package:trakk/src/widgets/input_field.dart';

class WalletHistory extends StatefulWidget {
  static const String id = "walletHistory";

  const WalletHistory({Key? key}) : super(key: key);

  @override
  _WalletHistoryState createState() => _WalletHistoryState();
}

class _WalletHistoryState extends State<WalletHistory> {
  bool shouldRepaint(CustomPainter oldDelegate) => false;

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
    var date = DateTime.parse(value);
    var formattedDate = "${date.day}-${date.month}-${date.year}";
    return formattedDate;

    // print(formattedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.2),
                  alignment: Alignment.center,
                  child: const Text(
                    'TRAKK WALLET',
                    style: TextStyle(
                        color: appPrimaryColor,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30.0),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20.0),
                    height: 180,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'My Trakk Balance',
                                  textScaleFactor: 1.3,
                                  style: TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  '₦30,000.00',
                                  textScaleFactor: 1.9,
                                  style: TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  margin: const EdgeInsets.only(bottom: 5.0),
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image.asset(
                                    'assets/images/hide_icon.png',
                                    height: 30,
                                    width: 30,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0XFFBDBDBD),
                                        offset: Offset(0.0, 1.0), //(x,y)
                                        blurRadius: 2.0,
                                      ),
                                    ],
                                  ),
                                ),
                                const Text(
                                  'Hide Balance',
                                  textScaleFactor: 0.5,
                                  style: TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 30.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Zebbra wallet balance',
                              textScaleFactor: 0.9,
                              style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              '₦1,100,000.00',
                              textScaleFactor: 1.3,
                              style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: InputField(
                            obscureText: false,
                            text: 'Select Date',
                            hintText: '24/3/2022',
                            textHeight: 5.0,
                            node: _pickUpDateNode,
                            textController: _pickUpDateController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            borderColor: appPrimaryColor.withOpacity(0.5),
                            area: null,
                            suffixIcon: IconButton(
                              onPressed: () {
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime(2022, 3, 5),
                                    maxTime: DateTime(2100, 6, 7),
                                    theme: const DatePickerTheme(
                                      headerColor: appPrimaryColor,
                                      backgroundColor: whiteColor,
                                      itemStyle: TextStyle(
                                        color: appPrimaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                      doneStyle: TextStyle(
                                        color: secondaryColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      cancelStyle: TextStyle(
                                        color: secondaryColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ), onChanged: (date) {
                                  print('change $date in time zone ' +
                                      date.timeZoneOffset.inHours.toString());
                                  print(date);
                                  print(_parseDate(date.toString()));
                                }, onConfirm: (date) {
                                  _pickUpDateController.text =
                                      _parseDate(date.toString());
                                  print('confirm $date');
                                  print(_parseDate(date.toString()));
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.en);
                              },
                              icon: const Icon(
                                Remix.calendar_2_fill,
                                size: 22.0,
                                color: secondaryColor,
                              ),
                            ),
                            validator: (value) {
                              if (value!.trim().length > 6) {
                                return null;
                              }
                              return "Enter a valid date";
                            },
                            onSaved: (value) {
                              _pickUpDate = value!.trim();
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        const Padding(
                          padding: EdgeInsets.only(top: 17),
                          child: Text(
                            'To',
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: InputField(
                            obscureText: false,
                            text: '',
                            hintText: '26/3/2022',
                            textHeight: 5.0,
                            node: _dropOffDateNode,
                            textController: _dropOffDateController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            borderColor: appPrimaryColor.withOpacity(0.5),
                            area: null,
                            suffixIcon: IconButton(
                              onPressed: () {
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime(2022, 3, 5),
                                    maxTime: DateTime(2100, 6, 7),
                                    theme: const DatePickerTheme(
                                      headerColor: appPrimaryColor,
                                      backgroundColor: whiteColor,
                                      itemStyle: TextStyle(
                                        color: appPrimaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                      doneStyle: TextStyle(
                                        color: secondaryColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      cancelStyle: TextStyle(
                                        color: secondaryColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ), onChanged: (date) {
                                  print('change $date in time zone ' +
                                      date.timeZoneOffset.inHours.toString());
                                }, onConfirm: (date) {
                                  print('confirm $date');
                                  _dropOffDateController.text =
                                      _parseDate(date.toString());
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.en);
                              },
                              icon: const Icon(
                                Remix.calendar_2_fill,
                                size: 22.0,
                                color: secondaryColor,
                              ),
                            ),
                            validator: (value) {
                              if (value!.trim().length > 6) {
                                return null;
                              }
                              return "Enter a valid date";
                            },
                            onSaved: (value) {
                              _dropOffDate = value!.trim();
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(30),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                        color: whiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 230, 230, 230),
                            spreadRadius: 1,
                            offset: Offset(2.0, 2.0), //(x,y)
                            blurRadius: 8.0,
                          ),
                        ]),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => const Divider(
                        thickness: 1,
                        color: Color(0xff909090),
                      ),
                      itemCount: 5,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Stack(children: [
                            Container(
                              height: 110,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset('assets/images/bike.png'),

                                  const Text(
                                    'Delivery to\nMaryland',
                                    style: TextStyle(),
                                  ),

                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        '₦2000',
                                        textScaleFactor: 1.4,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        'Nov 21',
                                        style: TextStyle(),
                                      ),
                                    ],
                                  ),

                                  // Text("Index $index"),
                                ],
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

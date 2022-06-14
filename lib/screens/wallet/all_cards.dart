import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/screens/wallet/fund_wallet.dart';
import 'package:trakk/screens/wallet/wallet.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/back_icon.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/widgets/cancel_button.dart';
import 'package:trakk/widgets/icon_container.dart';
import 'package:trakk/widgets/input_field.dart';

class AllCards extends StatefulWidget {
  static const String id = "allCards";

  const AllCards({Key? key}) : super(key: key);

  @override
  _AllCardsState createState() => _AllCardsState();
}

class _AllCardsState extends State<AllCards> {
  String _wallets = 'Select wallet';
  int geee = 2;
  String _cards = "XXXX-XXXX-2356";

  var cards = [
    "XXXX-XXXX-2356",
    "XXXX-XXXX-0863",
    "XXXX-XXXX-7552",
    "XXXX-XXXX-2535",
    "Add new card",
  ];

  var wallets = [
    "Select wallet",
    "Trakk wallet",
    "Zebrra wallet",
  ];

  String? _card;
  String? _wallet;
  String? _amount;
  int? _cardNumber;

  late TextEditingController _walletControler;
  late TextEditingController _amountController;

  FocusNode? _walletNode;
  FocusNode? _amountNode;

  @override
  void initState() {
    super.initState();
    _walletControler = TextEditingController();
    _amountController = TextEditingController();
    // _kinAddressController = TextEditingController();
    // _kinPhoneNumberController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
                  'PAYMENTS',
                  style: TextStyle(
                      color: appPrimaryColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Column(
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: Text(
                  "Secure and manage all your cards\nconnected to Trakk",
                  textScaleFactor: 1,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              width: mediaQuery.size.width,
              margin: EdgeInsets.only(top: 50),
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              //left: 30, right: 30, top: 30, bottom: 10
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      topLeft: Radius.circular(60)),
                  color: whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 230, 230, 230),
                      spreadRadius: 1,
                      offset: Offset(2.0, 2.0), //(x,y)
                      blurRadius: 8.0,
                    ),
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "My Debit Card",textScaleFactor: 1.2,
                                                  style: TextStyle(
                                                      //fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500)
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    'assets/images/zebrraCard.png',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 7.0, right: 7),
                    child: Column(
                      children: [
                        Button(
                            text: "Add A New Card",
                            onPress: () => showDialog<String>(
                                  // barrierDismissible: true,
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        backgroundColor:      Color.fromARGB(255, 231, 226, 202),
                                    // title: const Text('AlertDialog Title'),
                                    // contentPadding:
                                    //     const EdgeInsets
                                    //             .symmetric(
                                    //         horizontal: 50.0,
                                    //         vertical: 50.0),
                                    content: Expanded(
                                      child: Container(
                                       
                                        height: mediaQuery.size.height,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 0,
                                            right: 0,
                                            top: 0,
                                            bottom: 0,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text("Choose your card",
                                                  textScaleFactor: 1.2,
                                                  style: TextStyle(
                                                      //fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              const SizedBox(
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0), //border raiuds of dropdown button
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10.0),
                                                    child:
                                                        DropdownButton<String>(
                                                      value: _cards.toString(),
                                                      icon: const Icon(Remix
                                                          .arrow_down_s_line),
                                                      elevation: 16,
                                                      isExpanded: true,
                                                      style: TextStyle(
                                                        color: appPrimaryColor
                                                            .withOpacity(0.8),
                                                        fontSize: 18.0,
                                                      ),
                                                      underline:
                                                          Container(), //empty line
                                                      onChanged:
                                                          (String? newValue) {
                                                        setState(() {
                                                          _cards = newValue!;
                                                        });
                                                      },
                                                      items: cards
                                                          .map((String value) {
                                                        return DropdownMenuItem(
                                                          value: value,
                                                          child: Text(value),
                                                        );
                                                      }).toList(),
                                                    ),
                                                  )),
                                              const SizedBox(height: 20.0),
                                              const Text(
                                                  "Fill in your card details",
                                                  textScaleFactor: 1.2,
                                                  style: TextStyle(
                                                      //fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              const SizedBox(height: 15.0),
                                              InputField(
                                                key: const Key('name'),
                                                textController:
                                                    _walletControler,
                                                node: _amountNode,
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                obscureText: false,
                                                text: 'Card holder\'s name',
                                                hintText: 'Name',
                                                textHeight: 10.0,
                                                borderColor: appPrimaryColor
                                                    .withOpacity(0.9),
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
                                                  _card = value!.trim();
                                                  return null;
                                                },
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              InputField(
                                                key: const Key('Card number'),
                                                textController:
                                                    _amountController,
                                                keyboardType:
                                                    TextInputType.phone,
                                                node: _amountNode,
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                obscureText: false,
                                                text: 'Card number',
                                                hintText: '0000-0000-0000-0000',
                                                textHeight: 10.0,
                                                borderColor: appPrimaryColor
                                                    .withOpacity(0.9),

                                                // validator: (value) {
                                                //   if (value!.trim().length == 11) {
                                                //     return null;
                                                //   }
                                                //   return "Enter a valid phone number";
                                                // },
                                                onSaved: (value) {
                                                  _cardNumber =
                                                      value!.trim() as int?;
                                                  return null;
                                                },
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: InputField(
                                                      key: const Key(
                                                          'Expirydate'),
                                                      // textController: _firstNameController,
                                                      // node: _firstNameNode,
                                                      autovalidateMode:
                                                          AutovalidateMode
                                                              .onUserInteraction,
                                                      obscureText: false,
                                                      text: 'Expiry date',
                                                      hintText: 'mm/yy',
                                                      textHeight: 10.0,
                                                      borderColor:
                                                          appPrimaryColor
                                                              .withOpacity(0.9),

                                                      validator: (value) {
                                                        if (value!
                                                                .trim()
                                                                .length >
                                                            2) {
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
                                                      autovalidateMode:
                                                          AutovalidateMode
                                                              .onUserInteraction,
                                                      obscureText: false,
                                                      text: '',
                                                      hintText: 'cvv',
                                                      textHeight: 10.0,
                                                      borderColor:
                                                          appPrimaryColor
                                                              .withOpacity(0.9),

                                                      validator: (value) {
                                                        if (value!
                                                                .trim()
                                                                .length >
                                                            2) {
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
                                              
                                              Button(
                                                  text: "Add",
                                                  onPress: () {},
                                                  color: appPrimaryColor,
                                                  width: 308,
                                                  textColor: whiteColor,
                                                  isLoading: false),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            color: appPrimaryColor,
                            width: mediaQuery.size.width * 0.9,
                            textColor: whiteColor,
                            isLoading: false),
                            const SizedBox(height: 20,),
                            Button(text: "Cancel", onPress: (){}, color: whiteColor, width: mediaQuery.size.width * 0.9, 
                            textColor: appPrimaryColor, isLoading: false),
                       
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),

      // body: SafeArea(
      //   child: SingleChildScrollView(
      //     child: Column(
      //       children: [
      //         Row(
      //           children: [
      //             BackIcon(
      //               onPress: () {
      //                 Navigator.pop(context);
      //               },
      //             ),
      //             Container(
      //               margin: const EdgeInsets.only(left: 40.0),
      //               alignment: Alignment.center,
      //               child: const Text(
      //                 'PAYMENTS',
      //                 style: TextStyle(
      //                   color: appPrimaryColor,
      //                   fontSize: 20.0,
      //                   fontWeight: FontWeight.bold
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),

      //

      //        //r Expanded(child: Divider(),),
      //         Container(
      //           child: Column(children: [
      //           Container(child: Text("Hello"))
      //         ],))

      //       ]
      //     ),
      //   ),
      // )
    );
  }
}

class TodoModel {
  get taskList => null;
}

import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/mixins/customer_order_helper.dart';
import 'package:trakk/models/order/order.dart';
import 'package:trakk/screens/dispatch/pay_with_transfer.dart';
import 'package:trakk/screens/wallet/wallet.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/utils/constant.dart';
import 'package:trakk/utils/helper_utils.dart';
import 'package:trakk/utils/padding.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/widgets/expandable_item.dart';
import 'package:trakk/widgets/header.dart';
import 'package:trakk/widgets/input_field.dart';

class Payment extends StatefulWidget {
  static const String id = 'payment';

  const Payment({Key? key}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

// This is the private State class that goes with MyStatefulWidget.

class _PaymentState extends State<Payment> with CustomerOrderHelper {
  final _formKey = GlobalKey<FormState>();

  bool isVisible = false;
  bool isVisible1 = false;

  final List<Item> _data = generateItems(8);

  late PageController _paymentViewController;

  late TextEditingController _nameController;
  late TextEditingController _cardNumberController;
  late TextEditingController _walletControler;
  late TextEditingController _amountController;

  FocusNode? _nameNode;
  FocusNode? _cardNumberNode;
  FocusNode? _amountNode;

  String? _name;
  String? _card;
  int? _cardNumber;
  int? _amount;
  String _cards = "XXXX-XXXX-2356";

  var cards = [
    "XXXX-XXXX-2356",
    "XXXX-XXXX-0863",
    "XXXX-XXXX-7552",
    "XXXX-XXXX-2535",
    "Add new card",
  ];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _cardNumberController = TextEditingController();
    _walletControler = TextEditingController();
    _amountController = TextEditingController();
    _paymentViewController = PageController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _paymentViewController.jumpToPage(2);
    });
    // _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _cardNumberController.dispose();
    _walletControler.dispose();
    _amountController.dispose();
    _paymentViewController.dispose();
  }

  final List paymentMethods = [
    'Debit Cards',
    'bank transfer',
    'wallet',
    'Zebrra',
    'Pay on delivery',
  ];
  int radioValue = 3;

  void _handleRadioValueChanged(value) {
    setState(() {
      radioValue = value;
      print(radioValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    MediaQueryData mediaQuery = MediaQuery.of(context);
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    OrderModel orderModel = OrderModel.fromJson(arg["orderModel"]);

    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
          child: Column(
        children: [
          const SizedBox(height: 30.0),
          const Header(
            text: 'PAYMENT',
          ),

          const SizedBox(height: 30.0),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kDefaultLayoutPadding, vertical: 12),
            child: Text(
              'Choose preferred payment method',
              style: theme.textTheme.subtitle1!.copyWith(
                color: appPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          34.heightInPixel(),
          // Column(
          //   children: paymentMethods.map<RadioListTile>((method) => {
          //   return Card()
          // })
          // )
          AbsorbPointer(
            child: Opacity(
              opacity: 0.5,
              child: PaymentButton(
                child: RadioListTile(
                    activeColor: appPrimaryColor,
                    title: const Text("Pay with zebrra card and get 20% off"),
                    value: 0,
                    groupValue: radioValue,
                    onChanged: (dynamic value1) {
                      setState(() {
                        radioValue = value1;
                        _paymentViewController.jumpToPage(0);
                        //isVisible = true;
                        print(radioValue);
                      });
                    }),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          AbsorbPointer(
            child: Opacity(
              opacity: 0.5,
              child: PaymentButton(
                child: RadioListTile(
                    activeColor: appPrimaryColor,
                    title: const Text("Pay with transfer"),
                    value: 1,
                    groupValue: radioValue,
                    onChanged: (value) {
                      Navigator.of(context).pushNamed(PayWithTransfer.id);
                    }),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          AbsorbPointer(
            child: Opacity(
              opacity: 0.5,
              child: PaymentButton(
                child: RadioListTile(
                    activeColor: appPrimaryColor,
                    title: const Text("Pay with your card"),
                    value: 2,
                    groupValue: radioValue,
                    onChanged: (dynamic value) {
                      setState(() {
                        radioValue = value;
                        _paymentViewController.jumpToPage(1);
                        print(radioValue);
                      });
                    }),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          PaymentButton(
            child: RadioListTile(
                activeColor: appPrimaryColor,
                title: const Text("Pay on delivery"),
                value: 3,
                groupValue: radioValue,
                onChanged: (dynamic value1) {
                  setState(() {
                    radioValue = value1;
                    _paymentViewController.jumpToPage(2);
                    //isVisible = true;
                    print(radioValue);
                  });
                }),
          ),
          const SizedBox(
            height: 15,
          ),
          AbsorbPointer(
            child: Opacity(
              opacity: 0.5,
              child: PaymentButton(
                child: RadioListTile(
                    activeColor: appPrimaryColor,
                    title: const Text("Pay with wallet"),
                    value: 4,
                    groupValue: radioValue,
                    onChanged: (dynamic value1) {
                      setState(() {
                        radioValue = value1;
                        _paymentViewController.jumpToPage(3);
                        //isVisible = true;
                        print(radioValue);
                      });
                    }),
              ),
            ),
          ),

          const SizedBox(height: 10.0),

          SizedBox(
            height: mediaQuery.size.height,
            child: PageView(
              controller: _paymentViewController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Visibility(
                  //visible: true,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Container(
                          color: Color.fromARGB(255, 231, 226, 202),
                          height: 350,
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
                                const Text("Fill in your card details",
                                    textScaleFactor: 1.3,
                                    style: TextStyle(
                                        //fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                                const SizedBox(
                                  height: 20,
                                ),

                                InputField(
                                  key: const Key('name'),
                                  textController: _nameController,
                                  node: _nameNode,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  obscureText: false,
                                  text: 'Card holder\'s name',
                                  hintText: 'Name',
                                  textHeight: 10.0,
                                  borderColor: appPrimaryColor.withOpacity(0.9),
                                  validator: (value) {
                                    if (value!.trim().length > 2) {
                                      return null;
                                    }
                                    return "Enter a valid name";
                                  },
                                  onSaved: (value) {
                                    _name = value!.trim();
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20.0),
                                //
                                InputField(
                                  key: const Key('cardNumber'),
                                  textController: _cardNumberController,
                                  keyboardType: TextInputType.phone,
                                  node: _cardNumberNode,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  obscureText: false,
                                  text: 'Card number',
                                  hintText: '0000-0000-0000-0000',
                                  textHeight: 5.0,
                                  borderColor: appPrimaryColor.withOpacity(0.9),
                                  validator: (value) {
                                    if (value!.trim().length == 16) {
                                      return null;
                                    }
                                    return "Enter a valid card number";
                                  },
                                  onSaved: (value) {
                                    _cardNumber = value!.trim() as int?;
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
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
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        obscureText: false,
                                        text: 'Expiry date',
                                        hintText: 'mm/yy',
                                        textHeight: 10.0,
                                        borderColor:
                                            appPrimaryColor.withOpacity(0.9),

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
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        obscureText: false,
                                        text: '',
                                        hintText: 'cvv',
                                        textHeight: 10.0,
                                        borderColor:
                                            appPrimaryColor.withOpacity(0.9),

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
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    "AMOUNT:",
                                    textScaleFactor: 1.3,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "₦2000",
                                    textScaleFactor: 1.3,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    "Zebrra 20% off:",
                                    textScaleFactor: 1.3,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "1600",
                                    textScaleFactor: 1.3,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        Button(
                          text: 'Pay',
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
                                height: mediaQuery.size.height * 0.6,
                                child: Column(children: [
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
                                      "Payment successful",
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
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 15),
                                      height: mediaQuery.size.height * 0.2,
                                      decoration: const BoxDecoration(
                                        color: Color(0xffCA9E04),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text("Your delivery code is"),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "ID: #00556",
                                                textScaleFactor: 1,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Row(
                                                children: const [
                                                  Icon(Remix.file_copy_line),
                                                  Text(
                                                    "Copy",
                                                    textScaleFactor: 1,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: const [
                                                  Icon(Remix.share_line),
                                                  Text(
                                                    "Share",
                                                    textScaleFactor: 1,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  const SizedBox(height: 10.0),
                                  Button(
                                    text: 'Track item',
                                    onPress: () {
                                      Navigator.of(context)
                                          .pushNamed(WalletScreen.id);
                                    },
                                    color: appPrimaryColor,
                                    textColor: whiteColor,
                                    isLoading: false,
                                    width:
                                        MediaQuery.of(context).size.width / 1.3,
                                  ),
                                  Button(
                                    text: 'Cancel',
                                    onPress: () {
                                      Navigator.pop(context);
                                    },
                                    color: whiteColor,
                                    textColor: appPrimaryColor,
                                    isLoading: false,
                                    width:
                                        MediaQuery.of(context).size.width / 1.3,
                                  ),
                                ]),
                              ),
                            ),
                          ),
                          color: appPrimaryColor,
                          textColor: whiteColor,
                          isLoading: false,
                          width: MediaQuery.of(context).size.width / 1.2,
                        ),
                      ],
                    ),
                  ),
                ),
                //Pay with card
                Visibility(
                  //visible: false,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          color: Color.fromARGB(255, 231, 226, 202),
                          height: 470,
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
                                        width: 0.3),
                                    //border of dropdown button
                                    borderRadius: BorderRadius.circular(
                                        5.0), //border raiuds of dropdown button
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: DropdownButton<String>(
                                      value: _cards.toString(),
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
                                          _cards = newValue!;
                                        });
                                      },
                                      items: cards.map((String value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
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
                                textController: _walletControler,
                                node: _amountNode,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                obscureText: false,
                                text: 'Card holder\'s name',
                                hintText: 'Name',
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
                                  _card = value!.trim();
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              InputField(
                                key: const Key('Card number'),
                                textController: _cardNumberController,
                                keyboardType: TextInputType.phone,
                                node: _amountNode,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                obscureText: false,
                                text: 'Card number',
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
                                  _cardNumber = value!.trim() as int?;
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
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      obscureText: false,
                                      text: 'Expiry date',
                                      hintText: 'mm/yy',
                                      textHeight: 10.0,
                                      borderColor:
                                          appPrimaryColor.withOpacity(0.9),

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
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      obscureText: false,
                                      text: '',
                                      hintText: 'cvv',
                                      textHeight: 10.0,
                                      borderColor:
                                          appPrimaryColor.withOpacity(0.9),

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
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Amount:",
                                textScaleFactor: 1.3,
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Text("₦2000",
                                  textScaleFactor: 1.3,
                                  style:
                                      TextStyle(fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Button(
                            text: "Pay",
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
                                      height: mediaQuery.size.height * 0.6,
                                      child: Column(children: [
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
                                            "Payment successful",
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
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 15),
                                            height:
                                                mediaQuery.size.height * 0.2,
                                            decoration: const BoxDecoration(
                                              color: Color(0xffCA9E04),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text(
                                                    "Your delivery code is"),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      "ID: #00556",
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Row(
                                                      children: const [
                                                        Icon(Remix
                                                            .file_copy_line),
                                                        Text(
                                                          "Copy",
                                                          textScaleFactor: 1,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: const [
                                                        Icon(Remix.share_line),
                                                        Text(
                                                          "Share",
                                                          textScaleFactor: 1,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )),
                                        const SizedBox(
                                          height: 14,
                                        ),
                                        const SizedBox(height: 10.0),
                                        Button(
                                          text: 'Track item',
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
                                        Button(
                                          text: 'Cancel',
                                          onPress: () {
                                            Navigator.pop(context);
                                          },
                                          color: whiteColor,
                                          textColor: appPrimaryColor,
                                          isLoading: false,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.3,
                                        ),
                                      ]),
                                    ),
                                  ),
                                ),
                            color: appPrimaryColor,
                            width: 308,
                            textColor: whiteColor,
                            isLoading: false),
                      ],
                    ),
                  ),
                ),
                //Pay on delivery
                Visibility(
                    //visible: false,
                    child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Pay once item is received",
                          textScaleFactor: 1.3,
                          style: TextStyle(fontWeight: FontWeight.w700)),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 300,
                        foregroundDecoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/images/payOnDeliveryFor.png"),
                          ),
                        ),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image:
                                AssetImage("assets/images/payOnDelivery.png"),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Amount:",
                              textScaleFactor: 1.3,
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            Text(
                                "$naira${formatMoney(orderModel.data?.totalAmount ?? 0.0)}",
                                textScaleFactor: 1.3,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Button(
                          text: "Order and trakk delivery",
                          onPress: () {
                            doCreateOrder(
                                orderModel,
                                () => setState(() => _isLoading = true),
                                () => setState(() => _isLoading = false));
                          },
                          color: appPrimaryColor,
                          width: 308,
                          textColor: whiteColor,
                          isLoading: _isLoading),
                    ],
                  ),
                )),

                //Pay with wallet
                Visibility(
                  //visible: true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "Input your wallet PIN",
                          textScaleFactor: 1.3,
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
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Amount:",
                                textScaleFactor: 1.3,
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              Text("₦2000",
                                  textScaleFactor: 1.3,
                                  style:
                                      TextStyle(fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Button(
                            text: "Pay",
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
                                      height: mediaQuery.size.height * 0.6,
                                      child: Column(children: [
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
                                            "Payment successful",
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
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 15),
                                            height:
                                                mediaQuery.size.height * 0.2,
                                            decoration: const BoxDecoration(
                                              color: Color(0xffCA9E04),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text(
                                                    "Your delivery code is"),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      "ID: #00556",
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Row(
                                                      children: const [
                                                        Icon(Remix
                                                            .file_copy_line),
                                                        Text(
                                                          "Copy",
                                                          textScaleFactor: 1,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: const [
                                                        Icon(Remix.share_line),
                                                        Text(
                                                          "Share",
                                                          textScaleFactor: 1,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )),
                                        const SizedBox(
                                          height: 14,
                                        ),
                                        const SizedBox(height: 10.0),
                                        Button(
                                          text: 'Track item',
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
                                        Button(
                                          text: 'Cancel',
                                          onPress: () {
                                            Navigator.pop(context);
                                          },
                                          color: whiteColor,
                                          textColor: appPrimaryColor,
                                          isLoading: false,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.3,
                                        ),
                                      ]),
                                    ),
                                  ),
                                ),
                            color: appPrimaryColor,
                            width: 308,
                            textColor: whiteColor,
                            isLoading: false),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    ));
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return const Card(
              child: ListTile(
                leading: FlutterLogo(),
                title: Text('One-line with leading widget'),
              ),
            );
            // return ListTile(
            //   title: Text(item.headerValue),
            // );
          },
          body: ListTile(
              title: Text(item.expandedValue),
              subtitle:
                  const Text('To delete this panel, tap the trash can icon'),
              trailing: const Icon(Icons.delete),
              onTap: () {
                setState(() {
                  _data.removeWhere((Item currentItem) => item == currentItem);
                });
              }),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}

class PaymentButton extends StatelessWidget {
  final Widget child;

  const PaymentButton({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kDefaultLayoutPadding),
      height: 50,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: grayColor),
        color: whiteColor,
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: child,
    );
  }
}

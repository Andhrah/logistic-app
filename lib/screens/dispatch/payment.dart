import 'package:flutter/material.dart';
import 'package:trakk/models/payment_method.dart';
import 'package:trakk/screens/dispatch/dispatch_summary.dart';
import 'package:trakk/screens/dispatch/pay_with_transfer.dart';
import 'package:trakk/screens/wallet/wallet.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/widgets/cancel_button.dart';
import 'package:trakk/widgets/expandable_item.dart';
import 'package:trakk/widgets/header.dart';
import 'package:trakk/widgets/input_field.dart';
import 'package:remixicon/remixicon.dart';

// This is the stateful widget that the main application instantiates.
class Payment extends StatefulWidget {
  static const String id = 'payment';

  const Payment({Key? key}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

// This is the private State class that goes with MyStatefulWidget.

class _PaymentState extends State<Payment> {
  final _formKey = GlobalKey<FormState>();

  bool isVisible = false;
  bool isVisible1 = false;

  final List<Item> _data = generateItems(8);

  late TextEditingController _nameController;
  late TextEditingController _cardNumberController;

  FocusNode? _nameNode;
  FocusNode? _cardNumberNode;

  String? _name;
  int? _cardNumber;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _cardNumberController = TextEditingController();

    // _confirmPasswordController = TextEditingController();
  }

  final List paymentMethods = [
    'Debit Cards',
    'bank transfer',
    'wallet',
    'Zebrra',
    'Pay on delivery',
  ];
  int radioValue = -1;

  void _handleRadioValueChanged(value) {
    setState(() {
      radioValue = value;
      print(radioValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
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

          // Column(
          //   children: paymentMethods.map<RadioListTile>((method) => {
          //   return Card()
          // })
          // )
          PaymentButton(
            child: RadioListTile(
                activeColor: appPrimaryColor,
                title: const Text("Pay with zebrra card and get 20% off"),
                value: 0,
                groupValue: radioValue,
                onChanged: (dynamic value1) {
                  setState(() {
                    radioValue = value1;
                    isVisible = true;
                    print(radioValue);
                  });
                }),
          ),
          const SizedBox(
            height: 15,
          ),
          PaymentButton(
            child: RadioListTile(
                activeColor: appPrimaryColor,
                title: const Text("Pay with transfer"),
                value: 1,
                groupValue: radioValue,
                onChanged: (value){
                  Navigator.of(context).pushNamed(PayWithTransfer.id);
                }),
          ),
          const SizedBox(
            height: 15,
          ),
          PaymentButton(
            child: RadioListTile(
                activeColor: appPrimaryColor,
                title: const Text("Pay with your card"),
                value: 2,
                groupValue: radioValue,
                onChanged: _handleRadioValueChanged),
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
                onChanged: _handleRadioValueChanged),
          ),
          const SizedBox(
            height: 15,
          ),
          PaymentButton(
            child: RadioListTile(
                activeColor: appPrimaryColor,
                title: const Text("Pay with wallet"),
                value: 4,
                groupValue: radioValue,
                onChanged: _handleRadioValueChanged),
          ),

          const SizedBox(height: 10.0),
          Visibility(
            visible: true,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  borderColor: appPrimaryColor.withOpacity(0.9),

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
                                  borderColor: appPrimaryColor.withOpacity(0.9),

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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "AMOUNT:",
                              textScaleFactor: 1.3,
                              style: TextStyle(fontWeight: FontWeight.w600),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Zebrra 20% off:",
                              textScaleFactor: 1.3,
                              style: TextStyle(fontWeight: FontWeight.w600),
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
                                height: 400.0,
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
                                  const SizedBox(height: 20,),
                                  Container(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                      height: mediaQuery.size.height*0.2,
                                      decoration: const BoxDecoration(
                                        color: Color(0xffCA9E04),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,

                                        children: [
                                          const Text("Your delivery code is"),
                                          const SizedBox(height: 20,),
                                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text("ID: #00556",
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold
                                              ),
                                              ),
                                              Row(
                                                children: const [
                                                  Icon(Remix.file_copy_line),
                                                  Text("Copy",
                                                  textScaleFactor: 1,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold
                                              ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: const [
                                                  Icon(Remix.share_line),
                                                  Text("Share",
                                                  textScaleFactor: 1,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold
                                              ),),
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
                            )),
                    color: appPrimaryColor,
                    textColor: whiteColor,
                    isLoading: false,
                    width: MediaQuery.of(context).size.width / 1.2,
                  ),
                ],
              ),
            ),
          ),

          Visibility(visible: false, child: Text("data")),
          const SizedBox(height: 10.0),
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
      padding: const EdgeInsets.symmetric(horizontal: 0),
      height: 50,
      width: 300,
      decoration: BoxDecoration(
        border: Border.all(color: grayColor),
        color: whiteColor,
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: child,
    );
  }
}

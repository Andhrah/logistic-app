import 'package:flutter/material.dart';
import 'package:trakk/models/payment_method.dart';
import 'package:trakk/screens/dispatch/dispatch_summary.dart';
import 'package:trakk/screens/wallet/wallet.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/widgets/cancel_button.dart';
import 'package:trakk/widgets/expandable_item.dart';
import 'package:trakk/widgets/header.dart';
import 'package:trakk/widgets/input_field.dart';
import 'package:remixicon/remixicon.dart';

// This is the stateful widget that the main application instantiates.
class PayWithTransfer extends StatefulWidget {
  static const String id = 'payWithTransfer';

  const PayWithTransfer({Key? key}) : super(key: key);

  @override
  _PayWithTransferState createState() => _PayWithTransferState();
}

// This is the private State class that goes with MyStatefulWidget.

class _PayWithTransferState extends State<PayWithTransfer> {
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
    _makePayment();
    // _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
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

  bool _isLoading = true;

  void _makePayment() async {
    // setState(() {
    //   _isLoading = true;
    // });
    await Future.delayed(
      const Duration(seconds: 5),
    );
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Header(
              text: 'PAY WITH TRANSFER',
            ),
            _isLoading
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 80, horizontal: 30),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xffEEEEEE),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          height: 220,
                          width: 340,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CircularProgressIndicator(
                                color: Color(0xffCA9E0D),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Wait for 5 seconds to generate\naccount",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 16),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "05",
                                textScaleFactor: 1.4,
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40.0),
                        Button(
                            text: "Cancel",
                            onPress: () {},
                            color: whiteColor,
                            width: 300,
                            textColor: appPrimaryColor,
                            isLoading: false)
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        const Text(
                          "Transfer the sum of ₦20,000 to\nthe account below",
                          textScaleFactor: 1.3,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30.0),
                        Container(
                          color: Color(0xffEEEEEE),
                          height: mediaQuery.size.height*0.4,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 45),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 15),
                                  height: mediaQuery.size.height * 0.2,
                                  decoration: const BoxDecoration(
                                    color: Color(0xffCA9E04),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Zebrra Bank",
                                        textScaleFactor: 1.1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const Text(
                                        "0034587665",
                                        textScaleFactor: 1.3,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
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
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "This account expires in 30 mins",
                                  style: TextStyle(fontSize: 15),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "30",
                                  textScaleFactor: 1.3,
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        Button(
                          text: 'I have sent the money',
                          onPress: () {
                            setState(() {
                              
                            });
                          },
                          color: appPrimaryColor,
                          textColor: whiteColor,
                          isLoading: false,
                          width: MediaQuery.of(context).size.width / 1.2,
                        ),
                        const SizedBox(height: 30.0),
                        Button(
                            text: "Cancel",
                            onPress: () {},
                            color: whiteColor,
                            width: 340,
                            textColor: appPrimaryColor,
                            isLoading: false)
                      ],
                    ),
                  ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
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

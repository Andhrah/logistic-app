import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/screens/dispatch/payment.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/back_icon.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/widgets/input_field.dart';

class FundWalletScreen extends StatefulWidget {
  static const String id = 'fundscreen';

  const FundWalletScreen({Key? key}) : super(key: key);

  @override
  _FundWalletScreenState createState() => _FundWalletScreenState();
}

class _FundWalletScreenState extends State<FundWalletScreen> {
  String _wallets = 'Select wallet';

  var wallets = [
    "Select wallet",
    "Trakk wallet",
    "Zebrra wallet",
  ];

  String? _wallet;
  String? _amount;

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
      // backgroundColor: const Color(0xFFF8F9FF),
      body: SingleChildScrollView(
          child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackIcon(
                  onPress: () {
                    Navigator.pop(context);
                  },
                ),
                const Text(
                  'WALLET TOP UP',
                  style: TextStyle(
                      color: appPrimaryColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(),
              ],
            ),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                margin: const EdgeInsets.only(top: 18.0),
                alignment: Alignment.center,
                child: Column(
                  children: const [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Select your top up source',
                        style: TextStyle(
                            color: appPrimaryColor,
                            fontSize: 17.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    
                    // const Text(
                    //   'Select your top up source',
                    //   style: TextStyle(
                    //     color: appPrimaryColor,
                    //     fontSize: 17.0,
                    //     fontWeight: FontWeight.w600
                    //   ),
                    //   textAlign: TextAlign.start,
                    // ),
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  SizedBox(
                    child: TabBar(
                      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                      indicatorPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      //indicatorColor: Colors.red,
                      indicator: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                          color: secondaryColor),
                      labelPadding: EdgeInsets.only(left: 0),
                      labelColor: appPrimaryColor,
                      unselectedLabelColor: appPrimaryColor,
                      unselectedLabelStyle: TextStyle(fontSize: 16),

                      tabs: [
                        Tab(
                          height: 160,
                          //text: 'Edit',
                          child: Container(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/logo.png",
                                    height: 46,
                                  ),
                                  Text(
                                    "Top up from\nZebrra wallet",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(),
                                  ),
                                  Image.asset("assets/images/logo.png"),
                                ],
                              )),
                        ),
                        Tab(
                          height: 160,
                          //text: 'Edit',
                          child: Container(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/mastercard.png",
                                    height: 46,
                                  ),
                                  Text(
                                    "Top up with\nyour card",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(),
                                  ),
                                  Image.asset("assets/images/PP.png"),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    //width: double.maxFinite,
                    height: mediaQuery.size.height,
                    child: TabBarView(children: [
                      ListView(physics: ScrollPhysics(), children: [
                        Container(
                          decoration: BoxDecoration(
                            //color: Color.fromARGB(0, 202, 138, 41),
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              color: Color.fromARGB(255, 199, 190, 152),
                              height: 556,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 15,
                                  right: 15,
                                  top: 15,
                                  bottom: 20,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Select source wallet",
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
                                          child: DropdownButton<String>(
                                            value: _wallets,
                                            icon: const Icon(
                                                Remix.arrow_down_s_line),
                                            elevation: 16,
                                            isExpanded: true,
                                            style: TextStyle(
                                              color: appPrimaryColor
                                                  .withOpacity(0.8),
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
                                    const Text("Wallet to be funded",
                                        textScaleFactor: 1.2,
                                        style: TextStyle(
                                            //fontSize: 16,
                                            fontWeight: FontWeight.w500)),
                                    const SizedBox(height: 0.0),
                                    InputField(
                                      key: const Key('Trakk wallet'),
                                      textController: _walletControler,
                                      node: _amountNode,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      obscureText: false,
                                      text: '',
                                      hintText: 'Trakk wallet',
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
                                        _wallet = value!.trim();
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text("Amount",
                                        textScaleFactor: 1.2,
                                        style: TextStyle(
                                            //fontSize: 16,
                                            fontWeight: FontWeight.w500)),
                                    InputField(
                                      key: const Key('amount'),
                                      textController: _amountController,
                                      keyboardType: TextInputType.phone,
                                      node: _amountNode,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      obscureText: false,
                                      text: '',
                                      hintText: '₦00.00',
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
                                        _amount = value!.trim();
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Button(
                                        text: "Top Up",
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
                        )
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
                                color: Color.fromARGB(255, 199, 190, 152),
                                height: 556,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 15,
                                    right: 15,
                                    top: 15,
                                    bottom: 20,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            child: DropdownButton<String>(
                                              value: _wallets,
                                              icon: const Icon(
                                                  Remix.arrow_down_s_line),
                                              elevation: 16,
                                              isExpanded: true,
                                              style: TextStyle(
                                                color: appPrimaryColor
                                                    .withOpacity(0.8),
                                                fontSize: 18.0,
                                              ),
                                              underline:
                                                  Container(), //empty line
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  _wallets = newValue!;
                                                });
                                              },
                                              items:
                                                  wallets.map((String value) {
                                                return DropdownMenuItem(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                            ),
                                          )),
                                      const SizedBox(height: 20.0),
                                      const Text("Wallet to be funded",
                                          textScaleFactor: 1.2,
                                          style: TextStyle(
                                              //fontSize: 16,
                                              fontWeight: FontWeight.w500)),
                                      const SizedBox(height: 0.0),
                                      InputField(
                                        key: const Key('Trakk wallet'),
                                        textController: _walletControler,
                                        node: _amountNode,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        obscureText: false,
                                        text: '',
                                        hintText: 'Trakk wallet',
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
                                          _wallet = value!.trim();
                                          return null;
                                        },
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text("Amount",
                                          textScaleFactor: 1.2,
                                          style: TextStyle(
                                              //fontSize: 16,
                                              fontWeight: FontWeight.w500)),
                                      InputField(
                                        key: const Key('amount'),
                                        textController: _amountController,
                                        keyboardType: TextInputType.phone,
                                        node: _amountNode,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        obscureText: false,
                                        text: '',
                                        hintText: '₦00.00',
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
                                          _amount = value!.trim();
                                          return null;
                                        },
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Button(
                                          text: "Top Up",
                                          onPress: () {
                                            Navigator.of(context).pushNamed(Payment.id);
                                          },
                                          color: appPrimaryColor,
                                          width: 308,
                                          textColor: whiteColor,
                                          isLoading: false),
                                    ],
                                  ),
                                ),
                                ),))
                        //Divider()
                      ]),
                    ]),
                  ),
                ],
              ),
            ),
            // DefaultTabController(
            //   length: 2,
            //   child: Column(
            //     children: [
            //       SizedBox(
            //         height: 140,
            //         width: 160,
            //         child: Padding(
            //           padding: const EdgeInsets.all(0.0),
            //           child: TabBar(
            //               labelStyle:
            //                   const TextStyle(fontWeight: FontWeight.bold),
            //               indicatorPadding:
            //                   const EdgeInsets.symmetric(horizontal: 10),
            //               //indicatorColor: Colors.red,
            //               indicator: BoxDecoration(
            //                   borderRadius: const BorderRadius.all(
            //                     Radius.circular(8),
            //                   ),
            //                   border: Border.all(),
            //                   color: appPrimaryColor),
            //               labelPadding: EdgeInsets.only(left: 0),
            //               labelColor: whiteColor,
            //               unselectedLabelColor: appPrimaryColor,
            //               unselectedLabelStyle: TextStyle(fontSize: 16),
            //               tabs: const [
            //                 Tab(text: 'Edit'),
            //                 Tab(
            //                   text: 'Suspend',
            //                 ),
            //               ]),
            //         ),
            //       ),
            //       Container(
            //         //width: double.maxFinite,
            //         height: mediaQuery.size.height * 0.6,
            //         child: TabBarView(children: [
            //           SingleChildScrollView(
            //             //shrinkWrap: true,
            //             child: Container(
            //               child: Center(child: Text("data")),
            //             ),
            //           ),
            //           ListView(children: [
            //             Container(
            //               height: 57,
            //               child: const Padding(
            //                 padding: EdgeInsets.only(left: 19, top: 21),
            //                 child: Text(
            //                   'Library',
            //                   style: TextStyle(fontSize: 16),
            //                 ),
            //               ),
            //             ),
            //             Divider()
            //           ]),
            //         ]),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      )),
    );
  }
}

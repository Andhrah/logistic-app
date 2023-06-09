import 'package:flutter/material.dart';
import 'package:trakk/src/screens/wallet/all_cards.dart';
import 'package:trakk/src/screens/wallet/fund_wallet.dart';
import 'package:trakk/src/screens/wallet/transfers.dart';
import 'package:trakk/src/screens/wallet/wallet_history.dart';
import 'package:trakk/src/utils/helper_utils.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/widgets/icon_container.dart';

import '../../values/font.dart';

class WalletScreen extends StatefulWidget {
  static const String id = "wallet";

  const WalletScreen({Key? key}) : super(key: key);

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return AbsorbPointer(
      absorbing: true,
      child: Stack(
        children: [
          Scaffold(
              body: SafeArea(
            child: SingleChildScrollView(
              child: Column(children: [
                //kSmallSizeBox,kSmallSizeBox,
                12.heightInPixel(),
                Text(
                  'TRAKK WALLET',
                  style: theme.textTheme.subtitle1!.copyWith(
                      fontWeight: kBoldWeight,
                      fontSize: 18,
                      fontFamily: kDefaultFontFamilyHeading
                      // decoration: TextDecoration.underline,
                      ),
                ),
                // Container(
                //   margin:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.2, vertical: 20),
                //   alignment: Alignment.center,
                //   child: const Text(
                //     'TRAKK WALLET',
                //     style: TextStyle(
                //         color: appPrimaryColor,
                //         fontSize: 20.0,
                //         fontWeight: FontWeight.bold),
                //   ),
                // ),

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
                            'Zebrra wallet balance',
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

                // Container(
                //   margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 30.0),
                //   child: TextFormField(
                //     decoration: InputDecoration(
                //       labelText: 'Search',
                //       labelStyle: const TextStyle(fontSize: 18.0, color: Color(0xFFCDCDCD)),
                //       enabledBorder:  OutlineInputBorder(
                //         borderSide: BorderSide(color: darkerPurple.withOpacity(0.3), width: 0.0),
                //       ),
                //       suffixIcon: const Icon(
                //         Icons.search_rounded,
                //         color: Color(0xFFCDCDCD),
                //       ),
                //     ),
                //   )
                // ),

                Container(
                    margin: const EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 20.0),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconContainer(
                            text: 'Fund Wallet',
                            imgUrl: 'assets/images/fund.svg',
                            isText: false,
                            onPress: () {
                              Navigator.of(context)
                                  .pushNamed(FundWalletScreen.id);
                            },
                          ),

                          // IconContainer(
                          //   text: 'Payment',
                          //   imgUrl: 'assets/images/payment.svg',
                          //   isText: false,
                          //   onPress: (){
                          //     Navigator.of(context).pushNamed(Payments.id);
                          //   },
                          // ),
                          IconContainer(
                            text: 'All Cards',
                            imgUrl: 'assets/images/cards.svg',
                            isText: false,
                            onPress: () {
                              Navigator.of(context).pushNamed(AllCards.id);
                            },
                          ),

                          IconContainer(
                            text: 'Transfer',
                            imgUrl: 'assets/images/transfer01.svg',
                            isText: false,
                            onPress: () {
                              Navigator.of(context).pushNamed(Transfers.id);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 40.0),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // IconContainer(
                            //   text: 'QR Code',
                            //   imgUrl: 'assets/images/qrCode.svg',
                            //   isText: false,
                            //   onPress: () {
                            //     Navigator.of(context).pushNamed(QrPayment.id);
                            //   },
                            // ),
                            IconContainer(
                              text: 'Transaction\nHistory',
                              imgUrl: 'assets/images/transactionHistory.svg',
                              isText: false,
                              onPress: () {
                                Navigator.of(context)
                                    .pushNamed(WalletHistory.id);
                              },
                            ),
                          ]),
                      const SizedBox(height: 40.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // IconContainer(
                          //   text: 'Cards',
                          //   imgUrl:  'assets/images/cards.svg',
                          //   isText: false,
                          //   onPress: (){},
                          // ),

                          // IconContainer(
                          //   text: 'Transaction\nHistory',
                          //   imgUrl: 'assets/images/transactionHistory.svg',
                          //   isText: false,
                          //   onPress: (){},
                          // ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 6.3),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 6.3),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 6.3),

                          // IconContainer(
                          //   text: 'More',
                          //   imgUrl:  '...',
                          //   isText: true,
                          //   onPress: (){},
                          // ),
                        ],
                      ),
                    ]))
              ]),
            ),
          )),
          Container(
            decoration: BoxDecoration(color: Colors.grey.withOpacity(0.5)),
            constraints: const BoxConstraints.expand(),
          )
        ],
      ),
    );
  }
}

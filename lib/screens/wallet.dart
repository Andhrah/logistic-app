import 'package:flutter/material.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/icon_container.dart';

class WalletScreen extends StatefulWidget {

  const WalletScreen({Key? key}) : super(key: key);

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 60.0),
              alignment: Alignment.center,
              child: const Text(
                'TRAKK WALLET',
                style: TextStyle(
                  color: appPrimaryColor,
                  fontSize: 20.0, 
                  fontWeight: FontWeight.bold
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 30.0),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20.0),
              height: 180,
              //  height: MediaQuery.of(context).size.height * 0.5/3,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: appPrimaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0)
                ),
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
                        children: [
                          const Text(
                            'My Trakk Balance',
                            textScaleFactor: 1.3,
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w400
                            ),
                          ),

                          const SizedBox(height: 10.0),

                          const Text(
                            '₦30,000.00',
                            textScaleFactor: 1.9,
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.bold
                            ),
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
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0)
                              ),
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
                              fontWeight: FontWeight.w400
                            ),
                          ),
                        ], 
                      ),
                    ],
                  ),

                  const SizedBox(height: 30.0),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Zebbra wallet balance',
                        textScaleFactor: 0.9,
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w400
                        ),
                      ),

                      const SizedBox(height: 5.0),

                      const Text(
                        '₦1,100,000.00',
                        textScaleFactor: 1.3,
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 30.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Search',
                  labelStyle: const TextStyle(fontSize: 18.0, color: Color(0xFFCDCDCD)),
                  enabledBorder:  OutlineInputBorder(
                    borderSide: BorderSide(color: darkerPurple.withOpacity(0.3), width: 0.0),
                  ),
                  suffixIcon: const Icon(
                    Icons.search_rounded,
                    color: Color(0xFFCDCDCD),
                  ),
                ),
              )
            ),

            Container(
              margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const IconContainer(
                        text: 'Fund Wallet', 
                        imgUrl: 'assets/images/fund_wallet_img.png',
                        isText: false,
                      ),

                      const IconContainer(
                        text: 'Payment', 
                        imgUrl: 'assets/images/payment_img.png',
                        isText: false,
                      ),

                      const IconContainer(
                        text: 'Transfer', 
                        imgUrl: 'assets/images/transfer_img.png',
                        isText: false,
                      ),
                    ],
                  ),

                  const SizedBox(height: 40.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const IconContainer(
                        text: 'Withdraw', 
                        imgUrl: 'assets/images/withdraw_img.png',
                        isText: false,
                      ),

                      const IconContainer(
                        text: 'QR Code',
                        imgUrl: 'assets/images/qr_img.png',
                        isText: false,
                      ),

                      const IconContainer(
                        text: 'Buy Airtime',
                        imgUrl: 'assets/images/airtime_img.png',
                        isText: false,
                      ),
                    ],
                  ),

                  const SizedBox(height: 40.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const IconContainer(
                        text: 'Cards', 
                        imgUrl:  'assets/images/cards_img.png',
                        isText: false,
                      ),

                      const IconContainer(
                        text: 'Transaction\nHistory',
                        imgUrl: 'assets/images/history_img.png',
                        isText: false,
                      ),

                      const IconContainer(
                        text: 'More',
                        imgUrl:  '...',
                        isText: true,
                      ),
                    ],
                  ),
                  
                ],
              )
            )
          ]
        ),
      )
    );
  }
}

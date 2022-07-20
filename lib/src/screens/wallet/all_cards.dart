import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/src/screens/wallet/fund_wallet.dart';
import 'package:trakk/src/screens/wallet/wallet.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/utils/my_color.dart';
import 'package:trakk/src/widgets/back_icon.dart';
import 'package:trakk/src/widgets/button.dart';
import 'package:trakk/src/widgets/cancel_button.dart';
import 'package:trakk/src/widgets/custom_input_field.dart';
import 'package:trakk/src/widgets/icon_container.dart';
import 'package:trakk/src/widgets/input_field.dart';

class AllCards extends StatefulWidget {
  static const String id = "allCards";

  const AllCards({Key? key}) : super(key: key);

  @override
  _AllCardsState createState() => _AllCardsState();
}

class IndicatorCircle extends StatelessWidget {
  final bool active;

  IndicatorCircle(this.active);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        margin: const EdgeInsets.only(top: 10, bottom: 5, left: 2, right: 2),
        height: 5,
        width: active ? 17 : 8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(active ? 4 : 3),
            color: active ? appPrimaryColor : appPrimaryColor.withOpacity(.3)),
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn);
  }
}

class _AllCardsState extends State<AllCards> {
  CarouselController buttonCarouselController = CarouselController();
  int currentScreen = 1;
  double _widget_opacity = 1;
  Curve _animation_curve = Curves.fastLinearToSlowEaseIn;

  List<Map> cardStates = [
    {
      'image': 'assets/images/zebrraCard.png',
    },
    {
      'image': 'assets/images/zebrraCard.png',
    },
    {
      'image': 'assets/images/zebrraCard.png',
    },
  ];

  handleCarouselPageChange(int index, reason) {
    setState(() {
      currentScreen = index + 1;
    });
  }

  String reason = '';

  onPageChange(int index, CarouselPageChangedReason changeReason) {
    setState(() {
      reason = changeReason.toString();
    });
  }

  String _wallets = 'Select wallet';
  int geee = 2;
  String _cards = "XXXX-XXXX-2356";

  List<Map> cards = [
    {
      "id": 0,
      "cardNumber": "XXXX-XXXX-2356",
      "image": "assets/images/master_card.svg",
    },
    {
      "id": 1,
      "cardNumber": "XXXX-XXXX-0863",
      "image": "assets/images/visaCard.svg",
    },
    {
      "id": 2,
      "cardNumber": "XXXX-XXXX-7552",
      "image": "assets/images/verve_card.svg",
    },
    // {
    //   "id": 3,
    // "cardNumber": "Add new card",
    // "image": "assets/images/verve_card.svg",
    // },
    // {
    //   "id": 4,
    // "cardNumber":  "Add new card",
    //  "image": "assets/images/mastercard_Logo.svg",
    // },
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
    int currentScreenIndex = currentScreen - 1;

    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                BackIcon(
                  onPress: () {
                    Navigator.pop(context);
                  },
                ),
                Container(height: 98,
                  margin: EdgeInsets.only(left: mediaQuery.size.width / 5),
                  alignment: Alignment.center,
                  child: const Text(
                    'ALL CARDS',
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
                    "Secure and manage all your cards connected\n to Trakk",
                    textScaleFactor: 1.2,textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.w500,),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                width: mediaQuery.size.width,
                margin: EdgeInsets.only(top: 100),
                padding: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 8.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "My Debit Card",
                            textScaleFactor: 1.2,
                            style: TextStyle(
                                //fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                  child: CarouselSlider(
                                    carouselController:
                                        buttonCarouselController,
                                    options: CarouselOptions(
                                      // aspectRatio: MediaQuery.of(context)
                                      //     .size.aspectRatio,
                                      viewportFraction: 1.2,
                                      initialPage: 0,
                                      enableInfiniteScroll: true,
                                      reverse: false,
                                      autoPlay: false,
                                      autoPlayInterval:
                                          const Duration(seconds: 5),
                                      autoPlayAnimationDuration:
                                          const Duration(milliseconds: 800),
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      enlargeCenterPage: false,
                                      onPageChanged: handleCarouselPageChange,
                                      scrollDirection: Axis.horizontal,
                                    ),
                                    items: cardStates.map((cardState) {
                                      return Container(
                                        alignment: Alignment.bottomCenter,
                                        child: Image(
                                          width: mediaQuery.size.width / 1.4,
                                          image: AssetImage(cardState['image']),
                                          fit: BoxFit.fill,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  key: const Key('image-container')),
                            ],
                          ),
                          Container(
                            margin:
                                const EdgeInsets.only(top: 20, bottom: 30.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                IndicatorCircle(currentScreen == 1),
                                IndicatorCircle(currentScreen == 2),
                                IndicatorCircle(currentScreen == 3),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 0,
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
                                      backgroundColor:
                                          Color.fromARGB(255, 231, 226, 202),
                                      content: Expanded(
                                        child: Container(
                                          height: mediaQuery.size.height*0.7,
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
                                                          DropdownButtonHideUnderline(
                                                        child: DropdownButton<
                                                            String>(
                                                          hint: const Text(
                                                              "Add new card"),
                                                          value: _cards,
                                                          icon: const Icon(Remix
                                                              .arrow_down_s_line),
                                                          elevation: 16,
                                                          isExpanded: true,
                                                          style: TextStyle(
                                                            color:
                                                                appPrimaryColor
                                                                    .withOpacity(
                                                                        0.8),
                                                            fontSize: 18.0,
                                                          ),
                                                          underline:
                                                              Container(), //empty line
                                                          onChanged: (String?
                                                              newValue) {
                                                            setState(() {
                                                              _cards =
                                                                  newValue!;
                                                            });
                                                            print(_cards);
                                                          },
                                                          items: cards
                                                              .map((Map map) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: map[
                                                                      "cardNumber"]
                                                                  .toString(),
                                                              child: Row(
                                                                children: <
                                                                    Widget>[
                                                                  Container(
                                                                    margin: const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            10),
                                                                    child: Text(
                                                                        map["cardNumber"]),
                                                                  ),
                                                                  SvgPicture
                                                                      .asset(
                                                                    map["image"],
                                                                    height: 30,
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          }).toList(),
                                                        ),
                                                      ),
                                                    )),
                                                // DecoratedBox(

                                                const SizedBox(height: 20.0),
                                                const Text(
                                                    "Fill in your card details",
                                                    textScaleFactor: 1.2,
                                                    style: TextStyle(
                                                        //fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                                const SizedBox(height: 20.0),
                                                CustomInputField(
                                                    key: const Key(
                                                        'Trakk wallet'),
                                                    textController:
                                                        _walletControler,
                                                    node: _amountNode,
                                                    autovalidateMode:
                                                        AutovalidateMode
                                                            .onUserInteraction,
                                                    hintText: 'Name',
                                                    text: "Card holder's name",
                                                    textHeight: 10.0,
                                                    borderColor: appPrimaryColor
                                                        .withOpacity(0.9),
                                                    validator: (value) {
                                                      if (value!.trim().length >
                                                          2) {
                                                        return null;
                                                      }
                                                      return "Enter a valid  name";
                                                    },
                                                    onSaved: (value) {
                                                      _wallet = value!.trim();
                                                      return null;
                                                    },
                                                    obscureText: false),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                CustomInputField(
                                                  key: const Key('cardNumber'),
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
                                                  hintText:
                                                      '0000-0000-0000-0000',
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
                                                    _amount = value!.trim();
                                                    return null;
                                                  },
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: CustomInputField(
                                                          key: const Key(
                                                              'Trakk wallet'),
                                                          textController:
                                                              _walletControler,
                                                          node: _amountNode,
                                                          autovalidateMode:
                                                              AutovalidateMode
                                                                  .onUserInteraction,
                                                          hintText: 'mm / yy',
                                                          text: "Expiry date",
                                                          textHeight: 10.0,
                                                          borderColor:
                                                              appPrimaryColor
                                                                  .withOpacity(
                                                                      0.9),
                                                          onSaved: (value) {
                                                            _wallet =
                                                                value!.trim();
                                                            return null;
                                                          },
                                                          obscureText: false),
                                                    ),
                                                    const SizedBox(
                                                      width: 50,
                                                    ),
                                                    Expanded(
                                                      child: CustomInputField(
                                                          key: const Key(
                                                              'Trakk wallet'),
                                                          textController:
                                                              _walletControler,
                                                          node: _amountNode,
                                                          autovalidateMode:
                                                              AutovalidateMode
                                                                  .onUserInteraction,
                                                          hintText: 'cvv',
                                                          text: "",
                                                          textHeight: 10.0,
                                                          borderColor:
                                                              appPrimaryColor
                                                                  .withOpacity(
                                                                      0.9),
                                                          onSaved: (value) {
                                                            _wallet =
                                                                value!.trim();
                                                            return null;
                                                          },
                                                          obscureText: false),
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
                          const SizedBox(
                            height: 20,
                          ),
                          Button(
                              text: "Close",
                              onPress: () {},
                              color: whiteColor,
                              width: mediaQuery.size.width * 0.9,
                              textColor: appPrimaryColor,
                              isLoading: false),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
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

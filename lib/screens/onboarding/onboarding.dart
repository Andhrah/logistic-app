import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:trakk/screens/onboarding/get_started.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/widgets/elipse_img.dart';
import 'package:trakk/widgets/skip_button.dart';

class Onboarding extends StatefulWidget {
  static String id = 'onboarding';

  const Onboarding({Key? key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class IndicatorCircle extends StatelessWidget {
  final bool active;

  const IndicatorCircle(this.active, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        margin: const EdgeInsets.only(top: 10, bottom: 5, left: 2, right: 2),
        height: 5,
        width: active ? 17 : 8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(active ? 4 : 3),
            color: active ? secondaryColor : secondaryColor.withOpacity(.3)),
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn);
  }
}

class _OnboardingState extends State<Onboarding> {
  CarouselController buttonCarouselController = CarouselController();
  int currentScreen = 1;
  final double widgetOpacity = 1;
  Curve animationCurve = Curves.fastLinearToSlowEaseIn;

  List<Map> screenStates = [
    {
      'image': 'assets/images/onboarding_img1.png',
      'pageText': [
        'Choose location',
        'Choose your pickup and delivery location',
      ],
    },
    {
      'image': 'assets/images/onboarding_img2.png',
      'pageText': [
        'Choose your\npreferred ride',
        'Accept the proposed ride of choose your preferred ride',
      ],
    },
    {
      'image': 'assets/images/onboarding_img3.png',
      'pageText': [
        'Checkout to Make \npayment',
        'Pay with zebbra and get 20% off or choose preferred payemnt method',
      ]
    },
    {
      'image': 'assets/images/onboarding_img4.png',
      'pageText': [
        'Recieve your item',
        'Receive your delivery and notify that your item has been recieved',
      ]
    }
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

  @override
  void initState() {
    super.initState();
    // firstTimeUser = Auth.authProvider(context)
    //     .myFirst(FirstTimeUser.fromJson({"bool": true}));
    // print('first: $firstTimeUser');
    // _hiveRepository.add(
    //   item: firstTimeUser,
    //   key: 'firstTimeUser',
    //   name: kFirstTimeUser,
    // );
  }

  @override
  Widget build(BuildContext context) {
    int currentScreenIndex = currentScreen - 1;

    return Scaffold(
        body: Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(
          flex: 2,
          child: Column(
            children: [
              ElispeImg(
                child: SkipButton(onPress: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(GetStarted.id, (route) => false);
                }),
              ),
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: CarouselSlider(
                    carouselController: buttonCarouselController,
                    options: CarouselOptions(
                      aspectRatio: MediaQuery.of(context).size.aspectRatio,
                      viewportFraction: 1.2,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: false,
                      autoPlayInterval: const Duration(seconds: 5),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: false,
                      onPageChanged: handleCarouselPageChange,
                      scrollDirection: Axis.horizontal,
                    ),
                    items: screenStates.map((screenState) {
                      return Container(
                        alignment: Alignment.bottomCenter,
                        child: Image(
                          image: AssetImage(
                            screenState['image'],
                          ),
                          width: MediaQuery.of(context).size.width / 1.2,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
            flex: 2,
            child: Row(
              children: <Widget>[
                Expanded(
                    // flex: 9,
                    child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 30.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IndicatorCircle(currentScreen == 1),
                          IndicatorCircle(currentScreen == 2),
                          IndicatorCircle(currentScreen == 3),
                          IndicatorCircle(currentScreen == 4)
                        ],
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Align(
                            alignment: Alignment.center,
                            child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 100),
                                opacity: widgetOpacity,
                                curve: animationCurve,
                                child: Text(
                                  screenStates[currentScreenIndex]['pageText']
                                      [0],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 34,
                                    color: appPrimaryColor,
                                  ),
                                  textAlign: TextAlign.center,
                                )))),
                    Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: SizedBox(
                            height: 60.0,
                            width: 300.0,
                            child: Center(
                                child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 100),
                              opacity: widgetOpacity,
                              curve: animationCurve,
                              child: Column(
                                children: [
                                  Text(
                                    screenStates[currentScreenIndex]['pageText']
                                        [1],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: appPrimaryColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )))),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Button(
                          text: 'Next',
                          color: appPrimaryColor,
                          textColor: const Color(0XFFFFFFFF),
                          isLoading: false,
                          width: MediaQuery.of(context).size.width,
                          onPress: () {
                            currentScreen != 4
                                ? buttonCarouselController.nextPage()
                                : Navigator.of(context).pushNamedAndRemoveUntil(
                                    GetStarted.id, (route) => false);
                          },
                        )),
                    Expanded(
                      child: Container(
                        alignment: Alignment.bottomRight,
                        child: Image.asset(
                          "assets/images/bottom_cone.png",
                          width: MediaQuery.of(context).size.width / 4,
                        ),
                      ),
                    )
                  ],
                )),
              ],
            )),
      ])
    ]));
  }
}

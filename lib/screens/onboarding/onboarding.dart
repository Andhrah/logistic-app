import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:trakk/screens/home.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/utils/my_color.dart';
import 'package:trakk/widgets/back_icon.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/widgets/elipse_img.dart';
import 'package:trakk/widgets/skip_button.dart';

class Onboarding extends StatefulWidget {
  static String id = 'getStarted';

  const Onboarding({ Key? key }) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
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
        color: active ? HexColor('#CA9E04') :  HexColor('#CA9E04').withOpacity(.3)
      ),
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn
    );
  }
}

class _OnboardingState extends State<Onboarding> {

  CarouselController buttonCarouselController = CarouselController();
  int currentScreen = 1;
  double _widget_opacity = 1;
  Curve _animation_curve = Curves.fastLinearToSlowEaseIn;

  List<Map> screenStates = [
    {
      'image': 'assets/images/onboarding_img1.png',
      'pageText': [
        'Choose location',
        'Choose your pickup and delivery location?',
      ],
    },
    {
      'image': 'assets/images/onboarding_img2.png',
      'pageText':  [
        'Choose your preffered ride',
        'Accept the proposed ride of choose your preffered ride',
      ],
    },
    {
      'image': 'assets/images/onboarding_img3.png',
      'pageText':  [
        'Checkout and Make payment',
        'Pay with zebbra and get 20% off or choose preffered payemnt method',
      ]
    },
    {
      'image': 'assets/images/onboarding_img4.png',
      'pageText':  [
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
  Widget build(BuildContext context) {
    int currentScreenIndex = currentScreen - 1;

    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              currentScreen != 1 ?
              BackIcon(
                onPress: () {
                  buttonCarouselController.previousPage();
                },
              )
              : Container(),
              ElispeImg(
                child: SkipButton(
                  onPress: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      Home.id, (route) => false
                    );
                  }
                ),
              ),
            ],
          ),

          Expanded(
          // flex: 11,
          child: Row(
            children: <Widget>[
              Expanded(
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
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: false,
                    onPageChanged: handleCarouselPageChange,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: screenStates.map((screenState) {
                    return Container(
                      alignment: Alignment.bottomCenter,
                      child: Image(
                        image: AssetImage(screenState['image']),
                        fit: BoxFit.fill,
                      ),
                    
                    );
                  }).toList(),
                ),
                key: const Key('image-container')
              ),
            ],
          ),
        ),
        
        Expanded(
          // flex: 9,
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
                    SizedBox(
                      height: 60.0,
                      width: 300.0,
                      child: Align(
                        alignment: Alignment.center,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 100),
                          opacity: _widget_opacity,
                          curve: _animation_curve,
                          child: Text(
                            screenStates[currentScreenIndex]['pageText'][0],
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 28,
                              color: appPrimaryColor,
                            ),
                            textAlign: TextAlign.center,
                          )
                        )
                      )
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: SizedBox(
                        height: 80.0,
                        width: 300.0,
                        child: Center(
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 100),
                            opacity: _widget_opacity,
                            curve: _animation_curve,
                            child: Column(
                              children: [
                                Text(
                                  screenStates[currentScreenIndex]['pageText'][1],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: appPrimaryColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          )
                        )
                      )
                    ),
                    Button(
                      text: 'Continue',
                      color: appPrimaryColor,
                      textColor: const Color(0XFFFFFFFF),
                      isLoading: false,
                      width: 300.0,
                      onPress: () {
                        currentScreen != 4 ? buttonCarouselController.nextPage() :
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          Home.id, (route) => false
                        );
                      },
                    )
                  ],
                )
              ),
            ],
          )
        ),
      ]
      )
    );
  }
}
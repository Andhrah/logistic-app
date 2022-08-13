import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trakk/src/values/values.dart';

class MerchantContainer extends StatelessWidget {
  final String title;
  final Color color;
  final String icon;
  final String ?rides;
  final Color? iconColor;

  const MerchantContainer({
    Key? key,
    required this.color,
    required this.icon,
     this.iconColor,
    required this.title, 
    this.rides,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Container(
      margin: const EdgeInsets.only(left: 7, right: 7),
        height: mediaQuery.size.height*0.14,
        width: mediaQuery.size.width,
        decoration: BoxDecoration(
          
          boxShadow:  const [
              BoxShadow(
                color: Color.fromARGB(248, 248, 245, 245),
                spreadRadius: 2.0,
                blurRadius: 5.0,
                offset: Offset(5, 2), // changes position of shadow
              ),
            ],
          
            border: Border.all(color: boarderline ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)),
        child: Stack(
          children: [
            Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
              title,
              //add this
               textScaleFactor: 1.1,
              style: const TextStyle( fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            Text(rides?? '',textScaleFactor: 1.2, style: const TextStyle(fontWeight: FontWeight.w600, fontFamily: kDefaultFontFamily), )
                  ],
                )),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                child: Container(
                  height: mediaQuery.size.height*0.05,
                  width: mediaQuery.size.width*0.09,
                  decoration: BoxDecoration(
                      color: color,
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(25),
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(5),),
                          ),
                  child: Center(child: SvgPicture.asset(icon, color: iconColor,
                  height: mediaQuery.size.height*0.02,)),
                ),
              ),
            )
          ],
        ));
  }
}
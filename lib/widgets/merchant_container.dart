import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trakk/utils/colors.dart';

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
    return Container(
      margin: const EdgeInsets.only(left: 7, right: 7),
        height: 160,
        width: 160,
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
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            Text(rides?? '', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600), )
                  ],
                )),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                child: Container(
                  height: 48,
                  width: 50,
                  decoration: BoxDecoration(
                      color: color,
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(25),
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(5),),
                          ),
                  child: Center(child: SvgPicture.asset(icon, color: iconColor,)),
                ),
              ),
            )
          ],
        ));
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trakk/src/values/values.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      height: 32,
      width: 35,
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: appPrimaryColor,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 230, 230, 230),
              spreadRadius: 1,
              offset: Offset(2.0, 2.0), //(x,y)
              blurRadius: 8.0,
            ),
          ]),
      child: Center(
        child: SvgPicture.asset(
          'assets/images/cancel.svg',
          color: whiteColor,
        ),
      ),
    );
  }
}

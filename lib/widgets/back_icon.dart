import 'package:flutter/material.dart';
import 'package:trakk/utils/colors.dart';

class BackIcon extends StatelessWidget {
  const BackIcon({Key? key, this.onPress}) : super(key: key);

  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: 36,
      margin: const EdgeInsets.only(left: 25.0),
      child: InkWell(
        onTap: onPress,
        customBorder: const CircleBorder(),
        child: const Center(
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: whiteColor,
            size: 16.0,
          ),
        ),
      ),
      decoration: const BoxDecoration(
        color: appPrimaryColor,
        borderRadius: BorderRadius.all(
          Radius.circular(50.0)
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0XFFBDBDBD),
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 0.5,
          ),
        ],        
      ),
    );
  }
}

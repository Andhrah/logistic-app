import 'package:flutter/material.dart';
import 'package:trakk/utils/colors.dart';

class BackIcon extends StatelessWidget {
  const BackIcon({Key? key, this.onPress}) : super(key: key);

  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: 44,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(left: 25.0, top: 15.0, bottom: 15.0),
      child: InkWell(
        onTap: onPress,
        customBorder: const CircleBorder(),
        child: const Center(
          child: Icon(
            Icons.arrow_back_ios_new_outlined,color: appPrimaryColor,
            size: 24.0,
          ),
        )
      ),
      decoration: const BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.all(
          Radius.circular(50.0)
        ),
        //shape: BoxShape.rectangle,
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

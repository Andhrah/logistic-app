import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trakk/utils/colors.dart';

class IconContainer extends StatelessWidget {
  const IconContainer({
    Key? key, 
    required this.text,
    required this.imgUrl,
    required this.isText,
    required this.onPress,
  }) : super(key: key);

  final String text;
  final String imgUrl;
  final bool isText;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onPress,
          customBorder: const CircleBorder(),
          child: Container(
            height: 60,
            width: 60,
            margin: const EdgeInsets.only(bottom: 5.0),
            padding: const EdgeInsets.all(18.0),
            child: isText == false ? SvgPicture.asset(
            imgUrl,
              height: 20,
              width: 20,
            ) : Text(
                imgUrl,
                textScaleFactor: 1.6,
                style: const TextStyle(
                  color: appPrimaryColor,
                  fontWeight: FontWeight.bold
                ),
              textAlign: TextAlign.center,
            ),
            decoration: BoxDecoration(
              color: Colors.grey[200]!,
              borderRadius: const BorderRadius.all(
                Radius.circular(50.0),
              ),
            ),
          ),
        ),

        Text(
          text,
          textScaleFactor: 0.7,
          style: const TextStyle(
            color: appPrimaryColor,
            fontWeight: FontWeight.w400
          ),
        ),
      ],
    );
  }
}
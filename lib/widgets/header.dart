import 'package:flutter/material.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/back_icon.dart';

class Header extends StatelessWidget {
  const Header({Key? key, this.text}) : super(key: key);

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BackIcon(
          onPress: () {Navigator.pop(context);},
        ),
        Container(
          // margin: const EdgeInsets.only(right: 30.0),
          alignment: Alignment.center,
          child: Text(
            text!,
            textScaleFactor: 1.2,
            style: const TextStyle(
              color: appPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 60.0),
      ],
    );
  }
}

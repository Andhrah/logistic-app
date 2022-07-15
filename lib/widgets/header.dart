import 'package:flutter/material.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/back_icon.dart';

class Header extends StatelessWidget {
  const Header(
      {Key? key, this.text, this.padding = const EdgeInsets.only(left: 25.0)})
      : super(key: key);

  final String? text;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BackIcon(
          onPress: () {
            Navigator.pop(context);
          },
          padding: padding,
        ),
        Container(
          // margin: const EdgeInsets.only(right: 30.0),
          alignment: Alignment.center,
          child: Text(
            text ?? '',
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

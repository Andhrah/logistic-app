import 'package:flutter/material.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/back_icon.dart';

class Header extends StatelessWidget {
  const Header(
      {Key? key,
      this.text,
      this.padding = const EdgeInsets.only(left: 25.0),
      this.showBackButton = true,
      this.centerTitle = true})
      : super(key: key);

  final String? text;
  final EdgeInsets padding;
  final bool showBackButton;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Opacity(
          opacity: showBackButton ? 1 : 0,
          child: BackIcon(
            onPress: () {
              Navigator.pop(context);
            },
            padding: padding,
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              text ?? '',
              textScaleFactor: 1.2,
              style: const TextStyle(
                color: appPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        BackIcon(
          isPlaceHolder: true,
          onPress: () {},
          padding: padding,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:trakk/src/values/values.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.text,
    this.onPress,
    required this.color,
    required this.width,
    this.height,
    this.fontSize,
    this.borderRadius,
    this.borderColor,
    required this.textColor,
    // required this.font,
    required this.isLoading,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPress;
  final Color color;
  final double width;
  final double? height;
  final double? fontSize;
  final double? borderRadius;
  final Color? borderColor;
  final Color textColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return isLoading
        ? const CircularProgressIndicator(color: secondaryColor)
        : ElevatedButton(
            onPressed: onPress,
            child: Text(
              text,textScaleFactor: 1,
              style: theme.textTheme.button!.copyWith(                  color: textColor,
                  fontWeight: FontWeight.w400),
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(color),
                minimumSize:
                    MaterialStateProperty.all(Size(width, height ?? 55.0)),
                elevation: MaterialStateProperty.all(0.0),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
                  side: BorderSide(color: appPrimaryColor.withOpacity(0.1)),
                ))));
  }
}

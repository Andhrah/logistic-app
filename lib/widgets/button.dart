import 'package:flutter/material.dart';
import 'package:trakk/utils/colors.dart';

class Button extends StatelessWidget {
  const Button({Key? key, 
    required this.text,
    required this.onPress,
    required this.color,
    required this.width,
    this.borderColor,
    required this.textColor,
    // required this.font,
    required this.isLoading,
  }) : super(key: key);

  final String text;
  final VoidCallback onPress;
  final Color color;
  final double width;
  final Color? borderColor;
  final Color textColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      child: isLoading ? const CircularProgressIndicator(color: secondaryColor) : Text(text, style: TextStyle(fontSize: 17.0, color: textColor, fontWeight: FontWeight.w700),),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
        minimumSize: MaterialStateProperty.all(Size(width, 55.0)),
        elevation: MaterialStateProperty.all(0.0),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: BorderSide(color: appPrimaryColor.withOpacity(0.1)),
          )
        )
      )
    );
  }
}

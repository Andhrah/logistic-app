import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({Key? key, 
    required this.text,
    required this.onPress,
    required this.color,
    // required this.width,
    // required this.height,
    required this.textColor,
    // required this.font,
    required this.isLoading,
  }) : super(key: key);

  final String text;
  final VoidCallback onPress;
  final Color color;
  // final double width;
  // final double height;
  final Color textColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      child: isLoading ? Image.asset('name', color: Colors.white, height: 35.0, width: 35.0) : Text(text, style: TextStyle(fontSize: 17.0, color: textColor, fontWeight: FontWeight.w700),),
      style: ElevatedButton.styleFrom(
        primary: color,
        onPrimary: textColor,
        minimumSize: const Size(300.0 , 45.0)
      )
    );
  }
}

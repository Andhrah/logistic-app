import 'package:flutter/material.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({Key? key, this.onPress}) : super(key: key);

  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: onPress,
        child: const Text(
          'Skip',
          textScaleFactor: 1.1,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        )
      ),
    );
  }
}
import 'package:flutter/material.dart';

class BackIcon extends StatelessWidget {
  const BackIcon({Key? key, this.onPress}) : super(key: key);

  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
      child: GestureDetector(
        onTap: onPress,
        child: const Icon(
          Icons.arrow_back_ios_new_outlined,
          size: 20.0,
        )
      ),
    );
  }
}
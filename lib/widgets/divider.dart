import 'package:flutter/material.dart';

class divider extends StatelessWidget {
  const divider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 1.0,
      color: Color(0xff909090),
    );
  }
}
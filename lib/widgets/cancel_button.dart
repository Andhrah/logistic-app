import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trakk/utils/colors.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: const BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/images/cancel.svg',
          color: Colors.black,
        ),
      ),
    );
  }
}
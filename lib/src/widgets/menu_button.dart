import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/src/values/values.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    Key? key,
    this.onPress,
    this.padding = const EdgeInsets.only(left: 25.0),
    this.isPlaceHolder = false,
  }) : super(key: key);

  final VoidCallback? onPress;
  final EdgeInsets padding;
  final bool isPlaceHolder;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isPlaceHolder,
      child: Opacity(
        opacity: isPlaceHolder ? 0 : 1,
        child: Container(
          height: 36,
          width: 36,
          margin: padding,
          child: InkWell(
            onTap: isPlaceHolder ? null : onPress,
            customBorder: const CircleBorder(),
            child: const Center(
              child: Icon(
                Remix.menu_2_fill,
                color: whiteColor,
                size: 16.0,
              ),
            ),
          ),
          decoration: const BoxDecoration(
            color: appPrimaryColor,
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
            boxShadow: [
              BoxShadow(
                color: Color(0XFFBDBDBD),
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 0.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

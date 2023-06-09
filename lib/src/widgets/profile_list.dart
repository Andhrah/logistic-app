import 'package:flutter/material.dart';
import 'package:trakk/src/values/values.dart';

class ProfileList extends StatelessWidget {
  final Widget icon;
  final String? title;
  final Widget? titleWidget;
  final Widget? trailingWidget;

  const ProfileList({
    Key? key,
    required this.icon,
    this.title,
    this.titleWidget,
    this.trailingWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20),
      height: 48,
      decoration: const BoxDecoration(
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            spreadRadius: 0,
            color: Color.fromARGB(255, 238, 238, 238),
            offset: Offset(2.0, 3.0), //(x,y)
            blurRadius: 6,
          ),
        ],
      ),
      child: Align(
        alignment: Alignment.center,
        child: ListTile(
          leading: icon,
          title: titleWidget ??
              Text(
                title ?? '',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: appPrimaryColor,
                ),
              ),
          trailing: trailingWidget,
        ),
      ),
    );
  }
}

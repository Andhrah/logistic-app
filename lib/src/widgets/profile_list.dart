import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/src/values/values.dart';

class ProfileList extends StatelessWidget {
  final Widget icon;
  final String title;

  const ProfileList({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.only(left: 20),
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
          title: Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: appPrimaryColor,),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, color: kTextColor),
        ),
      ),
    );
  }
}
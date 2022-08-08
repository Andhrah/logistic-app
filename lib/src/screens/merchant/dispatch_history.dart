import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:trakk/src/screens/profile/dispatch_history_screen/user_dispatch_history.dart';
import 'package:trakk/src/values/enums.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/widgets/default_container.dart';

import '../../widgets/back_icon.dart';

class DispatchHistory extends StatefulWidget {
  static const String id = 'dispatchHistory';

  const DispatchHistory({Key? key}) : super(key: key);

  @override
  State<DispatchHistory> createState() => _DispatchHistoryState();
}

class _DispatchHistoryState extends State<DispatchHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        body: SafeArea(
            child: Column(
          children: [
            const SizedBox(height: 20.0),
            Row(
              children: [
                BackIcon(
                  onPress: () {
                    Navigator.pop(context);
                  },
                ),
                Container(
                  //height: 98,
                  margin: const EdgeInsets.only(left: 40.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'DISPATCH HISTORY',
                    textScaleFactor: 1.2,
                    style: TextStyle(
                      color: appPrimaryColor,
                      //fontWeight: FontWeight.bold,
                      fontWeight: kBoldWeight,
                      fontFamily: kDefaultFontFamilyHeading
                      // decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(UserDispatchHistory.id,
                      arguments: {'type': OrderHistoryType.fulfilled});
                },
                child: const DefaultContainer(
                  title: 'Successful dispatch',
                )),
            const SizedBox(
              height: 30,
            ),
            InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(UserDispatchHistory.id,
                      arguments: {'type': OrderHistoryType.referred});
                },
                child: const DefaultContainer(
                  title: 'Referred dispatch',
                )),
            const SizedBox(
              height: 30,
            ),
            InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(UserDispatchHistory.id,
                      arguments: {'type': OrderHistoryType.rejected});
                },
                child: const DefaultContainer(
                  title: 'Rejected request',
                )),
          ],
        )));
  }
}

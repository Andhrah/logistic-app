import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:trakk/screens/merchant/fulfilled_dispatch.dart';
import 'package:trakk/screens/merchant/referred_rides.dart';
import 'package:trakk/screens/merchant/rejected_rides.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/default_container.dart';

import '../../widgets/back_icon.dart';

class DispatchHistory extends StatefulWidget {
  static const String id = 'dispatchhistory';

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
            const SizedBox(height: 10.0),
            Row(
              children: [
                BackIcon(
                  onPress: () {
                    Navigator.pop(context);
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(left: 40.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'DISPATCH HISTORY',
                    textScaleFactor: 1.2,
                    style: TextStyle(
                      color: appPrimaryColor,
                      fontWeight: FontWeight.bold,
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
                  Navigator.of(context).pushNamed(FulfilledDispatch.id);
                },
                child: const DefaultContainer(
                  title: 'Succesful dispatch',
                )),
            const SizedBox(
              height: 30,
            ),
            InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(ReferredRides.id);
                },
                child: const DefaultContainer(
                  title: 'Referred dispatch',
                )),
            const SizedBox(
              height: 30,
            ),
            InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(RejectedRides.id);
                },
                child: const DefaultContainer(
                  title: 'Rejected request',
                )),
          ],
        )));
  }
}

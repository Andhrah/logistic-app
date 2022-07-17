import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:trakk/screens/merchant/add_rider.dart';
import 'package:trakk/screens/merchant/list_of_riders.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/default_container.dart';

import '../../widgets/back_icon.dart';

class Riders extends StatefulWidget {
  static const String id = 'riders';

  const Riders({Key? key}) : super(key: key);

  @override
  State<Riders> createState() => _RidersState();
}

class _RidersState extends State<Riders> {
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
                    'RIDERS',
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
                  Navigator.of(context).pushNamed(ListOfRiders.id);
                },
                child: const DefaultContainer(
                  title: 'View all riders',
                )),
            const SizedBox(
              height: 30,
            ),
            InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(AddRider.id);
                },
                child: const DefaultContainer(
                  title: 'Register new rider',
                )),
            const SizedBox(
              height: 30,
            ),
          ],
        )));
  }
}

import 'package:flutter/material.dart';
import 'package:trakk/src/screens/profile/dispatch_history_screen/user_dispatch_history.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/widgets/default_container.dart';

import '../../widgets/back_icon.dart';

class MerchantNotifications extends StatefulWidget {
  static const String id = 'merchantNotifications';

  const MerchantNotifications({Key? key}) : super(key: key);

  @override
  State<MerchantNotifications> createState() => _MerchantNotificationsState();
}

class _MerchantNotificationsState extends State<MerchantNotifications> {
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
                    'NOTIFICATIONS',
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
                Navigator.of(context).pushNamed(UserDispatchHistory.id);
              },
              child: const DefaultContainer(
                title: 'Completed delivery ',
                num: "(3)",
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(UserDispatchHistory.id);
              },
              child: const DefaultContainer(
                title: 'Referred dispatch ',
                num: "(0)",
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(UserDispatchHistory.id);
              },
              child: const DefaultContainer(
                title: 'Rejected request ',
                num: "(0)",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
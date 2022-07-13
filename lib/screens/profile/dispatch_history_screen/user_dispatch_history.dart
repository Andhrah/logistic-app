import 'package:flutter/material.dart';
import 'package:trakk/screens/profile/dispatch_history_screen/widgets/date_widget.dart';
import 'package:trakk/screens/profile/dispatch_history_screen/widgets/list_history.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/utils/padding.dart';

import '../../../widgets/back_icon.dart';

class UserDispatchHistory extends StatefulWidget {
  static const String id = 'userDispatchHistory';

  const UserDispatchHistory({Key? key}) : super(key: key);

  @override
  State<UserDispatchHistory> createState() => _UserDispatcHistoryState();
}

class _UserDispatcHistoryState extends State<UserDispatchHistory> {
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
        backgroundColor: whiteColor,
        body: SafeArea(
            child: Column(
          children: [
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackIcon(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultLayoutPadding),
                  onPress: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  'DISPATCH HISTORY',
                  style: theme.textTheme.subtitle1!.copyWith(
                    color: appPrimaryColor,
                    fontWeight: FontWeight.bold,
                    // decoration: TextDecoration.underline,
                  ),
                ),
                Opacity(
                  opacity: 0,
                  child: BackIcon(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultLayoutPadding),
                    onPress: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultLayoutPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    DateDispatchHistory(),
                    SizedBox(
                      height: 24,
                    ),
                    ListDispatchHistory()
                  ],
                ),
              ),
            ),
          ],
        )));
  }
}

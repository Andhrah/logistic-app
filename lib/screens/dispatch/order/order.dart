import 'package:custom_bloc/custom_bloc.dart';
import 'package:flutter/material.dart';
import 'package:trakk/bloc/customer/customer_order_history_bloc.dart';
import 'package:trakk/models/order/user_order_history_response.dart';
import 'package:trakk/screens/dispatch/order/widgets/order_card.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/utils/font.dart';
import 'package:trakk/utils/helper_utils.dart';
import 'package:trakk/utils/padding.dart';
import 'package:trakk/utils/styles.dart';

class UserOrderScreen extends StatefulWidget {
  static const String id = 'userOrder';

  const UserOrderScreen({Key? key}) : super(key: key);

  @override
  _UserOrderScreenState createState() => _UserOrderScreenState();
}

class _UserOrderScreenState extends State<UserOrderScreen> {
  @override
  void initState() {
    super.initState();
    getCustomersOrderHistoryBloc.fetchCurrent();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            12.heightInPixel(),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: kDefaultLayoutPadding),
              alignment: Alignment.center,
              child: Text(
                'Your Dispatch',
                style: theme.textTheme.headline6!
                    .copyWith(color: appPrimaryColor, fontWeight: kBoldWeight),
              ),
            ),
            12.heightInPixel(),
            Expanded(
              child: CustomStreamBuilder<List<UserOrderHistoryDatum>, String>(
                stream: getCustomersOrderHistoryBloc.behaviorSubject,
                dataBuilder: (context, data) {
                  return ListView.builder(
                      itemCount: data.length,
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultLayoutPadding, vertical: 12.0),
                      itemBuilder: (BuildContext context, int index) {
                        return UserOrderCard(data.elementAt(index));
                      });
                },
                loadingBuilder: (context) => const Center(
                  child: kCircularProgressIndicator,
                ),
                errorBuilder: (context, err) => Center(
                  child: Text(
                    err,
                    style: theme.textTheme.bodyText2,
                  ),
                ),
              ),
            ),
            // const SizedBox(height: 140.0),
          ],
        ),
      ),
    );
  }
}

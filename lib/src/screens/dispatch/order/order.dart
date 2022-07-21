import 'package:custom_bloc/custom_bloc.dart';
import 'package:flutter/material.dart';
import 'package:trakk/src/bloc/customer/customer_order_history_bloc.dart';
import 'package:trakk/src/models/order/user_order_history_response.dart';
import 'package:trakk/src/screens/dispatch/order/widgets/order_card.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/values/font.dart';
import 'package:trakk/src/utils/helper_utils.dart';
import 'package:trakk/src/values/padding.dart';
import 'package:trakk/src/values/styles.dart';

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
            Text(
              'YOUR DISPATCH',
              style: theme.textTheme.subtitle1!.copyWith(
                fontWeight: kBoldWeight,
                fontSize: 18, fontFamily: kDefaultFontFamilyHeading
                // decoration: TextDecoration.underline,
              ),
            ),
            //12.heightInPixel(),
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

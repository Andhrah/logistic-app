import 'package:custom_bloc/custom_bloc.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/src/bloc/customer/customer_order_history_bloc.dart';
import 'package:trakk/src/models/order/order.dart';
import 'package:trakk/src/models/order/user_order_history_response.dart';
import 'package:trakk/src/screens/dispatch/order/widgets/order_card.dart';
import 'package:trakk/src/utils/helper_utils.dart';
import 'package:trakk/src/values/font.dart';
import 'package:trakk/src/values/padding.dart';
import 'package:trakk/src/values/styles.dart';
import 'package:trakk/src/values/values.dart';

class CustomerOrderScreen extends StatefulWidget {
  final Function(int index, {OrderModel? orderModel}) forHomeNavigation;

  const CustomerOrderScreen(this.forHomeNavigation, {Key? key})
      : super(key: key);

  static const String id = 'userOrder';

  @override
  _CustomerOrderScreenState createState() => _CustomerOrderScreenState();
}

class _CustomerOrderScreenState extends State<CustomerOrderScreen> {
  late String filter;

  List<String> filters = [
    'All Orders',
    'Pending',
    'In-Transit',
    'Completed',
    'Declined'
  ];

  @override
  void initState() {
    super.initState();
    filter = filters.first;
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
            20.heightInPixel(),
            Text(
              'YOUR DISPATCH',
              style: theme.textTheme.subtitle1!.copyWith(
                  fontWeight: kBoldWeight,
                  fontSize: 18,
                  fontFamily: kDefaultFontFamilyHeading
                  // decoration: TextDecoration.underline,
                  ),
            ),
            //12.heightInPixel(),

            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultLayoutPadding, vertical: 12),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: appPrimaryColor.withOpacity(0.9),
                      width: 0.3), //border of dropdown button
                  borderRadius: BorderRadius.circular(
                      8.0), //border raiuds of dropdown button
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultLayoutPadding),
                  child: DropdownButton<String>(
                    borderRadius: BorderRadius.circular(8),
                    value: filter,
                    icon: const Icon(Remix.arrow_down_s_line),
                    elevation: 16,
                    isExpanded: true,

                    style: theme.textTheme.bodyText2!.copyWith(
                      color: appPrimaryColor.withOpacity(0.8),
                    ),
                    underline: Container(),
                    //empty line
                    // onChanged: (String? newValue) {
                    //   setState(() {
                    //     _listOfVehicles = newValue!;
                    //     // if (newValue.contains("All vahicles")) {
                    //     //   showAll = showAll;
                    //     //   isActive = false;
                    //     // } else if (newValue
                    //     //     .contains("Active Vehicles vehicles")) {
                    //     //   isActive = true;
                    //     //   showAll = false;
                    //     // } else if (newValue
                    //     //     .contains("Inactive vehicles")) {
                    //     //   isActive = false;
                    //     //   showAll = false;
                    //     // } else if (newValue.contains("search")) {
                    //     //   showAll = showAll;
                    //     //   isActive = false;
                    //     // }
                    //     isActive
                    //         ? const AllVehicleContainer()
                    //         : const InactiveContainer();
                    //   });

                    //   print(newValue);
                    // },
                    items: filters
                        .map((e) => DropdownMenuItem<String>(
                              value: e,
                              child: Text(
                                e,
                                style: theme.textTheme.caption!.copyWith(
                                  color: appPrimaryColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  // decoration: TextDecoration.underline,
                                ),
                              ),
                            ))
                        .toList(),
                    onChanged: (String? value) {
                      setState(() {
                        filter = value ?? filters.first;
                      });
                      getCustomersOrderHistoryBloc.fetchCurrent(status: filter);
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: CustomStreamBuilder<List<UserOrderHistoryDatum>, String>(
                stream: getCustomersOrderHistoryBloc.behaviorSubject,
                dataBuilder: (context, data) {
                  return ListView.builder(
                      itemCount: data.length,
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultLayoutPadding, vertical: 12.0),
                      itemBuilder: (BuildContext context, int index) {
                        return UserOrderCard(
                            widget.forHomeNavigation, data.elementAt(index));
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

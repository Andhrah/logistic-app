import 'package:custom_bloc/custom_bloc.dart';
import 'package:flutter/material.dart';
import 'package:trakk/src/bloc/rider/rider_order_history_bloc.dart';
import 'package:trakk/src/models/order/order_history_response.dart';
import 'package:trakk/src/utils/helper_utils.dart';
import 'package:trakk/src/values/styles.dart';
import 'package:trakk/src/values/values.dart';

class ListDispatchHistory extends StatefulWidget {
  const ListDispatchHistory({Key? key}) : super(key: key);

  @override
  State<ListDispatchHistory> createState() => _ListDispatchHistoryState();
}

class _ListDispatchHistoryState extends State<ListDispatchHistory> {
  bool containToday = false;
  bool containThisWeek = false;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return CustomStreamBuilder<List<OrderHistoryDatum>, String>(
      stream: getRiderOrderHistoryBloc.behaviorSubject,
      dataBuilder: (context, data) {
        return ListView.separated(
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 10,
              );
            },
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: data.length,
            itemBuilder: (context, index) {
              OrderHistoryDatumAttributes? attributes =
                  data.elementAt(index).attributes;
              String? dateValue;
              Duration difference =
                  DateTime.now().difference(attributes!.createdAt!);

              if (index == 0) {
                if (difference.inDays == 0) {
                  dateValue = 'Today';
                  containToday = true;
                } else if (difference.inDays < 7) {
                  containThisWeek = true;
                  dateValue = 'This week';
                } else {
                  dateValue = getLongDate(
                      dateValue: attributes.createdAt!.toIso8601String());

                  dateValue = dateValue.replaceAll(
                      '${DateTime.now().year.toString()} ', '');
                }
              } else if ((data
                          .elementAt(index - 1)
                          .attributes!
                          .createdAt!
                          .day !=
                      data.elementAt(index - 1).attributes!.createdAt!.day) &&
                  (difference.inDays == 0 && !containToday)) {
                dateValue = 'Today';
                containToday = true;
              } else if ((data
                          .elementAt(index - 1)
                          .attributes!
                          .createdAt!
                          .day !=
                      data.elementAt(index).attributes!.createdAt!.day) &&
                  (difference.inDays < 7 && !containThisWeek)) {
                dateValue = 'This week';
                containThisWeek = true;
              } else if ((data
                          .elementAt(index - 1)
                          .attributes!
                          .createdAt!
                          .day !=
                      data.elementAt(index).attributes!.createdAt!.day) &&
                  difference.inDays > 7) {
                dateValue = getLongDate(
                    dateValue: data
                        .elementAt(index)
                        .attributes!
                        .createdAt!
                        .toIso8601String());
                dateValue = dateValue.replaceAll(
                    '${DateTime.now().year.toString()} ', '');
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (dateValue != null)
                    Text(
                      "$dateValue delivery",
                      style: const TextStyle(
                        color: appPrimaryColor,
                        fontWeight: FontWeight.bold,
                        // decoration: TextDecoration.underline,
                      ),
                    ),
                  if (dateValue != null)
                    const SizedBox(
                      height: 8,
                    ),
                  ExpansionTile(
                    backgroundColor: whiteColor,
                    collapsedBackgroundColor: expansionTileBG,
                    iconColor: Colors.black,
                    title: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Delivery to ${attributes.destination ?? '-'}',
                                  style: theme.textTheme.subtitle2!
                                      .copyWith(fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 6.5,
                          ),
                          Text(
                            getLongDate(
                                dateValue:
                                    attributes.createdAt!.toIso8601String()),
                            style: const TextStyle(
                                color: grayColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    children: [
                      Column(
                        children: [
                          const Divider(
                            thickness: 2,
                            color: appPrimaryColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 0, right: 8, bottom: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      Assets.pickup_route,
                                      height: 100.0,
                                      width: 50,
                                    ),
                                    Expanded(
                                        child: Column(
                                      children: [
                                        const SizedBox(width: 0.0),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Expanded(
                                                child: Text('Pickup Location')),
                                            const SizedBox(width: 12.0),
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                    '${attributes.pickup}')),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Expanded(
                                              child: Text(
                                                'Delivery Location',
                                                // style: TextStyle(
                                                //     fontSize: 16,
                                                //     fontWeight:
                                                //         FontWeight
                                                //             .w500),
                                              ),
                                            ),
                                            const SizedBox(width: 12.0),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                  attributes.destination ?? ''),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ))
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 50,
                                          child: Radio(
                                            value: null,
                                            groupValue: null,
                                            fillColor:
                                                MaterialStateProperty.all(
                                                    secondaryColor),

                                            onChanged: null,

                                            //mouseCursor: MouseCursor.uncontrolled,
                                          ),
                                        ),
                                        const Expanded(child: Text("Item")),
                                        const SizedBox(width: 12.0),
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            attributes.itemName ?? '',
                                            style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 50,
                                          child: Radio(
                                            value: null,
                                            groupValue: null,
                                            fillColor:
                                                MaterialStateProperty.all(
                                                    secondaryColor),
                                            onChanged: null,
                                          ),
                                        ),
                                        const Expanded(
                                          child: Text("Rider"),
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            '${attributes.riderId?.data?.attributes?.userID?.data?.attributes?.firstName ?? ''} ${attributes.riderId?.data?.attributes?.userID?.data?.attributes?.lastName ?? ''}',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              );
            });
      },
      loadingBuilder: (context) =>
          const Center(child: kCircularProgressIndicator),
      errorBuilder: (context, err) => Center(
        child: Text(
          err,
        ),
      ),
    );
  }
}

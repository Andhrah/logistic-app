import 'package:flutter/material.dart';
import 'package:trakk/utils/colors.dart';

class ListDispatchHistory extends StatefulWidget {
  const ListDispatchHistory({Key? key}) : super(key: key);

  @override
  State<ListDispatchHistory> createState() => _UserDispatcHistoryState();
}

class _UserDispatcHistoryState extends State<ListDispatchHistory> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return ListView.separated(
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: 4,
        itemBuilder: (context, index) {
          // String dateValue;
          // Duration difference = DateTime.now()
          //     .difference(
          //     _map.elementAt(index).createdAt);
          // print(_map.elementAt(index).createdAt);
          // if (index == 0) {
          //   if (difference.inDays == 0) {
          //     dateValue = 'Today';
          //     containToday = true;
          //   } else if (difference.inDays < 7) {
          //     containThisWeek = true;
          //     dateValue = 'This week';
          //   } else {
          //     dateValue = getMonthDate(_map
          //         .elementAt(index)
          //         .createdAt
          //         .toIso8601String());
          //
          //     dateValue = dateValue.replaceAll(
          //         '${DateTime.now().year.toString()} ',
          //         '');
          //   }
          // } else if ((_map
          //     .elementAt(index - 1)
          //     .createdAt
          //     .day !=
          //     _map
          //         .elementAt(index)
          //         .createdAt
          //         .day) &&
          //     (difference.inDays == 0 &&
          //         !containToday)) {
          //   dateValue = 'Today';
          //   containToday = true;
          // } else if ((_map
          //     .elementAt(index - 1)
          //     .createdAt
          //     .day !=
          //     _map
          //         .elementAt(index)
          //         .createdAt
          //         .day) &&
          //     (difference.inDays < 7 &&
          //         !containThisWeek)) {
          //   dateValue = 'This week';
          //   containThisWeek = true;
          // } else if ((_map
          //     .elementAt(index - 1)
          //     .createdAt
          //     .day !=
          //     _map
          //         .elementAt(index)
          //         .createdAt
          //         .day) &&
          //     difference.inDays > 7) {
          //   dateValue = getMonthDate(_map
          //       .elementAt(index)
          //       .createdAt
          //       .toIso8601String());
          //   dateValue = dateValue.replaceAll(
          //       '${DateTime.now().year.toString()} ',
          //       '');
          // }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // if (dateValue != null)
              //   Text(
              //   "$dateValue delivery",
              //   textScaleFactor: 1.2,
              //   style: const TextStyle(
              //     color: appPrimaryColor,
              //     fontWeight: FontWeight.bold,
              //     // decoration: TextDecoration.underline,
              //   ),
              // ), if (dateValue != null)
              // const SizedBox(
              //   height: 8,
              // ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Delivery to Ikorodu',
                              style: theme.textTheme.subtitle2!
                                  .copyWith(fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 6.5,
                      ),
                      const Text(
                        '21/2/2022',
                        style: TextStyle(
                            color: grayColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                // trailing: Padding(
                //   padding:
                //       const EdgeInsets.symmetric(vertical: 12),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.end,
                //     children: [
                //       const Text(
                //         '#4000',
                //         style: TextStyle(
                //             color: Colors.black,
                //             fontSize: 18,
                //             fontWeight: FontWeight.w600),
                //       ),
                //       const SizedBox(
                //         height: 10,
                //       ),
                //       Icon(
                //         Icons.keyboard_arrow_up,
                //         size: 14,
                //         color: Colors.black,
                //       )
                //     ],
                //   ),
                // ),
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
                                SizedBox(
                                  width: 50,
                                  //height: 100,
                                  //color: appPrimaryColor,
                                  child: Image.asset(
                                    "assets/images/order_highlighter2.png",
                                    height: 100.0,
                                  ),
                                ),
                                const SizedBox(width: 0.0),
                                Column(
                                  children: const [
                                    Text('Pickup Location'),
                                    SizedBox(height: 65.0),
                                    Text(
                                      'Delivery Location',
                                      // style: TextStyle(
                                      //     fontSize: 16,
                                      //     fontWeight:
                                      //         FontWeight
                                      //             .w500),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('Pickup Location'),
                                    SizedBox(height: 65.0),
                                    Text(
                                      'Delivery ',
                                      // style: TextStyle(
                                      //     fontSize: 16,
                                      //     fontWeight:
                                      //         FontWeight
                                      //             .w500),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Radio(
                                        value: null,
                                        groupValue: null,
                                        fillColor: MaterialStateProperty.all(
                                            secondaryColor),

                                        onChanged: null,

                                        //mouseCursor: MouseCursor.uncontrolled,
                                      ),
                                      const Text("Item"),
                                      const SizedBox(
                                        width: 95,
                                      ),
                                      const Text(
                                        'Black handbag',
                                        style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    //crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Radio(
                                        value: null,
                                        groupValue: null,
                                        fillColor: MaterialStateProperty.all(
                                            secondaryColor),

                                        onChanged: null,

                                        //mouseCursor: MouseCursor.uncontrolled,
                                      ),
                                      const Text("Rider"),
                                      // const SizedBox(
                                      //   width: 20,
                                      // ),
                                      const SizedBox(
                                        width: 95,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            'Malik Johnson',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Boxer 0098',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
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
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        });
  }
}

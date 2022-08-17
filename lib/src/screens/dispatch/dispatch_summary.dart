import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trakk/src/models/order/available_rider_response.dart';
import 'package:trakk/src/models/order/order.dart';
import 'package:trakk/src/screens/dispatch/payment.dart';
import 'package:trakk/src/utils/helper_utils.dart';
import 'package:trakk/src/values/constant.dart';
import 'package:trakk/src/values/padding.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/widgets/button.dart';
import 'package:trakk/src/widgets/header.dart';

class DispatchSummary extends StatefulWidget {
  static const String id = 'dispatchSummary';

  const DispatchSummary({Key? key}) : super(key: key);

  @override
  _DispatchSummaryState createState() => _DispatchSummaryState();
}

class _DispatchSummaryState extends State<DispatchSummary> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    OrderModel orderModel = OrderModel.fromJson(arg["orderModel"]);
    AvailableRiderDataRider rider =
        AvailableRiderDataRider.fromJson(arg["riderModel"]);
    print('orderModel 2: ${orderModel.toJson()}');
    return Scaffold(
        body: SafeArea(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30.0),
        const Header(
          text: 'DETAIL SUMMARY',
          padding: EdgeInsets.symmetric(horizontal: kDefaultLayoutPadding),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultLayoutPadding, vertical: 12),
                  child: Text(
                    'Kindly confirm your details  before proceeding',
                    style: theme.textTheme.subtitle1!.copyWith(
                      color: appPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                34.heightInPixel(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultLayoutPadding),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Receiver’s Info',
                          style: TextStyle(
                              fontSize: 15.0,
                              color: appPrimaryColor,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      5.heightInPixel(),
                      Card(
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: appPrimaryColor.withOpacity(0.1),
                              width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.zero,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 20.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Name:',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: appPrimaryColor,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                          orderModel.data?.receiverName ?? '',
                                          style: const TextStyle(
                                              fontSize: 15.0,
                                              color: appPrimaryColor,
                                              fontWeight: FontWeight.w400)),
                                    )
                                  ],
                                ),
                                if ((orderModel.data?.receiverEmail ?? '')
                                    .isNotEmpty)
                                  14.heightInPixel(),
                                if ((orderModel.data?.receiverEmail ?? '')
                                    .isNotEmpty)
                                  Row(
                                    children: [
                                      const Expanded(
                                        flex: 2,
                                        child: Text(
                                          'Email Address:',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: appPrimaryColor,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                            orderModel.data?.receiverEmail ??
                                                '',
                                            style: const TextStyle(
                                                fontSize: 14.0,
                                                color: appPrimaryColor,
                                                fontWeight: FontWeight.w400)),
                                      )
                                    ],
                                  ),
                                14.heightInPixel(),
                                Row(
                                  children: [
                                    const Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Phone Number:',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: appPrimaryColor,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                          orderModel.data?.receiverPhone ?? '',
                                          style: const TextStyle(
                                              fontSize: 14.0,
                                              color: appPrimaryColor,
                                              fontWeight: FontWeight.w400)),
                                    )
                                  ],
                                ),
                              ],
                            )),
                      ),
                      34.heightInPixel(),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Date',
                          style: TextStyle(
                              fontSize: 15.0,
                              color: appPrimaryColor,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      5.heightInPixel(),
                      Card(
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: appPrimaryColor.withOpacity(0.1),
                              width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.zero,
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 20.0),
                            // height: 110,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Pickup Date:',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: appPrimaryColor,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                          getLongDate(
                                              dateValue:
                                                  orderModel.data?.pickupDate ??
                                                      ''),
                                          style: const TextStyle(
                                              fontSize: 15.0,
                                              color: appPrimaryColor,
                                              fontWeight: FontWeight.w400)),
                                    )
                                  ],
                                ),
                                14.heightInPixel(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Delivery Date:',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: appPrimaryColor,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                          getLongDate(
                                              dateValue: orderModel
                                                      .data?.deliveryDate ??
                                                  ''),
                                          style: const TextStyle(
                                              fontSize: 14.0,
                                              color: appPrimaryColor,
                                              fontWeight: FontWeight.w400)),
                                    )
                                  ],
                                ),
                              ],
                            )),
                      ),
                      34.heightInPixel(),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Items’ info',
                          style: TextStyle(
                              fontSize: 15.0,
                              color: appPrimaryColor,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      5.heightInPixel(),
                      Card(
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: appPrimaryColor.withOpacity(0.1),
                              width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.zero,
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 20.0),
                            // height: 110,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Item Name:',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: appPrimaryColor,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                          orderModel.data?.itemName ?? '',
                                          style: const TextStyle(
                                              fontSize: 15.0,
                                              color: appPrimaryColor,
                                              fontWeight: FontWeight.w400)),
                                    )
                                  ],
                                ),
                                14.heightInPixel(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Description:',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: appPrimaryColor,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                          orderModel.data?.itemDescription ??
                                              '',
                                          style: const TextStyle(
                                              fontSize: 14.0,
                                              color: appPrimaryColor,
                                              fontWeight: FontWeight.w400)),
                                    )
                                  ],
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                34.heightInPixel(),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: kDefaultLayoutPadding),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Image of item',
                      style: TextStyle(
                          fontSize: 15.0,
                          color: appPrimaryColor,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                5.heightInPixel(),
                Card(
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: appPrimaryColor.withOpacity(0.1), width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.symmetric(
                      horizontal: kDefaultLayoutPadding),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 24.0),
                    height: 170,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: Radii.k8pxRadius,
                          child: AspectRatio(
                            aspectRatio: 3 / 4,
                            child: orderModel.data?.itemImage != null &&
                                    orderModel.data!.itemImage!
                                        .startsWith('http')
                                ? CachedNetworkImage(
                                    imageUrl: orderModel.data?.itemImage ?? '',
                                    placeholder: (context, url) =>
                                        const SizedBox(),
                                    errorWidget: (context, url, err) =>
                                        const SizedBox(),
                                  )
                                : Image.file(
                                    File(orderModel.data?.itemImage ?? ''),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultLayoutPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 35.0),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Rider’s Info',
                          style: TextStyle(
                              fontSize: 15.0,
                              color: appPrimaryColor,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Card(
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: appPrimaryColor.withOpacity(0.1),
                              width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.zero,
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 20.0),
                            // height: 110,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Name:',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: appPrimaryColor,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                          '${rider.userId?.firstName ?? ''} ${rider.userId?.lastName ?? ''}',
                                          style: const TextStyle(
                                              fontSize: 15.0,
                                              color: appPrimaryColor,
                                              fontWeight: FontWeight.w400)),
                                    )
                                  ],
                                ),
                                if ((rider.userId?.email ?? '').isNotEmpty)
                                  14.heightInPixel(),
                                if ((rider.userId?.email ?? '').isNotEmpty)
                                  Row(
                                    children: [
                                      const Expanded(
                                        flex: 2,
                                        child: Text(
                                          'Email Address:',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: appPrimaryColor,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(rider.userId?.email ?? '',
                                            style: const TextStyle(
                                                fontSize: 14.0,
                                                color: appPrimaryColor,
                                                fontWeight: FontWeight.w400)),
                                      )
                                    ],
                                  ),
                                14.heightInPixel(),
                                Row(
                                  children: [
                                    const Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Phone Number:',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: appPrimaryColor,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(rider.phone ?? '',
                                          style: const TextStyle(
                                              fontSize: 14.0,
                                              color: appPrimaryColor,
                                              fontWeight: FontWeight.w400)),
                                    )
                                  ],
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 44),
                  alignment: Alignment.center,
                  child: Text(
                    'Total Cost: $naira${formatMoney(rider.cost ?? 0.0)}',
                    style: const TextStyle(
                        fontSize: 20.0,
                        color: appPrimaryColor,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultLayoutPadding),
                  child: Button(
                    text: 'Proceed to payment',
                    onPress: () {
                      orderModel = orderModel.copyWith(
                          data: orderModel.data!.copyWith(
                              riderId: rider.id,
                              amount: rider.cost,
                              totalAmount: rider.cost));

                      Navigator.pushNamed(context, Payment.id, arguments: {
                        'orderModel': orderModel.toJson(),
                      });
                    },
                    color: appPrimaryColor,
                    textColor: whiteColor,
                    isLoading: false,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                34.heightInPixel(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultLayoutPadding),
                  child: Button(
                    text: 'Go back and Edit',
                    onPress: () {
                      Navigator.pop(context);
                      // Navigator.of(context).pushNamed(Payment.id);
                    },
                    color: whiteColor,
                    textColor: appPrimaryColor,
                    isLoading: false,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                34.heightInPixel(),
              ],
            ),
          ),
        ),
      ],
    )));
  }
}

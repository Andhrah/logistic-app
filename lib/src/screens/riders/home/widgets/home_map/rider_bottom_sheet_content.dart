/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'package:flutter/material.dart';
import 'package:trakk/src/utils/helper_utils.dart';
import 'package:trakk/src/values/enums.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/widgets/button.dart';

typedef OnButtonClicked = Function(RiderOrderState data, String orderNo,
    String deliveryCode, double pickupLatitude, double pickupLongitude);

class RiderBottomSheetContentOnGoing extends StatelessWidget {
  final RiderOrderState orderState;
  final String orderId;
  final String orderNo;
  final String deliveryCode;
  final double pickupLatitude;
  final double pickupLongitude;
  final double deliveryLatitude;
  final double deliveryLongitude;
  final String pickupAddress;
  final String deliveryAddress;
  final OnButtonClicked onButtonClick;

  const RiderBottomSheetContentOnGoing(
      {Key? key,
      required this.orderState,
      required this.orderId,
      required this.orderNo,
      required this.deliveryCode,
      required this.pickupLatitude,
      required this.pickupLongitude,
      required this.deliveryLatitude,
      required this.deliveryLongitude,
      required this.pickupAddress,
      required this.deliveryAddress,
      required this.onButtonClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        14.heightInPixel(),
        Row(
          children: [
            Text(
              'ORDER ID:',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyText1!
                  .copyWith(fontWeight: kSemiBoldWeight, color: deepGreen),
            ),
            1.flexSpacer(),
            Text(
              '#$orderNo',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyText1!
                  .copyWith(fontWeight: kSemiBoldWeight),
            ),
          ],
        ),
        34.heightInPixel(),
        SizedBox(
          height: 135,
          child: Row(
            children: [
              Image.asset(
                Assets.pickup_route,
                height: 120,
              ),
              12.widthInPixel(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: FutureBuilder<String>(
                          future: getAddressFromLatLng(
                              pickupLatitude, pickupLongitude),
                          builder: (context, snapshot) {
                            String pickupAddress = this.pickupAddress;
                            if (snapshot.hasData &&
                                this.pickupAddress.isEmpty) {
                              pickupAddress = snapshot.data ?? '';
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'PICKUP LOCATION',
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodyText1!.copyWith(
                                      fontWeight: kSemiBoldWeight,
                                      color: dividerColor),
                                ),
                                4.heightInPixel(),
                                Text(
                                  pickupAddress,
                                  textAlign: TextAlign.start,
                                  style: theme.textTheme.bodyText1!
                                      .copyWith(fontWeight: kMediumWeight),
                                ),
                                1.flexSpacer(),
                                Text(
                                  'DELIVERY LOCATION',
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodyText1!.copyWith(
                                      fontWeight: kSemiBoldWeight,
                                      color: dividerColor),
                                ),
                                4.heightInPixel(),
                                FutureBuilder<String>(
                                    future: getAddressFromLatLng(
                                        deliveryLatitude, deliveryLongitude),
                                    builder: (context, snapshot) {
                                      String deliveryAddress =
                                          this.deliveryAddress;
                                      if (snapshot.hasData &&
                                          this.deliveryAddress.isEmpty) {
                                        deliveryAddress = snapshot.data ?? '';
                                      }
                                      return RichText(
                                        textAlign: TextAlign.start,
                                        text: TextSpan(
                                          text: '$deliveryAddress ',
                                          style: theme.textTheme.bodyText1!
                                              .copyWith(
                                                  fontWeight: kMediumWeight),
                                        ),
                                      );
                                    }),
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        44.heightInPixel(),
        ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: Button(
                text: (orderState == RiderOrderState.isRequestAccepted ||
                        orderState == RiderOrderState.isAlmostAtPickupLocation)
                    ? 'Confirm Pickup'
                    :
                    // (orderState == RiderOrderState.isItemPickedUpLocationAndEnRoute)
                    //         ? 'Go to Delivery'
                    //         :
                    (orderState ==
                            RiderOrderState.isItemPickedUpLocationAndEnRoute)
                        ? 'Delivery in progress'
                        : (orderState ==
                                RiderOrderState.isAlmostAtDestinationLocation)
                            ? 'Arrived at destination'
                            : (orderState ==
                                    RiderOrderState.isAtDestinationLocation)
                                ? 'Confirm delivery'
                                : (orderState ==
                                        RiderOrderState.isOrderCompleted)
                                    ? 'Item delivered'
                                    : 'Done',
                fontSize: 14,
                onPress: () {
                  onButtonClick(orderState, orderId, deliveryCode,
                      pickupLatitude, pickupLongitude);
                },
                color: (orderState == RiderOrderState.isRequestAccepted ||
                        // orderState == RiderOrderState.isItemPickedUpLocation ||
                        orderState == RiderOrderState.isAtDestinationLocation)
                    ? kTextColor
                    : deepGreen,
                width: double.infinity,
                textColor: whiteColor,
                isLoading: false))
      ],
    );
  }
}

class RiderBottomSheetContentCompleted extends StatelessWidget {
  final RiderOrderState orderState;
  final String orderId;
  final String orderNo;
  final String deliveryCode;
  final double pickupLatitude;
  final double pickupLongitude;
  final double deliveryLatitude;
  final double deliveryLongitude;
  final String deliveryDate;
  final String pickupDate;
  final String pickupAddress;
  final String deliveryAddress;
  final OnButtonClicked onButtonClick;

  const RiderBottomSheetContentCompleted(
      {Key? key,
      required this.orderState,
      required this.orderId,
      required this.orderNo,
      required this.deliveryCode,
      required this.pickupLatitude,
      required this.pickupLongitude,
      required this.deliveryLatitude,
      required this.deliveryLongitude,
      required this.deliveryDate,
      required this.pickupDate,
      required this.pickupAddress,
      required this.deliveryAddress,
      required this.onButtonClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        14.heightInPixel(),
        Row(
          children: [
            Text(
              'ORDER ID:',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyText1!
                  .copyWith(fontWeight: kSemiBoldWeight, color: deepGreen),
            ),
            1.flexSpacer(),
            Text(
              '#$orderNo',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyText1!
                  .copyWith(fontWeight: kSemiBoldWeight),
            ),
          ],
        ),
        34.heightInPixel(),
        Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.black),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                Assets.time_outline,
                width: 24,
                height: 24,
              ),
            ),
            12.widthInPixel(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PICKUP DATE',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyText1!.copyWith(
                      fontWeight: kSemiBoldWeight, color: dividerColor),
                ),
                4.heightInPixel(),
                Text(
                  pickupDate,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyText1!
                      .copyWith(fontWeight: kMediumWeight),
                )
              ],
            )
          ],
        ),
        24.heightInPixel(),
        Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.black),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                Assets.time_outline,
                width: 24,
                height: 24,
              ),
            ),
            12.widthInPixel(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DELIVERY DATE',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyText1!.copyWith(
                      fontWeight: kSemiBoldWeight, color: dividerColor),
                ),
                4.heightInPixel(),
                Text(
                  deliveryDate,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyText1!
                      .copyWith(fontWeight: kMediumWeight),
                )
              ],
            )
          ],
        ),
        24.heightInPixel(),
        Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.black),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                Assets.location_outline,
                width: 24,
                height: 24,
              ),
            ),
            12.widthInPixel(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DELIVERY LOCATION',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyText1!.copyWith(
                      fontWeight: kSemiBoldWeight, color: dividerColor),
                ),
                4.heightInPixel(),
                FutureBuilder<String>(
                    future: getAddressFromLatLng(
                        deliveryLatitude, deliveryLongitude),
                    builder: (context, snapshot) {
                      String address = '';
                      if (snapshot.hasData) {
                        address = snapshot.data ?? '';
                      }
                      return Text(
                        address,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyText1!
                            .copyWith(fontWeight: kMediumWeight),
                      );
                    }),
              ],
            )
          ],
        ),
        44.heightInPixel(),
        Center(
          child: Image.asset(
            Assets.check_success_outline,
            width: 54,
            height: 54,
          ),
        ),
        24.heightInPixel(),
        ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: Button(
                text: 'Item delivered',
                fontSize: 14,
                onPress: () {
                  onButtonClick(orderState, orderId, deliveryCode,
                      pickupLatitude, pickupLongitude);
                },
                color: deepGreen,
                width: double.infinity,
                textColor: whiteColor,
                isLoading: false))
      ],
    );
  }
}

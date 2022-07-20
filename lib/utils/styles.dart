/*
*  styles.dart
*  Trakk
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra Technologies]. All rights reserved.
    */

import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:trakk/models/order/user_order_history_response.dart';
import 'package:trakk/utils/app_toast.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/utils/custom_clipboard.dart';
import 'package:trakk/utils/enums.dart';
import 'package:trakk/utils/font.dart';
import 'package:trakk/utils/helper_utils.dart';
import 'package:trakk/utils/radii.dart';
import 'package:trakk/utils/singleton_data.dart';
import 'package:trakk/values/assets.dart';
import 'package:trakk/values/constant.dart';
import 'package:trakk/widgets/button.dart';

const kCircularProgressIndicator =
    CircularProgressIndicator(color: secondaryColor);

class LoadingDataStyle extends StatelessWidget {
  double height;
  double width;
  Color bgColor;
  Color? baseColor;
  Color? highlightColor;
  bool isCircle;

  double borderRadius;

  LoadingDataStyle(
      {this.height = 24,
      this.width = double.infinity,
      this.bgColor = Colors.white,
      this.borderRadius = 10,
      this.baseColor,
      this.highlightColor,
      this.isCircle = false}) {
    if (this.baseColor == null) {
      this.baseColor = Colors.grey[300];
    }
    if (this.highlightColor == null) {
      this.highlightColor = Colors.grey[100];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Shimmer.fromColors(
        baseColor: baseColor!,
        highlightColor: highlightColor!,
        enabled: true,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              borderRadius:
                  isCircle ? null : BorderRadius.circular(borderRadius),
              color: bgColor,
              shape: isCircle ? BoxShape.circle : BoxShape.rectangle),
        ),
      ),
    );
  }
}

class LoadingDataListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
        child: Container(
      height: 63,
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.grey.shade300),
    ));
  }
}

Future dialogOrderPaymentSuccess(
    {BuildContext? context,
    PaymentType paymentType = PaymentType.payOnDelivery,
    UserOrderHistoryDatum? datum,
    Function()? onPositiveCallback,
    Function()? onNegativeCallback}) async {
  BuildContext _authContext = context ??
      SingletonData.singletonData.navKey.currentState!.overlay!.context;
  var theme = Theme.of(_authContext);
  MediaQueryData mediaQuery = MediaQuery.of(_authContext);

  return await showDialog<String>(
    // barrierDismissible: true,
    context: _authContext,
    builder: (BuildContext context) => AlertDialog(
      // title: const Text('AlertDialog Title'),
      // contentPadding:
      //     const EdgeInsets
      //             .symmetric(
      //         horizontal: 50.0,
      //         vertical: 50.0),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        10.heightInPixel(),
        if (paymentType != PaymentType.payOnDelivery)
          Image.asset(
            Assets.check_success_outline,
            height: 55,
            width: 55,
          ),
        if (paymentType != PaymentType.payOnDelivery) 10.heightInPixel(),
        if (paymentType != PaymentType.payOnDelivery)
          const SizedBox(
            width: 250,
            child: Text(
              "Payment successful",
              // maxLines: 2,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff23710F),
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        if (paymentType != PaymentType.payOnDelivery)
          const SizedBox(
            height: 20,
          ),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            decoration: const BoxDecoration(
              color: secondaryColor,
              borderRadius: Radii.k8pxRadius,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Your delivery code is"),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: RichText(
                        text: TextSpan(
                            text: "ID: ",
                            style: theme.textTheme.bodyText1!.copyWith(
                                fontWeight: kBoldWeight,
                                color: appPrimaryColor),
                            children: [
                              TextSpan(
                                text: "#${datum?.attributes?.orderRef ?? ''}",
                                style: theme.textTheme.bodyText1!.copyWith(
                                    fontWeight: kMediumWeight,
                                    color: appPrimaryColor),
                              ),
                            ]),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () {
                          CustomClipboard.copy(
                            "$orderIdentifier${datum?.attributes?.orderRef ?? ''}",
                          );
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              const Icon(
                                Remix.file_copy_line,
                                size: 20,
                              ),
                              2.5.widthInPixel(),
                              Text(
                                "Copy",
                                style: theme.textTheme.bodyText1!
                                    .copyWith(fontWeight: kSemiBoldWeight),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () {
                          try {
                            Share.share("#${datum?.attributes?.orderRef ?? ''}",
                                subject: 'Delivery Code');
                          } catch (err) {
                            appToast('Could not share empty text',
                                appToastType: AppToastType.failed);
                          }
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              const Icon(
                                Remix.share_line,
                                size: 20,
                              ),
                              2.5.widthInPixel(),
                              Text(
                                "Share",
                                style: theme.textTheme.bodyText1!
                                    .copyWith(fontWeight: kSemiBoldWeight),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
        24.heightInPixel(),
        Button(
          text: 'Track item',
          onPress: () {
            if (datum != null) {
              Navigator.pop(context);

              if (onPositiveCallback != null) onPositiveCallback();
            } else {
              appToast(
                  'Can not track order at the moment, please try again or contact support',
                  appToastType: AppToastType.failed);
            }
          },
          color: appPrimaryColor,
          textColor: whiteColor,
          isLoading: false,
          width: MediaQuery.of(context).size.width,
        ),
        24.heightInPixel(),
        Button(
          text: 'Cancel',
          onPress: () {
            Navigator.pop(context);
            if (onPositiveCallback != null) onPositiveCallback();
          },
          color: whiteColor,
          textColor: appPrimaryColor,
          isLoading: false,
          width: MediaQuery.of(context).size.width,
        ),
      ]),
    ),
  );
}

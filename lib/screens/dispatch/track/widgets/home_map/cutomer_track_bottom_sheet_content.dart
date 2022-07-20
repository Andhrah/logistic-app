import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:trakk/models/order/user_order_history_response.dart';
import 'package:trakk/utils/app_toast.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/utils/custom_clipboard.dart';
import 'package:trakk/utils/enums.dart';
import 'package:trakk/utils/font.dart';
import 'package:trakk/utils/helper_utils.dart';
import 'package:trakk/values/assets.dart';
import 'package:trakk/values/constant.dart';

typedef OnButtonClicked = Function();

class CustomerTrackBottomSheetContentOnGoing extends StatelessWidget {
  final OnButtonClicked onButtonClick;

  const CustomerTrackBottomSheetContentOnGoing(
      {Key? key, required this.onButtonClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context)!.settings.arguments;

    final model = UserOrderHistoryDatum.fromJson(arg as Map<String, dynamic>);

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
            GestureDetector(
              onTap: () {
                CustomClipboard.copy(
                    '$orderIdentifier${model.attributes?.orderRef ?? ''}');
              },
              child: Text(
                '#${model.attributes?.orderRef ?? ''}',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyText1!
                    .copyWith(fontWeight: kSemiBoldWeight),
              ),
            ),
          ],
        ),
        34.heightInPixel(),
        SizedBox(
          height: 130,
          child: Row(
            children: [
              Image.asset(
                Assets.pickup_route,
                height: 130,
                fit: BoxFit.fitHeight,
              ),
              12.widthInPixel(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PICKUP LOCATION',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyText1!.copyWith(
                          fontWeight: kSemiBoldWeight, color: dividerColor),
                    ),
                    4.heightInPixel(),
                    FutureBuilder<String>(
                        future: getAddressFromLatLng(
                            model.attributes?.pickupLatitude ?? 0.0,
                            model.attributes?.pickupLongitude ?? 0.0),
                        builder: (context, snapshot) {
                          String address = '';
                          if (snapshot.hasData) {
                            address = snapshot.data ?? '';
                          }
                          return Text(
                            address,
                            textAlign: TextAlign.start,
                            style: theme.textTheme.caption!
                                .copyWith(fontWeight: kMediumWeight),
                          );
                        }),
                    1.flexSpacer(),
                    Text(
                      'DELIVERY LOCATION',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyText1!.copyWith(
                          fontWeight: kSemiBoldWeight, color: dividerColor),
                    ),
                    4.heightInPixel(),
                    FutureBuilder<String>(
                        future: getAddressFromLatLng(
                            model.attributes?.destinationLatitude ?? 0.0,
                            model.attributes?.destinationLongitude ?? 0.0),
                        builder: (context, snapshot) {
                          String pickupAddress = '';
                          String deliveryAddress = '';
                          if (snapshot.hasData) {
                            pickupAddress = snapshot.data ?? '';
                            deliveryAddress = snapshot.data ?? '';
                          }
                          return RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                                text: 'From ',
                                style: theme.textTheme.caption!
                                    .copyWith(fontWeight: kLightWeight),
                                children: [
                                  TextSpan(
                                    text: '$pickupAddress ',
                                    style: theme.textTheme.caption!
                                        .copyWith(fontWeight: kMediumWeight),
                                  ),
                                  TextSpan(
                                    text: 'to ',
                                    style: theme.textTheme.caption!
                                        .copyWith(fontWeight: kLightWeight),
                                  ),
                                  TextSpan(
                                    text: '$deliveryAddress ',
                                    style: theme.textTheme.caption!
                                        .copyWith(fontWeight: kMediumWeight),
                                  ),
                                ]),
                          );
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
        24.heightInPixel(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                'Share your track order link to the recipient to the track the item with you',
                style: theme.textTheme.bodyText2!.copyWith(),
              ),
            ),
            24.widthInPixel(),
            GestureDetector(
              onTap: () {
                try {
                  Share.share('#${model.attributes?.orderRef ?? ''}',
                      subject: 'Delivery Code');
                } catch (err) {
                  appToast('Could not share empty text',
                      appToastType: AppToastType.failed);
                }
              },
              child: Image.asset(
                Assets.share_icon,
                height: 20,
                width: 20,
              ),
            )
          ],
        ),
        44.heightInPixel(),
        // ConstrainedBox(
        //     constraints: const BoxConstraints(maxWidth: 450),
        //     child: Button(
        //         text: 'Cancel Ride',
        //         fontSize: 14,
        //         onPress: () {
        //           onButtonClick();
        //         },
        //         color: kTextColor,
        //         width: double.infinity,
        //         textColor: whiteColor,
        //         isLoading: false))

        34.heightInPixel(),
      ],
    );
  }
}

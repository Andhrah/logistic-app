import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/models/order/user_order_history_response.dart';
import 'package:trakk/screens/dispatch/track/customer_track_screen.dart';
import 'package:trakk/screens/riders/pick_up.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/utils/constant.dart';
import 'package:trakk/utils/font.dart';
import 'package:trakk/utils/helper_utils.dart';
import 'package:trakk/utils/padding.dart';
import 'package:trakk/widgets/button.dart';

class UserOrderCard extends StatelessWidget {
  final UserOrderHistoryDatum datum;

  const UserOrderCard(this.datum, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, CustomerTrackScreen.id,
            arguments: datum.toJson());
      },
      child: Card(
        color: whiteColor,
        // elevation: 0.0,
        shape: RoundedRectangleBorder(
          // side: BorderSide(color: appPrimaryColor.withOpacity(0.1), width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.symmetric(vertical: 10.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            24.heightInPixel(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kDefaultLayoutPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ORDER ID:',
                    textScaleFactor: 1.0,
                    style: TextStyle(
                        color: appPrimaryColor.withOpacity(0.3),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '#${datum.attributes?.orderRef ?? ''}',
                    textScaleFactor: 1.0,
                    style: TextStyle(
                      color: appPrimaryColor.withOpacity(0.3),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15.0),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kDefaultLayoutPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 20.0),
                  Image.asset(
                    'assets/images/order_highlighter2.png',
                    height: 100,
                    width: 13,
                  ),
                  const SizedBox(width: 20.0),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PICK-UP ORDER',
                          textScaleFactor: 0.9,
                          style: TextStyle(
                              color: appPrimaryColor.withOpacity(0.3),
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          datum.attributes?.pickup ?? '',
                          style: theme.textTheme.subtitle1!.copyWith(
                              color: appPrimaryColor, fontWeight: kBoldWeight),
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          'DROP-OFF ORDER',
                          textScaleFactor: 0.9,
                          style: TextStyle(
                              color: appPrimaryColor.withOpacity(0.3),
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          datum.attributes?.destination ?? '',
                          style: theme.textTheme.subtitle1!.copyWith(
                              color: appPrimaryColor, fontWeight: kBoldWeight),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30.0),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kDefaultLayoutPadding),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Remix.price_tag_3_fill,
                          color: secondaryColor,
                        ),
                        Text(
                          '$naira${datum.attributes?.totalAmount}',
                          style: theme.textTheme.subtitle2!.copyWith(
                              color: secondaryColor, fontWeight: kBoldWeight),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Remix.time_fill,
                          color: secondaryColor,
                        ),
                        Text(
                          (datum.attributes?.deliveryDate ?? '').isEmpty
                              ? ''
                              : getTimeFromDate(
                                  dateValue: datum.attributes?.deliveryDate),
                          style: theme.textTheme.subtitle2!.copyWith(
                              color: secondaryColor, fontWeight: kBoldWeight),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Remix.pin_distance_fill,
                          color: secondaryColor,
                        ),
                        Text(
                          datum.attributes?.distance ?? '',
                          textScaleFactor: 1.0,
                          style: theme.textTheme.subtitle2!.copyWith(
                              color: secondaryColor, fontWeight: kBoldWeight),
                        ),
                      ],
                    ),
                  ]),
            ),
            const SizedBox(height: 30.0),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kDefaultLayoutPadding),
              child: Text(
                'IMAGES:',
                textScaleFactor: 0.9,
                style: TextStyle(
                    color: appPrimaryColor.withOpacity(0.3),
                    fontWeight: FontWeight.bold),
              ),
            ),
            8.heightInPixel(),
            SizedBox(
              height: 120.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 1,
                padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultLayoutPadding / 2),
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: kDefaultLayoutPadding / 2),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: CachedNetworkImage(
                    imageUrl: datum.attributes?.itemImage ?? '',
                    height: 90.0,
                    width: 90,
                    placeholder: (context, url) => const SizedBox(
                      height: 90.0,
                      width: 90,
                    ),
                    errorWidget: (context, url, err) => const SizedBox(
                      height: 90.0,
                      width: 90,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
            30.heightInPixel(),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: kDefaultLayoutPadding),
              constraints: const BoxConstraints(maxWidth: 450),
              child: Button(
                text: 'TRACK YOUR ORDER',
                onPress: () {
                  Navigator.of(context).pushNamed(PickUpScreen.id);
                  // Navigator.pop(context);
                },
                color: appPrimaryColor,
                textColor: whiteColor,
                isLoading: false,
                width: double.infinity,
                // width: MediaQuery.of(context).size.width/6
              ),
            ),
            24.heightInPixel()
          ],
        ),
      ),
    );
  }
}

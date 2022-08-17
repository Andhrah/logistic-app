import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/src/models/order/order.dart';
import 'package:trakk/src/models/order/user_order_history_response.dart';
import 'package:trakk/src/screens/dispatch/track/customer_track_screen.dart';
import 'package:trakk/src/utils/helper_utils.dart';
import 'package:trakk/src/values/assets.dart';
import 'package:trakk/src/values/constant.dart';
import 'package:trakk/src/values/enums.dart';
import 'package:trakk/src/values/font.dart';
import 'package:trakk/src/values/padding.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/widgets/button.dart';

class UserOrderCard extends StatefulWidget {
  final Function(int index, {OrderModel? orderModel}) forHomeNavigation;

  final UserOrderHistoryDatum datum;

  const UserOrderCard(this.forHomeNavigation, this.datum, {Key? key})
      : super(key: key);

  @override
  State<UserOrderCard> createState() => _UserOrderCardState();
}

class _UserOrderCardState extends State<UserOrderCard> {
  final GlobalKey _key = GlobalKey();
  double height = 50;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(milliseconds: 100), () {
        final renderbox = _key.currentContext!.findRenderObject()! as RenderBox;

        setState(() => height = renderbox.size.height);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    OrderStatus orderStatus =
        (widget.datum.attributes?.deliveryDate ?? '') == 'completed'
            ? OrderStatus.completed
            : (widget.datum.attributes?.deliveryDate ?? '') == 'declined'
                ? OrderStatus.declined
                : (widget.datum.attributes?.deliveryDate ?? '') == 'in_transit'
                    ? OrderStatus.in_transit
                    : OrderStatus.pending;

    return Card(
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
                  '$orderIdentifier${widget.datum.attributes?.orderRef ?? ''}',
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
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: height,
                  width: 30,
                  child: Image.asset(
                    Assets.pickup_route,
                  ),
                ),
                const SizedBox(width: 20.0),
                Flexible(
                  key: _key,
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
                        widget.datum.attributes?.pickup ?? '',
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
                        widget.datum.attributes?.destination ?? '',
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
            child: Row(children: [
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(
                      child: Icon(
                        Remix.price_tag_3_fill,
                        color: secondaryColor,
                      ),
                    ),
                    const SizedBox(
                      width: 0,
                    ),
                    Text(
                      '$naira${formatMoney(widget.datum.attributes?.amount ?? 0.0)}',
                      style: theme.textTheme.subtitle2!.copyWith(
                          color: appPrimaryColor, fontWeight: kBoldWeight),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Remix.time_fill,
                      color: secondaryColor,
                    ),
                    const SizedBox(
                      width: 0,
                    ),
                    Text(
                      (widget.datum.attributes?.deliveryDate ?? '').isEmpty
                          ? ''
                          : getTimeFromDate(
                              dateValue: widget.datum.attributes?.deliveryDate),
                      style: theme.textTheme.subtitle2!.copyWith(
                          color: appPrimaryColor, fontWeight: kBoldWeight),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    const Expanded(
                      child: Icon(
                        Remix.pin_distance_fill,
                        color: secondaryColor,
                      ),
                    ),
                    const SizedBox(
                      width: 0,
                    ),
                    Expanded(
                      child: Text(
                        widget.datum.attributes?.distance ?? '',
                        textScaleFactor: 1.0,
                        style: theme.textTheme.subtitle2!.copyWith(
                            color: appPrimaryColor, fontWeight: kBoldWeight),
                      ),
                    ),
                  ],
                ),
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
          4.heightInPixel(),
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
                child: ClipRRect(
                  borderRadius: Radii.k8pxRadius,
                  child: CachedNetworkImage(
                    imageUrl: widget.datum.attributes?.itemImage ?? '',
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
              text: orderStatus == OrderStatus.completed
                  ? 'ORDER COMPLETED'
                  : orderStatus == OrderStatus.completed
                      ? 'ORDER CANCELLED'
                      : 'TRACK YOUR ORDER',
              onPress: () {
                if (orderStatus == OrderStatus.pending ||
                    orderStatus == OrderStatus.declined) {
                  widget.forHomeNavigation(0,
                      orderModel: OrderModel(
                          data: OrderModelData(
                        pickup: widget.datum.attributes?.pickup ?? '',
                        destination: widget.datum.attributes?.destination ?? '',
                        pickupLatitude:
                            (widget.datum.attributes?.pickupLatitude ?? 0.0)
                                .toString(),
                        pickupLongitude:
                            (widget.datum.attributes?.pickupLongitude ?? 0.0)
                                .toString(),
                        destinationLatitude:
                            (widget.datum.attributes?.destinationLatitude ??
                                    0.0)
                                .toString(),
                        destinationLongitude:
                            (widget.datum.attributes?.destinationLongitude ??
                                    0.0)
                                .toString(),
                        distance:
                            '${(Geolocator.distanceBetween((widget.datum.attributes?.pickupLatitude ?? 0.0), (widget.datum.attributes?.pickupLongitude ?? 0.0), (widget.datum.attributes?.destinationLatitude ?? 0.0), (widget.datum.attributes?.destinationLongitude ?? 0.0)).round() / 1000).toStringAsFixed(2)} km',
                        pickupDate: widget.datum.attributes?.pickupDate ?? '',
                        deliveryDate:
                            widget.datum.attributes?.deliveryDate ?? '',
                        itemName: widget.datum.attributes?.itemName ?? '',
                        itemDescription:
                            widget.datum.attributes?.itemDescription ?? '',
                        itemImage: widget.datum.attributes?.itemImage ?? '',
                        weight: widget.datum.attributes?.weight ?? '',
                        senderName: widget.datum.attributes?.senderName ?? '',
                        senderEmail: widget.datum.attributes?.senderEmail ?? '',
                        senderPhone: widget.datum.attributes?.senderPhone ?? '',
                        receiverName:
                            widget.datum.attributes?.receiverName ?? '',
                        receiverEmail:
                            widget.datum.attributes?.receiverEmail ?? '',
                        receiverPhone:
                            widget.datum.attributes?.receiverPhone ?? '',
                      )));
                } else if (orderStatus == OrderStatus.pending ||
                    orderStatus == OrderStatus.in_transit) {
                  Navigator.pushNamed(context, CustomerTrackScreen.id,
                      arguments: widget.datum.toJson());
                }
              },
              color: orderStatus == OrderStatus.completed
                  ? green
                  : appPrimaryColor,
              textColor: whiteColor,
              isLoading: false,
              width: double.infinity,
              // width: MediaQuery.of(context).size.width/6
            ),
          ),
          24.heightInPixel()
        ],
      ),
    );
  }
}

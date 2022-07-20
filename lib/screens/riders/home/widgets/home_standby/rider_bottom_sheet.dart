import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_bloc/custom_bloc.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:trakk/bloc/rider/rider_map_socket.dart';
import 'package:trakk/bloc/rider_home_state_bloc.dart';
import 'package:trakk/mixins/rider_order_helper.dart';
import 'package:trakk/models/rider/order_response.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/utils/enums.dart';
import 'package:trakk/utils/font.dart';
import 'package:trakk/utils/helper_utils.dart';
import 'package:trakk/utils/padding.dart';
import 'package:trakk/utils/radii.dart';
import 'package:trakk/values/assets.dart';
import 'package:trakk/values/constant.dart';
import 'package:trakk/widgets/button.dart';

class RiderBottomSheet extends StatefulWidget {
  const RiderBottomSheet({Key? key}) : super(key: key);

  @override
  _RiderBottomSheetState createState() => _RiderBottomSheetState();
}

class _RiderBottomSheetState extends State<RiderBottomSheet>
    with RiderOrderHelper {
  final _pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    //todo: separate both [_incomingRequest] and [_standby] into their own state
    return CustomStreamBuilder<RiderOrderState, String>(
        stream: riderHomeStateBloc.behaviorSubject,
        dataBuilder: (context, data) {
          if (data == RiderOrderState.isNewRequestClicked) {
            return StreamBuilder<BaseModel<OrderResponse, String>>(
                stream: riderStreamSocket.behaviorSubject,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.model != null) {
                    return _incomingRequest(snapshot.data!.model!);
                  }

                  //todo: change to no new request screen
                  return _standby();
                });
          }

          return _standby();
        });
  }

  Widget _standby() {
    var theme = Theme.of(context);

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: kDefaultLayoutPadding + kDefaultLayoutPadding,
            vertical: 34),
        decoration: const BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(50), topLeft: Radius.circular(50))),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: Radii.k8pxRadius,
                          boxShadow: [
                            BoxShadow(
                              color: darkBrownColor.withOpacity(0.08),
                              spreadRadius: 4,
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            )
                          ]),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8)),
                              child: Image.asset(
                                Assets.request_a_dispatch,
                                height: 25,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 24),
                            alignment: Alignment.center,
                            child: Text(
                              'Request a Dispatch',
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyText1!
                                  .copyWith(fontWeight: kMediumWeight),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: Radii.k8pxRadius,
                          boxShadow: [
                            BoxShadow(
                              color: darkBrownColor.withOpacity(0.08),
                              spreadRadius: 4,
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            )
                          ]),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8)),
                              child: Image.asset(
                                Assets.initiate_self_delivery,
                                height: 25,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 24),
                            alignment: Alignment.center,
                            child: Text(
                              'Initiate self Delivery',
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyText1!
                                  .copyWith(fontWeight: kMediumWeight),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _incomingRequest(OrderResponse orderResponse) {
    var theme = Theme.of(context);

    Order? order = orderResponse.order;

    return DraggableScrollableSheet(
        initialChildSize: 0.8,
        maxChildSize: 0.8,
        minChildSize: 0.2,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            decoration: const BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50))),
            child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 450),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(50),
                      topLeft: Radius.circular(50)),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal:
                            kDefaultLayoutPadding + kDefaultLayoutPadding,
                        vertical: 34),
                    controller: scrollController,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Incoming Request',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.subtitle1!.copyWith(
                              fontWeight: kSemiBoldWeight, color: deepGreen),
                        ),
                        18.heightInPixel(),
                        Row(
                          children: [
                            Text(
                              'ORDER ID:',
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyText1!.copyWith(
                                  fontWeight: kSemiBoldWeight,
                                  color: deepGreen),
                            ),
                            1.flexSpacer(),
                            Text(
                              '#${order?.orderRef ?? ''}',
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyText1!
                                  .copyWith(fontWeight: kSemiBoldWeight),
                            ),
                          ],
                        ),
                        18.heightInPixel(),
                        SizedBox(
                          height: 90,
                          child: Row(
                            children: [
                              Image.asset(
                                Assets.pickup_route,
                                height: 90,
                              ),
                              12.widthInPixel(),
                              Column(
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
                                  FutureBuilder<String>(
                                      future: getAddressFromLatLng(
                                          order?.pickupLatitude ?? 0.0,
                                          order?.pickupLongitude ?? 0.0),
                                      builder: (context, snapshot) {
                                        String address = '...';
                                        if (snapshot.hasData) {
                                          address = snapshot.data ?? '-';
                                        } else {
                                          address = '...';
                                        }
                                        return Text(
                                          address,
                                          textAlign: TextAlign.center,
                                          style: theme.textTheme.bodyText1!
                                              .copyWith(
                                                  fontWeight: kMediumWeight),
                                        );
                                      }),
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
                                          order?.destinationLatitude ?? 0.0,
                                          order?.destinationLongitude ?? 0.0),
                                      builder: (context, snapshot) {
                                        String address = '...';
                                        if (snapshot.hasData) {
                                          address = snapshot.data ?? '-';
                                        } else {
                                          address = '...';
                                        }
                                        return Text(
                                          address,
                                          textAlign: TextAlign.center,
                                          style: theme.textTheme.bodyText1!
                                              .copyWith(
                                                  fontWeight: kMediumWeight),
                                        );
                                      }),
                                ],
                              )
                            ],
                          ),
                        ),
                        24.heightInPixel(),
                        Row(
                          children: [
                            Expanded(
                                child: Row(
                              children: [
                                Image.asset(
                                  Assets.item_icon,
                                  width: 20,
                                  height: 20,
                                ),
                                12.widthInPixel(),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      text: 'Item : ',
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(fontWeight: kRegularWeight),
                                      children: [
                                        TextSpan(
                                          text: order?.itemName ?? '',
                                          style: theme.textTheme.bodyText1!
                                              .copyWith(
                                                  fontWeight: kSemiBoldWeight),
                                        ),
                                      ]),
                                ),
                              ],
                            )),
                            10.widthInPixel(),
                            Expanded(
                                child: Row(
                              children: [
                                Image.asset(
                                  Assets.distance_icon,
                                  width: 20,
                                  height: 20,
                                ),
                                12.widthInPixel(),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      text: 'Distance : ',
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(fontWeight: kRegularWeight),
                                      children: [
                                        TextSpan(
                                          text:
                                              '${(Geolocator.distanceBetween(order?.pickupLatitude ?? 0.0, order?.pickupLongitude ?? 0.0, order?.destinationLatitude ?? 0.0, order?.destinationLongitude ?? 0.0).round() / 1000).toStringAsFixed(2)} km',
                                          style: theme.textTheme.bodyText1!
                                              .copyWith(
                                                  fontWeight: kSemiBoldWeight),
                                        ),
                                      ]),
                                ),
                              ],
                            ))
                          ],
                        ),
                        34.heightInPixel(),
                        Row(
                          children: [
                            Expanded(
                                child: Row(
                              children: [
                                Image.asset(
                                  Assets.price_icon,
                                  width: 20,
                                  height: 20,
                                ),
                                12.widthInPixel(),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      text: 'Price : ',
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(fontWeight: kRegularWeight),
                                      children: [
                                        TextSpan(
                                          text: naira,
                                          style: theme.textTheme.bodyText1!
                                              .copyWith(
                                                  fontFamily: kNairaFontFamily,
                                                  fontWeight: kSemiBoldWeight),
                                        ),
                                        TextSpan(
                                          text:
                                              formatMoney(order?.amount ?? 0.0),
                                          style: theme.textTheme.bodyText1!
                                              .copyWith(
                                                  fontFamily:
                                                      kDefaultFontFamily,
                                                  fontWeight: kSemiBoldWeight),
                                        ),
                                      ]),
                                ),
                              ],
                            )),
                            10.widthInPixel(),
                            Expanded(
                                child: Row(
                              children: [
                                Image.asset(
                                  Assets.size_icon,
                                  width: 20,
                                  height: 20,
                                ),
                                12.widthInPixel(),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      text: 'Size : ',
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(fontWeight: kRegularWeight),
                                      children: [
                                        TextSpan(
                                          text: order?.weight ?? '-',
                                          style: theme.textTheme.bodyText1!
                                              .copyWith(
                                                  fontWeight: kSemiBoldWeight),
                                        ),
                                      ]),
                                ),
                              ],
                            ))
                          ],
                        ),
                        34.heightInPixel(),
                        SizedBox(
                          height: 100,
                          width: 145,
                          child: Card(
                            elevation: 4,
                            shadowColor: dividerColor.withOpacity(0.4),
                            shape: const RoundedRectangleBorder(
                                borderRadius: Radii.k6pxRadius),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Image of Item',
                                    style: theme.textTheme.bodyText2!.copyWith(
                                        fontSize: 12,
                                        fontWeight: kSemiBoldWeight),
                                  ),
                                  8.heightInPixel(),
                                  Expanded(
                                    child: PageView.builder(
                                        controller: _pageController,
                                        itemCount: 1,
                                        itemBuilder: (context, index) {
                                          return CachedNetworkImage(
                                            imageUrl: '${order?.itemImage}',
                                            placeholder: (context, url) =>
                                                const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                            errorWidget: (context, url, err) =>
                                                SizedBox(
                                              child: Center(
                                                child: Text(
                                                  'Could not load image',
                                                  textAlign: TextAlign.center,
                                                  style: theme
                                                      .textTheme.caption!
                                                      .copyWith(),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        20.heightInPixel(),
                        //todo: change to text base
                        SmoothPageIndicator(
                          count: 1,
                          controller: _pageController,
                          effect:
                              const WormEffect(activeDotColor: secondaryColor),
                        ),
                        34.heightInPixel(),

                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 450),
                          child: Row(
                            children: [
                              Expanded(
                                child: Button(
                                    text: 'Accept',
                                    fontSize: 14,
                                    onPress: () {
                                      if ('${(order?.id ?? '')}'.isNotEmpty) {
                                        doAcceptOrder('${order?.id ?? ''}');
                                      }
                                    },
                                    borderRadius: 12,
                                    color: kTextColor,
                                    width: double.infinity,
                                    textColor: whiteColor,
                                    isLoading: false),
                              ),
                              20.widthInPixel(),
                              Expanded(
                                child: Button(
                                    text: 'Reject',
                                    fontSize: 14,
                                    onPress: () {
                                      modalDialog(
                                        context,
                                        positiveLabel: 'Refer another rider',
                                        onPositiveCallback: () {},
                                        negativeLabel: 'Reject',
                                        onNegativeCallback: () =>
                                            doDeclineOrder(
                                                '${order?.id ?? ' '}'),
                                      );
                                    },
                                    borderRadius: 12,
                                    color: redColor,
                                    width: double.infinity,
                                    textColor: whiteColor,
                                    isLoading: false),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          );
        });
  }
}

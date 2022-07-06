import 'package:custom_bloc/custom_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trakk/bloc/map_socket.dart';
import 'package:trakk/bloc/map_ui_extras_bloc.dart';
import 'package:trakk/bloc/rider_home_state_bloc.dart';
import 'package:trakk/models/rider/on_move_response.dart';
import 'package:trakk/utils/assets.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/utils/enums.dart';
import 'package:trakk/utils/font.dart';
import 'package:trakk/utils/helper_utils.dart';
import 'package:trakk/utils/padding.dart';
import 'package:trakk/utils/styles.dart';
import 'package:trakk/widgets/button.dart';

class RiderBottomSheet extends StatefulWidget {
  final double initialSize;

  const RiderBottomSheet({Key? key, this.initialSize = 0.07}) : super(key: key);

  @override
  State<RiderBottomSheet> createState() => _RiderBottomSheetState();
}

class _RiderBottomSheetState extends State<RiderBottomSheet> {
  DraggableScrollableController draggableScrollableController =
      DraggableScrollableController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    draggableScrollableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return DraggableScrollableSheet(
        initialChildSize: widget.initialSize,
        maxChildSize: 0.5,
        minChildSize: 0.07,
        controller: draggableScrollableController,
        builder: (BuildContext context, ScrollController scrollController) {
          return Stack(
            children: [
              Positioned(
                top: 20,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45.withOpacity(0.07),
                          spreadRadius: 1,
                          offset: const Offset(0.0, -2.0), //(x,y)
                          blurRadius: 8.0,
                        ),
                      ],
                      color: whiteColor,
                      borderRadius: const BorderRadius.only(
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
                          child: CustomStreamBuilder<RiderOrderState, String>(
                              stream: riderHomeStateBloc.behaviorSubject,
                              dataBuilder: (context, orderState) {
                                return CustomStreamBuilder<OnNewRequestResponse,
                                        String>(
                                    stream: streamSocket.behaviorSubject,
                                    dataBuilder: (context, data) {
                                      final String orderNo =
                                          data.order?.id ?? '';
                                      final double pickupLatitude =
                                          data.order?.pickupLatitude ?? 0.0;
                                      final double pickupLongitude =
                                          data.order?.pickupLongitude ?? 0.0;
                                      final double deliveryLatitude =
                                          data.order?.destinationLatitude ??
                                              0.0;
                                      final double deliveryLongitude =
                                          data.order?.destinationLongitude ??
                                              0.0;
                                      if (orderState ==
                                          RiderOrderState.isOrderCompleted) {
                                        return contentCompleted(
                                            orderState,
                                            orderNo,
                                            pickupLatitude,
                                            pickupLongitude,
                                            deliveryLatitude,
                                            deliveryLongitude);
                                      }
                                      return contentOnGoing(
                                          orderState,
                                          orderNo,
                                          pickupLatitude,
                                          pickupLongitude,
                                          deliveryLatitude,
                                          deliveryLongitude);
                                    },
                                    loadingBuilder: (context) {
                                      return Column(
                                        children: [
                                          LoadingDataStyle(
                                            height: 12,
                                            width: 120,
                                            bgColor: Colors.black45,
                                          )
                                        ],
                                      );
                                    },
                                    errorBuilder: (context, err) {
                                      return Column(
                                        children: [
                                          LoadingDataStyle(
                                            height: 12,
                                            width: 120,
                                            bgColor: Colors.black45,
                                          )
                                        ],
                                      );
                                    });
                              }),
                        ),
                      )),
                ),
              ),
              Positioned(
                top: 0,
                right: 44,
                child: GestureDetector(
                  onTap: () {
                    _updateBottomSheetSize();
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: secondaryColor),
                    padding: const EdgeInsets.all(11),
                    alignment: Alignment.center,
                    child: RotatedBox(
                      quarterTurns:
                          draggableScrollableController.size == 0.5 ? 4 : 2,
                      child: const Icon(
                        Icons.arrow_downward,
                        size: 25,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  Widget contentOnGoing(
      RiderOrderState orderState,
      String orderNo,
      double pickupLatitude,
      double pickupLongitude,
      double deliveryLatitude,
      double deliveryLongitude) {
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
                        fontWeight: kSemiBoldWeight, color: dividerColor),
                  ),
                  4.heightInPixel(),
                  FutureBuilder<String>(
                      future:
                          getAddressFromLatLng(pickupLatitude, pickupLongitude),
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
                          deliveryLatitude, deliveryLongitude),
                      builder: (context, snapshot) {
                        String pickupAddress = '';
                        String deliveryAddress = '';
                        if (snapshot.hasData) {
                          pickupAddress = snapshot.data ?? '';
                          deliveryAddress = snapshot.data ?? '';
                        }
                        return Text(
                          'From $pickupAddress to $deliveryAddress',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyText1!
                              .copyWith(fontWeight: kMediumWeight),
                        );
                      }),
                ],
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
                    ? 'Go to pickup'
                    : (orderState == RiderOrderState.isItemPickedUpLocation)
                        ? 'Go to Delivery'
                        : (orderState == RiderOrderState.isEnRoute)
                            ? 'Delivery in progress'
                            : (orderState ==
                                    RiderOrderState
                                        .isAlmostAtDestinationLocation)
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
                  _onButtonClick(orderState, pickupLatitude, pickupLongitude);
                },
                color: (orderState == RiderOrderState.isRequestAccepted ||
                        orderState == RiderOrderState.isItemPickedUpLocation ||
                        orderState == RiderOrderState.isAtDestinationLocation)
                    ? kTextColor
                    : deepGreen,
                width: double.infinity,
                textColor: whiteColor,
                isLoading: false))
      ],
    );
  }

  Widget contentCompleted(
      RiderOrderState orderState,
      String orderNo,
      double pickupLatitude,
      double pickupLongitude,
      double deliveryLatitude,
      double deliveryLongitude) {
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
                  'PICKUP TIME',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyText1!.copyWith(
                      fontWeight: kSemiBoldWeight, color: dividerColor),
                ),
                4.heightInPixel(),
                FutureBuilder<String>(
                    future:
                        getAddressFromLatLng(pickupLatitude, pickupLongitude),
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
                  'DELIVERY TIME',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyText1!.copyWith(
                      fontWeight: kSemiBoldWeight, color: dividerColor),
                ),
                4.heightInPixel(),
                FutureBuilder<String>(
                    future:
                        getAddressFromLatLng(pickupLatitude, pickupLongitude),
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
                    future:
                        getAddressFromLatLng(pickupLatitude, pickupLongitude),
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
            Assets.check_success,
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
                  _updateBottomSheetSize();
                },
                color: deepGreen,
                width: double.infinity,
                textColor: whiteColor,
                isLoading: false))
      ],
    );
  }

  _onButtonClick(
      RiderOrderState data, double pickupLatitude, double pickupLongitude) {
    if (data == RiderOrderState.isRequestAccepted ||
        data == RiderOrderState.isAlmostAtPickupLocation) {
      mapExtraUIBloc.updateMarkersWithCircle(
          [LatLng(pickupLatitude, pickupLongitude)], 'Pickup', true);
    } else if (data == RiderOrderState.isItemPickedUpLocation) {
    } else if (data == RiderOrderState.isEnRoute) {
    } else if (data == RiderOrderState.isAlmostAtDestinationLocation) {
    } else if (data == RiderOrderState.isAtDestinationLocation) {
    } else if (data == RiderOrderState.isOrderCompleted) {
    } else {
      //  minimize bottom sheet
      _updateBottomSheetSize();
    }
  }

  _updateBottomSheetSize() {
    if (draggableScrollableController.size == 0.5) {
      draggableScrollableController.animateTo(0.07,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      draggableScrollableController.animateTo(0.5,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }
}

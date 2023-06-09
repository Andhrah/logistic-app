/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'package:custom_bloc/custom_bloc.dart';
import 'package:flutter/material.dart';
import 'package:trakk/src/bloc/rider/rider_home_state_bloc.dart';
import 'package:trakk/src/bloc/rider/rider_map_socket.dart';
import 'package:trakk/src/mixins/rider_order_helper.dart';
import 'package:trakk/src/models/rider/order_response.dart';
import 'package:trakk/src/screens/riders/home/widgets/home_map/rider_bottom_sheet_content.dart';
import 'package:trakk/src/utils/app_toast.dart';
import 'package:trakk/src/values/enums.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/widgets/general_widget.dart';

class RiderBottomSheet extends StatefulWidget {
  final double initialSize;
  double maxSize;

  RiderBottomSheet({Key? key, this.initialSize = 0.07, this.maxSize = 0.5})
      : super(key: key);

  @override
  State<RiderBottomSheet> createState() => _RiderBottomSheetState();
}

class _RiderBottomSheetState extends State<RiderBottomSheet>
    with RiderOrderHelper {
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
    // orderInFocus.setOrderInFocusID();

    return DraggableScrollableSheet(
        initialChildSize: widget.initialSize,
        maxChildSize: widget.maxSize,
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
                          child: CustomStreamBuilder<int, String>(
                              stream: orderInFocus.behaviorSubject,
                              dataBuilder: (context, orderIDInFocus) {
                                return CustomStreamBuilder<RiderOrderState,
                                        String>(
                                    stream: riderHomeStateBloc.behaviorSubject,
                                    dataBuilder: (context, orderState) {
                                      return CustomStreamBuilder<
                                              List<OrderResponse>, String>(
                                          stream:
                                              riderStreamSocket.behaviorSubject,
                                          dataBuilder: (context, orders) {
                                            var data = orders
                                                        .where((element) =>
                                                            element.order?.id ==
                                                            orderInFocus
                                                                .acceptedOrderID)
                                                        .isNotEmpty &&
                                                    orders
                                                            .where((element) =>
                                                                element.order
                                                                    ?.id ==
                                                                orderInFocus
                                                                    .acceptedOrderID)
                                                            .first
                                                            .order !=
                                                        null
                                                ? orders
                                                    .where((element) =>
                                                        element.order?.id ==
                                                        orderInFocus
                                                            .acceptedOrderID)
                                                    .first
                                                : null;

                                            // orders.elementAt(orderIDInFocus);
                                            final String orderId =
                                                '${data?.order?.id ?? ''}';
                                            final String orderNo =
                                                data?.order?.orderRef ?? '';

                                            final String deliveryCode =
                                                data?.order?.deliveryCode ?? '';
                                            final double pickupLatitude =
                                                data?.order?.pickupLatitude ??
                                                    0.0;
                                            final double pickupLongitude =
                                                data?.order?.pickupLongitude ??
                                                    0.0;
                                            final String pickupAddress =
                                                data?.order?.pickup ?? '';

                                            final double deliveryLatitude = data
                                                    ?.order
                                                    ?.destinationLatitude ??
                                                0.0;
                                            final double deliveryLongitude = data
                                                    ?.order
                                                    ?.destinationLongitude ??
                                                0.0;
                                            final String deliveryAddress =
                                                data?.order?.destination ?? '';

                                            if (orderState ==
                                                RiderOrderState
                                                    .isOrderCompleted) {
                                              final String deliveryDate =
                                                  data?.order?.deliveryDate ??
                                                      '';
                                              final String pickupDate =
                                                  data?.order?.pickupDate ?? '';

                                              return RiderBottomSheetContentCompleted(
                                                orderState: orderState,
                                                orderId: orderId,
                                                orderNo: orderNo,
                                                deliveryCode: deliveryCode,
                                                pickupLatitude: pickupLatitude,
                                                pickupLongitude:
                                                    pickupLongitude,
                                                deliveryLatitude:
                                                    deliveryLatitude,
                                                deliveryLongitude:
                                                    deliveryLongitude,
                                                deliveryDate: deliveryDate,
                                                pickupDate: pickupDate,
                                                pickupAddress: pickupAddress,
                                                deliveryAddress:
                                                    deliveryAddress,
                                                onButtonClick: _onButtonClick,
                                              );
                                            }
                                            return RiderBottomSheetContentOnGoing(
                                              orderState: orderState,
                                              orderId: orderId,
                                              orderNo: orderNo,
                                              deliveryCode: deliveryCode,
                                              pickupLatitude: pickupLatitude,
                                              pickupLongitude: pickupLongitude,
                                              deliveryLatitude:
                                                  deliveryLatitude,
                                              deliveryLongitude:
                                                  deliveryLongitude,
                                              pickupAddress: pickupAddress,
                                              deliveryAddress: deliveryAddress,
                                              onButtonClick: _onButtonClick,
                                            );
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
                          draggableScrollableController.size == widget.maxSize
                              ? 4
                              : 2,
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

  _onButtonClick(RiderOrderState data, String orderNo, String deliveryCode,
      double pickupLatitude, double pickupLongitude) {
    if (data == RiderOrderState.isRequestAccepted ||
        data == RiderOrderState.isAlmostAtPickupLocation) {
      modalDialog(
        context,
        title: 'Are you sure you have picked up item?',
        positiveLabel: 'Yes',
        onPositiveCallback: () {
          doPickupOrder(orderNo);
        },
        negativeLabel: 'No',
        onNegativeCallback: () => Navigator.pop(context),
      );
    } else if (data == RiderOrderState.isItemPickedUpLocationAndEnRoute) {
      riderHomeStateBloc
          .updateState(RiderOrderState.isAlmostAtDestinationLocation);
    } else if (data == RiderOrderState.isAlmostAtDestinationLocation) {
      riderHomeStateBloc.updateState(RiderOrderState.isAtDestinationLocation);
      riderStreamSocket.updateStatus(RiderOrderStatus.delivered);
    } else if (data == RiderOrderState.isAtDestinationLocation) {
      modalCodeDialog(
        context,
        title: 'Enter delivery code',
        positiveLabel: 'Confirm',
        onPositiveCallback: (String value) {
          if (value == deliveryCode) {
            riderStreamSocket.updateStatus(RiderOrderStatus.deliveryConfirmed);
            doDeliverOrder(orderNo);
            return;
          }

          appToast('Invalid Code', appToastType: AppToastType.failed);
        },
        negativeLabel: 'Cancel',
        onNegativeCallback: () => Navigator.pop(context),
      );
    } else if (data == RiderOrderState.isOrderCompleted) {
      riderHomeStateBloc.updateState(RiderOrderState.isHomeScreen);
      riderStreamSocket.remove();
      if (riderStreamSocket.orders.isNotEmpty) {
        riderHomeStateBloc.updateState(RiderOrderState.isNewRequestIncoming);
      }
    } else {
      //  minimize bottom sheet
      _updateBottomSheetSize();
    }
  }

  _updateBottomSheetSize() {
    if (draggableScrollableController.size == widget.maxSize) {
      draggableScrollableController.animateTo(0.07,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      draggableScrollableController.animateTo(widget.maxSize,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }
}

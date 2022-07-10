import 'package:custom_bloc/custom_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trakk/bloc/map_socket.dart';
import 'package:trakk/bloc/map_ui_extras_bloc.dart';
import 'package:trakk/bloc/rider_home_state_bloc.dart';
import 'package:trakk/mixins/order_helper.dart';
import 'package:trakk/models/rider/order_response.dart';
import 'package:trakk/screens/riders/home/widgets/home_map/rider_bottom_sheet_content.dart';
import 'package:trakk/utils/app_toast.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/utils/enums.dart';
import 'package:trakk/utils/helper_utils.dart';
import 'package:trakk/utils/padding.dart';
import 'package:trakk/utils/styles.dart';

class RiderBottomSheet extends StatefulWidget {
  final double initialSize;
  double maxSize;

  RiderBottomSheet({Key? key, this.initialSize = 0.07, this.maxSize = 0.5})
      : super(key: key);

  @override
  State<RiderBottomSheet> createState() => _RiderBottomSheetState();
}

class _RiderBottomSheetState extends State<RiderBottomSheet> with OrderHelper {
  DraggableScrollableController draggableScrollableController =
      DraggableScrollableController();

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    draggableScrollableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
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
                          child: CustomStreamBuilder<RiderOrderState, String>(
                              stream: riderHomeStateBloc.behaviorSubject,
                              dataBuilder: (context, orderState) {
                                return CustomStreamBuilder<OrderResponse,
                                        String>(
                                    stream: streamSocket.behaviorSubject,
                                    dataBuilder: (context, data) {
                                      final String orderNo =
                                          '${data.order?.id ?? ''}';

                                      final String deliveryCode =
                                          '${data.order?.deliveryCode ?? ''}';
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
                                              RiderOrderState
                                                  .isRequestAccepted ||
                                          orderState ==
                                              RiderOrderState
                                                  .isAlmostAtPickupLocation) {
                                        mapExtraUIBloc.updateMarkersWithCircle([
                                          LatLng(
                                              pickupLatitude, pickupLongitude)
                                        ], 'Pickup', true);
                                      }

                                      if (orderState ==
                                          RiderOrderState.isOrderCompleted) {
                                        return RiderBottomSheetContentCompleted(
                                          orderState: orderState,
                                          orderNo: orderNo,
                                          deliveryCode: deliveryCode,
                                          pickupLatitude: pickupLatitude,
                                          pickupLongitude: pickupLongitude,
                                          deliveryLatitude: deliveryLatitude,
                                          deliveryLongitude: deliveryLongitude,
                                          onButtonClick: _onButtonClick,
                                        );
                                      }
                                      return RiderBottomSheetContentOnGoing(
                                        orderState: orderState,
                                        orderNo: orderNo,
                                        deliveryCode: deliveryCode,
                                        pickupLatitude: pickupLatitude,
                                        pickupLongitude: pickupLongitude,
                                        deliveryLatitude: deliveryLatitude,
                                        deliveryLongitude: deliveryLongitude,
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
    print('RiderOrderState: $data');

    if (data == RiderOrderState.isRequestAccepted ||
        data == RiderOrderState.isAlmostAtPickupLocation) {
      modalDialog(
        context,
        title: 'Are you sure to go to delivery?',
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
    } else if (data == RiderOrderState.isAtDestinationLocation) {
      modalDialog(
        context,
        title: 'Enter delivery code',
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: 'Code',
                labelStyle:
                    const TextStyle(fontSize: 18.0, color: Color(0xFFCDCDCD)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: darkerPurple.withOpacity(0.3), width: 0.0),
                ),
              ),
            )
          ],
        ),
        positiveLabel: 'Confirm',
        onPositiveCallback: () {
          if (_controller.text == deliveryCode) {
            doDeliverOrder(orderNo);
            return;
          }

          appToast('Invalid Code', redColor);
        },
        negativeLabel: 'Cancel',
        onNegativeCallback: () => Navigator.pop(context),
      );
    } else if (data == RiderOrderState.isOrderCompleted) {
      riderHomeStateBloc.updateState(RiderOrderState.isHomeScreen);
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
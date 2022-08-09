import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_bloc/custom_bloc.dart';
import 'package:flutter/material.dart';
import 'package:trakk/src/bloc/rider/rider_rating_bloc.dart';
import 'package:trakk/src/mixins/rider_order_helper.dart';
import 'package:trakk/src/models/order/user_order_history_response.dart';
import 'package:trakk/src/screens/dispatch/track/widgets/home_map/cutomer_track_bottom_sheet_content.dart';
import 'package:trakk/src/utils/helper_utils.dart';
import 'package:trakk/src/values/assets.dart';
import 'package:trakk/src/values/enums.dart';
import 'package:trakk/src/values/padding.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/widgets/general_widget.dart';

class CustomerBottomSheet extends StatefulWidget {
  const CustomerBottomSheet({Key? key}) : super(key: key);

  @override
  State<CustomerBottomSheet> createState() => _CustomerBottomSheetState();
}

class _CustomerBottomSheetState extends State<CustomerBottomSheet>
    with RiderOrderHelper {
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
    var arg = ModalRoute.of(context)!.settings.arguments;

    final model = UserOrderHistoryDatum.fromJson(arg as Map<String, dynamic>);

    var theme = Theme.of(context);
    return DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: safeAreaHeight(context, 50) > 390 ? 0.6 : 0.8,
        minChildSize: 0.25,
        controller: draggableScrollableController,
        builder: (BuildContext context, ScrollController scrollController) {
          return Stack(
            children: [
              Positioned.fill(
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
                      color: Colors.black,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(50),
                          topLeft: Radius.circular(50))),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(50),
                        topLeft: Radius.circular(50)),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 450),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 24.0, horizontal: 24),
                                child: Row(
                                  children: [
                                    ClipOval(
                                      child: CachedNetworkImage(
                                        imageUrl: model
                                                .attributes
                                                ?.riderId
                                                ?.data
                                                ?.attributes
                                                ?.userId
                                                ?.data
                                                ?.attributes
                                                ?.avatar ??
                                            '',
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            Image.asset(
                                          Assets.dummy_avatar,
                                          height: 60,
                                          width: 60,
                                          fit: BoxFit.cover,
                                        ),
                                        errorWidget: (context, url, err) =>
                                            Image.asset(
                                          Assets.dummy_avatar,
                                          height: 60,
                                          width: 60,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    12.widthInPixel(),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            model
                                                    .attributes
                                                    ?.riderId
                                                    ?.data
                                                    ?.attributes
                                                    ?.userId
                                                    ?.data
                                                    ?.attributes
                                                    ?.firstName ??
                                                '',
                                            style: theme.textTheme.bodyText2!
                                                .copyWith(color: whiteColor),
                                          ),
                                          8.heightInPixel(),
                                          CustomStreamBuilder<int, String>(
                                              stream: getRiderRatingBloc
                                                  .behaviorSubject,
                                              dataBuilder: (context, data) {
                                                return Row(children: [
                                                  ...List.generate(
                                                      data,
                                                      (index) => Row(
                                                            children: [
                                                              const Icon(
                                                                Icons.star,
                                                                color:
                                                                    secondaryColor,
                                                                size: 13,
                                                              ),
                                                              2.widthInPixel(),
                                                            ],
                                                          )),
                                                  5.widthInPixel(),
                                                  Text(
                                                    data >= 4
                                                        ? 'Very Good'
                                                        : data < 3
                                                            ? 'Not Good'
                                                            : 'Good',
                                                    style: theme
                                                        .textTheme.caption!
                                                        .copyWith(
                                                            color: whiteColor,
                                                            fontSize: 8),
                                                  ),
                                                ]);
                                              }),
                                        ],
                                      ),
                                    ),
                                    12.widthInPixel(),
                                    Row(
                                      children: [
                                        // Image.asset(
                                        //   Assets.track_chat_icon,
                                        //   height: 24,
                                        //   width: 24,
                                        // ),
                                        // 10.widthInPixel(),
                                        GestureDetector(
                                          onTap: () => urlLauncher(
                                              model.attributes?.riderId?.data
                                                      ?.attributes?.phone ??
                                                  '',
                                              urlLaunchType:
                                                  UrlLaunchType.call),
                                          child: Image.asset(
                                            Assets.track_call_icon,
                                            height: 24,
                                            width: 24,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 100,
                left: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(50),
                      topLeft: Radius.circular(50)),
                  child: Container(
                    color: whiteColor,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                          horizontal:
                              kDefaultLayoutPadding + kDefaultLayoutPadding,
                          vertical: 24),
                      controller: scrollController,
                      child: CustomerTrackBottomSheetContentOnGoing(
                        onButtonClick: _onButtonClick,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  _onButtonClick() {
    modalDialog(
      context,
      title: 'Are you sure you want to cancel delivery?',
      positiveLabel: 'Yes',
      onPositiveCallback: () {
        Navigator.pop(context);
        // doPickupOrder('orderNo');
      },
      negativeLabel: 'No',
      onNegativeCallback: () => Navigator.pop(context),
    );
  }
}

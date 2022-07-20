import 'package:custom_bloc/custom_bloc.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:trakk/src/bloc/misc_bloc.dart';
import 'package:trakk/src/bloc/rider/rider_map_socket.dart';
import 'package:trakk/src/bloc/rider_home_state_bloc.dart';
import 'package:trakk/src/models/rider/order_response.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/values/enums.dart';
import 'package:trakk/src/values/font.dart';
import 'package:trakk/src/utils/glow_widget.dart';
import 'package:trakk/src/utils/helper_utils.dart';
import 'package:trakk/src/values/padding.dart';

import 'package:trakk/src/values/assets.dart';
import 'package:trakk/src/widgets/button.dart';

class RiderLocationCard extends StatefulWidget {
  final MiscBloc locaBloc;

  const RiderLocationCard(this.locaBloc, {Key? key}) : super(key: key);

  @override
  _RiderLocationCardState createState() => _RiderLocationCardState();
}

class _RiderLocationCardState extends State<RiderLocationCard> {
  @override
  void initState() {
    super.initState();
    widget.locaBloc.fetchLocation();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return CustomStreamBuilder<RiderOrderState, String>(
        stream: riderHomeStateBloc.behaviorSubject,
        dataBuilder: (context, data) {
          if (data == RiderOrderState.isNewRequestIncoming) {
            return StreamBuilder<BaseModel<OrderResponse, String>>(
                stream: riderStreamSocket.behaviorSubject,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.model != null) {
                    return cardWithNewRequest(context);
                  }
                  return cardWithLocation(context);
                });
          } else if (data == RiderOrderState.isHomeScreen) {
            return cardWithLocation(context);
          }

          return const SizedBox();
        });
  }

  Widget cardWithNewRequest(BuildContext context) {
    var theme = Theme.of(context);

    return Center(
      child: SizedBox(
        key: UniqueKey(),
        width: double.infinity,
        child: CircularGlow(
          glowColor: secondaryColor,
          endRadius: 180.0,
          duration: const Duration(milliseconds: 2000),
          repeat: true,
          reverse: true,
          showTwoGlows: true,
          repeatPauseDuration: const Duration(milliseconds: 0),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 200),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: whiteColor.withOpacity(0.5),
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: secondaryColor.withOpacity(0.1),
              ),
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Incoming request',
                    style: theme.textTheme.subtitle1!
                        .copyWith(fontWeight: kMediumWeight),
                  ),
                  18.heightInPixel(),
                  Button(
                    text: 'View Details',
                    fontSize: 14,
                    onPress: () {
                      riderHomeStateBloc
                          .updateState(RiderOrderState.isNewRequestClicked);
                    },
                    color: appPrimaryColor,
                    textColor: whiteColor,
                    isLoading: false,
                    width: 125.0,
                    height: 47,
                    borderRadius: 10,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget cardWithLocation(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      constraints: const BoxConstraints(maxWidth: 450),
      margin: const EdgeInsets.symmetric(horizontal: kDefaultLayoutPadding),
      decoration: const BoxDecoration(
          color: whiteColor, borderRadius: Radii.k8pxRadius),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
              child: Image.asset(
                Assets.rider_home_location,
                height: 130,
              ),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            'My Location',
                            style: theme.textTheme.bodyText1!
                                .copyWith(fontWeight: kMediumWeight),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Image.asset(
                            Assets.rider_location_icon,
                            width: 20,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      StreamBuilder<LocationData>(
                        stream: miscBloc.location.onLocationChanged,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return FutureBuilder<String>(
                                future: getAddressFromLatLng(
                                    snapshot.data?.latitude ?? 0.0,
                                    snapshot.data?.longitude ?? 0.0),
                                builder: (context, snapshot) {
                                  String address = '...';
                                  if (snapshot.hasData) {
                                    address = snapshot.data ?? '-';
                                  } else {
                                    address = '...';
                                  }
                                  return ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxWidth: safeAreaWidth(context, 60)),
                                    child: Text(
                                      address,
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(
                                              fontWeight: kMediumWeight,
                                              color: dividerColor),
                                    ),
                                  );
                                });
                          }
                          return const SizedBox();
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
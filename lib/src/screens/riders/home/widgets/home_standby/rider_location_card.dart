/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'package:custom_bloc/custom_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:location/location.dart';
import 'package:trakk/src/bloc/app_settings_bloc.dart';
import 'package:trakk/src/bloc/misc_bloc.dart';
import 'package:trakk/src/bloc/rider/get_vehicles_for_rider_list_bloc.dart';
import 'package:trakk/src/bloc/rider/rider_home_state_bloc.dart';
import 'package:trakk/src/bloc/rider/rider_map_socket.dart';
import 'package:trakk/src/models/app_settings.dart';
import 'package:trakk/src/models/merchant/get_vehicles_for_merchant_response.dart';
import 'package:trakk/src/models/rider/add_rider_to_merchant_model.dart';
import 'package:trakk/src/models/rider/order_response.dart';
import 'package:trakk/src/screens/auth/rider/next_of_kin.dart';
import 'package:trakk/src/screens/merchant/add_rider1.dart';
import 'package:trakk/src/screens/merchant/add_rider_2/add_rider2.dart';
import 'package:trakk/src/utils/app_toast.dart';
import 'package:trakk/src/utils/glow_widget.dart';
import 'package:trakk/src/utils/helper_utils.dart';
import 'package:trakk/src/values/enums.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/widgets/button.dart';

class RiderLocationCard extends StatefulWidget {
  final MiscBloc locaBloc;

  const RiderLocationCard(this.locaBloc, {Key? key}) : super(key: key);

  static const String id = 'riderLocationCard';

  @override
  _RiderLocationCardState createState() => _RiderLocationCardState();
}

class _RiderLocationCardState extends State<RiderLocationCard> {
  @override
  void initState() {
    super.initState();
    widget.locaBloc.fetchLocation();
    getVehiclesForRiderListBloc.fetchCurrent();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return StreamBuilder<AppSettings>(
        stream: appSettingsBloc.appSettings,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            bool completedContact = snapshot.data?.loginResponse?.data?.user
                    ?.onBoardingSteps?.riderContactCompleted ??
                false;
            bool completedNok = snapshot.data?.loginResponse?.data?.user
                    ?.onBoardingSteps?.riderNOKCompleted ??
                false;
            bool completedVehicles = snapshot.data?.loginResponse?.data?.user
                    ?.onBoardingSteps?.riderVehicleCompleted ??
                false;

            if (!completedContact || !completedNok || !completedVehicles) {
              return cardWithOnBoarding(
                  context, completedContact, completedNok, completedVehicles);
            }

            return CustomStreamBuilder<RiderOrderState, String>(
                stream: riderHomeStateBloc.behaviorSubject,
                dataBuilder: (context, data) {
                  if (data == RiderOrderState.isNewRequestIncoming) {
                    return StreamBuilder<
                            BaseModel<List<OrderResponse>, String>>(
                        stream: riderStreamSocket.behaviorSubject,
                        builder: (context, snapshot) {
                          if (snapshot.hasData &&
                              snapshot.data?.model != null &&
                              snapshot.data!.model!.isNotEmpty) {
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
          endRadius: safeAreaHeight(context, 20),
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
                  2.safeAreaHeight(context),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 50),
                    child: Button(
                      text: 'View Details',
                      fontSize: 14,
                      onPress: () {
                        riderHomeStateBloc
                            .updateState(RiderOrderState.isNewRequestClicked);
                        FlutterRingtonePlayer.stop();
                      },
                      color: appPrimaryColor,
                      textColor: whiteColor,
                      isLoading: false,
                      width: 125.0,
                      borderRadius: 10,
                    ),
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
                //if suspended? Assets.rider_home_suspended
                Assets.rider_home_location,
                height: 135,
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

  Widget cardWithOnBoarding(BuildContext context, bool completedContact,
      bool completedNok, bool completedVehicles) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);

    return Container(
      constraints: const BoxConstraints(maxWidth: 450),
      margin: const EdgeInsets.symmetric(horizontal: kDefaultLayoutPadding),
      decoration: const BoxDecoration(
          color: whiteColor, borderRadius: Radii.k8pxRadius),
      child: Container(
        height: 135,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  if (completedContact) {
                    appToast('You had previously added contact details');
                    return;
                  }
                  var model = AddRiderToMerchantModel(
                      data: AddRiderToMerchantModelData(
                          userId: ((await appSettingsBloc.fetchAppSettings())
                                      .loginResponse
                                      ?.data
                                      ?.user
                                      ?.id ??
                                  '')
                              .toString()));
                  Navigator.pushNamed(context, AddRider1.id, arguments: {
                    'rider_bio_data': model.toJson(),
                    'previousScreenID': RiderLocationCard.id
                  });
                },
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45.withOpacity(0.1),
                          spreadRadius: 1,
                          offset: const Offset(0.0, 0.0), //(x,y)
                          blurRadius: 8.0,
                        ),
                      ],
                      color: whiteColor,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Assets.rider_add_contact,
                          height: 20,
                          width: 20,
                        ),
                        2.5.heightInPixel(),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Add Contact Details',
                                textScaleFactor: 0.8,
                                textAlign: TextAlign.center,
                                style: theme.textTheme.caption!.copyWith(
                                  fontWeight: kSemiBoldWeight,
                                  //fontSize: textFontSize(context, 10)
                                ),
                              ),
                            ),
                            // 2.widthInPixel(),
                            Icon(
                              completedContact ? Icons.check : Icons.add,
                              size: 14,
                              color: secondaryColor,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            20.widthInPixel(),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (completedNok) {
                    appToast(
                        'You had previously added contact next of kin details');
                    return;
                  }
                  Navigator.pushNamed(context, NextOfKin.id);
                },
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45.withOpacity(0.1),
                          spreadRadius: 1,
                          offset: const Offset(0.0, 0.0), //(x,y)
                          blurRadius: 8.0,
                        ),
                      ],
                      color: whiteColor,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Assets.rider_add_next_of_kin,
                          height: 20,
                          width: 20,
                        ),
                        2.5.heightInPixel(),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Add Next of Kin Details',
                                textScaleFactor: 0.8,
                                textAlign: TextAlign.center,
                                style: theme.textTheme.caption!.copyWith(
                                  fontWeight: kSemiBoldWeight,
                                  //fontSize: textFontSize(context, 10)
                                ),
                              ),
                            ),
                            // 2.widthInPixel(),
                            Icon(
                              completedNok ? Icons.check : Icons.add,
                              size: 14,
                              color: secondaryColor,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            20.widthInPixel(),
            Expanded(
              child: StreamBuilder<
                      BaseModel<List<GetVehiclesForMerchantDatum>, String>>(
                  stream: getVehiclesForRiderListBloc.behaviorSubject,
                  builder: (context, snapshot) {
                    bool? completedVehicles;

                    if (snapshot.hasData) {
                      completedVehicles = snapshot.data!.hasData &&
                          (snapshot.data?.model?.length ?? 0) > 0;
                    }
                    return GestureDetector(
                      onTap: () {
                        if (completedVehicles == null) {
                          runToast('Fetching data');
                          return;
                        }
                        if (completedVehicles) {
                          appToast('You had previously added vehicle');
                          return;
                        }
                        Navigator.pushNamed(context, AddRider2.id, arguments: {
                          'previousScreenID': RiderLocationCard.id
                        });
                      },
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black45.withOpacity(0.1),
                                spreadRadius: 1,
                                offset: const Offset(0.0, 0.0), //(x,y)
                                blurRadius: 8.0,
                              ),
                            ],
                            color: whiteColor,
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                Assets.rider_add_vehicle_details,
                                height: 20,
                                width: 20,
                              ),
                              2.5.heightInPixel(),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Add Vehicle Details',
                                      textScaleFactor: 0.8,
                                      textAlign: TextAlign.center,
                                      style: theme.textTheme.caption!.copyWith(
                                        fontWeight: kSemiBoldWeight,
                                        //fontSize: textFontSize(context, 10)
                                      ),
                                    ),
                                  ),
                                  // 2.widthInPixel(),
                                  if (completedVehicles != null)
                                    Icon(
                                      completedVehicles
                                          ? Icons.check
                                          : Icons.add,
                                      size: 14,
                                      color: secondaryColor,
                                    )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

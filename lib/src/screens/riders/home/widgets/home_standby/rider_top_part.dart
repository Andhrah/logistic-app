/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_bloc/custom_bloc.dart';
import 'package:flutter/material.dart';
import 'package:trakk/src/bloc/app_settings_bloc.dart';
import 'package:trakk/src/bloc/socket_state_bloc.dart';
import 'package:trakk/src/models/app_settings.dart';
import 'package:trakk/src/screens/merchant/merchant_notifications.dart';
import 'package:trakk/src/screens/riders/home/widgets/home_standby/rider_notification.dart';
import 'package:trakk/src/utils/helper_utils.dart';
import 'package:trakk/src/values/enums.dart';
import 'package:trakk/src/values/values.dart';

class RiderTopPart extends StatefulWidget {
  final Function(int index) forHomeNavigation;

  const RiderTopPart(this.forHomeNavigation, {Key? key}) : super(key: key);

  @override
  _RiderTopPartState createState() => _RiderTopPartState();
}

class _RiderTopPartState extends State<RiderTopPart> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SafeArea(child: SizedBox(height: 12.0)),
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: kDefaultLayoutPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StreamBuilder<AppSettings>(
                  stream: appSettingsBloc.appSettings,
                  builder: (context, snapshot) {
                    String avatar = '';

                    if (snapshot.hasData) {
                      avatar =
                          snapshot.data?.loginResponse?.data?.user?.avatar ??
                              '';
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            widget.forHomeNavigation(3);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: whiteColor, width: 1.5)),
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: avatar,
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Image.asset(
                                  Assets.dummy_avatar,
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.cover,
                                ),
                                errorWidget: (context, url, err) => Image.asset(
                                  Assets.dummy_avatar,
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        StreamBuilder<BaseModel<NetworkState, String>>(
                            stream: socketStateBloc.behaviorSubject,
                            builder: (context, snapshot) {
                              NetworkState state = NetworkState.connecting;

                              if (snapshot.hasData &&
                                  snapshot.data?.model != null) {
                                state = snapshot.data!.model!;
                              }
                              return Text(
                                state == NetworkState.connecting
                                    ? 'Connecting'
                                    : state == NetworkState.connected
                                        ? 'Active'
                                        : 'Inactive',
                                style: theme.textTheme.caption!.copyWith(
                                    color: secondaryColor, height: 1.55),
                              );
                            }),
                      ],
                    );
                  }),
              // InkWell(
              //   onTap: () {
              //     Navigator.pushNamed(context, RiderNotification.id);
              //   },
              //   child: Container(
              //     decoration: const BoxDecoration(
              //         color: secondaryColor, borderRadius: Radii.k4pxRadius),
              //     padding: const EdgeInsets.all(8),
              //     child: Image.asset(
              //       Assets.notification_icon_only,
              //       width: 22,
              //     ),
              //   ),
              // )
            ],
          ),
        ),
        const SizedBox(
          height: 34,
        ),
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: kDefaultLayoutPadding),
          child: StreamBuilder<AppSettings>(
              stream: appSettingsBloc.appSettings,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    'Hello ${snapshot.data?.loginResponse?.data?.user?.firstName ?? ''},',
                    style: theme.textTheme.headline5!.copyWith(
                        fontWeight: kSemiBoldWeight, color: whiteColor),
                  );
                }
                return const SizedBox();
              }),
        ),
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: kDefaultLayoutPadding),
          child: Text(
            greetWithTime(),
            style: theme.textTheme.subtitle1!.copyWith(
              color: whiteColor,
            ),
          ),
        ),
      ],
    );
  }
}

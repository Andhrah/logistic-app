/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'dart:async';

import 'package:custom_bloc/custom_bloc.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:trakk/src/bloc/misc_bloc.dart';
import 'package:trakk/src/bloc/rider/rider_home_state_bloc.dart';
import 'package:trakk/src/mixins/connectivity_helper.dart';
import 'package:trakk/src/mixins/profile_helper.dart';
import 'package:trakk/src/models/update_profile/update_profile.dart';
import 'package:trakk/src/provider/rider/rider_map_provider.dart';
import 'package:trakk/src/screens/riders/home/widgets/home_map/rider_home_map.dart';
import 'package:trakk/src/screens/riders/home/widgets/home_standby/rider_home_standby.dart';
import 'package:trakk/src/utils/app_toast.dart';
import 'package:trakk/src/utils/helper_utils.dart';
import 'package:trakk/src/values/assets.dart';
import 'package:trakk/src/values/enums.dart';

class RiderHomeScreen extends StatefulWidget {
  final Function(int index) forHomeNavigation;

  const RiderHomeScreen(this.forHomeNavigation, {Key? key}) : super(key: key);

  @override
  _RiderHomeScreenState createState() => _RiderHomeScreenState();
}

class _RiderHomeScreenState extends State<RiderHomeScreen>
    with ProfileHelper, ConnectivityHelper {
  final locaBloc = MiscBloc();

  double distance = 0.0;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    //update the state here, socket will change the screen when there is an event
    riderHomeStateBloc.updateState(RiderOrderState.isHomeScreen);
    Location.instance.requestPermission();

    _timer = Timer.periodic(const Duration(minutes: 2), (timer) {
      scheduler();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
  }

  scheduler() async {
    var location = await locaBloc.fetchLocation();
    String address = '';
    try {
      address = await getAddressFromLatLng(
          location?.latitude ?? 0.0, location?.longitude ?? 0.0);
    } catch (err) {
      address = '';
    }
    doUpdateRiderLocationManuallyOperation(
      UpdateProfile.riderLocation(
          currentLocation: address,
          currentLatitude: location?.latitude ?? 0.0,
          currentLongitude: location?.longitude ?? 0.0),
      () {},
      () {},
    );
  }

  init() async {
    var injector = RiderMapProvider.riderMapProvider(context);
    // injector.connect();
    injector.connectAndListenToSocket(
      onConnected: () {},
      onConnectionError: () {
        runToast('Connection error, retrying connection');
        init();
        // showDialogButton(context, 'Failed', 'Could not start service', 'Ok');
      },
    );
  }

  @override
  void dispose() {
    riderHomeStateBloc.invalidate();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Assets.rider_home_bg), fit: BoxFit.cover)),
        child: CustomStreamBuilder<RiderOrderState, String>(
          stream: riderHomeStateBloc.behaviorSubject,
          dataBuilder: (context, data) {
            if (data == RiderOrderState.isHomeScreen ||
                data == RiderOrderState.isNewRequestIncoming ||
                data == RiderOrderState.isNewRequestClicked) {
              return RiderHomeStandbyScreen(locaBloc, widget.forHomeNavigation);
            }

            return RiderHomeMapScreen(locaBloc, data);
          },
          loadingBuilder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorBuilder: (context, err) => Center(
            child: Text(err),
          ),
        ),
      ),
    );
  }
}

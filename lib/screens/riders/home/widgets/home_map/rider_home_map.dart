import 'dart:async';

import 'package:custom_bloc/custom_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:trakk/bloc/map_socket.dart';
import 'package:trakk/bloc/map_ui_extras_bloc.dart';
import 'package:trakk/bloc/misc_bloc.dart';
import 'package:trakk/screens/riders/home/widgets/home_map/rider_bottom_sheet.dart';
import 'package:trakk/utils/assets.dart';
import 'package:trakk/utils/enums.dart';
import 'package:trakk/utils/helper_utils.dart';
import 'package:trakk/utils/map_style.dart';

class RiderHomeMapScreen extends StatefulWidget {
  final MiscBloc locaBloc;
  final RiderOrderState orderState;
  static const String id = 'riderHome';

  const RiderHomeMapScreen(this.locaBloc, this.orderState, {Key? key})
      : super(key: key);

  @override
  _RiderHomeMapScreenState createState() => _RiderHomeMapScreenState();
}

class _RiderHomeMapScreenState extends State<RiderHomeMapScreen> {
  MapExtraUIBloc mapExtraUIBloc = MapExtraUIBloc();

  double initialSize = 0.07;

  double maxSize = 0.5;

  final Completer<GoogleMapController> _controller = Completer();

  var bottomSheetKey = UniqueKey();

  @override
  void initState() {
    super.initState();

    if (widget.orderState == RiderOrderState.isOrderCompleted) {
      maxSize = 0.7;
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      streamSocket.getResponse.listen((event) {
        initialSize = 0.5;
        if (event.order != null) {
          if (event.order!.destinationLatitude != null &&
                  event.order!.destinationLongitude != null &&
                  widget.orderState ==
                      RiderOrderState.isItemPickedUpLocationAndEnRoute ||
              widget.orderState ==
                  RiderOrderState.isAlmostAtDestinationLocation) {
            //meant to be for auto map route plotting

          }

          if (event.order!.pickupLatitude != null &&
              event.order!.pickupLongitude != null &&
              widget.orderState == RiderOrderState.isAlmostAtPickupLocation) {
            // if (speakIsCloseOnce) {
            //   _speak('You are getting close');
            //   speakIsCloseOnce = false;
          }
        }
        if (widget.orderState == RiderOrderState.isAtDestinationLocation ||
            widget.orderState == RiderOrderState.isOrderCompleted) {
          mapExtraUIBloc.stopFetchingRoute();
        }
      });
    });
  }

  @override
  void dispose() {
    mapExtraUIBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Assets.rider_home_bg), fit: BoxFit.cover)),
      child: Stack(
        children: [
          GestureDetector(
            onDoubleTap: () => _updateKey(),
            child: StreamBuilder<LocationData>(
                stream: widget.locaBloc.location.onLocationChanged,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                        height: widget.orderState ==
                                RiderOrderState.isItemPickedUpLocationAndEnRoute
                            ? safeAreaHeight(context, 100)
                            : safeAreaHeight(context, 99),
                        child: StreamBuilder<BaseModel<MapExtraUI, String>>(
                            stream: mapExtraUIBloc.behaviorSubject,
                            builder: (context, snapshot) {
                              Set<Marker> _markers =
                                  snapshot.data?.model?.marker ?? {};

                              Set<Polyline> _polyLines =
                                  snapshot.data?.model?.polyline ?? {};

                              return GoogleMap(
                                  onMapCreated: _onMapCreated,
                                  myLocationEnabled: true,
                                  zoomGesturesEnabled: true,
                                  onCameraMove: (CameraPosition pos) {},
                                  gestureRecognizers: {}..addAll([
                                      Factory<PanGestureRecognizer>(
                                          () => PanGestureRecognizer()),
                                      Factory<VerticalDragGestureRecognizer>(
                                          () =>
                                              VerticalDragGestureRecognizer()),
                                      Factory<HorizontalDragGestureRecognizer>(
                                          () =>
                                              HorizontalDragGestureRecognizer())
                                    ]),
                                  markers: _markers,
                                  polylines: _polyLines,
                                  initialCameraPosition: const CameraPosition(
                                      target: LatLng(0, 0)));
                            }));
                  }
                  return const SizedBox();
                }),
          ),
          RiderBottomSheet(
            key: bottomSheetKey,
            initialSize: initialSize,
            maxSize: maxSize,
          ),
        ],
      ),
    );
  }

  _updateKey() => setState(() => bottomSheetKey = UniqueKey());

  void moveCameraToUser() async {
    final loca = await miscBloc.fetchLocation();
    if (loca != null) {
      final latitude = loca.latitude ?? 0;
      final longitude = loca.longitude ?? 0;
      final center = LatLng(latitude, longitude);

      final GoogleMapController controller = await _controller.future;

      setState(() {
        controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: center, zoom: 15.0)));
      });
    } else {
      // await miscBloc.fetchLocation();
      moveCameraToUser();
    }
  }

  void _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);

    ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    setState(() {
      if (isDark) {
        controller.setMapStyle(MapStyle().night);
      } else {
        controller.setMapStyle(MapStyle().sliver);
      }
    });
    // await miscBloc.fetchLocation();

    moveCameraToUser();
  }
}
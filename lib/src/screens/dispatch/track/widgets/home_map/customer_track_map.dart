import 'dart:async';

import 'package:custom_bloc/custom_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trakk/src/bloc/customer/customer_map_socket.dart';
import 'package:trakk/src/bloc/map_ui_extras_bloc.dart';
import 'package:trakk/src/bloc/misc_bloc.dart';
import 'package:trakk/src/models/order/user_order_history_response.dart';
import 'package:trakk/src/screens/dispatch/track/widgets/home_map/customer_bottom_sheet.dart';
import 'package:trakk/src/utils/helper_utils.dart';
import 'package:trakk/src/values/assets.dart';
import 'package:trakk/src/values/enums.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/widgets/back_icon.dart';

class CustomerHomeMapScreen extends StatefulWidget {
  final MiscBloc locaBloc;

  const CustomerHomeMapScreen(this.locaBloc, {Key? key}) : super(key: key);

  @override
  _CustomerHomeMapScreenState createState() => _CustomerHomeMapScreenState();
}

class _CustomerHomeMapScreenState extends State<CustomerHomeMapScreen> {
  MapExtraUIBloc mapExtraUIBloc = MapExtraUIBloc();

  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
          SizedBox(
              height: safeAreaHeight(context, 100),
              child: StreamBuilder<BaseModel<MapExtraUI, String>>(
                  stream: mapExtraUIBloc.behaviorSubject,
                  builder: (context, snapshot) {
                    Set<Marker> _markers = snapshot.data?.model?.marker ?? {};

                    Set<Polyline> _polyLines =
                        snapshot.data?.model?.polyline ?? {};

                    return GoogleMap(
                        onMapCreated: (controller) {
                          _controller.complete(controller);
                          _onMapCreated(controller);
                        },
                        myLocationEnabled: false,
                        myLocationButtonEnabled: false,
                        zoomGesturesEnabled: true,
                        onCameraMove: (CameraPosition pos) {},
                        gestureRecognizers: {}..addAll([
                            Factory<PanGestureRecognizer>(
                                () => PanGestureRecognizer()),
                            Factory<VerticalDragGestureRecognizer>(
                                () => VerticalDragGestureRecognizer()),
                            Factory<HorizontalDragGestureRecognizer>(
                                () => HorizontalDragGestureRecognizer())
                          ]),
                        markers: _markers,
                        polylines: _polyLines,
                        initialCameraPosition:
                            const CameraPosition(target: LatLng(0, 0)));
                  })),
          const CustomerBottomSheet(),
          Positioned(
            top: 12,
            left: kDefaultLayoutPadding,
            child: SafeArea(
              child: BackIcon(
                onPress: () {
                  Navigator.pop(context);
                },
                padding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void moveCameraToUser({LatLng? riderLatLng}) async {
    if (riderLatLng != null) {
      final GoogleMapController controller = await _controller.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: riderLatLng, zoom: 16.0)));
    }
  }

  void _onMapCreated(GoogleMapController controller) async {
    customerStreamSocket.behaviorSubject.listen((value) {
      if (value.model != null && mounted) {
        String status = value.model?.info?.status ?? '';
        var fromLatLng = LatLng(
            (double.tryParse(value.model?.info?.currentLatitude ?? '0.0') ??
                0.0),
            (double.tryParse(value.model?.info?.currentLongitude ?? '0.0') ??
                0.0));

        // print('fromLatLng: ${fromLatLng.latitude} ${fromLatLng.longitude}');
        moveCameraToUser(riderLatLng: fromLatLng);

        var arg = ModalRoute.of(context)!.settings.arguments;
        if (arg != null) {
          final model =
              UserOrderHistoryDatum.fromJson(arg as Map<String, dynamic>);

          if (model.id != null) {
            // print('------attributes------');
            // print(model.attributes?.pickupLatitude ?? 0.0);
            // print(model.attributes?.pickupLongitude ?? 0.0);

            //Status we have that rider can broadcast
            // pending, to-pickup,delivered,delivery_confirmed
            mapExtraUIBloc.updateMarkersWithCircle(
              (status == RiderOrderStatus.pending.name ||
                      status == RiderOrderStatus.toPickup.name)
                  ? [
                      LatLng(
                        model.attributes?.pickupLatitude ?? 0.0,
                        model.attributes?.pickupLongitude ?? 0.0,
                      )
                    ]
                  : [
                      LatLng(
                        model.attributes?.destinationLatitude ?? 0.0,
                        model.attributes?.destinationLongitude ?? 0.0,
                      )
                    ],
              (status == RiderOrderStatus.pending.name ||
                      status == RiderOrderStatus.toPickup.name)
                  ? 'Pickup'
                  : 'Destination',
              true,
              true,
              fromLatLng: fromLatLng,
            );
          }
        }
        // isLoadedAtLeastOnce = true;
      }
    });
  }
}

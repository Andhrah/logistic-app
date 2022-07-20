import 'dart:async';

import 'package:custom_bloc/custom_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trakk/src/bloc/customer/customer_map_socket.dart';
import 'package:trakk/src/bloc/map_ui_extras_bloc.dart';
import 'package:trakk/src/bloc/misc_bloc.dart';
import 'package:trakk/src/screens/dispatch/track/widgets/home_map/customer_bottom_sheet.dart';
import 'package:trakk/src/utils/helper_utils.dart';
import 'package:trakk/src/values/assets.dart';

class CustomerHomeMapScreen extends StatefulWidget {
  final MiscBloc locaBloc;

  const CustomerHomeMapScreen(this.locaBloc, {Key? key}) : super(key: key);

  @override
  _CustomerHomeMapScreenState createState() => _CustomerHomeMapScreenState();
}

class _CustomerHomeMapScreenState extends State<CustomerHomeMapScreen> {
  MapExtraUIBloc mapExtraUIBloc = MapExtraUIBloc();

  final Completer<GoogleMapController> _controller = Completer();

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
    // final datum = UserOrderHistoryDatum.fromJson(
    //     (ModalRoute.of(context)!.settings.arguments) as Map<String, dynamic>);

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
                        onMapCreated: _onMapCreated,
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
        ],
      ),
    );
  }

  void moveCameraToUser(LatLng riderLatLng) async {
    final GoogleMapController controller = await _controller.future;

    setState(() {
      controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: riderLatLng, zoom: 15.0)));
    });
  }

  bool isLoadedAtLeastOnce = false;

  void _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);

    // ThemeData theme = Theme.of(context);
    // final bool isDark = theme.brightness == Brightness.dark;
    // setState(() {
    //   if (isDark) {
    //     controller.setMapStyle(MapStyle().night);
    //   } else {
    //     controller.setMapStyle(MapStyle().retro);
    //   }
    // });
    // // await miscBloc.fetchLocation();

    customerStreamSocket.behaviorSubject.listen((value) {
      if (value.model != null && !isLoadedAtLeastOnce) {
        moveCameraToUser(value.model!);

        isLoadedAtLeastOnce = true;
      }
    });
  }
}
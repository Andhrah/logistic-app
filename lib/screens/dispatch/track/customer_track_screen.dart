import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:trakk/bloc/map_ui_extras_bloc.dart';
import 'package:trakk/bloc/misc_bloc.dart';
import 'package:trakk/models/order/user_order_history_response.dart';
import 'package:trakk/provider/customer/customer_map_provider.dart';
import 'package:trakk/screens/dispatch/track/widgets/home_map/customer_track_map.dart';

class CustomerTrackScreen extends StatefulWidget {
  static const String id = 'customerTrackScreen';

  const CustomerTrackScreen({Key? key}) : super(key: key);

  @override
  _CustomerTrackScreenState createState() => _CustomerTrackScreenState();
}

class _CustomerTrackScreenState extends State<CustomerTrackScreen> {
  final locaBloc = MiscBloc();

  double distance = 0.0;
  CustomerMapProvider? injector;

  @override
  void initState() {
    super.initState();
    Location.instance.requestPermission();

    init();
  }

  init() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final arg = UserOrderHistoryDatum.fromJson(
          (ModalRoute.of(context)!.settings.arguments) as Map<String, dynamic>);

      if (arg.id != null) {
        injector = CustomerMapProvider.customerMapProvider(context);
        // injector.connect();
        injector?.connectAndListenToSocket(
            orderID: arg.id.toString(),
            onConnected: () {
              // var model = customerStreamSocket.behaviorSubject.value.model;
              var arg = ModalRoute.of(context)!.settings.arguments;
              if (arg != null) {
                final model = UserOrderHistoryDatum.fromJson(
                    (ModalRoute.of(context)!.settings.arguments)
                        as Map<String, dynamic>);

                if (model.attributes != null) {
                  mapExtraUIBloc.updateMarkersWithCircle([
                    LatLng(
                      model.attributes?.destinationLatitude ?? 0.0,
                      model.attributes?.destinationLongitude ?? 0.0,
                    )
                  ], 'Destination', true, true,
                      fromLatLng: LatLng(
                        model.attributes?.pickupLatitude ?? 0.0,
                        model.attributes?.pickupLongitude ?? 0.0,
                      ));
                }
              }
            },
            onConnectionError: () {
              injector?.disconnectSocket();
              // showDialogButton(context, 'Failed', 'Could not start service', 'Ok');
            });
      }
    });
  }

  @override
  void dispose() {
    if (injector != null) injector?.disconnectSocket();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: CustomerHomeMapScreen(locaBloc),
    );
  }
}

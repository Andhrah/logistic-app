import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:trakk/src/bloc/misc_bloc.dart';
import 'package:trakk/src/models/order/user_order_history_response.dart';
import 'package:trakk/src/provider/customer/customer_map_provider.dart';
import 'package:trakk/src/screens/dispatch/track/widgets/home_map/customer_track_map.dart';

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
      var arg = ModalRoute.of(context)!.settings.arguments;
      if (arg != null) {
        final model =
            UserOrderHistoryDatum.fromJson(arg as Map<String, dynamic>);

        if (model.id != null) {
          injector = CustomerMapProvider.customerMapProvider(context);
          // injector.connect();
          injector?.connectAndListenToSocket(
              toLatLng: LatLng(
                model.attributes?.destinationLatitude ?? 0.0,
                model.attributes?.destinationLongitude ?? 0.0,
              ),
              orderID: model.id.toString(),
              onConnected: () {},
              onConnectionError: () {
                injector?.disconnectSocket();
                // showDialogButton(context, 'Failed', 'Could not start service', 'Ok');
              });
        }
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

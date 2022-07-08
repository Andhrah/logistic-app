import 'package:custom_bloc/custom_bloc.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:trakk/bloc/misc_bloc.dart';
import 'package:trakk/bloc/rider_home_state_bloc.dart';
import 'package:trakk/provider/merchant/rider_map_provider.dart';
import 'package:trakk/screens/riders/home/widgets/home_map/rider_home_map.dart';
import 'package:trakk/screens/riders/home/widgets/home_standby/rider_home_standby.dart';
import 'package:trakk/services/get_user_service.dart';
import 'package:trakk/utils/assets.dart';
import 'package:trakk/utils/enums.dart';

class RiderHomeScreen extends StatefulWidget {
  static const String id = 'riderHome';

  const RiderHomeScreen({Key? key}) : super(key: key);

  @override
  _RiderHomeScreenState createState() => _RiderHomeScreenState();
}

class _RiderHomeScreenState extends State<RiderHomeScreen> {
  final locaBloc = MiscBloc();

  double distance = 0.0;

  @override
  void initState() {
    super.initState();
    //update the state here, socket will change the screen when there is an event
    riderHomeStateBloc.updateState(RiderOrderState.isHomeScreen);
    Location.instance.requestPermission();

    init();
  }

  init() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var injector = RiderMapProvider.riderMapProvider(context);
      injector.connect();
      // injector.connectAndListenToSocket(
      //     onConnected: () {},
      //     onConnectionError: () {
      //       injector.disconnectSocket();
      //       // showDialogButton(context, 'Failed', 'Could not start service', 'Ok');
      //     });
    });
  }

  @override
  void dispose() {
    locaBloc.dispose();
    riderHomeStateBloc.invalidate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Assets.rider_home_bg), fit: BoxFit.cover)),
        child: CustomStreamBuilder<RiderOrderState, String>(
          stream: riderHomeStateBloc.behaviorSubject,
          dataBuilder: (context, data) {
            if (data == RiderOrderState.isHomeScreen ||
                data == RiderOrderState.isOrderCompleted) {
              return RiderHomeStandbyScreen(locaBloc);
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

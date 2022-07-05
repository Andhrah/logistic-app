import 'package:custom_bloc/custom_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:remixicon/remixicon.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:trakk/bloc/misc_bloc.dart';
import 'package:trakk/bloc/rider_home_state_bloc.dart';
import 'package:trakk/provider/merchant/rider_map_provider.dart';
import 'package:trakk/screens/riders/home/widgets/home_map/rider_home_map.dart';
import 'package:trakk/screens/riders/home/widgets/home_standby/rider_home_standby.dart';
import 'package:trakk/screens/riders/pick_up.dart';
import 'package:trakk/services/get_user_service.dart';
import 'package:trakk/utils/assets.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/utils/constant.dart';
import 'package:trakk/utils/enums.dart';
// import 'package:trakk/utils/constant.dart';
import 'package:trakk/widgets/button.dart';

class RiderHomeScreen extends StatefulWidget {
  static const String id = 'riderHome';

  const RiderHomeScreen({Key? key}) : super(key: key);

  @override
  _RiderHomeScreenState createState() => _RiderHomeScreenState();
}

class _RiderHomeScreenState extends State<RiderHomeScreen> {
  final locaBloc = MiscBloc();

  GoogleMapController? mapController; //contrller for Google map
  PolylinePoints polylinePoints = PolylinePoints();

  String googleAPiKey = "AIzaSyBvxkb0Gv6kwpiplPtmeQZhG4_V-KvLZ1U";

  Set<Marker> markers = {}; //markers for google map
  Map<PolylineId, Polyline> polylines = {};
  late IO.Socket socket;

  //var box = Hive.box('userData');
  //double pickupLongitude = box.get('pickupLongitude');

  //  LatLng startLocation = LatLng(
  //     double.parse(box.get("pickupLongitude")), double.parse(box.get("pickupLatitude")));
  // LatLng endLocation = LatLng(double.parse(box.get("destinationLatitude")),
  //     double.parse(box.get("destinationLongitude")));

  double distance = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Location.instance.requestPermission();

    GetUserData.getUser();
    print("connect called");
    connect();
    print("${box.get('riderId')} hollow");
    listenToRequest();

    var injector = RiderMapProvider.riderMapProvider(context);
    injector.connectAndListenToSocket(
        onConnected: () {},
        onConnectionError: () {
          injector.disconnectSocket();
          // showDialogButton(context, 'Failed', 'Could not start service', 'Ok');
        });
  }

  void connect() {
    socket = IO.io("http://134.122.92.247:1440", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
      'path': '/socket/v1/',
      'auth': {
        // put token here, it will be used to make authenticated calls
        "token":
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NTMsImlhdCI6MTY1NTQ1MzU2OCwiZXhwIjoxNjU1NTM5OTY4fQ.o6t0HuncCBjace-EZpP-HqXV9BfxWLZCD4eSTEE52gk"
      }
    });
    socket.connect();
    socket.onConnect((data) => print(" the sever is connected"));
    listenToRequest();
    print("this is the socket response " + socket.connected.toString());
    //ride request with the rider id, so we will retrieve the rider's id and use it here

    //socket.emit("message", "Test for riders");
  }

  @override
  void dispose() {
    listenToRequest();
    locaBloc.dispose();
    riderHomeStateBloc.invalidate();
    connect();
    super.dispose();
  }

  Future<void> listenToRequest() async {
    print('just to test>>>>');
    //await Future.delayed(const Duration(milliseconds: 3000));

    socket.on("rider_request_${box.get('riderId')}", (data) async {
      print("value of data >>>" + data.toString());
      await box.putAll({
        "pickupLongitude": data["order"]["pickupLongitude"],
        "pickupLatitude": data["order"]["pickupLatitude"],
        "destinationLatitude": data["order"]["destinationLatitude"],
        "destinationLongitude": data["order"]["destinationLongitude"],
      });

      var id = data["order"]["id"];
      var pickup = data["order"]["pickup"];
      var destination = data["order"]["destination"];
      var pickupLongitude = data["order"]["pickupLongitude"];
      // var pickupLatitude = data["order"]["pickupLatitude"];
      // var destinationLatitude = data["order"]["destinationLatitude"];
      // var destinationLongitude = data["order"]["destinationLongitude"];
      print(
          "${box.get(["destinationLongitude"].toString())} >>>>>>>>>long lat");

      showOrder(context, id, pickup, destination);
      print(data["order"]["id"]);
      //data;
    });
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

  Future<dynamic> showOrder(
      BuildContext context, var id, pickup, String destination) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0))),
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TweenAnimationBuilder(
                  tween: Tween(
                      begin: const Duration(minutes: 2), end: Duration.zero),
                  duration: const Duration(minutes: 3),
                  builder:
                      (BuildContext context, Duration value, Widget? child) {
                    final minutes = value.inMinutes;
                    final seconds = value.inSeconds % 60;
                    return Container(
                        height: 150.0,
                        width: 150.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: appPrimaryColor,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('$minutes:$seconds',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: secondaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30))
                          ],
                        ));
                  }),
              const SizedBox(height: 80.0),
              Container(
                  padding: const EdgeInsetsDirectional.only(top: 20.0),
                  decoration: const BoxDecoration(
                    color: whiteColor,
                    // color: Colors.amber,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: Column(children: [
                    ListTile(
                      leading: Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade200),
                        child: const Icon(
                          Remix.user_3_fill,
                          size: 30.0,
                          color: appPrimaryColor,
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Order ID',
                            textScaleFactor: 1.2,
                            style: TextStyle(
                                color: appPrimaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            id.toString(),
                            textScaleFactor: 1.0,
                            style: TextStyle(
                              color: appPrimaryColor.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Divider(
                      color: appPrimaryColor.withOpacity(0.4),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 20.0),
                        Column(
                          children: [
                            Text(
                              '6\nmin',
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                color: appPrimaryColor.withOpacity(0.3),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Text(
                              '28\nmin',
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                color: appPrimaryColor.withOpacity(0.3),
                              ),
                            ),
                          ],
                        ),
                        Image.asset(
                          'assets/images/order_highlighter.png',
                          height: 160,
                          width: 30,
                        ),
                        const SizedBox(width: 20.0),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'My location',
                              textScaleFactor: 1.2,
                              style: TextStyle(
                                  color: appPrimaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5.0),
                            Text(
                              '1.2km',
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                color: appPrimaryColor.withOpacity(0.3),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 10.0, bottom: 10.0),
                              color: appPrimaryColor.withOpacity(0.2),
                              height: 1.0,
                              width: MediaQuery.of(context).size.width / 1.3,
                            ),
                            Text(
                              pickup,
                              textScaleFactor: 1.1,
                              style: TextStyle(
                                  color: appPrimaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5.0),
                            Text(
                              distance.toStringAsFixed(2) + "KM",
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                color: appPrimaryColor.withOpacity(0.3),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 10.0, bottom: 10.0),
                              color: appPrimaryColor.withOpacity(0.2),
                              height: 1.0,
                              width: MediaQuery.of(context).size.width / 1.3,
                            ),
                            Text(
                              destination,
                              textScaleFactor: 1.2,
                              style: const TextStyle(
                                  color: appPrimaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 30.0),
                    Row(
                      children: [
                        const SizedBox(width: 40.0),
                        Expanded(
                          child: Button(
                            text: 'Accept',
                            onPress: () {
                              Navigator.of(context).pushNamed(PickUpScreen.id);
                              //Navigator.pop(context);
                            },
                            color: secondaryColor,
                            textColor: appPrimaryColor,
                            isLoading: false,
                            width: 60.0,
                            // width: MediaQuery.of(context).size.width/6
                          ),
                        ),
                        const SizedBox(width: 20.0),
                        Expanded(
                          child: Button(
                              text: 'Decline',
                              onPress: () {
                                // Navigator.of(context).pushNamed(id);
                                Navigator.pop(context);
                              },
                              color: appPrimaryColor,
                              textColor: whiteColor,
                              isLoading: false,
                              width: MediaQuery.of(context).size.width / 7),
                        ),
                        const SizedBox(width: 40.0),
                      ],
                    ),
                    const SizedBox(height: 30.0),
                  ])),
            ],
          );
        });
  }
}

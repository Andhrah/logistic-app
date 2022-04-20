import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trakk/screens/dispatch/checkout.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/widgets/header.dart';
import 'package:trakk/widgets/input_field.dart';

class PickRide extends StatefulWidget {
  static const String id = 'pickRide';

  const PickRide({Key? key}) : super(key: key);

  @override
  _PickRideState createState() => _PickRideState();
}

class _PickRideState extends State<PickRide> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 30.0),
              const Header(
                text: 'PICK A RIDE',
              ),

              Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/map_pin.png",
                      height: 100.0,
                    ),

                    const SizedBox(width: 20.0),
                    Container(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      width: 280.0,
                      child: Column(
                        children: [
                          InputField(
                            text: '',
                            hintText: 'Item’s Location',
                            textHeight: 0.0,
                            borderColor: appPrimaryColor.withOpacity(0.5),
                          ),

                          InputField(
                            text: '',
                            hintText: 'Item’s Destination',
                            textHeight: 0,
                            borderColor: appPrimaryColor.withOpacity(0.5),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      child: GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: _kGooglePlex,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                      ),
                    ),
                  ]
                ),
              ),

              Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  // side: BorderSide(color: appPrimaryColor.withOpacity(0.3), width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  width: MediaQuery.of(context).size.width/1.2,
                  // height: 170,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            width: MediaQuery.of(context).size.width/3,
                            child: Image.asset(
                              "assets/images/ride.png",
                              height: 50.0,
                            ),
                          ),

                          const Text(
                            'Closest and suitable\nrider for item\n₦2000',
                            style: TextStyle(
                              fontSize: 15.0, 
                              color: appPrimaryColor, 
                              fontWeight: FontWeight.w500
                            )
                          )
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            width: MediaQuery.of(context).size.width/3,
                            child:const Text(
                              'Distance:',
                              style: TextStyle(
                                fontSize: 15.0, 
                                color: appPrimaryColor, 
                                fontWeight: FontWeight.w700
                              ),
                            ),
                          ),
                         
                          const Text(
                            '5mins away from\nitem’s location',
                            style: TextStyle(
                              fontSize: 15.0, 
                              color: appPrimaryColor, 
                              fontWeight: FontWeight.w500
                            )
                          )
                        ],
                      ),

                      const SizedBox(height: 20.0),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            width: MediaQuery.of(context).size.width/3,
                            child: const Text(
                              'Vehicle:',
                              style: TextStyle(
                                fontSize: 15.0, 
                                color: appPrimaryColor, 
                                fontWeight: FontWeight.w700
                              ),
                            ),
                          ),
                         
                          const Text(
                            'Boxer 22568AB',
                            style: TextStyle(
                              fontSize: 15.0, 
                              color: appPrimaryColor, 
                              fontWeight: FontWeight.w500
                            )
                          ),
                        ],
                      ),

                      const SizedBox(height: 20.0),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            width: MediaQuery.of(context).size.width/3,
                            child: const Text(
                              'Color:',
                              style: TextStyle(
                                fontSize: 15.0, 
                                color: appPrimaryColor, 
                                fontWeight: FontWeight.w700
                              ),
                            ),
                          ),
                          const Text(
                            'Black',
                            style: TextStyle(
                              fontSize: 15.0, 
                              color: appPrimaryColor, 
                              fontWeight: FontWeight.w500
                            )
                          ),
                        ],
                      ),

                      const SizedBox(height: 40.0),
                      Button(
                        text: 'Accept', 
                        onPress: () => showDialog<String>(
                          // barrierDismissible: true,
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            // title: const Text('AlertDialog Title'),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 50.0),
                            content: SizedBox(
                              height: 150.0,
                              child: Column(
                                children: [
                                  Button(
                                    text: 'Verify now', 
                                    onPress: () {
                                      Navigator.of(context).pushNamed(PickRide.id);
                                    }, 
                                    color: appPrimaryColor, 
                                    textColor: whiteColor, 
                                    isLoading: false,
                                    width: MediaQuery.of(context).size.width/1.6,
                                  ),

                                  const SizedBox(height: 30.0),

                                  Button(
                                    text: 'Continue as a guest', 
                                    onPress: () {
                                      Navigator.of(context).pushNamed(Checkout.id);
                                    }, 
                                    color: whiteColor, 
                                    textColor: appPrimaryColor, 
                                    isLoading: false,
                                    width: MediaQuery.of(context).size.width/1.6,
                                  )
                                ]
                              ),
                            ),
                          ),
                        ),
                        color: appPrimaryColor, 
                        textColor: whiteColor, 
                        isLoading: false,
                        width: MediaQuery.of(context).size.width/1.2,
                      ),

                      const SizedBox(height: 20.0),
                      Button(
                        text: 'Pick a preffered rider', 
                        onPress: () {
                          Navigator.of(context).pushNamed(PickRide.id);
                        }, 
                        color: whiteColor, 
                        textColor: appPrimaryColor, 
                        isLoading: false,
                        width: MediaQuery.of(context).size.width/1.2,
                      ),
                      const SizedBox(height: 30.0),
                    ]
                  ),
                ),
              ),
            ],
          )
        ),
      )
    );
  }
}

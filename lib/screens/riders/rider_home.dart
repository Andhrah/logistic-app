import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/button.dart';

class RiderHomeScreen extends StatefulWidget {

  const RiderHomeScreen({Key? key}) : super(key: key);

  @override
  _RiderHomeScreenState createState() => _RiderHomeScreenState();
}

class _RiderHomeScreenState extends State<RiderHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10.0),

            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/empty_map.png"),
                  fit: BoxFit.cover,
                  // scale: 3.0,
                ),
              ),
              child: SafeArea(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          const Text(
                            'Online',
                            style: TextStyle(
                              color: appPrimaryColor,
                              fontSize: 20.0, 
                              fontWeight: FontWeight.bold
                            ),
                          ),

                          const InkWell(
                            child: Icon(
                              Remix.toggle_fill,
                              size: 30.0,
                              color: green,
                            ),
                          )
                        ],
                      ),

                      // center item in a container
                      SizedBox(
                        // color: Colors.amber,
                        height: MediaQuery.of(context).size.height/1.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/rider2.png',
                              height: MediaQuery.of(context).size.height/3,
                              width: MediaQuery.of(context).size.width/1.5,
                            ),

                            // Image.asset(
                            //   'assets/images/location_pointer.png',
                            //   height: 160,
                            //   width: 160,
                            // ),

                            // const Text(
                            //   'Enable Location',
                            //   textScaleFactor: 1.5,
                            //   style: TextStyle(
                            //     fontWeight: FontWeight.bold,
                            //     color: appPrimaryColor,
                            //   ),
                            // ),

                            // const SizedBox(height: 30.0),
                            // Text(
                            //   'Enable location service to your\nlocation easily',
                            //   textScaleFactor: 1.1,
                            //   textAlign: TextAlign.center,
                            //   style: TextStyle(
                            //     // fontWeight: FontWeight.bold,
                            //     color: appPrimaryColor.withOpacity(0.4),
                            //   ),
                            // ),

                            ElevatedButton(
                              child: const Text('Show Order'),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                   backgroundColor: Colors.transparent,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30.0),
                                      topRight: Radius.circular(30.0)
                                    )
                                  ),
                                  builder: (context) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TweenAnimationBuilder(
                                          tween: Tween(begin: const Duration(minutes: 2), end: Duration.zero),
                                          duration: const Duration(minutes: 3),
                                          builder: (BuildContext context, Duration value, Widget? child) {
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
                                                  Text(
                                                    '$minutes:$seconds',
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      color: secondaryColor,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 30
                                                    )
                                                  )
                                                ],
                                              )
                                            );
                                          }
                                        ),

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
                                           child: Column(
                                            children: [
                                               ListTile(
                                                leading: Container(
                                                  height: 50.0,
                                                  width: 50.0,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.grey.shade200
                                                  ),
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
                                                        fontWeight: FontWeight.bold
                                                      ),
                                                    ),

                                                    const SizedBox(height: 10.0),
                                                    Text(
                                                      '#234516',
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
                                                          fontWeight: FontWeight.bold
                                                        ),
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
                                                        margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                                                        color: appPrimaryColor.withOpacity(0.2),
                                                        height: 1.0,
                                                        width: MediaQuery.of(context).size.width/1.3,
                                                      ),

                                                      const Text(
                                                        '50b, Tapa street, yaba',
                                                        textScaleFactor: 1.1,
                                                        style: TextStyle(
                                                          color: appPrimaryColor,
                                                          fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5.0),
                                                      Text(
                                                        '29.2km',
                                                        textScaleFactor: 1.0,
                                                        style: TextStyle(
                                                          color: appPrimaryColor.withOpacity(0.3),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                                                        color: appPrimaryColor.withOpacity(0.2),
                                                        height: 1.0,
                                                        width: MediaQuery.of(context).size.width/1.3,
                                                      ),

                                                      const Text(
                                                        '1 Aminu street, mende maryland',
                                                        textScaleFactor: 1.2,
                                                        style: TextStyle(
                                                          color: appPrimaryColor,
                                                          fontWeight: FontWeight.bold
                                                        ),
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
                                                        // Navigator.of(context).pushNamed(id);
                                                        Navigator.pop(context);
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
                                                      width: MediaQuery.of(context).size.width/7
                                                    ),
                                                  ),
                                                  const SizedBox(width: 40.0),
                                                ],
                                              ),
                                              const SizedBox(height: 30.0),
                                            ]
                                          )
                                        ),
                                      ],
                                    );
                                  }
                                );
                                
                              },
                            )
                          ]
                        ),
                      )
                    ],
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

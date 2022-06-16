import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/screens/dispatch/item_details.dart';
import 'package:trakk/screens/dispatch/pick_ride.dart';
import 'package:trakk/screens/merchant/dispatch_history.dart';
import 'package:trakk/screens/merchant/notifications.dart';
import 'package:trakk/screens/merchant/riders.dart';
import 'package:trakk/screens/merchant/vehicles.dart';
import 'package:trakk/screens/profile/profile_menu.dart';
import 'package:trakk/services/get_user_service.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/merchant_container.dart';
import 'package:badges/badges.dart';

class CompanyHome extends StatefulWidget {
  static const String id = 'companyhome';
  const CompanyHome({Key? key}) : super(key: key);

  @override
  State<CompanyHome> createState() => _CompanyHomeState();
}

class _CompanyHomeState extends State<CompanyHome> {
  int notificatiobount = 26;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //GetUserData.getUser();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    var box = Hive.box('userData');
    // String firstName = box.get('firstName');

    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
          color: appPrimaryColor,
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  const Color.fromARGB(255, 24, 24, 24).withOpacity(0.2),
                  BlendMode.dstATop),
              image: AssetImage("assets/images/merchant1.png"),
              fit: BoxFit.fill),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            Container(
              padding: const EdgeInsets.only(left: 30.0, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(ProfileMenu.id);
                          },
                          child: const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/ladySmiling.png'),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Admin',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: secondaryColor),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ]),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(Notifications.id);
                        },
                        child: Badge(
                          badgeContent: Text("$notificatiobount"),
                          badgeColor: whiteColor,
                          child: Container(
                              //padding: EdgeInsets.only(top: 15),
                              width: 36,
                              height: 36,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                  color: secondaryColor),
                              child: Icon(Remix.notification_line)),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    //String firstName = ;
                    'Hello ' + box.get('firstName') + ',',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: whiteColor),
                  ),
                  const Text(
                    "Good evening",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: whiteColor),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      //spreadRadius: 5,
                      blurRadius: 2.0,
                      offset: const Offset(0.0, 1.0),
                    ),
                  ],
                ),
                child: Expanded(
                    child: Column(
                  children: [
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(Vehicles.id);
                                },
                                child: const MerchantContainer(
                                  color: deepGreen,
                                  icon: 'assets/images/vehicle.svg',
                                  title: 'Vehicles',
                                ),
                              ),
                            ),
                          ),
                          //const SizedBox(width: 20,),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(Riders.id);
                                },
                                child: const MerchantContainer(
                                  color: secondaryColor,
                                  icon: 'assets/images/users.svg',
                                  title: 'Riders',
                                  iconColor: appPrimaryColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(DispatchHistory.id);
                                },
                                child: const MerchantContainer(
                                  color: deepGreen,
                                  icon: 'assets/images/mark.svg',
                                  title: 'Dispatch\nhistory',
                                ),
                              ),
                            ),
                          ),
                          //const SizedBox(width: 20,),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(ItemDetails.id);
                                },
                                child: const MerchantContainer(
                                  color: deepGreen,
                                  icon: 'assets/images/vehicle.svg',
                                  title: 'Request for a\n Rider',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: InkWell(
                                onTap: () {
                                  //Navigator.of(context).pushNamed(ItemDetails.id);
                                },
                                child: const MerchantContainer(
                                  color: secondaryColor,
                                  icon: 'assets/images/customers.svg',
                                  title: 'My Customers',
                                  iconColor: appPrimaryColor,
                                ),
                              ),
                            ),
                          ),
                          //const SizedBox(width: 20,),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(PickRide.id);
                                },
                                child: MerchantContainer(
                                  color: deepGreen,
                                  icon: 'assets/images/users.svg',
                                  title: 'Deliver to my\n Customer',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

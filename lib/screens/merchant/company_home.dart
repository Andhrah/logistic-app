import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/bloc/app_settings_bloc.dart';
import 'package:trakk/models/app_settings.dart';
import 'package:trakk/screens/dispatch/item_detail/item_details.dart';
import 'package:trakk/screens/dispatch/pick_ride.dart';
import 'package:trakk/screens/merchant/dispatch_history.dart';
import 'package:trakk/screens/merchant/notifications.dart';
import 'package:trakk/screens/merchant/riders.dart';
import 'package:trakk/screens/merchant/vehicles.dart';
import 'package:trakk/screens/profile/profile_menu.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/utils/helper_utils.dart';
import 'package:trakk/widgets/merchant_container.dart';

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
    //GetVehiclesListService.getVehiclesList();
    //RiderProfileService.getRiderProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    // String firstName = box.get('firstName');

    return Scaffold(
      body: SafeArea(
          child: Stack(children: [
        Container(
          decoration: BoxDecoration(
            color: appPrimaryColor,
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    const Color.fromARGB(255, 24, 24, 24).withOpacity(0.2),
                    BlendMode.dstATop),
                image: const AssetImage("assets/images/merchant1.png"),
                fit: BoxFit.fill),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30),
                child: Row(
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
                      // const Text(
                      //   'Admin',
                      //   style: TextStyle(
                      //     fontSize: 14,
                      //     fontWeight: FontWeight.w400,
                      //     color: secondaryColor
                      //   ),
                      // ),
                    ]),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(Notifications.id);
                      },
                      child: Badge(
                        badgeContent: Text("$notificatiobount"),
                        badgeColor: whiteColor,
                        child: Container(
                            width: 36,
                            height: 36,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                                color: secondaryColor),
                            child: const Icon(Remix.notification_line)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, bottom: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder<AppSettings>(
                        stream: appSettingsBloc.appSettings,
                        builder: (context, snapshot) {
                          String firstName = '';
                          if (snapshot.hasData) {
                            firstName = snapshot.data?.loginResponse?.data?.user
                                    ?.firstName ??
                                '';
                          }
                          return Text(
                            "Hello $firstName",
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: whiteColor),
                          );
                        }),
                    Text(
                      greetWithTime(),
                      style: const TextStyle(
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
              //const Expanded(child: Divider(),),
              Expanded(
                child: Container(
                  // height: MediaQuery.of(context).size.height / 2,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  // height: MediaQuery.of(context).size.height * 0.7,
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
                        offset: Offset(0.0, 1.0),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
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
                              padding: const EdgeInsets.all(10.0),
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
                      kSizeBox,
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
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
                              padding: const EdgeInsets.all(10.0),
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
                      kSizeBox,
                      Row(
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
                              padding: const EdgeInsets.all(10),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(PickRide.id);
                                },
                                child: const MerchantContainer(
                                  color: deepGreen,
                                  icon: 'assets/images/users.svg',
                                  title: 'Deliver to my\n Customer',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ])),
    );
  }
}

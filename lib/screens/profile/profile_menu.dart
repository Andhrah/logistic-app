import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:trakk/provider/update_profile/update_profile.dart';
import 'package:trakk/screens/support/help_and_support.dart';
import 'package:trakk/services/get_user_service.dart';
import 'package:trakk/utils/constant.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/screens/profile/settings.dart';
import 'package:trakk/screens/profile/user_dispatch_history.dart';
import 'package:trakk/screens/profile/edit_profile.dart';
import 'package:trakk/screens/wallet/wallet.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/back_icon.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/widgets/profile_list.dart';

import '../support/help_and_support.dart';

class ProfileMenu extends StatefulWidget {
  static const String id = "ProfileMenu";
  const ProfileMenu({Key? key}) : super(key: key);

  @override
  State<ProfileMenu> createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu> {

// var box = Hive.box('userData');
//    String firstName = box.get('firstName');

@override
  void initState() {
    super.initState();
    GetUserData.getUser();
    fetchUserData();
  }

  fetchUserData() async {
    var response = await UpdateUserProvider.updateUserProvider(context).updateUserProfile();
    print(
        "responseData=> ${response}");
  }

  // fetchRiderHistory() async {
  //   var response = await RiderHistoryProvider.riderHistoryProvider(context)
  //       .getRidersHistory();
  //   print(
  //       "responseData=> ${response["data"]["attributes"]["orders"]["data"][0]["attributes"]}");

  //   responseHolder =
  //       response["data"]["attributes"]["orders"]["data"][0]["attributes"];
  // }
  @override
  Widget build(BuildContext context) {
    var box = Hive.box('userData');
       print("${box.get('lastName')} second call>>>");

        return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                BackIcon(
                  onPress: () {
                    Navigator.pop(context);
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(left: 60.0),
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {},
                    customBorder: const CircleBorder(),
                    child: const Text(
                      'PROFILE MENU',
                      textScaleFactor: 1.2,
                      style: TextStyle(
                        color: appPrimaryColor,
                        fontWeight: FontWeight.bold,
                        // decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 160,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 35.0, right: 35.0, top: 0, bottom: 0),
                          child: Stack(children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 78,
                                    width: 80,
                                    alignment: Alignment.centerLeft,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/ladySmiling.png'),
                                            fit: BoxFit.contain),
                                        shape: BoxShape.circle),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                 Row(
                                   children: [
                                     Text(
                                      box.get('firstName') ?? "",
                                      style:  TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(width: 5,),
                                     Text(
                                      box.get('lastName') ?? "",
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600),
                                ),
                                   ],
                                 ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(box.get('phoneNumber').toString()),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(box.get('email') ?? "",),
                                      ],
                                    ),
                                    Button(
                                        text: 'Edit profile',
                                        onPress: () {
                                        //  var id = box.get('id');
                                        //   //print("This is the token " + name);
                                        //   print("This is the user id " +
                                        //       id.toString());

                                          Navigator.of(context)
                                              .pushNamed(EditProfile.id);
                                        },
                                        color: Colors.black,
                                        width: 80.0,
                                        textColor: whiteColor,
                                        isLoading: false),
                                  ],
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        height: 87,
                        decoration: const BoxDecoration(
                          color: secondaryColor,
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 2,
                              color: Color.fromARGB(255, 233, 233, 233),
                              offset: Offset(2.0, 4.0), //(x,y)
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: ListTile(
                            title: Text(
                              'Share App with your Trakk\ncode and get ₦500 bonus in\nyour wallet',
                              textAlign: TextAlign.justify,
                            ),
                            trailing: Icon(
                              Remix.share_line,
                              color: appPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                     
                      const SizedBox(

                        height: 18,
                      ),
                      InkWell(
                        onTap: () {

                          Navigator.of(context)
                              .pushNamed(UserDispatchHistory.id);
                        },
                        child: const ProfileList(
                          icon: Icon(Remix.history_line),
                          //svg: 'assets/images/history.svg',
                          title: 'Dispatch History',
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(Settings.id);
                        },
                        child: const ProfileList(
                          icon: Icon(Remix.settings_2_line),
                          //svg: 'assets/images/settings.svg',
                          title: 'Settings',
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(HelpAndSupport.id);
                        },
                        child: const ProfileList(
                          icon: Icon(Remix.question_line),
                          //svg: 'assets/images/help.svg',
                          title: 'Help and Support',
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      // InkWell(
                      //   onTap: () {},
                      //   child:  ProfileList(
                      //     icon: Remix.wallet_2_line,
                      //     title: 'E-commerce',
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 18,
                      // ),
                      // InkWell(
                      //   onTap: () {},
                      //   child: const ProfileList(
                      //     svg: 'assets/images/insurance.svg',
                      //     title: 'Insurance',
                      //   ),
                      // ),
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 30),
                        height: 48,
                        decoration: const BoxDecoration(
                          color: whiteColor,
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 2,
                              color: Color.fromARGB(255, 235, 235, 235),
                              offset: Offset(2.0, 2.0), //(x,y)
                              blurRadius: 16,
                            ),
                          ],
                        ),
                        child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/Logout.svg',
                                  color: redColor,
                                ),
                                const SizedBox(
                                  width: 22,
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: const Text(
                                    "Log out",
                                    style: TextStyle(
                                        color: redColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            )),
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Button(
                            text: 'Become a rider and earn',
                            onPress: () {},
                            color: kTextColor,
                            width: 344,
                            textColor: whiteColor,
                            isLoading: false),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuContainer extends StatelessWidget {
  const MenuContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 35.0, right: 35.0, top: 0, bottom: 0),
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  height: 78,
                  width: 80,
                  alignment: Alignment.centerLeft,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/ladySmiling.png'),
                          fit: BoxFit.contain),
                      shape: BoxShape.circle),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Malik Johnson',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('+234816559234'),
                      SizedBox(
                        height: 8,
                      ),
                      Text('malhohn11@gmail.com'),
                    ],
                  ),
                  Button(
                      text: 'Edit profile',
                      onPress: () {
                        // var box =  Hive.box('userData');
                        // String name = box.get('token');
                        // dynamic id = box.get('id');

                        // print("This is the token " + name);
                        // print("This is the user id " + id.toString());

                        Navigator.of(context).pushNamed(EditProfile.id);
                      },
                      color: Colors.black,
                      width: 80.0,
                      textColor: whiteColor,
                      isLoading: false),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

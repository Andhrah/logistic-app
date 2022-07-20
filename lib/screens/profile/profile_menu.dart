import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:hive/hive.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/bloc/app_settings_bloc.dart';
import 'package:trakk/mixins/connectivity_helper.dart';
import 'package:trakk/mixins/logout_helper.dart';
import 'package:trakk/mixins/profile_helper.dart';
import 'package:trakk/models/app_settings.dart';
import 'package:trakk/screens/auth/login.dart';
import 'package:trakk/screens/auth/signup.dart';
import 'package:trakk/screens/onboarding/get_started.dart';
import 'package:trakk/screens/profile/dispatch_history_screen/user_dispatch_history.dart';
import 'package:trakk/screens/profile/edit_profile.dart';
import 'package:trakk/screens/profile/privacy_and_policy.dart';
import 'package:trakk/screens/support/help_and_support.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/utils/font.dart';
import 'package:trakk/utils/helper_utils.dart';
import 'package:trakk/values/assetkk/utils/helper_utils.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/widgets/general_widget.dart';
import 'package:trakk/widgets/profile_list.dart';

import '../support/help_and_support.dart';

class ProfileMenu extends StatefulWidget {
  static const String id = "ProfileMenu";

  const ProfileMenu({Key? key}) : super(key: key);

  @override
  State<ProfileMenu> createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu>
    with ProfileHelper, ConnectivityHelper, LogoutHelper {
// var box = Hive.box('userData');
//    String firstName = box.get('firstName');

  @override
  void initState() {
    super.initState();
    doGetProfileOperation();
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
    var theme = Theme.of(context);

    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            12.heightInPixel(),
            Text(
              'PROFILE MENU',
              style: theme.textTheme.subtitle1!.copyWith(
                fontWeight: kBoldWeight,
                fontSize: 17,
                // decoration: TextDecoration.underline,
              ),
            ),
            12.heightInPixel(),
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
                            StreamBuilder<AppSettings>(
                                stream: appSettingsBloc.appSettings,
                                builder: (context, snapshot) {
                                  String avatar = '';
                                  String firstName = '';
                                  String lastName = '';
                                  String phone = '';
                                  String email = '';

                                  if (snapshot.hasData) {
                                    avatar = snapshot.data?.loginResponse?.data
                                            ?.user?.avatar ??
                                        '';
                                    firstName = snapshot.data?.loginResponse
                                            ?.data?.user?.firstName ??
                                        '';
                                    lastName = snapshot.data?.loginResponse
                                            ?.data?.user?.lastName ??
                                        '';
                                    phone = snapshot.data?.loginResponse?.data
                                            ?.user?.phoneNumber ??
                                        '';
                                    email = snapshot.data?.loginResponse?.data
                                            ?.user?.email ??
                                        '';
                                  }

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      12.heightInPixel(),
                                      Expanded(
                                        child: ClipOval(
                                          child: CachedNetworkImage(
                                            imageUrl: avatar,
                                            height: 70,
                                            width: 70,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Image.asset(
                                              Assets.dummy_avatar,
                                              height: 70,
                                              width: 70,
                                              fit: BoxFit.cover,
                                            ),
                                            errorWidget: (context, url, err) =>
                                                Image.asset(
                                              Assets.dummy_avatar,
                                              height: 70,
                                              width: 70,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        '$firstName $lastName',
                                        style: theme.textTheme.headline6!
                                            .copyWith(fontWeight: kBoldWeight),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                phone,
                                                style: theme.textTheme.caption,
                                              ),
                                              2.heightInPixel(),
                                              Text(
                                                email,
                                                style: theme.textTheme.caption,
                                              ),
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
                                              height: 40,
                                              textColor: whiteColor,
                                              isLoading: false),
                                        ],
                                      ),
                                    ],
                                  );
                                }),
                          ]),
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                      ),

                      // Container(
                      //   padding: EdgeInsets.only(left: 20),
                      //   height: 87,
                      //   decoration: const BoxDecoration(
                      //     color: secondaryColor,
                      //     boxShadow: [
                      //       BoxShadow(
                      //         spreadRadius: 2,
                      //         color: Color.fromARGB(255, 233, 233, 233),
                      //         offset: Offset(2.0, 4.0), //(x,y)
                      //         blurRadius: 10,
                      //       ),
                      //     ],
                      //   ),
                      //   child: Align(
                      //     alignment: Alignment.center,
                      //     child: ListTile(
                      //       title: Row(
                      //         children: [
                      //           ConstrainedBox(
                      //             constraints:
                      //                 const BoxConstraints(maxWidth: 200),
                      //             child: Text(
                      //               'Share App with your Trakk code and get ₦500 bonus in your wallet',
                      //               textAlign: TextAlign.justify,
                      //               style: theme.textTheme.bodyText2!
                      //                   .copyWith(height: 1.4),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //       trailing: StreamBuilder<AppSettings>(
                      //           stream: appSettingsBloc.appSettings,
                      //           builder: (context, snapshot) {
                      //             String code = '';

                      //             if (snapshot.hasData) {
                      //               // code = snapshot.data?.loginResponse?.data
                      //               //   ?.user?.code ??
                      //               // '';
                      //             }
                      //             return GestureDetector(
                      //               onTap: () {
                      //                 try {
                      //                   Share.share(code,
                      //                       subject: 'Delivery Code');
                      //                 } catch (err) {
                      //                   appToast('Could not share empty text',
                      //                       appToastType: AppToastType.failed);
                      //                 }
                      //               },
                      //               child: const Icon(
                      //                 Remix.share_line,
                      //                 color: appPrimaryColor,
                      //               ),
                      //             );
                      //           }),
                      //     ),
                      //   ),
                      // ),
                      // InkWell(
                      //   onTap: () {
                      //     Navigator.of(context)
                      //         .pushNamed(UserDispatchHistory.id);
                      //   },
                      //   child: const ProfileList(
                      //     icon: Icon(
                      //       Remix.wallet_3_line,
                      //       color: appPrimaryColor,
                      //     ),
                      //     //svg: 'assets/images/history.svg',
                      //     title: 'Wallet',
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 18,
                      // ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(UserDispatchHistory.id);
                        },
                        child: const ProfileList(
                          icon: Icon(
                            Remix.history_line,
                            color: appPrimaryColor,
                          ),
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
                          icon: Icon(
                            Remix.settings_2_line,
                            color: appPrimaryColor,
                          ),
                          //svg: 'assets/images/settings.svg',
                          title: 'Privacy & Security',
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
                          icon: Icon(
                            Remix.question_line,
                            color: appPrimaryColor,
                          ),
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
                      InkWell(
                        onTap: () {
                          yesNoDialog(
                            context,
                            message: 'Log out?',
                            positiveCallback: () =>
                                logout(context, completeLogout: () {
                              Navigator.popUntil(
                                  context, ModalRoute.withName(GetStarted.id));
                              Navigator.of(context).pushNamed(Login.id);
                            }),
                            negativeCallback: () => Navigator.pop(context),
                          );
                        },
                        child: Container(
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
                                    Assets.Logout_svg,
                                    color: redColor,
                                  ),
                                  const SizedBox(
                                    width: 22,
                                  ),
                                  const Text(
                                    "Log out",
                                    style: TextStyle(
                                        color: redColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      StreamBuilder<AppSettings>(
                          stream: appSettingsBloc.appSettings,
                          builder: (context, snapshot) {
                            bool isCustomer = false;
                            if (snapshot.hasData) {
                              isCustomer = (snapshot.data?.loginResponse?.data
                                          ?.user?.userType ??
                                      '') ==
                                  'customer';
                            }

                            return isCustomer
                                ? Align(
                                    alignment: Alignment.center,
                                    child: Button(
                                        text: 'Become a rider and earn',
                                        onPress: () {
                                          yesNoDialog(
                                            context,
                                            message:
                                                'You will be logged out to continue',
                                            positiveCallback: () => logout(
                                                context, completeLogout: () {
                                              Navigator.popUntil(
                                                  context,
                                                  ModalRoute.withName(
                                                      GetStarted.id));
                                              Navigator.of(context).pushNamed(
                                                  Signup.id,
                                                  arguments: {
                                                    "userType": "rider",
                                                  });
                                            }),
                                            negativeCallback: () =>
                                                Navigator.pop(context),
                                          );
                                        },
                                        color: kTextColor,
                                        width: 344,
                                        textColor: whiteColor,
                                        isLoading: false),
                                  )
                                : const SizedBox();
                          }),
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

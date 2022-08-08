import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:hive/hive.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/src/bloc/app_settings_bloc.dart';
import 'package:trakk/src/mixins/biometrics_helper.dart';
import 'package:trakk/src/mixins/connectivity_helper.dart';
import 'package:trakk/src/mixins/logout_helper.dart';
import 'package:trakk/src/mixins/profile_helper.dart';
import 'package:trakk/src/models/app_settings.dart';
import 'package:trakk/src/screens/auth/login.dart';
import 'package:trakk/src/screens/auth/signup.dart';
import 'package:trakk/src/screens/onboarding/get_started.dart';
import 'package:trakk/src/screens/profile/dispatch_history_screen/user_dispatch_history.dart';
import 'package:trakk/src/screens/profile/edit_profile_screen/edit_profile.dart';
import 'package:trakk/src/screens/profile/privacy_and_policy.dart';
import 'package:trakk/src/screens/support/help_and_support.dart';
import 'package:trakk/src/utils/helper_utils.dart';
import 'package:trakk/src/values/enums.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/widgets/button.dart';
import 'package:trakk/src/widgets/general_widget.dart';
import 'package:trakk/src/widgets/profile_list.dart';

class ProfileMenu extends StatefulWidget {
  static const String id = "ProfileMenu";

  const ProfileMenu({Key? key}) : super(key: key);

  @override
  State<ProfileMenu> createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu>
    with ProfileHelper, ConnectivityHelper, BiometricsHelper, LogoutHelper {
// var box = Hive.box('userData');
//    String firstName = box.get('firstName');

  bool isBiometricsEnabled = false;

  Map<IconData, String> list = {
    Remix.history_line: 'Dispatch History',
    Remix.settings_2_line: 'Privacy & Security',
    Remix.question_line: 'Help & Support',
    Remix.lock_2_line: 'Enable Touch ID'
  };

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
  //
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
            25.heightInPixel(),
            Text(
              'PROFILE MENU',
              style: theme.textTheme.subtitle1!.copyWith(
                  fontWeight: kBoldWeight,
                  fontSize: 18,
                  fontFamily: kDefaultFontFamilyHeading
                  // decoration: TextDecoration.underline,
                  ),
            ),
            12.heightInPixel(),
            Expanded(
              child: StreamBuilder<AppSettings>(
                  stream: appSettingsBloc.appSettings,
                  builder: (context, snapshot) {
                    String avatar = '';
                    String firstName = '';
                    String lastName = '';
                    String phone = '';
                    String email = '';

                    if (snapshot.hasData &&
                        snapshot.data!.loginResponse != null) {
                      isBiometricsEnabled = snapshot.hasData
                          ? snapshot.data!.biometricsEnabled
                          : false;
                      avatar =
                          snapshot.data?.loginResponse?.data?.user?.avatar ??
                              '';
                      firstName =
                          snapshot.data?.loginResponse?.data?.user?.firstName ??
                              '';
                      lastName =
                          snapshot.data?.loginResponse?.data?.user?.lastName ??
                              '';
                      phone = snapshot
                              .data?.loginResponse?.data?.user?.phoneNumber ??
                          '';
                      email =
                          snapshot.data?.loginResponse?.data?.user?.email ?? '';
                    }
                    return SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(
                              thickness: 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 35.0, right: 35.0, top: 0, bottom: 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  12.heightInPixel(),
                                  Hero(
                                    tag: 'profile_pic',
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
                                          text: 'Edit Profile',
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
                              ),
                            ),
                            const Divider(
                              thickness: 1,
                            ),
                            FutureBuilder<bool>(
                                future: deviceHasBiometrics,
                                builder: (context, snapshot) {
                                  bool deviceHasBiometrics = false;

                                  if (snapshot.hasData) {
                                    deviceHasBiometrics =
                                        snapshot.data ?? false;
                                  }

                                  return ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: list.length,
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        if (index == 3 &&
                                            !deviceHasBiometrics) {
                                          return Container();
                                        }
                                        return InkWell(
                                          onTap: (index != 3 && index != 4)
                                              ? () {
                                                  _onTap(context, index);
                                                }
                                              : null,
                                          child: Container(
                                            height: 60,
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            // padding: const EdgeInsets.symmetric(vertical: 24),
                                            child: ProfileList(
                                              title:
                                                  list.values.elementAt(index),
                                              icon: Icon(
                                                list.keys.elementAt(index),
                                                color: appPrimaryColor,
                                              ),
                                              trailingWidget: Padding(
                                                padding: EdgeInsets.only(
                                                    right:
                                                        (index != 3) ? 8 : 10),
                                                child: index == 3
                                                    ? _SwitchWidget(
                                                        isBiometricsEnabled,
                                                        (bool value) {
                                                        return _onTap(
                                                            context, index,
                                                            value: value);
                                                      })
                                                    : const Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: kTextColor,
                                                        size: 18,
                                                      ),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                }),
                            const SizedBox(
                              height: 50,
                            ),
                            InkWell(
                              onTap: () {
                                yesNoDialog(
                                  context,
                                  title: 'Log out',
                                  message: 'Are you sure you want to log out?',
                                  positiveCallback: () =>
                                      logout(completeLogout: () {
                                    Navigator.popUntil(context,
                                        ModalRoute.withName(GetStarted.id));
                                    Navigator.of(context).pushNamed(Login.id,
                                        arguments: {'isFromLogout': true});
                                  }),
                                  negativeCallback: () =>
                                      Navigator.pop(context),
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
                                    isCustomer = (snapshot.data?.loginResponse
                                                ?.data?.user?.userType ??
                                            '') ==
                                        'customer';
                                  }

                                  return isCustomer
                                      ? Align(
                                          alignment: Alignment.center,
                                          child: Button(
                                              text: 'Become a Rider and Earn',
                                              onPress: () {
                                                yesNoDialog(
                                                  context,
                                                  message:
                                                      'You will be logged out to continue',
                                                  positiveCallback: () =>
                                                      logout(
                                                          completeLogout: () {
                                                    Navigator.popUntil(
                                                        context,
                                                        ModalRoute.withName(
                                                            GetStarted.id));
                                                    Navigator.of(context)
                                                        .pushNamed(Signup.id,
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
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Future _onTap(BuildContext context, int index, {bool? value}) async {
    switch (index) {
      case 0:
        Navigator.of(context).pushNamed(UserDispatchHistory.id,
            arguments: {'type': OrderHistoryType.all});
        break;
      case 1:
        Navigator.of(context).pushNamed(PrivacyAndPolicy.id);
        break;
      case 2:
        Navigator.of(context).pushNamed(HelpAndSupport.id);
        break;

      case 3:
        bool result = await toggleBiometrics(
            context, value!, true, (validationSuccess) async {});

        if (result) {
          await appSettingsBloc.setBiometrics(value);
          return value;
        } else {
          await appSettingsBloc.setBiometrics(!value);

          return !value;
        }
    }

    return false;
  }
}

typedef _SwitchCallback = Future? Function(bool value);

class _SwitchWidget extends StatefulWidget {
  final bool value;
  final _SwitchCallback __switchCallback;

  const _SwitchWidget(this.value, this.__switchCallback, {Key? key})
      : super(key: key);

  @override
  _SwitchWidgetState createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<_SwitchWidget> {
  late bool value = widget.value;

  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: widget.value,
        activeColor: secondaryColor,
        onChanged: (bool _value) async {
          var result = await widget.__switchCallback(_value);
          if (result != null && result is bool) {
            setState(() {
              value = result;
            });
          }
        });
  }
}

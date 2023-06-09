import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_auth/local_auth.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/src/bloc/app_settings_bloc.dart';
import 'package:trakk/src/mixins/biometrics_helper.dart';
import 'package:trakk/src/mixins/connectivity_helper.dart';
import 'package:trakk/src/mixins/login_helper.dart';
import 'package:trakk/src/mixins/merchant_add_rider_and_vehicle_helper.dart';
import 'package:trakk/src/mixins/profile_helper.dart';
import 'package:trakk/src/models/app_settings.dart';
import 'package:trakk/src/screens/auth/forgot_password.dart';
import 'package:trakk/src/screens/auth/signup.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/widgets/back_icon.dart';
import 'package:trakk/src/widgets/button.dart';
import 'package:trakk/src/widgets/general_widget.dart';
import 'package:trakk/src/widgets/input_field.dart';

class Login extends StatefulWidget {
  static const String id = 'login';

  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>
    with
        LoginHelper,
        ConnectivityHelper,
        MerchantAddRiderAndVehicleHelper,
        ProfileHelper,
        BiometricsHelper {
  bool _loading = false;
  bool _hidePassword = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
  }

  init() async {
    AppSettings appSettings = await appSettingsBloc.fetchAppSettings();
    if (appSettings.loginResponse != null &&
        appSettings.loginResponse!.data != null) {
      final arg = ModalRoute.of(context)!.settings.arguments;

      bool isFromLogout = (arg != null) &&
          (arg as Map).isNotEmpty &&
          (arg['isFromLogout'] ?? false);
      if (appSettings.biometricsEnabled && !isFromLogout) {
        performVerify();
      }
    }
  }

  performVerify() {
    doBiometricActivity(context, () {
      doGetProfileOperation(
        onShowLoader: () {
          showDialog(
              context: context,
              builder: (context) =>
                  const Center(child: kCircularProgressIndicator));
        },
        onCloseLoader: () {},
        profileFetchSuccess: (authData) async {
          Navigator.pop(context);
          AppSettings appSettings = await appSettingsBloc.fetchAppSettings();

          finaliseLogin(appSettings.loginResponse!, false);
        },
      );
    });
  }

  _onSubmit() async {
    doLoginOperation(
        true,
        () => setState(() {
              _loading = true;
            }),
        () => setState(() {
              _loading = false;
            }));
  }

  void displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (ctx) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 60),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Authentication Required",
                  textScaleFactor: 1.2,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                const Text(
                  "Authenticate your biometrics to verify your\n identity",
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 36,
                ),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onLongPress: () {},
                    onTap: () {
                      Navigator.pop(context);
                      performVerify();
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: -3,
                            blurRadius: 11,
                            offset: Offset(0, 8), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Center(
                        child: SvgPicture.asset("assets/images/biometric.svg"),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Touch the fingerprint sensor",
                  textScaleFactor: 0.8,
                ),
                const SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: ElevatedButton(
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: appPrimaryColor),
                      ),
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.white,
                        primary: whiteColor,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        // setState(() {});
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            kSizeBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackIcon(
                  onPress: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(right: 70.0),
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {},
                    customBorder: const CircleBorder(),
                    child: const Text(
                      'LOG IN',
                      textScaleFactor: 1.2,
                      style: TextStyle(
                        color: appPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(),
              ],
            ),
            const SizedBox(height: 30.0),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputField(
                      key: const Key('email'),
                      obscureText: false,
                      textController: emailCC,
                      keyboardType: TextInputType.emailAddress,
                      text: 'Email Address',
                      hintText: 'jane@email.com',
                      textHeight: 10.0,
                      borderColor: appPrimaryColor.withOpacity(0.9),
                      suffixIcon: const Icon(
                        Remix.mail_line,
                        size: 18.0,
                        color: Color(0xFF909090),
                      ),
                      validator: validationBloc.emailValidator,
                      onSaved: (value) {
                        return null;
                      },
                    ),
                    const SizedBox(height: 30.0),
                    InputField(
                      key: const Key('password'),
                      textController: passwordCC,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: _hidePassword,
                      text: 'Password',
                      hintText: 'password',
                      textHeight: 10.0,
                      maxLines: 1,
                      borderColor: appPrimaryColor.withOpacity(0.9),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _hidePassword == false
                              ? Remix.eye_line
                              : Remix.eye_close_line,
                          size: 18.0,
                          color: const Color(0xFF909090),
                        ),
                        onPressed: () {
                          setState(() {
                            _hidePassword = !_hidePassword;
                          });
                        },
                      ),
                      validator: (value) {
                        if (value!.trim().length < 7) {
                          return "Password should be 8 characters or more";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        return null;
                      },
                    ),
                    const SizedBox(height: 10.0),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(ForgetPassword.id);
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: secondaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40.0),
                    StreamBuilder<AppSettings>(
                        stream: appSettingsBloc.appSettings,
                        builder: (context, snapshot) {
                          if (snapshot.hasData &&
                              snapshot.data!.biometricsEnabled &&
                              snapshot.data!.loginResponse?.data?.token !=
                                  null) {
                            return FutureBuilder<List<BiometricType>?>(
                                future: getAvailableBiometrics(),
                                builder: (context, snapshot) {
                                  BiometricType biometricType =
                                      BiometricType.fingerprint;
                                  if (snapshot.hasData) {
                                    if (Platform.isIOS) {
                                      if (snapshot.data!
                                          .contains(BiometricType.face)) {
                                        biometricType = BiometricType.face;
                                      }
                                    } else {
                                      if (snapshot.data!
                                          .contains(BiometricType.iris)) {
                                        biometricType = BiometricType.iris;
                                      }
                                    }
                                  }
                                  return Align(
                                    alignment: Alignment.center,
                                    child: InkWell(
                                      onTap: () => displayBottomSheet(context),
                                      //  {

                                      //   Navigator.pushNamed(context, MyPage.id);
                                      //   // _show = true;
                                      //   // setState(() {});
                                      // },
                                      child: Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          color: whiteColor,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: -3,
                                              blurRadius: 11,
                                              offset: Offset(0,
                                                  8), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: SvgPicture.asset(
                                              Assets.biometric_icon_svg),
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          }

                          return const SizedBox();
                        }),
                    const SizedBox(height: 40.0),
                    Align(
                        alignment: Alignment.center,
                        child: Button(
                            text: 'Log in',
                            onPress: _onSubmit,
                            color: appPrimaryColor,
                            textColor: whiteColor,
                            isLoading: _loading,
                            width: MediaQuery.of(context).size.width/1.3)),
                    const SizedBox(height: 15.0),
                    InkWell(
                      onTap: () {
                        modalSearchableList(['Customer', 'Rider', 'Company'],
                            (int index, String value) {
                          String userType = 'customer';
                          switch (value) {
                            case 'Customer':
                              userType = 'customer';
                              break;
                            case 'Rider':
                              userType = 'rider';
                              break;
                            case 'Company':
                              userType = 'merchant';
                              break;
                          }

                          Navigator.of(context)
                              .pushNamed(Signup.id, arguments: {
                            "userType": userType,
                          });
                        });
                      },
                      child: Align(
                        child: RichText(
                          textScaleFactor: 0.9,
                          text: const TextSpan(
                            text: 'Don’t have an account? ',
                            style: TextStyle(
                              color: appPrimaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Sign up',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: secondaryColor)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    // Row(
                    //   children: const [
                    //     Expanded(
                    //       child: Divider(
                    //         color: appPrimaryColor,
                    //       ),
                    //     ),
                    //     Padding(
                    //       padding: EdgeInsets.symmetric(horizontal: 8.0),
                    //       child: Text(
                    //         'Or continue with',
                    //         textScaleFactor: 1.2,
                    //         style: TextStyle(
                    //             color: appPrimaryColor,
                    //             fontWeight: FontWeight.w400),
                    //       ),
                    //     ),
                    //     Expanded(
                    //       child: Divider(
                    //         color: appPrimaryColor,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: ElevatedContainer(
                    //         onPress: () {},
                    //         radius: 5.0,
                    //         color: whiteColor,
                    //         height: 55.0,
                    //         width: 55.0,
                    //         child: Image.asset(
                    //           'assets/images/google_icon.png',
                    //           height: 15,
                    //           width: 15,
                    //         ),
                    //       ),
                    //     ),
                    //     Expanded(
                    //       child: ElevatedContainer(
                    //         onPress: () {},
                    //         radius: 5.0,
                    //         color: whiteColor,
                    //         height: 55.0,
                    //         width: 55.0,
                    //         child: Image.asset(
                    //           'assets/images/apple_icon.png',
                    //           height: 20,
                    //           width: 20,
                    //         ),
                    //       ),
                    //     ),
                    //     Expanded(
                    //       child: ElevatedContainer(
                    //         onPress: () {},
                    //         radius: 5.0,
                    //         color: whiteColor,
                    //         height: 55.0,
                    //         width: 55.0,
                    //         child: Image.asset(
                    //           'assets/images/facebook_icon.png',
                    //           height: 18,
                    //           width: 18,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
      //bottomSheet: _loginBottomSheet(),
    );
  }

// Widget? _loginBottomSheet() {
//   //bool _show;
//   if (_show) {
//     return BottomSheet(
//       onClosing: () {},
//       builder: (context) {
//         return Container(
//           padding: EdgeInsets.symmetric(vertical: 50),
//           height: 400,
//           width: double.infinity,
//           decoration: BoxDecoration(
//               color: whiteColor,
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(50.0),
//                   topRight: Radius.circular(50.0))),
//           alignment: Alignment.center,
//           child: Column(
//             children: [
//               Text(
//                 "Authentication Required",
//                 textScaleFactor: 1.2,
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 "Authenticate your biometrics to verify your\n identity",
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(
//                 height: 36,
//               ),
//               Align(
//                 alignment: Alignment.center,
//                 child: InkWell(
//                   onTap: () {
//                     _show = true;
//                     setState(() {});
//                   },
//                   child: Container(
//                     height: 60,
//                     width: 60,
//                     decoration: BoxDecoration(
//                       color: whiteColor,
//                       shape: BoxShape.circle,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           spreadRadius: -3,
//                           blurRadius: 11,
//                           offset: Offset(0, 8), // changes position of shadow
//                         ),
//                       ],
//                     ),
//                     child: Center(
//                       child: SvgPicture.asset("assets/images/biometric.svg"),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Text(
//                 "Touch the fingerprint sensor",
//                 textScaleFactor: 0.8,
//               ),
//               const SizedBox(
//                 height: 50,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 20),
//                 child: Align(
//                   alignment: Alignment.bottomLeft,
//                   child: ElevatedButton(
//                     child: Text(
//                       "Cancel",
//                       style: TextStyle(color: appPrimaryColor),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       onPrimary: Colors.white,
//                       primary: whiteColor,
//                     ),
//                     onPressed: () {
//                       _show = false;
//                       setState(() {});
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   } else {
//     return null;
//   }
// }
}

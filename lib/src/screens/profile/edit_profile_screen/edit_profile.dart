import 'dart:io';

import 'package:custom_bloc/custom_bloc.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/src/bloc/app_settings_bloc.dart';
import 'package:trakk/src/bloc/rider/get_vehicles_for_rider_list_bloc.dart';
import 'package:trakk/src/bloc/validation_bloc.dart';
import 'package:trakk/src/mixins/profile_helper.dart';
import 'package:trakk/src/models/app_settings.dart';
import 'package:trakk/src/models/merchant/get_vehicles_for_merchant_response.dart';
import 'package:trakk/src/models/update_profile/update_profile.dart';
import 'package:trakk/src/screens/merchant/add_rider_2/add_rider2.dart';
import 'package:trakk/src/screens/profile/edit_profile_screen/widgets/image_selector_widget.dart';
import 'package:trakk/src/utils/app_toast.dart';
import 'package:trakk/src/utils/helper_utils.dart';
import 'package:trakk/src/values/enums.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/widgets/back_icon.dart';
import 'package:trakk/src/widgets/button.dart';
import 'package:trakk/src/widgets/input_field.dart';

class EditProfile extends StatefulWidget {
  static String id = "editProfile";

  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> with ProfileHelper {
  final _formKey = GlobalKey<FormState>();

  ValidationBloc validationBloc = ValidationBloc();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final FocusNode _firstNameNode = FocusNode();
  final FocusNode _lastNameNode = FocusNode();
  final FocusNode _phoneNumberNode = FocusNode();
  final FocusNode _emailNode = FocusNode();
  final FocusNode _addressNode = FocusNode();

  File? _itemImage;

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    var user =
        (await appSettingsBloc.fetchAppSettings()).loginResponse?.data?.user;

    UserType userType = await appSettingsBloc.getUserType;
    if (userType == UserType.rider) {
      getVehiclesForRiderListBloc.fetchCurrent();
    }
    setState(() {
      _firstNameController.text = user?.firstName ?? '';
      _lastNameController.text = user?.lastName ?? '';
      _emailController.text = user?.email ?? '';
      _phoneNumberController.text = user?.phoneNumber ?? '';
      _addressController.text = user?.address ?? '';
    });
  }

  @override
  void dispose() {
    validationBloc.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

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
                  height: 98,
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.2),
                  alignment: Alignment.center,
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
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                    thickness: 1.0,
                    color: Color(0xff909090),
                  ),
                  StreamBuilder<AppSettings>(
                      stream: appSettingsBloc.appSettings,
                      builder: (context, snapshot) {
                        String firstName = '';
                        String phone = '';
                        String email = '';

                        if (snapshot.hasData) {
                          firstName = snapshot
                                  .data?.loginResponse?.data?.user?.firstName ??
                              '';
                          phone = snapshot.data?.loginResponse?.data?.user
                                  ?.phoneNumber ??
                              '';
                          email =
                              snapshot.data?.loginResponse?.data?.user?.email ??
                                  '';
                        }

                        return SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 30.0, right: 30, bottom: 17),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                12.heightInPixel(),
                                EditProfileImageSelectorWidget(
                                    (File? itemImage) {
                                  _itemImage = itemImage;
                                }),
                                4.heightInPixel(),
                                Text(
                                  firstName,
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  phone,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  email,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                  const Divider(
                    thickness: 1.0,
                    color: Color(0xff909090),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InputField(
                            key: const Key('First name'),
                            textController: _firstNameController,
                            node: _firstNameNode,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            obscureText: false,
                            text: 'First name',
                            hintText: 'First name',
                            textHeight: 10.0,
                            borderColor: appPrimaryColor.withOpacity(0.9),
                            // suffixIcon: const Icon(
                            //   Remix.user_line,
                            //   size: 18.0,
                            //   color: Color(0xFF909090),
                            // ),
                            validator: (value) {
                              if (value!.trim().length > 2) {
                                return null;
                              }
                              return "Enter a valid first  name";
                            },
                            onSaved: (value) {
                              return null;
                            },
                          ),
                          const SizedBox(height: 30.0),
                          InputField(
                            key: const Key('Last name'),
                            textController: _lastNameController,
                            node: _lastNameNode,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            obscureText: false,
                            text: 'Last name',
                            hintText: 'Last name',
                            textHeight: 10.0,
                            borderColor: appPrimaryColor.withOpacity(0.9),
                            // suffixIcon: const Icon(
                            //   Remix.user_line,
                            //   size: 18.0,
                            //   color: Color(0xFF909090),
                            // ),
                            validator: (value) {
                              if (value!.trim().length > 2) {
                                return null;
                              }
                              return "Enter a valid last  name";
                            },
                            onSaved: (value) {
                              return null;
                            },
                          ),
                          const SizedBox(height: 30.0),
                          InputField(
                            key: const Key('phoneNumber'),
                            textController: _phoneNumberController,
                            keyboardType: TextInputType.phone,
                            node: _phoneNumberNode,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            obscureText: false,
                            text: 'Phone Number',
                            hintText: '+234-807-675-8970',
                            textHeight: 10.0,
                            borderColor: appPrimaryColor.withOpacity(0.9),
                            // suffixIcon: const Icon(
                            //   Remix.phone_line,
                            //   size: 18.0,
                            //   color: Color(0xFF909090),
                            // ),
                            validator: (value) {
                              if (value!.trim().length == 11) {
                                return null;
                              }
                              return "Enter a valid phone number";
                            },
                            onSaved: (value) {
                              return null;
                            },
                          ),
                          const SizedBox(height: 30.0),
                          Opacity(
                            opacity: 0.5,
                            child: InputField(
                              key: const Key('Company\'s email address'),
                              textController: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              node: _emailNode,
                              // autovalidateMode: AutovalidateMode.onUserInteraction,
                              obscureText: false,
                              enabled: false,
                              text: 'Email Address',
                              hintText: '@gmail.com',
                              textHeight: 10.0,
                              borderColor: appPrimaryColor.withOpacity(0.9),

                              validator: validationBloc.emailValidator,
                              onSaved: (value) {
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 30.0),
                          InputField(
                            key: const Key('Home address'),
                            textController: _addressController,
                            node: _addressNode,
                            maxLines: 1,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            obscureText: false,
                            text: 'Home address',
                            hintText: 'Address',
                            textHeight: 10.0,
                            borderColor: appPrimaryColor.withOpacity(0.9),
                            onSaved: (value) {
                              return null;
                            },
                          ),
                          const SizedBox(height: 20.0),
                          StreamBuilder<AppSettings>(
                              stream: appSettingsBloc.appSettings,
                              builder: (context, snapshot) {
                                if (snapshot.hasData &&
                                    snapshot.data?.loginResponse?.data?.user
                                            ?.getUserType() ==
                                        UserType.rider) {
                                  return CustomStreamBuilder<
                                          List<GetVehiclesForMerchantDatum>,
                                          String>(
                                      stream: getVehiclesForRiderListBloc
                                          .behaviorSubject,
                                      dataBuilder: (context, data) {
                                        if (data.isNotEmpty) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Click to edit Vehicle',
                                                style: theme
                                                    .textTheme.bodyText1!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const AddRider2(
                                                                isUpdate: true,
                                                              ),
                                                          settings:
                                                              RouteSettings(
                                                                  name: AddRider2
                                                                      .id)));
                                                },
                                                child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color:
                                                              appPrimaryColor,
                                                          shape:
                                                              BoxShape.circle),
                                                  child: const Icon(
                                                    Remix.add_line,
                                                    color: whiteColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                        return const SizedBox();
                                      });
                                }
                                return const SizedBox();
                              }),
                          const SizedBox(height: 20.0),
                          Align(
                              alignment: Alignment.center,
                              child: Button(
                                  text: 'Save',
                                  //onPress:// _onSubmit,
                                  onPress: () => doUpdateProfileOperation(
                                        UpdateProfile(
                                            firstName:
                                                _firstNameController.text,
                                            lastName: _lastNameController.text,
                                            phoneNumber:
                                                _phoneNumberController.text,
                                            email: _emailController.text,
                                            address: _addressController.text,
                                            profilePic: _itemImage),
                                        () => setState(() => _loading = true),
                                        () async {
                                          setState(() => _loading = false);
                                          await appToast(
                                              'Profile updated successfully',
                                              appToastType:
                                                  AppToastType.success);

                                          Navigator.pop(context);
                                        },
                                      ),
                                  color: appPrimaryColor,
                                  textColor: whiteColor,
                                  isLoading: _loading,
                                  width: 350.0)),
                          const SizedBox(height: 25.0),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}

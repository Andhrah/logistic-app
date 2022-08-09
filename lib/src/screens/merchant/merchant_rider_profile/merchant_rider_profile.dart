import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:trakk/src/bloc/app_settings_bloc.dart';
import 'package:trakk/src/bloc/merchant/get_riders_list_bloc.dart';
import 'package:trakk/src/bloc/validation_bloc.dart';
import 'package:trakk/src/mixins/merchant_add_rider_and_vehicle_helper.dart';
import 'package:trakk/src/mixins/merchant_update_rider_and_vehicle_helper.dart';
import 'package:trakk/src/mixins/profile_helper.dart';
import 'package:trakk/src/models/merchant/get_riders_for_merchant_response.dart';
import 'package:trakk/src/models/rider/add_rider_to_merchant_model.dart';
import 'package:trakk/src/screens/dispatch/item_detail/widget/item_detail_date_widget.dart';
import 'package:trakk/src/screens/profile/edit_profile_screen/widgets/image_selector_widget.dart';
import 'package:trakk/src/utils/app_toast.dart';
import 'package:trakk/src/utils/helper_utils.dart';
import 'package:trakk/src/utils/singleton_data.dart';
import 'package:trakk/src/utils/time_ago.dart';
import 'package:trakk/src/values/enums.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/widgets/back_icon.dart';
import 'package:trakk/src/widgets/button.dart';
import 'package:trakk/src/widgets/cancel_button.dart';
import 'package:trakk/src/widgets/input_field.dart';

class MerchantRiderProfile extends StatefulWidget {
  static String id = "merchantRiderProfile";

  const MerchantRiderProfile({Key? key}) : super(key: key);

  @override
  State<MerchantRiderProfile> createState() => _MerchantRiderProfile();
}

class _MerchantRiderProfile extends State<MerchantRiderProfile> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    var arg = ModalRoute.of(context)!.settings.arguments;

    if (arg != null && arg is Map<String, dynamic>) {
      final model =
          GetRidersForMerchantResponseDatum.fromJson(arg['rider_datum'])
              .attributes;

      return const Scaffold(
        backgroundColor: whiteColor,
        body: SafeArea(child: ProfileIdget()),
      );
    }

    return const Scaffold(
      body: SizedBox(),
    );
  }
}

class ProfileIdget extends StatefulWidget {
  const ProfileIdget({Key? key}) : super(key: key);

  @override
  State<ProfileIdget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileIdget>
    with
        MerchantUpdateRiderAndVehicleHelper,
        MerchantAddRiderAndVehicleHelper,
        ProfileHelper {
  RiderProfileOptions selectedProfileOptions = RiderProfileOptions.none;

  final formValidation = ValidationBloc();

  final _formKey = GlobalKey<FormState>();

  bool _selectedProfile = false;

  FocusNode? _firstNameNode;

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _passwordController;
  late TextEditingController _homeAddressController;
  late TextEditingController _assignedvehicleController;
  final TextEditingController _reasonSuspension = TextEditingController();

  FocusNode? _lastNameNode;
  FocusNode? _phoneNumberNode;
  FocusNode? _emailNode;
  FocusNode? _passwordNode;
  FocusNode? _homeAddressNode;
  FocusNode? _assignedvehicleNode;

  bool _loading = false;
  bool _passwordIsValid = false;
  bool _confirmPasswordIsValid = false;
  bool _hidePassword = true;
  bool _autoValidate = false;
  bool _emailIsValid = false;

  File? image;

  String? startDate;
  String? endDate;
  bool isSuspended = false;
  bool isDeleted = false;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _passwordController = TextEditingController();
    _homeAddressController = TextEditingController();
    _assignedvehicleController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
  }

  init() async {
    var arg = ModalRoute.of(context)!.settings.arguments;
    if (arg != null && arg is Map<String, dynamic>) {
      final model =
          GetRidersForMerchantResponseDatum.fromJson(arg['rider_datum'])
              .attributes;

      setState(() {
        _firstNameController.text =
            model?.userId?.data?.attributes?.firstName ?? '';
        _lastNameController.text =
            model?.userId?.data?.attributes?.lastName ?? '';
        _emailController.text = model?.userId?.data?.attributes?.email ?? '';
        _phoneNumberController.text =
            model?.userId?.data?.attributes?.phoneNumber ?? '';
        _homeAddressController.text = model?.residentialAddress ?? '';
        _assignedvehicleController.text =
            ((model?.vehicles?.data?.length ?? 0) > 0)
                ? model?.vehicles?.data?.first.attributes?.name ?? ''
                : '';
        // _reasonSuspension.text =
        //     model?.userId?.data?.attributes?.reasonForSuspension ?? '';
        // startDate = model?.userId?.data?.attributes?.suspensionStartDate;
        // endDate = model?.userId?.data?.attributes?.suspensionEndDate;
        isSuspended = model?.status == 'suspended';
        isDeleted = model?.status == 'deleted';
      });
    }
  }

  Map<String, dynamic>? responseKey;

  isConfirmPasswordValid() {
    setState(() {
      _confirmPasswordIsValid = _homeAddressController.text != null &&
          _homeAddressController.text == _passwordController.text;
      print(_confirmPasswordIsValid);
    });
  }

  @override
  void dispose() {
    formValidation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    var arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final model = GetRidersForMerchantResponseDatum.fromJson(arg['rider_datum'])
        .attributes;

    print(model?.toJson());

    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 0.0, right: 30, bottom: 17, top: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackIcon(
                onPress: () {
                  Navigator.pop(context);
                },
              ),
              //Text('data'),
            ],
          ),
        ),
        EditProfileImageSelectorWidget(
          (File? file) {
            image = file;
          },
          avatarURL: model?.userId?.data?.attributes?.avatar,
          width: 80,
          height: 80,
          rowMainAxisAlignment: MainAxisAlignment.center,
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: Column(
              children: [
                Text(
                  "${model?.userId?.data?.attributes?.firstName ?? ""} ${model?.userId?.data?.attributes?.lastName ?? ""} ",
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 59,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.all(color: grayColor),
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: (selectedProfileOptions ==
                                  RiderProfileOptions.Edit)
                              ? MaterialStateProperty.all(appPrimaryColor)
                              : MaterialStateProperty.all(whiteColor),
                        ),
                        onPressed: () {
                          setState(() {
                            selectedProfileOptions = RiderProfileOptions.Edit;
                            _selectedProfile = true;
                          });
                        },
                        child: Text(
                          "Edit",
                          style: TextStyle(
                              color: (selectedProfileOptions ==
                                      RiderProfileOptions.Edit)
                                  ? whiteColor
                                  : appPrimaryColor),
                        ),
                      ),
                    ),
                    Container(
                      height: 59,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.all(color: grayColor),
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: (selectedProfileOptions ==
                                  RiderProfileOptions.Suspend)
                              ? MaterialStateProperty.all(appPrimaryColor)
                              : MaterialStateProperty.all(whiteColor),
                        ),
                        onPressed: () {
                          setState(() {
                            selectedProfileOptions =
                                RiderProfileOptions.Suspend;
                          });
                        },
                        child: Text(
                          "Suspend",
                          style: TextStyle(
                              color: (selectedProfileOptions ==
                                      RiderProfileOptions.Suspend)
                                  ? whiteColor
                                  : appPrimaryColor),
                        ),
                      ),
                    ),
                    Container(
                      height: 59,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.all(color: grayColor),
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: (selectedProfileOptions ==
                                  RiderProfileOptions.Delete)
                              ? MaterialStateProperty.all(appPrimaryColor)
                              : MaterialStateProperty.all(whiteColor),
                        ),
                        onPressed: () {
                          var arg = ModalRoute.of(context)!.settings.arguments
                              as Map<String, dynamic>;
                          final model =
                              GetRidersForMerchantResponseDatum.fromJson(
                                  arg['rider_datum']);

                          String name =
                              '${model.attributes?.userId?.data?.attributes?.firstName ?? ''} ${model.attributes?.userId?.data?.attributes?.lastName ?? ''}';
                          showDialog<String>(
                            // barrierDismissible: true,
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              // title: const Text('AlertDialog Title'),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 15.0),
                              content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const CancelButton())
                                      ],
                                    ),
                                    20.heightInPixel(),
                                    Text(
                                      isDeleted
                                          ? 'You are about to reactivate $name account'
                                          : 'You are about to delete $name from the list of riders',
                                      // maxLines: 2,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      height: 14,
                                    ),
                                    Button(
                                      text: isDeleted ? 'Activate' : 'Delete',
                                      onPress: () {
                                        Navigator.pop(context);
                                        doDeleteRider('${model.id ?? ''}',
                                            accountRemovalType: isDeleted
                                                ? RiderAccountRemovalType
                                                    .reactivate
                                                : RiderAccountRemovalType
                                                    .delete, onSuccessful: () {
                                          getRidersForMerchantListBloc
                                              .fetchCurrent();
                                          Navigator.pop(SingletonData
                                              .singletonData
                                              .navKey
                                              .currentState!
                                              .context);
                                          showDialog<String>(
                                            // barrierDismissible: true,
                                            context: SingletonData
                                                .singletonData
                                                .navKey
                                                .currentState!
                                                .overlay!
                                                .context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              // title: const Text('AlertDialog Title'),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0,
                                                      vertical: 15.0),
                                              content: SizedBox(
                                                height: 220.0,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child:
                                                              const CancelButton(),
                                                        )
                                                      ],
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 30),
                                                      child: Center(
                                                        child: Text(
                                                          isDeleted
                                                              ? 'You have successfully reactivated $name account'
                                                              : 'You have successfully deleted $name from the list of riders',
                                                          // maxLines: 2,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                      },
                                      color: redColor,
                                      textColor: whiteColor,
                                      isLoading: false,
                                      width: MediaQuery.of(context).size.width /
                                          1.6,
                                    ),
                                    14.heightInPixel(),
                                    Button(
                                      text: isDeleted
                                          ? 'Don\'t activate'
                                          : 'Don\'t delete',
                                      onPress: () {
                                        Navigator.of(context).pop();
                                      },
                                      color: appPrimaryColor,
                                      textColor: whiteColor,
                                      isLoading: false,
                                      width: MediaQuery.of(context).size.width /
                                          1.6,
                                    )
                                  ]),
                            ),
                          );
                        },
                        child: Text(
                          isDeleted ? 'Activate' : "Delete",
                          style: TextStyle(
                              color: (selectedProfileOptions ==
                                      RiderProfileOptions.Delete)
                                  ? whiteColor
                                  : appPrimaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
                getCustomContainer(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget getCustomContainer() {
    //var selectedOptions;
    switch (selectedProfileOptions) {
      case RiderProfileOptions.Edit:
        return editContainer();
      case RiderProfileOptions.Suspend:
        return suspendContainer();
      case RiderProfileOptions.Delete:
        return deleteContainer();
      case RiderProfileOptions.none:
        return AbsorbPointer(absorbing: true, child: editContainer());
    }
  }

  Widget editContainer() {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Column(children: [
      Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            InputField(
              key: const Key('First name'),
              textController: _firstNameController,
              node: _firstNameNode,
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                return "Enter a valid first name";
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
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                return "Enter a valid last name";
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
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
            InputField(
              key: const Key('Company\'s email address'),
              textController: _emailController,
              keyboardType: TextInputType.emailAddress,
              node: _emailNode,
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: false,
              text: 'Email Address',
              hintText: 'malikjohn11@gmail.com',
              textHeight: 10.0,
              borderColor: appPrimaryColor.withOpacity(0.9),
              // suffixIcon: const Icon(
              //   Remix.mail_line,
              //   size: 18.0,
              //   color: Color(0xFF909090),
              // ),
              validator: formValidation.emailValidator,
              onSaved: (value) {
                return null;
              },
            ),
            const SizedBox(height: 30.0),
            InputField(
              key: const Key('Home address'),
              textController: _homeAddressController,
              node: _homeAddressNode,
              maxLines: 1,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: false,
              text: 'Home address',
              hintText: 'N0. Mcneil Street, Yaba',
              textHeight: 10.0,
              borderColor: appPrimaryColor.withOpacity(0.9),
            ),
            // const SizedBox(height: 30.0),
            // InputField(
            //   key: const Key('Assigned vehicle'),
            //   textController: _assignedvehicleController,
            //   node: _assignedvehicleNode,
            //   maxLines: 1,
            //   autovalidateMode: AutovalidateMode.onUserInteraction,
            //   obscureText: false,
            //   text: 'Assigned vehicle',
            //   hintText: 'Yamaha 4567658',
            //   textHeight: 10.0,
            //   borderColor: appPrimaryColor.withOpacity(0.9),
            // ),
            if (selectedProfileOptions == RiderProfileOptions.Edit)
              const SizedBox(height: 48.0),
            if (selectedProfileOptions == RiderProfileOptions.Edit)
              Align(
                  alignment: Alignment.center,
                  child: Button(
                      text: 'Save',
                      //onPress:// _onSubmit,
                      onPress: () async {
                        var arg = ModalRoute.of(context)!.settings.arguments
                            as Map<String, dynamic>;
                        final model =
                            GetRidersForMerchantResponseDatum.fromJson(
                                arg['rider_datum']);

                        updateRiderBioData(AddRiderToMerchantModel(
                            data: AddRiderToMerchantModelData(
                                profilePicFile: image,
                                userId:
                                    '${model.attributes?.userId?.data?.id ?? ''}',
                                merchantId: (await appSettingsBloc.getUserID),
                                firstName: _firstNameController.text,
                                lastName: _lastNameController.text,
                                avatar: '',
                                phone: _phoneNumberController.text,
                                email: _emailController.text,
                                residentialAddress:
                                    _homeAddressController.text)));
                      },
                      color: appPrimaryColor,
                      textColor: whiteColor,
                      isLoading: _loading,
                      width: mediaQuery.size.width * 1)),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    ]);
  }

  Widget suspendContainer() {
    var theme = Theme.of(context);

    MediaQueryData mediaQuery = MediaQuery.of(context);

    return SingleChildScrollView(
      // crossAxisAlignment: CrossAxisAlignment.start,
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: isSuspended
            ? Button(
                text: 'Remove Suspension',
                onPress: () {
                  var arg = ModalRoute.of(context)!.settings.arguments
                      as Map<String, dynamic>;
                  final model = GetRidersForMerchantResponseDatum.fromJson(
                      arg['rider_datum']);

                  String name =
                      '${model.attributes?.userId?.data?.attributes?.firstName ?? ''} ${model.attributes?.userId?.data?.attributes?.lastName ?? ''}';
                  showDialog<String>(
                    // barrierDismissible: true,
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      // title: const Text('AlertDialog Title'),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15.0),
                      content:
                          Column(mainAxisSize: MainAxisSize.min, children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: const CancelButton())
                          ],
                        ),
                        20.heightInPixel(),
                        Text(
                          'You are about to remove suspension for ${camelCase(name)}',
                          // maxLines: 2,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        14.heightInPixel(),
                        Button(
                          text: 'Remove suspension',
                          onPress: () {
                            Navigator.pop(context);
                            unSuspendRider(riderID: '${model.id ?? ''}');
                          },
                          color: appPrimaryColor,
                          textColor: whiteColor,
                          isLoading: false,
                          width: MediaQuery.of(context).size.width / 1.6,
                        ),
                        14.heightInPixel(),
                        Button(
                          text: 'Don\'t remove',
                          onPress: () {
                            Navigator.of(context).pop();
                          },
                          color: redColor,
                          textColor: whiteColor,
                          isLoading: false,
                          width: MediaQuery.of(context).size.width / 1.6,
                        )
                      ]),
                    ),
                  );
                },
                color: Colors.black,
                width: mediaQuery.size.width * 1,
                textColor: Colors.white,
                isLoading: false)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20.0),
                  InputField(
                    text: 'Reason for suspension',
                    textHeight: 10,
                    textController: _reasonSuspension,
                    maxLines: 8,
                  ),
                  20.heightInPixel(),
                  Text(
                    'Choose suspension duration',
                    style: theme.textTheme.bodyText2!.copyWith(
                      color: appPrimaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  10.heightInPixel(),
                  ItemDetailDateWidget(
                    (String? start, String? end) {
                      startDate = start;
                      endDate = end;
                    },
                    startTitle: 'Start Date',
                    endTitle: 'End date',
                    startDate: startDate,
                    endDate: endDate,
                  ),
                  // DecoratedBox(
                  //   decoration: BoxDecoration(
                  //     border: Border.all(
                  //         color: appPrimaryColor.withOpacity(0.9),
                  //         width: 0.3), //border of dropdown button
                  //     borderRadius: BorderRadius.circular(
                  //         5.0), //border raiuds of dropdown button
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  //     child: DropdownButton<String>(
                  //       value: _suspensionDuration,
                  //       icon: const Icon(Remix.arrow_down_s_line),
                  //       elevation: 16,
                  //       isExpanded: true,
                  //       style: theme.textTheme.bodyText2!.copyWith(
                  //         color: appPrimaryColor.withOpacity(0.8),
                  //       ),
                  //       underline: Container(),
                  //       //empty line
                  //       onChanged: (String? newValue) {
                  //         setState(() {
                  //           _suspensionDuration = newValue!;
                  //         });
                  //       },
                  //       items: duration.map((String value) {
                  //         return DropdownMenuItem(
                  //           value: value,
                  //           child: Text(value),
                  //         );
                  //       }).toList(),
                  //     ),
                  //   ),
                  // ),

                  35.heightInPixel(),
                  Button(
                      text: 'Send',
                      onPress: () {
                        var arg = ModalRoute.of(context)!.settings.arguments
                            as Map<String, dynamic>;
                        final model =
                            GetRidersForMerchantResponseDatum.fromJson(
                                arg['rider_datum']);

                        String name =
                            '${model.attributes?.userId?.data?.attributes?.firstName ?? ''} ${model.attributes?.userId?.data?.attributes?.lastName ?? ''}';

                        String suspensionStartDate =
                            startDate ?? DateTime.now().toIso8601String();
                        String suspensionEndDate = endDate ??
                            DateTime.now()
                                .add(const Duration(days: 1))
                                .toIso8601String();

                        showDialog<String>(
                          // barrierDismissible: true,
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            // title: const Text('AlertDialog Title'),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 15.0),
                            content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const CancelButton())
                                    ],
                                  ),
                                  20.heightInPixel(),
                                  Text(
                                    'You are about to suspend $name for the period of ${TimeAgo.getTimeWithSuffix(startTime: (DateTime.tryParse(suspensionStartDate) ?? DateTime.now()).millisecondsSinceEpoch, endTime: (DateTime.tryParse(suspensionEndDate) ?? DateTime.now()).millisecondsSinceEpoch, suffixText: '')}',
                                    // maxLines: 2,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  14.heightInPixel(),
                                  Button(
                                    text: 'Suspend',
                                    onPress: () {
                                      if (startDate == null) {
                                        runToast('Start date is required');
                                        return;
                                      }
                                      if (endDate == null) {
                                        runToast('End date is required');
                                        return;
                                      }

                                      Navigator.pop(context);
                                      suspendRider(
                                          riderUserID:
                                              '${model.attributes?.userId?.data?.id ?? ''}',
                                          reasonForSuspension:
                                              _reasonSuspension.text,
                                          suspensionStartDate:
                                              suspensionStartDate,
                                          suspensionEndDate: suspensionEndDate,
                                          status: 'suspended',
                                          name: name);
                                    },
                                    color: redColor,
                                    textColor: whiteColor,
                                    isLoading: false,
                                    width:
                                        MediaQuery.of(context).size.width / 1.6,
                                  ),
                                  14.heightInPixel(),
                                  Button(
                                    text: 'Don\'t suspend',
                                    onPress: () {
                                      Navigator.of(context).pop();
                                    },
                                    color: appPrimaryColor,
                                    textColor: whiteColor,
                                    isLoading: false,
                                    width:
                                        MediaQuery.of(context).size.width / 1.6,
                                  )
                                ]),
                          ),
                        );
                      },
                      color: Colors.black,
                      width: mediaQuery.size.width * 1,
                      textColor: Colors.white,
                      isLoading: false),
                ],
              ),
      ),
    );
  }

  Widget deleteContainer() {
    return Container(
      color: Colors.black,
      height: 200,
    );
  }
}

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/bloc/app_settings_bloc.dart';
import 'package:trakk/bloc/validation_bloc.dart';
import 'package:trakk/mixins/profile_helper.dart';
import 'package:trakk/models/app_settings.dart';
import 'package:trakk/models/update_profile/update_profile.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/utils/enums.dart';
import 'package:trakk/widgets/back_icon.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/widgets/input_field.dart';

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

  String? _itemImage = "";

  bool _loading = false;
  bool _isItemImage = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    var user =
        (await appSettingsBloc.fetchAppSettings()).loginResponse?.data?.user;

    UserType userType = await appSettingsBloc.getUserType;
    setState(() {
      _firstNameController.text = user?.firstName ?? '';
      _lastNameController.text = user?.lastName ?? '';
      _emailController.text = user?.email ?? '';
      _phoneNumberController.text = user?.phoneNumber ?? '';
      _addressController.text = userType == UserType.rider
          ? (user?.rider?.residentialAddress ?? '')
          : user?.address ?? '';
    });
  }

  uploadItemImage() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      // Open single file open
      final file = result.files.first;
      print("Image Name: ${file.name}");
      setState(() {
        _itemImage = file.name;
        _isItemImage = true;
      });
      return;
    }
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
                                _isItemImage == false
                                    ? InkWell(
                                        splashColor:
                                            Colors.black12.withAlpha(30),
                                        child: Icon(
                                          Remix.account_circle_fill,
                                          size: 90,
                                        ),
                                        onTap: uploadItemImage,
                                      )
                                    : Text(
                                        _itemImage!,
                                        textScaleFactor: 1.5,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: secondaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
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
                          InputField(
                            key: const Key('Company\'s email address'),
                            textController: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            node: _emailNode,
                            // autovalidateMode: AutovalidateMode.onUserInteraction,
                            obscureText: false,
                            text: 'Email Address',
                            hintText: '@gmail.com',
                            textHeight: 10.0,
                            borderColor: appPrimaryColor.withOpacity(0.9),

                            validator: validationBloc.emailValidator,
                            onSaved: (value) {
                              return null;
                            },
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
                          const SizedBox(height: 40.0),
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
                                            address: _addressController.text),
                                        () => setState(() => _loading = true),
                                        () => setState(() => _loading = false),
                                      ),
                                  color: appPrimaryColor,
                                  textColor: whiteColor,
                                  isLoading: _loading,
                                  width: 350.0)),
                          const SizedBox(height: 15.0),
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

import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/src/bloc/app_settings_bloc.dart';
import 'package:trakk/src/bloc/validation_bloc.dart';
import 'package:trakk/src/mixins/profile_helper.dart';
import 'package:trakk/src/models/update_profile/update_profile.dart';
import 'package:trakk/src/utils/app_toast.dart';
import 'package:trakk/src/utils/helper_utils.dart';
import 'package:trakk/src/values/enums.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/widgets/back_icon.dart';
import 'package:trakk/src/widgets/button.dart';
import 'package:trakk/src/widgets/input_field.dart';

class NextOfKin extends StatefulWidget {
  static const String id = 'nextOfKin';

  const NextOfKin({Key? key}) : super(key: key);

  @override
  _NextOfKinState createState() => _NextOfKinState();
}

class _NextOfKinState extends State<NextOfKin> with ProfileHelper {
  ValidationBloc validationBloc = ValidationBloc();

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  final TextEditingController _fullNameCC = TextEditingController();
  final TextEditingController _emailCC = TextEditingController();
  final TextEditingController _phoneCC = TextEditingController();
  final TextEditingController _addressCC = TextEditingController();

  final FocusNode _fullNameNode = FocusNode();
  final FocusNode _emailNode = FocusNode();
  final FocusNode _phoneNode = FocusNode();
  final FocusNode _addressNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _fullNameCC.dispose();
    _emailCC.dispose();
    _phoneCC.dispose();
    _addressCC.dispose();
    _fullNameNode.dispose();
    _emailNode.dispose();
    _phoneNode.dispose();
    _addressNode.dispose();
    validationBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          10.heightInPixel(),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: kDefaultLayoutPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackIcon(
                  padding: EdgeInsets.zero,
                  onPress: () {
                    Navigator.pop(context);
                  },
                ),
                InkWell(
                  onTap: () {},
                  customBorder: const CircleBorder(),
                  child: Text(
                    'NEXT OF KIN',
                    style: theme.textTheme.subtitle1!.copyWith(
                      color: appPrimaryColor,
                      fontWeight: FontWeight.bold,
                      // decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                BackIcon(
                  padding: EdgeInsets.zero,
                  isPlaceHolder: true,
                  onPress: () {},
                ),
              ],
            ),
          ),
          30.heightInPixel(),
          Expanded(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultLayoutPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5.0),
                    InputField(
                      textController: _fullNameCC,
                      node: _fullNameNode,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: false,
                      text: 'Next Of Kin Full Name',
                      hintText: 'Full Name',
                      textHeight: 10.0,
                      borderColor: appPrimaryColor.withOpacity(0.9),
                      suffixIcon: const Icon(
                        Remix.user_6_line,
                        size: 18.0,
                        color: Color(0xFF909090),
                      ),
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Enter next of kin full name";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        return null;
                      },
                    ),
                    20.heightInPixel(),
                    InputField(
                      textController: _emailCC,
                      node: _emailNode,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: false,
                      text: 'Next Of Kin Email',
                      hintText: 'Email',
                      textHeight: 10.0,
                      borderColor: appPrimaryColor.withOpacity(0.9),
                      suffixIcon: const Icon(
                        Remix.mail_line,
                        size: 18.0,
                        color: Color(0xFF909090),
                      ),
                      validator: validationBloc.emailValidator,
                    ),
                    20.heightInPixel(),
                    InputField(
                      textController: _phoneCC,
                      node: _phoneNode,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: false,
                      text: 'Next Of Kin Phone Number',
                      hintText: 'Phone Number',
                      textHeight: 10.0,
                      borderColor: appPrimaryColor.withOpacity(0.9),
                      suffixIcon: const Icon(
                        Remix.phone_line,
                        size: 18.0,
                        color: Color(0xFF909090),
                      ),
                      validator: (String? value) =>
                          validationBloc.phoneValidator(value,
                              response: "Enter next of kin phone number"),
                      onSaved: (value) {
                        return null;
                      },
                    ),
                    20.heightInPixel(),
                    InputField(
                      textController: _addressCC,
                      node: _addressNode,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: false,
                      text: 'Next Of Kin Residential Address',
                      hintText: 'Residential Address',
                      textHeight: 10.0,
                      borderColor: appPrimaryColor.withOpacity(0.9),
                      suffixIcon: const Icon(
                        Remix.home_7_line,
                        size: 18.0,
                        color: Color(0xFF909090),
                      ),
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Enter next of kin residential address";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Button(
                          text: 'Next',
                          onPress: () async {
                            if (_formKey.currentState!.validate()) {
                              doNextOfKinOperation(
                                  UpdateProfile.riderNOK(
                                      riderId:
                                          (await appSettingsBloc.getUserID),
                                      nOKfullName: _fullNameCC.text,
                                      nOKemail: _emailCC.text,
                                      nOKphoneNumber: _phoneCC.text,
                                      nOKaddress: _addressCC.text), () {
                                setState(() => isLoading = true);
                              }, () async {
                                setState(() => isLoading = false);

                                await appToast(
                                    'Next of kin updated successfully',
                                    appToastType: AppToastType.success);

                                Navigator.pop(context);
                              });
                            }
                          },
                          color: appPrimaryColor,
                          textColor: whiteColor,
                          isLoading: isLoading,
                          width: double.infinity),
                    ),
                    24.heightInPixel(),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

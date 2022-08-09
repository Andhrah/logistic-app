// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/src/bloc/validation_bloc.dart';
import 'package:trakk/src/models/rider/add_rider_to_merchant_model.dart';
import 'package:trakk/src/screens/merchant/add_rider1.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/values/font.dart';
import 'package:trakk/src/utils/helper_utils.dart';
import 'package:trakk/src/values/padding.dart';
import 'package:trakk/src/widgets/back_icon.dart';
import 'package:trakk/src/widgets/button.dart';
import 'package:trakk/src/widgets/input_field.dart';

class AddRider extends StatefulWidget {
  static const String id = 'addRider';

  const AddRider({Key? key}) : super(key: key);

  @override
  _AddRiderState createState() => _AddRiderState();
}

class _AddRiderState extends State<AddRider> {
  final _formKey = GlobalKey<FormState>();
  ValidationBloc validationBloc = ValidationBloc();

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  FocusNode? _firstNameNode;
  FocusNode? _lastNameNode;
  FocusNode? _phoneNumberNode;
  FocusNode? _emailNode;
  FocusNode? _passwordNode;

  FocusNode? _confirmPasswordNode;

  bool _hidePassword = true;
  bool _hideConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    validationBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
        backgroundColor: whiteColor,
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.heightInPixel(),
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
                      'ADD RIDER',
                      style: theme.textTheme.subtitle1!.copyWith(
                        color: appPrimaryColor,
                        ///fontWeight: FontWeight.bold,
                        fontWeight: kBoldWeight,
                      fontFamily: kDefaultFontFamilyHeading
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kDefaultLayoutPadding),
              child: Text('Personal data :',
                  style: theme.textTheme.subtitle1!.copyWith(
                    color: appPrimaryColor,
                    fontWeight: kBoldWeight,
                    // decoration: TextDecoration.underline,
                  )),
            ),
            24.heightInPixel(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultLayoutPadding),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputField(
                        key: const Key('firstName'),
                        textController: _firstNameController,
                        node: _firstNameNode,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: false,
                        text: 'First Name',
                        hintText: 'Jane',
                        textHeight: 10.0,
                        borderColor: appPrimaryColor.withOpacity(0.9),
                        suffixIcon: const Icon(
                          Remix.user_line,
                          size: 18.0,
                          color: Color(0xFF909090),
                        ),
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
                      const SizedBox(height: 20.0),
                      InputField(
                        key: const Key('lastName'),
                        textController: _lastNameController,
                        node: _lastNameNode,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: false,
                        text: 'Last Name',
                        hintText: 'Doe',
                        textHeight: 10.0,
                        borderColor: appPrimaryColor.withOpacity(0.9),
                        suffixIcon: const Icon(
                          Remix.user_line,
                          size: 18.0,
                          color: Color(0xFF909090),
                        ),
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
                        key: const Key('email'),
                        textController: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        node: _emailNode,
                        obscureText: false,
                        text: 'Email Address',
                        hintText: 'jane@email.com',
                        textHeight: 5.0,
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
                        key: const Key('phoneNumber'),
                        textController: _phoneNumberController,
                        keyboardType: TextInputType.phone,
                        node: _phoneNumberNode,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: false,
                        text: 'Phone Number',
                        hintText: '08000000000',
                        textHeight: 5.0,
                        borderColor: appPrimaryColor.withOpacity(0.9),
                        suffixIcon: const Icon(
                          Remix.phone_line,
                          size: 18.0,
                          color: Color(0xFF909090),
                        ),
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
                        key: const Key('password'),
                        textController: _passwordController,
                        node: _passwordNode,
                        obscureText: _hidePassword,
                        maxLines: 1,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        text: 'Password',
                        hintText: 'password',
                        textHeight: 5.0,
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
                      const SizedBox(height: 40.0),
                      InputField(
                        key: const Key('confirm'),
                        textController: _confirmPasswordController,
                        node: _confirmPasswordNode,
                        obscureText: _hideConfirmPassword,
                        maxLines: 1,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        text: 'Confirm Password',
                        hintText: 'confirm password',
                        textHeight: 5.0,
                        borderColor: appPrimaryColor.withOpacity(0.9),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _hideConfirmPassword == false
                                ? Remix.eye_line
                                : Remix.eye_close_line,
                            size: 18.0,
                            color: const Color(0xFF909090),
                          ),
                          onPressed: () {
                            setState(() {
                              _hideConfirmPassword = !_hideConfirmPassword;
                            });
                          },
                        ),
                        validator: (value) {
                          if (_confirmPasswordController.text.length < 8 ||
                              _passwordController.text !=
                                  _confirmPasswordController.text) {
                            return "Password do not match";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          return null;
                        },
                      ),
                      const SizedBox(height: 40.0),
                      Button(
                          text: "Next",
                          //onPress: _onSubmit,
                          onPress: () {
                            if (_formKey.currentState!.validate()) {
                              AddRiderToMerchantModel model =
                                  AddRiderToMerchantModel(
                                      data: AddRiderToMerchantModelData(
                                          firstName: _firstNameController.text,
                                          lastName: _lastNameController.text,
                                          email: _emailController.text,
                                          phone: _phoneNumberController.text,
                                          password: _passwordController.text));
                              Navigator.of(context).pushNamed(AddRider1.id,
                                  arguments: {
                                    'rider_bio_data': model.toJson(),
                                    'previousScreenID': AddRider.id
                                  });
                            }
                          },
                          color: appPrimaryColor,
                          textColor: whiteColor,
                          isLoading: false,
                          width: double.infinity),
                      24.heightInPixel()
                    ],
                  ),
                ),
              ),
            ),
          ],
        )));
  }
}

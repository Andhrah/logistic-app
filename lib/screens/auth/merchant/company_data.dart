// ignore_for_file: unnecessary_null_comparison

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/bloc/validation_bloc.dart';
import 'package:trakk/provider/merchant/add_company_data_provider.dart';
import 'package:trakk/screens/tab.dart';
import 'package:trakk/utils/app_toast.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/utils/enums.dart';
import 'package:trakk/utils/font.dart';
import 'package:trakk/widgets/back_icon.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/widgets/input_field.dart';

class CompanyData extends StatefulWidget {
  static const String id = 'companyData';

  const CompanyData({Key? key}) : super(key: key);

  @override
  _CompanyDataState createState() => _CompanyDataState();
}

class _CompanyDataState extends State<CompanyData> {
  final _formKey = GlobalKey<FormState>();
  ValidationBloc validationBloc = ValidationBloc();

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _passwordController;

  FocusNode? _nameNode;
  FocusNode? _phoneNumberNode;
  FocusNode? _emailNode;
  FocusNode? _rcNumberNode;

  String? _name;
  String? _email;
  String? _phoneNumber;
  String? _rcNumber;

  // String? _cacDocument;
  String _cacDocument = "";

  bool _loading = false;
  bool _passwordIsValid = false;
  bool _hidePassword = true;
  bool _emailIsValid = false;
  bool _isImage = false;
  bool _isButtonPress = false;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _passwordController = TextEditingController();
  }

  /// This function handles email validation
  _validateEmail() {
    RegExp regex;
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    String email = _emailController.text;
    if (email.trim().isEmpty) {
      setState(() {
        _emailIsValid = false;
      });
      return "Email address cannot be empty";
    } else {
      regex = RegExp(pattern);
      setState(() {
        _emailIsValid = regex.hasMatch(email);
      });
      if (_emailIsValid == false) {
        return "Enter a valid email address";
      }
    }
  }

  /*
   * This method handles the onsubmit event annd validates users input. It triggers validation and sends data to the API
  */
  _onSubmit() async {
    setState(() {
      _isButtonPress = true;
      _loading = true;
    });

    final FormState? form = _formKey.currentState;
    if (form!.validate() && _cacDocument.isNotEmpty) {
      form.save();

      try {
        var response =
            await AddCompanyDataProvider.authProvider(context).addCompanyData(
          _name.toString(),
          _email.toString(),
          _phoneNumber.toString(),
          _rcNumber.toString(),
          _cacDocument.toString(),
        );
        setState(() {
          _loading = false;
        });
        form.reset();
        await appToast(
          'Your information has been add successfully',
          appToastType: AppToastType.success,
        );
        Navigator.of(context).pushNamed(
          Tabs.id,
          // CompanyHome.id
        );
      } catch (err) {
        setState(() {
          _loading = false;
        });
        appToast(err.toString(), appToastType: AppToastType.failed);
        rethrow;
      }
    }
    setState(() {
      _loading = false;
    });
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
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    "ADD COMPANY'S INFORMATION",
                    style: theme.textTheme.subtitle1!.copyWith(
                      color: appPrimaryColor,
                      fontWeight: kBoldWeight,
                      // decoration: TextDecoration.underline,
                    ),
                  ),
                  AbsorbPointer(
                    child: Opacity(
                      opacity: 0,
                      child: BackIcon(
                        onPress: () {},
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputField(
                        key: const Key('companyName'),
                        textController: _firstNameController,
                        node: _nameNode,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: false,
                        text: 'Company’s name',
                        hintText: 'Company’s name',
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
                          return "Enter a valid company's name";
                        },
                        onSaved: (value) {
                          _name = value!.trim();
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
                        text: 'Company’s email address',
                        hintText: 'email@company.com',
                        textHeight: 5.0,
                        borderColor: appPrimaryColor.withOpacity(0.9),
                        suffixIcon: const Icon(
                          Remix.mail_line,
                          size: 18.0,
                          color: Color(0xFF909090),
                        ),
                        validator: validationBloc.emailValidator,
                        onSaved: (value) {
                          _email = value!.trim();
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
                          _phoneNumber = value!.trim();
                          return null;
                        },
                      ),

                      const SizedBox(height: 30.0),
                      InputField(
                        key: const Key('cac'),
                        textController: _lastNameController,
                        keyboardType: TextInputType.phone,
                        node: _rcNumberNode,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: false,
                        text: 'CAC RC number (Optional)',
                        hintText: 'CAC RC number',
                        textHeight: 10.0,
                        borderColor: appPrimaryColor.withOpacity(0.9),
                        suffixIcon: const Icon(
                          Remix.user_line,
                          size: 18.0,
                          color: Color(0xFF909090),
                        ),
                        onSaved: (value) {
                          _rcNumber = value!.trim();
                          return null;
                        },
                      ),

                      const SizedBox(height: 30.0),

                      _isImage == false
                          ? InkWell(
                              onTap: () async {
                                final result =
                                    await FilePicker.platform.pickFiles();
                                if (result != null) {
                                  // Open single file open
                                  final file = result.files.first;
                                  print("============= PRINTING File ========");
                                  print(file);
                                  setState(() {
                                    _cacDocument = file.name;
                                    _isImage = true;
                                  });
                                  return;
                                }
                              },
                              child: Align(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 15.0),
                                  width: MediaQuery.of(context).size.width / 3,
                                  height:
                                      MediaQuery.of(context).size.height / 7,
                                  child: Column(
                                    children: const [
                                      Icon(
                                        Remix.upload_2_line,
                                        size: 25,
                                      ),
                                      SizedBox(height: 15.0),
                                      Text(
                                        'Upload CAC Certificate not more than 5mb',
                                        textScaleFactor: 0.9,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: appPrimaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: appPrimaryColor.withOpacity(0.2),
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(5.0),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Align(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 15.0),
                                width: MediaQuery.of(context).size.width / 3,
                                height: MediaQuery.of(context).size.height / 7,
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          _isButtonPress = false;
                                          _isImage = false;
                                          _cacDocument = "";
                                        });
                                      },
                                      child: const Icon(
                                        Remix.delete_bin_2_line,
                                        size: 25,
                                        color: redColor,
                                      ),
                                    ),
                                    const SizedBox(height: 15.0),
                                    Text(
                                      _cacDocument,
                                      textScaleFactor: 1.0,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: secondaryColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: appPrimaryColor.withOpacity(0.2),
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                ),
                              ),
                            ),
                      // Text(
                      //   _cacDocument,
                      //   textScaleFactor: 1.5,
                      //   textAlign: TextAlign.center,
                      //   style: const TextStyle(
                      //     color: secondaryColor,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),

                      const SizedBox(height: 5.0),
                      _isButtonPress && _cacDocument.isEmpty
                          ? const Align(
                              child: Text(" Upload your cac document",
                                  textScaleFactor: 0.9,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.red,
                                    // fontWeight: FontWeight.bold,
                                  )),
                            )
                          : Container(),

                      const SizedBox(height: 40.0),
                      Align(
                          alignment: Alignment.center,
                          child: Button(
                              text: 'Add',
                              onPress: _onSubmit,
                              // onPress: () {
                              //   Navigator.of(context).pushNamed(PersonalData.id);
                              // },
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
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/src/bloc/validation_bloc.dart';
import 'package:trakk/src/mixins/connectivity_helper.dart';
import 'package:trakk/src/mixins/logout_helper.dart';
import 'package:trakk/src/mixins/signup_helper.dart';
import 'package:trakk/src/screens/auth/merchant/widgets/company_data_doc_selector_widget.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/widgets/back_icon.dart';
import 'package:trakk/src/widgets/button.dart';
import 'package:trakk/src/widgets/input_field.dart';

class CompanyData extends StatefulWidget {
  static const String id = 'companyData';

  const CompanyData({Key? key}) : super(key: key);

  @override
  _CompanyDataState createState() => _CompanyDataState();
}

class _CompanyDataState extends State<CompanyData>
    with SignupHelper, ConnectivityHelper, LogoutHelper {
  ValidationBloc validationBloc = ValidationBloc();

  FocusNode? _nameNode;
  FocusNode? _phoneNumberNode;
  FocusNode? _emailNode;
  FocusNode? _rcNumberNode;

  bool _loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    validationBloc.dispose();
    disposeControllers();
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
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputField(
                        key: const Key('companyName'),
                        textController: nameController,
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
                          return null;
                        },
                      ),
                      const SizedBox(height: 30.0),
                      InputField(
                        key: const Key('email'),
                        textController: emailController,
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
                          return null;
                        },
                      ),
                      const SizedBox(height: 30.0),
                      InputField(
                        key: const Key('phoneNumber'),
                        textController: phoneNumberController,
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
                        key: const Key('cac'),
                        textController: rcNumberController,
                        keyboardType: TextInputType.text,
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
                          return null;
                        },
                      ),
                      const SizedBox(height: 30.0),
                      CompanyDataDocSelectorWidget((String? itemImagePath) {
                        cacDocument = itemImagePath ?? '';
                      }),
                      const SizedBox(height: 40.0),
                      Align(
                          alignment: Alignment.center,
                          child: Button(
                              text: 'Add',
                              onPress: () => doAddCompanyInfoOperation(() {
                                    setState(() {
                                      _loading = true;
                                    });
                                    formKey.currentState!.save();
                                  }, () {
                                    setState(() {
                                      _loading = false;
                                    });
                                    formKey.currentState!.reset();
                                  }),
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

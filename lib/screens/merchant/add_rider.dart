// ignore_for_file: unnecessary_null_comparison

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/provider/auth/auth_provider.dart';
import 'package:trakk/screens/auth/login.dart';
import 'package:trakk/screens/auth/rider/personal_data.dart';
import 'package:trakk/screens/merchant/add_rider1.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/back_icon.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/widgets/elevated_container.dart';
import 'package:trakk/widgets/input_field.dart';

class AddRider extends StatefulWidget {
  static const String id = 'addrider';

  const AddRider({Key? key}) : super(key: key);

  @override
  _AddRiderState createState() => _AddRiderState();
}

class _AddRiderState extends State<AddRider> {

  final _formKey = GlobalKey<FormState>();

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
  // FocusNode? _confirmPasswordNode;

  String? _firstName;
  String? _lastName;
  String? _email;
  String? _phoneNumber;
  String? _password;
  String? _confirmPassword;
  String? userType;

  bool _loading = false;
  bool _passwordIsValid = false;
  bool _confirmPasswordIsValid = false;
  bool _hidePassword = true;
  bool _autoValidate = false;
  bool _emailIsValid = false;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _passwordController = TextEditingController();
    // _confirmPasswordController = TextEditingController();
  }

  _validateEmail() {
    RegExp regex;
    String pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
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
      if(_emailIsValid == false){
        return "Enter a valid email address";
      }
    }
  }

  isConfirmPasswordValid() {
    setState(() {
      _confirmPasswordIsValid = _confirmPasswordController.text != null &&
        _confirmPasswordController.text == _passwordController.text;
    });
  }

  /*
   * This method handles the onsubmit event annd validates users input. It triggers validation and sends data to the API
  */
  _onSubmit() async {
    setState(() {
      _loading = true;
    });
    
    final FormState? form = _formKey.currentState;
    if(form!.validate()){

      form.save();
      var box = await Hive.openBox('userData');

      // var box = Hive.box('userData');
      box.putAll({
        "firstName": _firstName,
        "lastName": _lastName,
        "email": _email,
        "phoneNumber": _phoneNumber,
        "password": _password,
        "userType": userType,
      });
      
      try {
        if(userType == "user") {
          var response = await Auth.authProvider(context).createUser(
            _firstName.toString(), 
            _lastName.toString(), 
            _email.toString(), 
            _password.toString(), 
            _phoneNumber.toString(),
            userType.toString()
          );
          setState(() {
            _loading = false;
          });
          if (response["code"] == 201) {
            form.reset();
            await Flushbar(
              messageText: Text(
                response["message"] + ' Please login',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: whiteColor,
                  fontSize: 18,
                ),
              ),
              backgroundColor: green,
              maxWidth: MediaQuery.of(context).size.width/1.4,
              flushbarPosition: FlushbarPosition.TOP,
              borderRadius: BorderRadius.circular(10),
              duration: const Duration(seconds: 2),
            ).show(context);
            Navigator.of(context).pushNamed(Login.id);
          }
        } else {
          Navigator.of(context).pushNamed(PersonalData.id);
        }
      } catch(err){
        setState(() {
          _loading = false;
        });
        await Flushbar(
          messageText: Text(
            err.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: whiteColor,
              fontSize: 18,
            ),
          ),
          backgroundColor: redColor,
          flushbarPosition: FlushbarPosition.TOP,
          maxWidth: MediaQuery.of(context).size.width/1.2,
          borderRadius: BorderRadius.circular(10),
          duration: const Duration(seconds: 5),
        ).show(context);
        rethrow;
      }
    }
    setState(() {
      _loading = false;
    });
  }

  
  
  @override
  Widget build(BuildContext context) {

    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    //userType = arg["userType"];

    print('================================');
    print(userType);

    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              Row(
                children: [
                  BackIcon(
                    onPress: () {Navigator.pop(context);},
                  ),

                  Container(
                    margin: const EdgeInsets.only(left: 40.0),
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {},
                      customBorder: const CircleBorder(),
                      child: const Text(
                        'ADD RIDER',
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
                        onSaved: (value){
                          _firstName = value!.trim();
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
                          _lastName = value!.trim();
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
                        validator: (value) {
                          return _validateEmail();
                        },
                        onSaved: (value){
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
                            _hidePassword == false ? Remix.eye_fill : Remix.eye_close_line,
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
                          _password = value!.trim();
                          return null;
                        },
                      ),

                    const SizedBox(height: 40.0),
                    Align(
                      alignment: Alignment.center,
                      child: Button(
                        text: "Next",
                        //onPress: _onSubmit,
                        onPress: () {
                          Navigator.of(context).pushNamed(AddRider1.id);
                        }, 
                        color: appPrimaryColor, 
                        textColor: whiteColor, 
                        isLoading: _loading,
                        width: 350.0
                      )
                    ),
                    
                    const SizedBox(height: 15.0),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pushNamed(Login.id);
                      },
                      child: Align(
                        child: RichText(
                          textScaleFactor: 0.9,
                          text: const TextSpan(
                            text: 'Already have an account? ',
                            style: TextStyle(
                              color: appPrimaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                            children: <TextSpan>[
                              TextSpan(text: 'Log in', style: TextStyle(fontWeight: FontWeight.bold, color: secondaryColor)),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25.0),
                    Row(
                      children: const [
                        Expanded(
                          child: Divider(
                            color: appPrimaryColor,
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                          'Or continue with',
                            textScaleFactor: 1.2,
                            style: TextStyle(
                              color: appPrimaryColor,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                        ),

                        Expanded(
                          child: Divider(
                            color: appPrimaryColor,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedContainer(
                            onPress: (){},
                            radius: 5.0, 
                            color: whiteColor,
                            height: 55.0,
                            width: 55.0,
                            child: Image.asset(
                              'assets/images/google_icon.png',
                              height: 15,
                              width: 15,
                            ),
                          ),
                        ),

                        Expanded(
                          child: ElevatedContainer(
                            onPress: (){},
                            radius: 5.0, 
                            color: whiteColor,
                            height: 55.0,
                            width: 55.0,
                            child: Image.asset(
                              'assets/images/apple_icon.png',
                              height: 20,
                              width: 20,
                            ),
                          ),
                        ),

                        Expanded(
                          child: ElevatedContainer(
                            onPress: (){},
                            radius: 5.0, 
                            color: whiteColor,
                            height: 55.0,
                            width: 55.0,
                            child: Image.asset(
                              'assets/images/facebook_icon.png',
                              height: 18,
                              width: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                ),
              ),
            ],
          )
        ),
      )
    );
  }
}
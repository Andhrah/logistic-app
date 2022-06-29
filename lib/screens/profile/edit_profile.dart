import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/provider/auth/auth_provider.dart';
import 'package:trakk/provider/auth/signup_provider.dart';
import 'package:trakk/provider/provider_list.dart';
import 'package:trakk/screens/auth/login.dart';
import 'package:trakk/screens/auth/signup.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/back_icon.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/widgets/input_field.dart';

class EditProfile extends StatefulWidget {
  static String id = "editprofile";

  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  static String userType = "user";

  final _formKey = GlobalKey<FormState>();

  // this controller keeps track of what the user is typing in th textField
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
  FocusNode? _homeAddress;

  String? _firstName;
  String? _lastName;
  String? _email;
  String? _phoneNumber;
  String? _password;
  String homeAddress = "";
  String? firstName = "";

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
    _confirmPasswordController = TextEditingController();
  }

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
        print(_emailIsValid);
      });
      if (_emailIsValid == false) {
        return "Enter a valid email address";
      }
    }
  }

  isConfirmPasswordValid() {
    setState(() {
      _confirmPasswordIsValid = _confirmPasswordController.text != null &&
          _confirmPasswordController.text == _passwordController.text;
      print(_confirmPasswordIsValid);
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
    if (form!.validate()) {
      form.save();

      try {
        var response = await SignupProvider.authProvider(context).createUser(
            _firstName.toString(),
            _lastName.toString(),
            _email.toString(),
            _password.toString(),
            _phoneNumber.toString(),
            userType);
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
            flushbarPosition: FlushbarPosition.TOP,
            duration: const Duration(seconds: 2),
          ).show(context);
          Navigator.of(context).pushNamed(Login.id);
        }
        // Auth.authProvider(context)
      } catch (err) {
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
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        backgroundColor: Colors.white,
        leading: BackIcon(
          onPress: () {
            Navigator.pop(context);
          },
        ),
        title: Container(
          // margin: const EdgeInsets.only(left: 0.0),
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {},
            customBorder: const CircleBorder(),
            child: const Text(
              'EDIT PROFILE',
              textScaleFactor: 1.0,
              style: TextStyle(
                color: appPrimaryColor,
                fontWeight: FontWeight.bold,
                // decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ),
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
          child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
             EditProfileContainer(),
            const Divider( thickness: 1.0,color: Color(0xff909090),),
            const SizedBox(height: 20,),
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
                          return "Enter a valid first  name";
                        },
                        onSaved: (value) {
                          _firstName = value!.trim();
                          return null;
                        },
                      ),
                      const SizedBox(height: 30.0),
                      InputField(
                        key: const Key('Last name'),
                        textController: _lastNameController,
                        node: _firstNameNode,
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
                          return "Enter a valid last  name";
                        },
                        onSaved: (value) {
                          _firstName = value!.trim();
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
                          _phoneNumber = value!.trim();
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
                        // suffixIcon: const Icon(
                        //   Remix.mail_line,
                        //   size: 18.0,
                        //   color: Color(0xFF909090),
                        // ),
                        validator: (value) {
                          return _validateEmail();
                        },
                        onSaved: (value) {
                          _email = value!.trim();
                          return null;
                        },
                      ),
                      const SizedBox(height: 30.0),
                      
                      InputField(
                        key: const Key('Home address'),
                        textController: _confirmPasswordController,
                        node: _homeAddress,
                        maxLines: 1,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: _hidePassword,
                        text: 'Home address',
                        hintText: 'Address',
                        textHeight: 10.0,
                        borderColor: appPrimaryColor.withOpacity(0.9),
                        
                        
                      ),
                      
                      const SizedBox(height: 40.0),
                      Align(
                          alignment: Alignment.center,
                          child: Button(
                              text: 'Save',
                              //onPress:// _onSubmit,
                              onPress: () {
                                //firstName = _firstNameController.text;
                                setState(() {
                                  firstName = _firstNameController.text;
                                });
                                Navigator.of(context).pop();
                              },
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
        ),
      )),
    );
  }
}

class EditProfileContainer extends StatelessWidget {
   String? firstName ;
   EditProfileContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(left:30.0, right: 30, bottom: 17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 8, bottom: 12,),
              height: 80,
              width: 80,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('assets/images/image.png'))),
            ),
             Text(
              firstName?? "",
              style:
                  TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            const Text('+234816559234'),
            const SizedBox(
              height: 8,
            ),
            Text('malhohn11@gmail.com'),
          ],
        ),
      ),
    );
  }
}

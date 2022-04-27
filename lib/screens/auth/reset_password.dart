import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/provider/auth/auth_provider.dart';
import 'package:trakk/screens/auth/login.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/back_icon.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/widgets/input_field.dart';

class ResetPassword extends StatefulWidget {
  static const String id = 'resetPassword';

  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  final _formKey = GlobalKey<FormState>();

  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  FocusNode? _passwordNode;
  FocusNode? _confirmPasswordNode;

  String? code;
  String? _password;

  bool _loading = false;
  bool _hidePassword = true;
  bool _confirmPasswordIsValid = false;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
     _confirmPasswordController = TextEditingController();
  }

  isConfirmPasswordValid() {
    setState(() {
      _confirmPasswordIsValid = _confirmPasswordController.text != null &&
        _confirmPasswordController.text == _passwordController.text;
      print(_confirmPasswordIsValid);
    });
  }

  _onSubmit() async {
    setState(() {
      _loading = true;
    });
    
    final FormState? form = _formKey.currentState;
    if(form!.validate()){

      form.save();
      
      try {
        var response = await Auth.authProvider(context).resetPassword(
          code.toString(),
          _password.toString(),
        );
        setState(() {
          _loading = false;
        });
        if (response["statusCode"] == "OK") {
          form.reset();
          await Flushbar(
            messageText: Text(
              response["message"],
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: whiteColor,
                fontSize: 18,
              ),
            ),
            backgroundColor: green,
            maxWidth: MediaQuery.of(context).size.width/1.2,
            flushbarPosition: FlushbarPosition.TOP,
            borderRadius: BorderRadius.circular(10),
            duration: const Duration(seconds: 2),
          ).show(context);
          Navigator.of(context).pushNamed(Login.id);
        } else {
          await Flushbar(
            messageText: const Text(
              'An Error Occurred',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: whiteColor,
                fontSize: 18,
              ),
            ),
            backgroundColor: redColor,
            maxWidth: MediaQuery.of(context).size.width/1.2,
            flushbarPosition: FlushbarPosition.TOP,
            borderRadius: BorderRadius.circular(10),
            duration: const Duration(seconds: 5),
          ).show(context);
        }
        // Auth.authProvider(context)
      } catch(err){
        setState(() {
          _loading = false;
        });
        await Flushbar(
          messageText: const Text(
             'An Error Occurred',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: whiteColor,
              fontSize: 18,
            ),
          ),
          backgroundColor: redColor,
          maxWidth: MediaQuery.of(context).size.width/1.2,
          flushbarPosition: FlushbarPosition.TOP,
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

    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackIcon(
                    onPress: () {Navigator.pop(context);},
                  ),

                  Container(
                    margin: const EdgeInsets.only(right: 70.0),
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {},
                      customBorder: const CircleBorder(),
                      child: const Text(
                        'RESET PASSWORD',
                        textScaleFactor: 1.2,
                        style: TextStyle(
                          color: appPrimaryColor,
                          fontWeight: FontWeight.bold,
                          // decoration: TextDecoration.underline,
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
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputField(
                        key: const Key('password'),
                        textController: _passwordController,
                        node: _passwordNode,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        text: 'Enter new password',
                        hintText: 'password',
                        obscureText: _hidePassword,
                        textHeight: 10.0,
                        maxLines: 1,
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

                      const SizedBox(height: 30.0),
                      InputField(
                        key: const Key('confirmPassword'),
                        textController: _confirmPasswordController,
                        node: _confirmPasswordNode,
                        maxLines: 1,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        text: 'Confirm password',
                        hintText: 'password',
                        obscureText: _hidePassword,
                        textHeight: 10.0,
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
                          if(_confirmPasswordController.text != _passwordController.text){
                            return "Password does not match";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _password = value!.trim();
                          return null;
                        },
                      ),

                      const SizedBox(height: 50.0),
                      Align(
                        alignment: Alignment.center,
                        child: Button(
                          text: 'Reset Password', 
                          // onPress: () {
                          //   Navigator.of(context).pushNamed(Login.id);
                          // },
                          onPress: _onSubmit,
                          color: appPrimaryColor, 
                          textColor: whiteColor, 
                          isLoading: _loading,
                          width: 350.0
                        )
                      ),
                    ],
                  ),
                )
              ),
            ],
          )
        ),
      )
    );
  }
}

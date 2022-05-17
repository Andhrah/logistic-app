import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/provider/auth/auth_provider.dart';
import 'package:trakk/screens/auth/login.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/back_icon.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/widgets/input_field.dart';

class NextOfKin extends StatefulWidget {
  static const String id = 'nextOfKin';

  const NextOfKin({Key? key}) : super(key: key);

  @override
  _NextOfKinState createState() => _NextOfKinState();
}

class _NextOfKinState extends State<NextOfKin> {

  final _formKey = GlobalKey<FormState>();

  late TextEditingController _kinFirstNameController;
  late TextEditingController _kinEmailController;
  late TextEditingController _kinAddressController;
  late TextEditingController _kinPhoneNumberController;

  FocusNode? _kinFirstNameNode;
  FocusNode? _kinEmailNode;
  FocusNode? _kinAddressNode;
  FocusNode? _kinPhoneNumberNode;


  String? _firstName;
  String? _lastName;
  String? _email;
  String? _phoneNumber;
  String? _password;
  String? userType;
  // address
  String? country;
  String? stateOfOrigin;
  String? stateOfResidence;
  String? residentialAddress;
  String? _userPassport;
  // vehicle info
  String? _vehicleName;
  String? _vehicleColor;
  String? _vehicleNumber;
  String? _vehicleCapacity;
  String _vehicleParticulars = "";
  String _vehicleImage = "";
  // kin info
  String? _kinFulltName;
  String? _kinEmail;
  String? _kinAddress;
  String? _kinPhoneNumber;

  bool _loading = false;
  bool _emailIsValid = false;

  @override
  void initState() {
    super.initState();
    _kinFirstNameController = TextEditingController();
    _kinEmailController = TextEditingController();
    _kinAddressController = TextEditingController();
    _kinPhoneNumberController = TextEditingController();
  }

  _validateEmail() {
    RegExp regex;
    String pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    String email = _kinEmailController.text;
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

      try {
        var response = await Auth.authProvider(context).createRider(
          _firstName = box.get("firstName"),
          _lastName = box.get("firstName"),
          _email = box.get("email"),
          _password = box.get("password"),
          _phoneNumber = box.get("phoneNumber"),
          userType = box.get("userType"),
          stateOfOrigin = box.get("stateOfOrigin"),
          stateOfResidence = box.get("stateOfResidence"),
          residentialAddress = box.get("residentialAddress"),
          _userPassport = box.get("userPassport"),
          _vehicleName = box.get("vehicleName"),
          _vehicleColor = box.get("vehicleColor"),
          _vehicleNumber = box.get("vehicleNumber"),
          _vehicleCapacity = box.get("vehicleCapacity"),
          _vehicleParticulars = box.get("vehicleParticulars"),
          _vehicleImage =  box.get("vehicleImage"),
          _kinFulltName.toString(),
          _kinEmail.toString(),
          _kinAddress.toString(),
          _kinPhoneNumber.toString(),
        );
        setState(() {
          _loading = false;
        });
        if (response["code"] == 201) {
          // form.reset();
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
            maxWidth: MediaQuery.of(context).size.width/1.2,
            borderRadius: BorderRadius.circular(10),
            flushbarPosition: FlushbarPosition.TOP,
            duration: const Duration(seconds: 2),
          ).show(context);
          Navigator.of(context).pushNamed(Login.id);
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
                        'CREATE AN ACCOUNT',
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
                    const Text(
                      'Next Of Kin',
                      textScaleFactor: 1.2,
                      style: TextStyle(
                        color: appPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    const SizedBox(height: 30.0),
                    InputField(
                      key: const Key('kinFullName'),
                      textController: _kinFirstNameController,
                      node: _kinFirstNameNode,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: false,
                      text: 'Full Name of Kin',
                      hintText: 'John Doe',
                      textHeight: 10.0,
                      borderColor: appPrimaryColor.withOpacity(0.9),
                      suffixIcon: const Icon(
                        Remix.user_line,
                        size: 18.0,
                        color: Color(0xFF909090),
                      ),
                      validator: (value) {
                        if (value!.trim().length > 3) {
                          return null;
                        }
                        return "Enter a valid full name";
                      },
                        onSaved: (value){
                          _kinFulltName = value!.trim();
                          return null;
                      },
                    ),
                    

                    const SizedBox(height: 30.0),
                    InputField(
                      key: const Key('kinEmail'),
                      textController: _kinEmailController,
                      keyboardType: TextInputType.emailAddress,
                      node: _kinEmailNode,
                      obscureText: false,
                      text: 'Email Address of Kin',
                      hintText: 'johndoe@email.com',
                      textHeight: 10.0,
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
                        _kinEmail = value!.trim();
                        return null;
                      },
                    ),

                    const SizedBox(height: 30.0),
                    InputField(
                      key: const Key('kinAddress'),
                      textController: _kinAddressController,
                      node: _kinAddressNode,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: false,
                      text: 'Address of Kin',
                      hintText: 'Address of next of kin',
                      textHeight: 10.0,
                      borderColor: appPrimaryColor.withOpacity(0.9),
                      suffixIcon: const Icon(
                        Remix.home_7_line,
                        size: 18.0,
                        color: Color(0xFF909090),
                      ),
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Enter your residential address";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _kinAddress = value!.trim();
                        return null;
                      },
                    ),

                    const SizedBox(height: 30.0),
                    InputField(
                      key: const Key('kinPhoneNumber'),
                      textController: _kinPhoneNumberController,
                      node: _kinPhoneNumberNode,
                      keyboardType: TextInputType.phone,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: false,
                      text: 'Phone number of Kin',
                      hintText: '08000000000',
                      textHeight: 10.0,
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
                        _kinPhoneNumber = value!.trim();
                        return null;
                      },
                    ),

                    const SizedBox(height: 40.0),
                    Align(
                      alignment: Alignment.center,
                      child: Button(
                        text: 'Create account', 
                        // onPress: () {
                        //   Navigator.of(context).pushNamed(Tabs.id);
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
                ),
              ),
            ],
          )
        ),
      )
    );
  }
}

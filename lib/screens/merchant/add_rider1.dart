import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/provider/auth/auth_provider.dart';
import 'package:trakk/screens/auth/login.dart';
import 'package:trakk/screens/auth/signup.dart';
import 'package:trakk/screens/dispatch/checkout.dart';
import 'package:trakk/screens/dispatch/pick_ride.dart';
import 'package:trakk/screens/merchant/add_rider2.dart';
import 'package:trakk/screens/merchant/company_home.dart';
import 'package:trakk/screens/merchant/list_of_vehicles.dart';
import 'package:trakk/screens/merchant/vehicles.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/back_icon.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/widgets/cancel_button.dart';
import 'package:trakk/widgets/input_field.dart';

class AddRider1 extends StatefulWidget {
  static String id = "addrider1";

  const AddRider1({Key? key}) : super(key: key);

  @override
  State<AddRider1> createState() => _AddRider1State();
}

class _AddRider1State extends State<AddRider1> {
  static String userType = "user";
  final _formKey = GlobalKey<FormState>();

  String _stateOfOrigin = 'State of origin';
  String _stateOfResidence = 'State of residence';

  String? residentialAddress;

  bool _isButtonPress = false;

  var states = [
    "State of origin",
    "Abia",
    "Adamawa",
    "Akwa Ibom",
    "Anambra",
    "Bauchi",
    "Bayelsa",
    "Benue",
    "Borno",
    "Cross River",
    "Delta",
    "Ebonyi",
    "Edo",
    "Ekiti",
    "Enugu",
    "FCT - Abuja",
    "Gombe",
    "Imo",
    "Jigawa",
    "Kaduna",
    "Kano",
    "Katsina",
    "Kebbi",
    "Kogi",
    "Kwara",
    "Lagos",
    "Nasarawa",
    "Niger",
    "Ogun",
    "Ondo",
    "Osun",
    "Oyo",
    "Plateau",
    "Rivers",
    "Sokoto",
    "Taraba",
    "Yobe",
    "Zamfara"
  ];
  var states1 = [
    "State of residence",
    "Abia",
    "Adamawa",
    "Akwa Ibom",
    "Anambra",
    "Bauchi",
    "Bayelsa",
    "Benue",
    "Borno",
    "Cross River",
    "Delta",
    "Ebonyi",
    "Edo",
    "Ekiti",
    "Enugu",
    "FCT - Abuja",
    "Gombe",
    "Imo",
    "Jigawa",
    "Kaduna",
    "Kano",
    "Katsina",
    "Kebbi",
    "Kogi",
    "Kwara",
    "Lagos",
    "Nasarawa",
    "Niger",
    "Ogun",
    "Ondo",
    "Osun",
    "Oyo",
    "Plateau",
    "Rivers",
    "Sokoto",
    "Taraba",
    "Yobe",
    "Zamfara"
  ];

  late TextEditingController _stateOfOriginController;
  late TextEditingController _vehicleColorController;
  late TextEditingController _emailController;
  late TextEditingController _vehicleNumberController;
  late TextEditingController _vehicleCapacityController;
  late TextEditingController _passwordController;
  late TextEditingController _residentialAddressController;

  FocusNode? _stateNode;
  FocusNode? _lastNameNode;
  FocusNode? _vehicleNumberNode;
  FocusNode? _residentialAddressNode;
  FocusNode? _emailNode;
  FocusNode? _passwordNode;
  FocusNode? _confirmPasswordNode;
  FocusNode? _vehicleColorNode;
  String? _residentialAddress;

  String? _state;
  String? _lastName;
  String? _name;
  String? _email;
  String? _vehicleNumber;
  String? _vehicleCapacity;
  String? _password;
  String? _confirmPassword;
  String? _vehicleColor;

  bool _loading = false;
  bool _passwordIsValid = false;
  bool _confirmPasswordIsValid = false;
  bool _hidePassword = true;
  bool _autoValidate = false;
  bool _emailIsValid = false;

  @override
  void initState() {
    super.initState();
    _stateOfOriginController = TextEditingController();
    _vehicleColorController = TextEditingController();
    _vehicleCapacityController = TextEditingController();
    _emailController = TextEditingController();
    _vehicleNumberController = TextEditingController();
    _passwordController = TextEditingController();
    _residentialAddressController = TextEditingController();
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
      _confirmPasswordIsValid = _residentialAddressController.text != null &&
          _residentialAddressController.text == _passwordController.text;
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
        var response = await Auth.authProvider(context).createUser(
            _name.toString(),
            _lastName.toString(),
            _email.toString(),
            _password.toString(),
            _vehicleNumber.toString(),
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
      backgroundColor: whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                BackIcon(
                  onPress: () {
                    Navigator.pop(context);
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(left: 40.0),
                  alignment: Alignment.center,
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
              ],
            ),
            SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                'Address:',
                textScaleFactor: 1.2,
                style: TextStyle(
                  color: appPrimaryColor,
                  fontWeight: FontWeight.bold,
                  // decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            Container(
                height: 450,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Form(
                  key: _formKey,
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       
                        const SizedBox(height: 5.0),
                        DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: appPrimaryColor.withOpacity(0.9),
                                  width: 0.3), //border of dropdown button
                              borderRadius: BorderRadius.circular(
                                  5.0), //border raiuds of dropdown button
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: DropdownButton<String>(
                                value: _stateOfOrigin,
                                icon: const Icon(Remix.arrow_down_s_line),
                                elevation: 16,
                                isExpanded: true,
                                style: TextStyle(
                                  color: appPrimaryColor.withOpacity(0.8),
                                  fontSize: 18.0,
                                ),
                                underline: Container(), //empty line
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _stateOfOrigin = newValue!;
                                  });
                                },
                                items: states.map((String value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            )),

                        const SizedBox(height: 5.0),

                        _isButtonPress && _stateOfOrigin == "State of origin"
                            ? const Text(
                                " Choose your State of origin",
                                textScaleFactor: 0.9,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              )
                            : Container(),
                        SizedBox(
                          height: 20,
                        ),
                         const Text(
                          'State of residence',
                          textScaleFactor: 1.2,
                          style: TextStyle(
                            color: appPrimaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),


                        const SizedBox(height: 20.0),
                        DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: appPrimaryColor.withOpacity(0.9),
                                  width: 0.3), //border of dropdown button
                              borderRadius: BorderRadius.circular(
                                  5.0), //border raiuds of dropdown button
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: DropdownButton<String>(
                                value: _stateOfResidence,
                                icon: const Icon(Remix.arrow_down_s_line),
                                elevation: 16,
                                isExpanded: true,
                                style: TextStyle(
                                  color: appPrimaryColor.withOpacity(0.8),
                                  fontSize: 18.0,
                                ),
                                underline: Container(), //empty line
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _stateOfResidence = newValue!;
                                  });
                                },
                                items: states1.map((String value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            )),

                        const SizedBox(height: 5.0),

                        _isButtonPress && _stateOfResidence == "State of residence"
                            ? const Text(
                                " Choose your State of residence",
                                textScaleFactor: 0.9,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              )
                            : Container(),
                        SizedBox(
                          height: 20,
                        ),

                        
                      InputField(
                          key: const Key('residentialAddress'),
                          textController: _residentialAddressController,
                          node: _residentialAddressNode,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: false,
                          text: 'Residential Address',
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
                              return "Enter your residential address";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _residentialAddress = value!.trim();
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
                              //onPress:// _onSubmit,
                              onPress: () {
                                Navigator.of(context).pushNamed(AddRider2.id);
                              },
                                  
                              color: appPrimaryColor,
                              textColor: whiteColor,
                              isLoading: _loading,
                              width: 300.0),
                        ),
                      ],
                    ),
                  ),
                )),

            const SizedBox(height: 15.0),
            const SizedBox(height: 25.0),
            //   ],
            // ),
          ]),
        ),
      ),
    );
  }
}

class EditProfileContainer extends StatelessWidget {
  const EditProfileContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30, bottom: 17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 8,
                bottom: 12,
              ),
              height: 80,
              width: 80,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('assets/images/image.png'))),
            ),
            const Text(
              'Malik Johnson',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
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

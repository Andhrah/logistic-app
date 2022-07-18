import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/models/rider/add_rider_to_merchant_model.dart';
import 'package:trakk/screens/merchant/add_rider_2/add_rider2.dart';
import 'package:trakk/utils/app_toast.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/utils/constant.dart';
import 'package:trakk/utils/font.dart';
import 'package:trakk/utils/helper_utils.dart';
import 'package:trakk/utils/padding.dart';
import 'package:trakk/widgets/back_icon.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/widgets/input_field.dart';

class AddRider1 extends StatefulWidget {
  static String id = "addRider1";

  const AddRider1({Key? key}) : super(key: key);

  @override
  State<AddRider1> createState() => _AddRider1State();
}

class _AddRider1State extends State<AddRider1> {
  static String userType = "user";
  final _formKey = GlobalKey<FormState>();

  String? _stateOfOrigin;
  String? _stateOfResidence;

  String? residentialAddress;

  bool _isButtonPress = false;

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

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    AddRiderToMerchantModel model =
        AddRiderToMerchantModel.fromJson(arg["rider_bio_data"]);

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
                    'ADD RIDER',
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
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: kDefaultLayoutPadding),
            child: Text('Address:',
                style: theme.textTheme.subtitle1!.copyWith(
                  color: appPrimaryColor,
                  fontWeight: kBoldWeight,
                  // decoration: TextDecoration.underline,
                )),
          ),
          24.heightInPixel(),

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
                    Text(
                      'State of origin',
                      style: theme.textTheme.bodyText1!.copyWith(
                        fontWeight: kMediumWeight,
                      ),
                    ),
                    10.heightInPixel(),
                    DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: appPrimaryColor.withOpacity(0.9),
                              width: 0.3), //border of dropdown button
                          borderRadius: BorderRadius.circular(
                              5.0), //border raiuds of dropdown button
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: DropdownButton<String>(
                            value: _stateOfOrigin,
                            icon: const Icon(Remix.arrow_down_s_line),
                            elevation: 16,
                            hint: Text(
                              'State of origin',
                              style: theme.textTheme.bodyText2!
                                  .copyWith(color: const Color(0xFFBDBDBD)),
                            ),
                            isExpanded: true,
                            style: TextStyle(
                              color: appPrimaryColor.withOpacity(0.8),
                              fontSize: 18.0,
                            ),
                            underline: Container(),
                            //empty line
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
                    20.heightInPixel(),
                    Text(
                      'State of residence',
                      style: theme.textTheme.bodyText1!.copyWith(
                        fontWeight: kMediumWeight,
                      ),
                    ),
                    10.heightInPixel(),
                    DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: appPrimaryColor.withOpacity(0.9),
                              width: 0.3), //border of dropdown button
                          borderRadius: BorderRadius.circular(
                              5.0), //border raiuds of dropdown button
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: DropdownButton<String>(
                            value: _stateOfResidence,
                            icon: const Icon(Remix.arrow_down_s_line),
                            elevation: 16,
                            hint: Text(
                              'State of residence',
                              style: theme.textTheme.bodyText2!
                                  .copyWith(color: const Color(0xFFBDBDBD)),
                            ),
                            isExpanded: true,
                            style: TextStyle(
                              color: appPrimaryColor.withOpacity(0.8),
                              fontSize: 18.0,
                            ),
                            underline: Container(),
                            //empty line
                            onChanged: (String? newValue) {
                              setState(() {
                                _stateOfResidence = newValue!;
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
                            if (_formKey.currentState!.validate()) {
                              if (_stateOfResidence == null) {
                                appToast('State of residence is required');
                                return;
                              }
                              if (_stateOfOrigin == null) {
                                appToast('State of origin is required');
                                return;
                              }
                              model = model.copyWith(
                                  data: model.data!.copyWith(
                                      stateOfOrigin: _stateOfOrigin,
                                      stateOfResidence: _stateOfResidence,
                                      residentialAddress:
                                          _residentialAddressController.text));

                              Navigator.of(context).pushNamed(AddRider2.id,
                                  arguments: {
                                    'rider_bio_data': model.toJson()
                                  });
                            }
                          },
                          color: appPrimaryColor,
                          textColor: whiteColor,
                          isLoading: _loading,
                          width: double.infinity),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //   ],
          // ),
        ]),
      ),
    );
  }
}

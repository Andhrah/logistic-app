import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/models/rider/add_rider_to_merchant_model.dart';
import 'package:trakk/screens/merchant/company_home.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/utils/font.dart';
import 'package:trakk/utils/helper_utils.dart';
import 'package:trakk/utils/padding.dart';
import 'package:trakk/widgets/back_icon.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/widgets/cancel_button.dart';
import 'package:trakk/widgets/input_field.dart';

class AddRider2 extends StatefulWidget {
  static String id = "addRider2";

  const AddRider2({Key? key}) : super(key: key);

  @override
  State<AddRider2> createState() => _AddRider2State();
}

class _AddRider2State extends State<AddRider2> {
  static String userType = "user";

  bool _isButtonPress = false;

  var colors = [
    "Color of vehicle",
    "black",
    "white",
    "gold",
    "grey",
    "ash",
    "blue",
    "red"
  ];
  String _colorsTypes = "Color of vehicle";

  final _formKey = GlobalKey<FormState>();

  late TextEditingController _vehicleNameController;
  late TextEditingController _vehicleModelController;
  late TextEditingController _emailController;
  late TextEditingController _vehicleNumberController;
  late TextEditingController _vehicleCapacityController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  FocusNode? _nameNode;
  FocusNode? _lastNameNode;
  FocusNode? _vehicleNumberNode;
  FocusNode? _vehicleCapacityNode;
  FocusNode? _emailNode;
  FocusNode? _passwordNode;
  FocusNode? _confirmPasswordNode;
  FocusNode? _vehicleColorNode;
  FocusNode? _vehicleModelNode;

  String? _name;
  String? _lastName;
  String? _email;
  String? _vehicleNumber;
  String? _vehicleCapacity;
  String? _password;
  String? _confirmPassword;
  String? _vehicleColor;
  String? _vehicleModel;

  bool _loading = false;
  bool _passwordIsValid = false;
  bool _confirmPasswordIsValid = false;
  bool _hidePassword = true;
  bool _autoValidate = false;
  bool _emailIsValid = false;

  @override
  void initState() {
    super.initState();
    _vehicleNameController = TextEditingController();
    _vehicleModelController = TextEditingController();
    _vehicleCapacityController = TextEditingController();
    _emailController = TextEditingController();
    _vehicleNumberController = TextEditingController();
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
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: kDefaultLayoutPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackIcon(
                  onPress: () {
                    Navigator.pop(context);
                  },
                  padding: EdgeInsets.zero,
                ),
                Text(
                  'ADD RIDER',
                  style: theme.textTheme.subtitle1!.copyWith(
                    color: appPrimaryColor,
                    fontWeight: FontWeight.bold,
                    // decoration: TextDecoration.underline,
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
            child: Text('Vehicle data',
                style: theme.textTheme.subtitle1!.copyWith(
                  color: appPrimaryColor,
                  fontWeight: kBoldWeight,
                  // decoration: TextDecoration.underline,
                )),
          ),

          24.heightInPixel(),
          Expanded(
              child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: kDefaultLayoutPadding),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  14.heightInPixel(),
                  InputField(
                    key: const Key('name of vehicle'),
                    textController: _vehicleNameController,
                    node: _nameNode,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: false,
                    text: 'Type of vehicle',
                    hintText: 'name of vehicle',
                    textHeight: 10.0,
                    borderColor: appPrimaryColor.withOpacity(0.9),
                    // suffixIcon: const Icon(
                    //   Remix.user_line,
                    //   size: 18.0,
                    //   color: Color(0xFF909090),
                    // ),
                    // validator: (value) {
                    //   if (value!.trim().length > 2) {
                    //     return null;
                    //   }
                    //   return "Enter a valid first  name";
                    // },
                    onSaved: (value) {
                      _name = value!.trim();
                      return null;
                    },
                  ),
                  20.heightInPixel(),
                  const Text(
                    'Color of vehicle',
                    style: TextStyle(
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
                          value: _colorsTypes,
                          icon: const Icon(Remix.arrow_down_s_line),
                          elevation: 16,
                          isExpanded: true,
                          style: TextStyle(
                            color: appPrimaryColor.withOpacity(0.8),
                            fontSize: 18.0,
                          ),
                          underline: Container(),
                          //empty line
                          onChanged: (String? newValue) {
                            setState(() {
                              _colorsTypes = newValue!;
                            });
                          },
                          items: colors.map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      )),
                  _isButtonPress && _colorsTypes == "Vehicle capacity"
                      ? const Text(
                          "Select weight",
                          textScaleFactor: 0.9,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        )
                      : Container(),
                  const SizedBox(height: 20.0),
                  InputField(
                    key: const Key('vehiclenumber'),
                    textController: _vehicleNumberController,
                    keyboardType: TextInputType.phone,
                    node: _vehicleNumberNode,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: false,
                    text: 'Vehicle number',
                    hintText: 'Vehicle number',
                    textHeight: 10.0,
                    borderColor: appPrimaryColor.withOpacity(0.9),
                    // validator: (value) {
                    //   if (value!.trim().length == 11) {
                    //     return null;
                    //   }
                    //   return "Enter a valid phone number";
                    // },
                    onSaved: (value) {
                      _vehicleNumber = value!.trim();
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  InputField(
                    key: const Key('vehicleModel'),
                    textController: _vehicleModelController,
                    keyboardType: TextInputType.text,
                    node: _vehicleModelNode,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: false,
                    text: 'Vehicle Model',
                    hintText: 'Vehicle model',
                    textHeight: 10.0,
                    borderColor: appPrimaryColor.withOpacity(0.9),
                    onSaved: (value) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  InputField(
                    key: const Key('vehicleEngineCapacity'),
                    textController: _vehicleCapacityController,
                    keyboardType: TextInputType.text,
                    node: _vehicleCapacityNode,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: false,
                    text: 'Vehicle Model',
                    hintText: 'Vehicle model',
                    textHeight: 10.0,
                    borderColor: appPrimaryColor.withOpacity(0.9),
                    onSaved: (value) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 40.0),
                  Align(
                    alignment: Alignment.center,
                    child: Button(
                        text: 'Register',
                        //onPress:// _onSubmit,
                        onPress: () {
                          showDialog<String>(
                            // barrierDismissible: true,
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              // title: const Text('AlertDialog Title'),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 24.0, vertical: 10.0),
                              content: SizedBox(
                                height: 250.0,
                                child: Column(children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            Navigator.of(context)
                                                .pushNamed(CompanyHome.id);
                                          },
                                          child: const CancelButton())
                                    ],
                                  ),
                                  20.heightInPixel(),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Suzuki No. 889 has been added to vehicle lists',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        const SizedBox(height: 30),
                                        Button(
                                            text: 'View all vehicles',
                                            onPress: () {
                                              // Navigator.of(context)
                                              //     .pushNamed(ListOfVehicles.id);
                                            },
                                            color: appPrimaryColor,
                                            textColor: whiteColor,
                                            isLoading: false,
                                            width: 300
                                            //MediaQuery.of(context).size.width/1.6,
                                            ),
                                      ],
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                          );
                        },
                        color: appPrimaryColor,
                        textColor: whiteColor,
                        isLoading: _loading,
                        width: double.infinity),
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

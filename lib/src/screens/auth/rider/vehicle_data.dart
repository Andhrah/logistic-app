import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:remixicon/remixicon.dart';
import 'package:trakk/src/screens/auth/rider/next_of_kin.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/widgets/back_icon.dart';
import 'package:trakk/src/widgets/button.dart';
import 'package:trakk/src/widgets/input_field.dart';

class VehicleData extends StatefulWidget {
  static const String id = 'vehicledata';

  const VehicleData({Key? key}) : super(key: key);

  @override
  _VehicleDataState createState() => _VehicleDataState();
}

class _VehicleDataState extends State<VehicleData> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _vehicleNameController;
  late TextEditingController _vehicleColorController;
  late TextEditingController _vehicleNumberController;
  late TextEditingController _vehicleCapacityController;
  late TextEditingController _vehicleModelController;

  FocusNode? _vehicleNameNode;
  FocusNode? _vehicleColorNode;
  FocusNode? _vehicleNumberNode;
  FocusNode? _vehicleCapacityNode;
  FocusNode? _vehicleModelNode;

  String? userType;

  String? country;
  String? stateOfOrigin;
  String? stateOfResidence;
  String? residentialAddress;
  String? userPassport;

  String? _vehicleName;
  String? _vehicleColor;
  String? _vehicleNumber;
  String? _vehicleCapacity;
  String? _vehicleModel;
  String _vehicleParticulars = "";
  String _vehicleImageUrl = "";
  String _driverLicence = "";

  bool _isVehicleParticularsImage = false;
  bool _isVehicleImage = false;
  bool _isDriverLicence = false;
  bool _isButtonPress = false;

  @override
  void initState() {
    super.initState();

    _vehicleNameController = TextEditingController();
    _vehicleColorController = TextEditingController();
    _vehicleNumberController = TextEditingController();
    _vehicleCapacityController = TextEditingController();
    _vehicleModelController = TextEditingController();
  }

  /*
   * This method handles the onsubmit event annd validates users input. It triggers validation and sends data to the API
  */
  _onNextPress() async {
    setState(() {
      _isButtonPress = true;
    });

    final FormState? form = _formKey.currentState;
    if (form!.validate() &&
        _vehicleParticulars.isNotEmpty &&
        _vehicleImageUrl.isNotEmpty) {
      form.save();

      var vehicleImage = {
        "name": "vehicleImage",
        "url": _vehicleImageUrl,
      };
      var vehicleParticular = {
        "name": "vehicleParticular",
        "url": _vehicleParticulars,
      };
      var driverLicence = {
        "name": "driverLicence",
        "url": _driverLicence,
      };

      var routeMap =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      routeMap.addAll({
        "vehicleName": _vehicleName,
        "vehicleColor": _vehicleColor,
        "vehicleNumber": _vehicleNumber,
        "vehicleCapacity": _vehicleCapacity,
        "vehicleModel": _vehicleModel,
      });

      Map<String, dynamic> imgDocs = routeMap['riderDocs'];

      imgDocs.addAll({
        'vehicleImage': vehicleImage,
        'vehicleParticular': vehicleParticular,
        'driverLicence': driverLicence
      });

      routeMap['riderDocs'] = imgDocs;

      Navigator.of(context).pushNamed(NextOfKin.id);
    }
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
                    onPress: () {
                      Navigator.pop(context);
                    },
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
                        'Vehicle data:',
                        textScaleFactor: 1.2,
                        style: TextStyle(
                          color: appPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      InputField(
                        key: const Key('vehicleName'),
                        textController: _vehicleNameController,
                        node: _vehicleNameNode,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: false,
                        text: 'Name of vehicle',
                        hintText: 'Name of vehicle',
                        textHeight: 5.0,
                        borderColor: appPrimaryColor.withOpacity(0.9),
                        validator: (value) {
                          if (value!.trim().length > 3) {
                            return null;
                          }
                          return "Enter a valid vehicle name";
                        },
                        onSaved: (value) {
                          _vehicleName = value!.trim();
                          return null;
                        },
                      ),
                      const SizedBox(height: 30.0),
                      InputField(
                        key: const Key('vehicleColor'),
                        textController: _vehicleColorController,
                        node: _vehicleColorNode,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: false,
                        text: 'Color of vehicle',
                        hintText: 'blue',
                        textHeight: 5.0,
                        borderColor: appPrimaryColor.withOpacity(0.9),
                        validator: (value) {
                          if (value!.trim().length > 3) {
                            return null;
                          }
                          return "Enter a valid vehicle color";
                        },
                        onSaved: (value) {
                          _vehicleColor = value!.trim();
                          return null;
                        },
                      ),
                      const SizedBox(height: 30.0),
                      InputField(
                        key: const Key('vehicleNumber'),
                        textController: _vehicleNumberController,
                        node: _vehicleNumberNode,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: false,
                        text: 'Vehicle number',
                        hintText: 'Vehicle number',
                        textHeight: 5.0,
                        borderColor: appPrimaryColor.withOpacity(0.9),
                        validator: (value) {
                          if (value!.trim().length > 3) {
                            return null;
                          }
                          return "Enter a valid vehicle number";
                        },
                        onSaved: (value) {
                          _vehicleNumber = value!.trim();
                          return null;
                        },
                      ),
                      const SizedBox(height: 30.0),
                      InputField(
                        key: const Key('vehicleCapacity'),
                        textController: _vehicleCapacityController,
                        node: _vehicleCapacityNode,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: false,
                        text: 'Vehicle capacity',
                        hintText: 'Vehicle capacity',
                        textHeight: 5.0,
                        borderColor: appPrimaryColor.withOpacity(0.9),
                        validator: (value) {
                          if (value!.trim().length > 2) {
                            return null;
                          }
                          return "Enter a valid vehicle capacity";
                        },
                        onSaved: (value) {
                          _vehicleCapacity = value!.trim();
                          return null;
                        },
                      ),
                      const SizedBox(height: 30.0),
                      InputField(
                        key: const Key('vehicleModel'),
                        textController: _vehicleModelController,
                        node: _vehicleModelNode,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: false,
                        text: 'Vehicle Model',
                        hintText: 'Vehicle model',
                        textHeight: 5.0,
                        borderColor: appPrimaryColor.withOpacity(0.9),
                        validator: (value) {
                          if (value!.trim().length > 2) {
                            return null;
                          }
                          return "Enter a valid vehicle model";
                        },
                        onSaved: (value) {
                          _vehicleModel = value!.trim();
                          return null;
                        },
                      ),
                      const SizedBox(height: 30.0),
                      _isVehicleParticularsImage == false
                          ? InkWell(
                              onTap: () async {
                                final result =
                                    await FilePicker.platform.pickFiles();
                                if (result != null) {
                                  // Open single file open
                                  final file = result.files.first;
                                  print("Image Name: ${file.name}");
                                  setState(() {
                                    _vehicleParticulars = file.name;
                                    _isVehicleParticularsImage = true;
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
                                    children: [
                                      const Icon(
                                        Remix.upload_2_line,
                                        size: 25,
                                      ),
                                      const SizedBox(height: 15.0),
                                      const Text(
                                        'Upload vehicle particulars not more than 10kb',
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
                          : Text(
                              _vehicleParticulars,
                              textScaleFactor: 1.5,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: secondaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      const SizedBox(height: 5.0),
                      _isButtonPress && _vehicleParticulars.isEmpty
                          ? const Align(
                              child: Text(
                                  " Upload your vehicle image for verification",
                                  textScaleFactor: 0.9,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.red,
                                    // fontWeight: FontWeight.bold,
                                  )),
                            )
                          : Container(),
                      const SizedBox(height: 30.0),
                      _isVehicleImage == false
                          ? InkWell(
                              onTap: () async {
                                final result =
                                    await FilePicker.platform.pickFiles();
                                if (result != null) {
                                  // Open single file open
                                  final file = result.files.first;
                                  print("Image Name: ${file.name}");
                                  setState(() {
                                    _vehicleImageUrl = file.name;
                                    _isVehicleImage = true;
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
                                    children: [
                                      const Icon(
                                        Remix.upload_2_line,
                                        size: 25,
                                      ),
                                      const SizedBox(height: 15.0),
                                      const Text(
                                        'Upload vehicle image',
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
                          : Text(
                              _vehicleImageUrl,
                              textScaleFactor: 1.5,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: secondaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      const SizedBox(height: 5.0),
                      _isButtonPress && _vehicleImageUrl.isEmpty
                          ? const Align(
                              child: Text(" Upload vehicle image",
                                  textScaleFactor: 0.9,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.red,
                                    // fontWeight: FontWeight.bold,
                                  )),
                            )
                          : Container(),
                      const SizedBox(height: 30.0),
                      _isDriverLicence == false
                          ? InkWell(
                              onTap: () async {
                                final result =
                                    await FilePicker.platform.pickFiles();
                                if (result != null) {
                                  // Open single file open
                                  final file = result.files.first;
                                  print("Image Name: ${file.name}");
                                  setState(() {
                                    _driverLicence = file.name;
                                    _isDriverLicence = true;
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
                                    children: [
                                      const Icon(
                                        Remix.upload_2_line,
                                        size: 25,
                                      ),
                                      const SizedBox(height: 15.0),
                                      const Text(
                                        'Upload driver’s licence',
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
                          : Text(
                              _driverLicence,
                              textScaleFactor: 1.5,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: secondaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      const SizedBox(height: 5.0),
                      _isButtonPress && _driverLicence.isEmpty
                          ? const Align(
                              child: Text(" Upload driver’s licence",
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
                              text: 'Next',
                              onPress: _onNextPress,
                              // onPress: () {
                              //   Navigator.of(context).pushNamed(NextOfKin.id);
                              // },
                              color: appPrimaryColor,
                              textColor: whiteColor,
                              isLoading: false,
                              width: 350.0)),
                      const SizedBox(height: 40.0),
                    ],
                  ),
                ),
              ),
            ],
          )),
        ));
  }
}

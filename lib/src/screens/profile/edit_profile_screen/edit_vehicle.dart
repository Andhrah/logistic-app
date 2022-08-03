import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/src/utils/helper_utils.dart';
import 'package:trakk/src/values/colors.dart';

import '../../../bloc/app_settings_bloc.dart';
import '../../../bloc/validation_bloc.dart';
import '../../../values/font.dart';
import '../../../widgets/back_icon.dart';
import '../../../widgets/button.dart';
import '../../../widgets/input_field.dart';

class EditVehicle extends StatefulWidget {
  EditVehicle({Key? key}) : super(key: key);
  static const String id = "editVehicle";

  @override
  State<EditVehicle> createState() => _EditVehicleState();
}

class _EditVehicleState extends State<EditVehicle> {
  ValidationBloc validationBloc = ValidationBloc();

  bool _isButtonPress = false;
  var colors = ["black", "white", "gold", "grey", "ash", "blue", "red"];
  String? _colorsTypes;

  final TextEditingController _nameOfVehicleController =
      TextEditingController();
  final TextEditingController _vehicleNumberController =
      TextEditingController();
  final TextEditingController _vhicleModelController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final FocusNode _nameOfVehicleNode = FocusNode();
  final FocusNode _vehicleNumberNode = FocusNode();
  final FocusNode _vhicleModelNode = FocusNode();
  final FocusNode _emailNode = FocusNode();
  final FocusNode _addressNode = FocusNode();

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    var user =
        (await appSettingsBloc.fetchAppSettings()).loginResponse?.data?.user;

    // UserType userType = await appSettingsBloc.getUserType;
    setState(() {
      _nameOfVehicleController.text = user?.firstName ?? '';
      _vehicleNumberController.text = user?.lastName ?? '';
      _vhicleModelController.text = user?.email ?? '';
      _phoneNumberController.text = user?.phoneNumber ?? '';
      _addressController.text = user?.address ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
  
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              BackIcon(
                onPress: () {
                  Navigator.pop(context);
                },
              ),
              Container(
                height: 98,
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.2),
                alignment: Alignment.center,
                child: const Text(
                  'EDIT VEHICLE',
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
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Vehicle data',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                  24.heightInPixel(),
                  InputField(
                    key: const Key('Vehicle type'),
                    textController: _nameOfVehicleController,
                    node: _nameOfVehicleNode,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: false,
                    text: 'Type of Vehicle',
                    hintText: 'Name of vehicle',
                    textHeight: 10.0,
                    borderColor: appPrimaryColor.withOpacity(0.9),
                    onSaved: (value) {
                      return null;
                    },
                  ),
                  24.heightInPixel(),
                  Text(
                    'Color of vehicle',
                    style: theme.textTheme.bodyText1!.copyWith(
                      fontWeight: kMediumWeight,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                          hint: Text(
                            'Color of vehicle',
                            style: theme.textTheme.bodyText2!
                                .copyWith(color: const Color(0xFFBDBDBD)),
                          ),
                          style: theme.textTheme.bodyText2!.copyWith(
                            color: appPrimaryColor.withOpacity(0.8),
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
                      24.heightInPixel(),
                  InputField(
                    key: const Key('Vehicle number'),
                    textController: _vehicleNumberController,
                    node: _vehicleNumberNode,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: false,
                    text: 'Vehicle number',
                    hintText: 'Vehicle number',
                    textHeight: 10.0,
                    borderColor: appPrimaryColor.withOpacity(0.9),
                    onSaved: (value) {
                      return null;
                    },
                  ),
                  24.heightInPixel(),
                  Opacity(
                    opacity: 0.5,
                    child: InputField(
                      key: const Key('Vehicle Model'),
                      textController: _vhicleModelController,
                      node: _vhicleModelNode,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: false,
                      text: 'Vehicle Model',
                      hintText: 'Vehicle model',
                       enabled: false,
                      textHeight: 10.0,
                      borderColor: appPrimaryColor.withOpacity(0.9),
                      onSaved: (value) {
                        return null;
                      },
                    ),
                  ),
                  60.heightInPixel(),
                  Align(
                      alignment: Alignment.center,
                      child: Button(
                          text: 'Add',
                          //onPress:// _onSubmit,
                          onPress: () => {},
                          color: appPrimaryColor,
                          textColor: whiteColor,
                          isLoading: _loading,
                          width: 350.0)),
                ],
              ),
            ),
          ))
        ],
      )),
    );
  }
}

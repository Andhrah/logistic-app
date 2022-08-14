import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/src/bloc/rider/get_vehicles_for_rider_list_bloc.dart';
import 'package:trakk/src/mixins/connectivity_helper.dart';
import 'package:trakk/src/mixins/merchant_update_rider_and_vehicle_helper.dart';
import 'package:trakk/src/mixins/profile_helper.dart';
import 'package:trakk/src/utils/helper_utils.dart';
import 'package:trakk/src/values/colors.dart';

import '../../../values/font.dart';
import '../../../widgets/back_icon.dart';
import '../../../widgets/button.dart';
import '../../../widgets/input_field.dart';

class EditVehicle extends StatefulWidget {
  const EditVehicle({Key? key}) : super(key: key);
  static const String id = "editVehicle";

  @override
  State<EditVehicle> createState() => _EditVehicleState();
}

class _EditVehicleState extends State<EditVehicle>
    with
        MerchantUpdateRiderAndVehicleHelper,
        ProfileHelper,
        ConnectivityHelper {
  var colors = ["black", "white", "gold", "grey", "ash", "blue", "red"];
  String? _colorsTypes;

  final TextEditingController _nameOfVehicleController =
      TextEditingController();
  final TextEditingController _vehicleNumberController =
      TextEditingController();
  final TextEditingController _vhicleModelController = TextEditingController();

  final FocusNode _nameOfVehicleNode = FocusNode();
  final FocusNode _vehicleNumberNode = FocusNode();
  final FocusNode _vhicleModelNode = FocusNode();

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    // UserType userType = await appSettingsBloc.getUserType;

    var attribute = getVehiclesForRiderListBloc
        .behaviorSubject.value.model?.first.attributes;
    setState(() {
      _nameOfVehicleController.text = attribute?.name ?? '';
      _vehicleNumberController.text = attribute?.number ?? '';
      _colorsTypes = attribute?.color ?? '';
      _vhicleModelController.text = attribute?.model ?? '';
    });
  }

  @override
  void dispose() {
    _nameOfVehicleController.dispose();
    _vehicleNumberController.dispose();
    _vhicleModelController.dispose();
    _nameOfVehicleNode.dispose();
    _vehicleNumberNode.dispose();
    _vhicleModelNode.dispose();
    super.dispose();
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
                //height: 98,
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.2, vertical: 27),
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
                  const Text(
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
                  InputField(
                    key: const Key('Vehicle Model'),
                    textController: _vhicleModelController,
                    node: _vhicleModelNode,
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
                  60.heightInPixel(),
                  Align(
                      alignment: Alignment.center,
                      child: Button(
                          text: 'Add',
                          onPress: () => {},
                          color: appPrimaryColor,
                          textColor: whiteColor,
                          isLoading: _loading,
                          width: MediaQuery.of(context).size.width/1.3)),
                ],
              ),
            ),
          ))
        ],
      )),
    );
  }
}

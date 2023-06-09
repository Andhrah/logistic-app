import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/src/bloc/app_settings_bloc.dart';
import 'package:trakk/src/mixins/connectivity_helper.dart';
import 'package:trakk/src/mixins/merchant_add_rider_and_vehicle_helper.dart';
import 'package:trakk/src/mixins/profile_helper.dart';
import 'package:trakk/src/models/rider/add_rider_to_merchant_model.dart';
import 'package:trakk/src/models/update_profile/update_profile.dart';
import 'package:trakk/src/screens/merchant/add_rider.dart';
import 'package:trakk/src/screens/merchant/list_of_riders.dart';
import 'package:trakk/src/screens/merchant/riders.dart';
import 'package:trakk/src/screens/riders/home/widgets/home_standby/rider_location_card.dart';
import 'package:trakk/src/utils/app_toast.dart';
import 'package:trakk/src/utils/helper_utils.dart';
import 'package:trakk/src/values/enums.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/widgets/back_icon.dart';
import 'package:trakk/src/widgets/button.dart';
import 'package:trakk/src/widgets/input_field.dart';

class AddRider1 extends StatefulWidget {
  static String id = "addRider1";

  const AddRider1({Key? key}) : super(key: key);

  @override
  State<AddRider1> createState() => _AddRider1State();
}

class _AddRider1State extends State<AddRider1>
    with ProfileHelper, MerchantAddRiderAndVehicleHelper, ConnectivityHelper {
  final _formKey = GlobalKey<FormState>();

  String? _stateOfOrigin;
  String? _stateOfResidence;

  final TextEditingController _residentialAddressController =
      TextEditingController();

  final FocusNode _residentialAddressNode = FocusNode();

  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _residentialAddressController.dispose();
    _residentialAddressNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    AddRiderToMerchantModel model =
        AddRiderToMerchantModel.fromJson(arg["rider_bio_data"]);
    bool continueFlow = (arg["previousScreenID"] == AddRider.id);

    print('someonelat: $continueFlow');
    // someonelat
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          20.heightInPixel(),
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
                    (arg["previousScreenID"] == RiderLocationCard.id)
                        ? 'Contact Details'
                        : 'ADD RIDER',
                    style: theme.textTheme.subtitle1!.copyWith(
                        color: appPrimaryColor,
                        //fontWeight: FontWeight.bold,
                        fontWeight: kBoldWeight,
                        fontFamily: kDefaultFontFamilyHeading
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
          if (arg["previousScreenID"] == AddRider.id)
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
          if (arg["previousScreenID"] == AddRider.id) 24.heightInPixel(),

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
                    5.heightInPixel(),
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
                                child: Text(
                                  value,
                                  style: theme.textTheme.bodyText2!.copyWith(),
                                ),
                              );
                            }).toList(),
                          ),
                        )),
                    20.heightInPixel(),
                    Text(
                      'State of residence',
                      style: theme.textTheme.bodyText1!.copyWith(
                        fontWeight: kMediumWeight,
                      ),
                    ),
                    5.heightInPixel(),
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
                                child: Text(
                                  value,
                                  style: theme.textTheme.bodyText2!.copyWith(),
                                ),
                              );
                            }).toList(),
                          ),
                        )),
                    20.heightInPixel(),
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
                          onPress: () async {
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

                              if (continueFlow) {
                                ///This has been changed to when mean the process would stop.
                                ///Comment below and uncomment full flow to use a flow that navigates
                                /// merchant o add rider, add and assign vehicle at the same time
                                if (((await appSettingsBloc.getUserType) ==
                                    UserType.merchant)) {
                                  String merchantId =
                                      await appSettingsBloc.getUserID;

                                  ///This flow is for when the user is from addRider1 (Complete flow)
                                  model = model.copyWith(
                                      data: model.data!.copyWith(
                                    merchantId: merchantId,
                                  ));

                                  doCreateRider(model, onSuccess: () async {
                                    appToast('Rider added successfully',
                                        appToastType: AppToastType.success);
                                    await showSuccessfulDialog(
                                        "${camelCase(model.data?.firstName ?? '')} has been added to rider's list",
                                        'View All Riders', () async {
                                      Navigator.pop(context);

                                      Navigator.popUntil(context,
                                          ModalRoute.withName(Riders.id));

                                      Navigator.pushNamed(
                                          context, ListOfRiders.id);
                                    }, nextAction: () async {
                                      Navigator.pop(context);
                                      Navigator.popUntil(context,
                                          ModalRoute.withName(Riders.id));
                                    });
                                  }, continueStepAfterCompletion: false);
                                }

                                ///full flow
                                // Navigator.of(context).pushNamed(AddRider2.id,
                                //     arguments: {
                                //       'rider_bio_data': model.toJson()
                                //     });
                              } else {
                                doUpdateRiderContactDetailsOperation(
                                    UpdateProfile.riderContact(
                                        residentialAddress:
                                            model.data!.residentialAddress,
                                        stateOfOrigin:
                                            model.data!.stateOfOrigin,
                                        stateOfResidence:
                                            model.data!.stateOfResidence),
                                    () => setState(() => isLoading = true),
                                    () async {
                                  setState(() => isLoading = false);

                                  await appToast('Contact updated successfully',
                                      appToastType: AppToastType.success);

                                  Navigator.pop(context);
                                });
                              }
                            }
                          },
                          color: appPrimaryColor,
                          textColor: whiteColor,
                          isLoading: isLoading,
                          width: double.infinity),
                    ),
                    24.heightInPixel(),
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

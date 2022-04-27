import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/screens/auth/rider/next_of_kin.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/back_icon.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/widgets/input_field.dart';

class VehicleData extends StatefulWidget {
  static const String id = 'vehicledata';

  const VehicleData({Key? key}) : super(key: key);

  @override
  _VehicleDataState createState() => _VehicleDataState();
}

class _VehicleDataState extends State<VehicleData> {
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputField(
                      obscureText: false,
                      text: 'Name of vehicle',
                      hintText: 'Name of vehicle',
                      textHeight: 10.0,
                      borderColor: appPrimaryColor.withOpacity(0.9),
                    ),

                    const SizedBox(height: 30.0),
                    InputField(
                      obscureText: false,
                      text: 'Color of vehicle',
                       hintText: 'blue',
                      textHeight: 10.0,
                      borderColor: appPrimaryColor.withOpacity(0.9),
                    ),

                    const SizedBox(height: 30.0),
                    InputField(
                      obscureText: false,
                      text: 'Vehicle number',
                      hintText: 'Vehicle number',
                      textHeight: 10.0,
                      borderColor: appPrimaryColor.withOpacity(0.9),
                    ),

                    const SizedBox(height: 30.0),
                    InputField(
                      obscureText: false,
                      text: 'Vehicle capacity',
                      hintText: 'Vehicle capacity',
                      textHeight: 10.0,
                      borderColor: appPrimaryColor.withOpacity(0.9),
                    ),

                    const SizedBox(height: 30.0),
                    InkWell(
                      onTap: (){},
                      child: Align(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
                          width: MediaQuery.of(context).size.width / 3,
                          height: MediaQuery.of(context).size.height / 7,
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
                    ),

                    const SizedBox(height: 30.0),
                    InkWell(
                      onTap: (){},
                      child: Align(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
                          width: MediaQuery.of(context).size.width / 3,
                          height: MediaQuery.of(context).size.height / 7,
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
                    ),

                    const SizedBox(height: 40.0),
                    Align(
                      alignment: Alignment.center,
                      child: Button(
                        text: 'Next', 
                        onPress: () {
                          Navigator.of(context).pushNamed(NextOfKin.id);
                        }, 
                        color: appPrimaryColor, 
                        textColor: whiteColor, 
                        isLoading: false,
                        width: 350.0
                      )
                    ),

                    const SizedBox(height: 40.0),
                  ],
                ),
              ),
            ],
          )
        ),
      )
    );
  }
}

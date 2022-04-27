import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/screens/auth/rider/vehicle_data.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/back_icon.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/widgets/input_field.dart';

class PersonalData extends StatefulWidget {
  static const String id = 'personalData';

  const PersonalData({Key? key}) : super(key: key);

  @override
  _PersonalDataState createState() => _PersonalDataState();
}

class _PersonalDataState extends State<PersonalData> {

  final _formKey = GlobalKey<FormState>();

  late TextEditingController _stateOfOriginController;

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
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Country',
                        textScaleFactor: 1.2,
                        style: TextStyle(
                          color: appPrimaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 10.0),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
                        width: MediaQuery.of(context).size.width,
                        child: const Text(
                          'Nigeria',
                          textScaleFactor: 1.4,
                          style: TextStyle(
                            color: appPrimaryColor,
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: appPrimaryColor.withOpacity(0.4),
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 30.0),
                      InputField(
                        obscureText: false,
                        text: 'State of origin',
                        hintText: 'Rivers',
                        textHeight: 10.0,
                        borderColor: appPrimaryColor.withOpacity(0.9),
                      ),

                      const SizedBox(height: 30.0),
                      InputField(
                        obscureText: false,
                        text: 'State of residence',
                        hintText: 'lagos',
                        textHeight: 10.0,
                        borderColor: appPrimaryColor.withOpacity(0.9),
                      ),

                      const SizedBox(height: 30.0),
                      InputField(
                        obscureText: false,
                        text: 'Residential address',
                        hintText: '50b tapa street, yaba',
                        textHeight: 10.0,
                        borderColor: appPrimaryColor.withOpacity(0.9),
                        suffixIcon: const Icon(
                          Remix.home_7_line,
                          size: 18.0,
                          color: Color(0xFF909090),
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
                                  'Upload a clear passport not more than 5kb',
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
                            Navigator.of(context).pushNamed(VehicleData.id);
                          }, 
                          color: appPrimaryColor, 
                          textColor: whiteColor, 
                          isLoading: false,
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

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:open_file/open_file.dart';
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

  var states = [
    "Choose State",
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

  final _formKey = GlobalKey<FormState>();

  late TextEditingController _residentialAddressController;

  FocusNode? _residentialAddressNode;

  String country = "Nigeria";
  String _stateOfOrigin = 'Choose State';   
  String _stateOfResidence = 'Choose State';
  String? _residentialAddress;
  String _userPassport = "";

  bool _isImage = false;
  bool _isButtonPress = false;

  // late List<Object> _;

  @override
  void initState() {
    super.initState();
   
    _residentialAddressController = TextEditingController();
  }


  void openFile(PlatformFile file) {
    OpenFile.open(file.path!);
  }

  /*
   * This method handles the onsubmit event annd validates users input. It triggers validation and sends data to the API
  */
  _onNextPress() async {
    setState(() {
      _isButtonPress = true;
    });
    
    final FormState? form = _formKey.currentState;
    if(form!.validate() && 
      _stateOfResidence != "Choose State" 
      && _stateOfOrigin != "Choose State" &&
      _userPassport.isNotEmpty
      ){
      form.save();
      
      var box = await Hive.openBox('userData');
      box.putAll({
        "stateOfOrigin": _stateOfOrigin,
        "stateOfResidence": _stateOfResidence,
        "residentialAddress": _residentialAddress,
        "userPassport": _userPassport,
      });
      
      Navigator.of(context).pushNamed(VehicleData.id);
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
                        'Address:',
                        textScaleFactor: 1.2,
                        style: TextStyle(
                          color: appPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15.0),

                      const Text(
                        'Country',
                        textScaleFactor: 1.2,
                        style: TextStyle(
                          color: appPrimaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 5.0),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
                        width: MediaQuery.of(context).size.width,
                        child: Row(children: [
                          Image.asset(
                            'assets/images/ng_flag.png',
                            height: 20,
                            width: 20,
                          ),

                          const SizedBox(width: 8.0),

                          Text(
                            country,
                            textScaleFactor: 1.4,
                            style: const TextStyle(
                              color: appPrimaryColor,
                            ),
                          ),
                        ]),
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
                      const Text(
                        'State of origin',
                        textScaleFactor: 1.2,
                        style: TextStyle(
                          color: appPrimaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 5.0),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: appPrimaryColor.withOpacity(0.9),
                            width: 0.3
                          ), //border of dropdown button
                          borderRadius: BorderRadius.circular(5.0), //border raiuds of dropdown button
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                        )
                      ),

                       const SizedBox(height: 5.0),

                      _isButtonPress && _stateOfOrigin == "Choose State" ? const Text(
                        " Choose your state of origin",
                        textScaleFactor: 0.9,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ) : Container(),

                      const SizedBox(height: 30.0),
                      const Text(
                        'State of residence',
                        textScaleFactor: 1.2,
                        style: TextStyle(
                          color: appPrimaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 5.0),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: appPrimaryColor.withOpacity(0.9),
                            width: 0.3
                          ), //border of dropdown button
                          borderRadius: BorderRadius.circular(5.0), //border raiuds of dropdown button
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                            items: states.map((String value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        )
                      ),

                      const SizedBox(height: 5.0),

                      _isButtonPress && _stateOfResidence == "Choose State" ? const Text(
                        " Choose your state of origin",
                        textScaleFactor: 0.9,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ) : Container(),

                      const SizedBox(height: 30.0),
                      InputField(
                        key: const Key('residentialAddress'),
                        node: _residentialAddressNode,
                        textController: _residentialAddressController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: false,
                        text: 'Residential address',
                        hintText: '50b tapa street, yaba',
                        textHeight: 5.0,
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

                      const SizedBox(height: 30.0),

                      _isImage == false ? 
                      InkWell(
                        onTap: () async {
                          final result = await FilePicker.platform.pickFiles();
                          if(result != null) {
                            // Open single file open
                            final file = result.files.first;
                             setState(() {
                              _userPassport = file.name;
                              _isImage = true;
                            });
                            return;
                          }
                        },
                        child: Align(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
                            width: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.height / 7,
                            child: Column(
                              children: const [
                                Icon(
                                  Remix.upload_2_line,
                                  size: 25,
                                ),

                                SizedBox(height: 15.0),
                                Text(
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
                      ) : 
                      Text(
                        _userPassport,
                        textScaleFactor: 1.5,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: secondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5.0),
                      _isButtonPress &&_userPassport.isEmpty ?
                      const Align(
                        child: Text(
                        " Upload your passport",
                          textScaleFactor: 0.9,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.red,
                            // fontWeight: FontWeight.bold,
                          )
                        ),
                      ): Container(),

                      const SizedBox(height: 40.0),
                      Align(
                        alignment: Alignment.center,
                        child: Button(
                          text: 'Next', 
                          onPress: _onNextPress,
                          color: appPrimaryColor, 
                          textColor: whiteColor, 
                          isLoading: false,
                          width: 350.0
                        )
                      ),

                      const SizedBox(height: 30.0),
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

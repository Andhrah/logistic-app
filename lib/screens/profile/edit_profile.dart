import 'package:another_flushbar/flushbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/models/update_profile/update_profile.dart';
import 'package:trakk/provider/auth/auth_provider.dart';
import 'package:trakk/provider/auth/signup_provider.dart';
import 'package:trakk/provider/provider_list.dart';
import 'package:trakk/screens/auth/login.dart';
import 'package:trakk/screens/auth/signup.dart';
import 'package:trakk/services/get_user_service.dart';
import 'package:trakk/services/update_profile_service.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/back_icon.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/widgets/input_field.dart';

class EditProfile extends StatefulWidget {
  static String id = "editprofile";

  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  static String userType = "user";

  final _formKey = GlobalKey<FormState>();

  UpdateProfileService updateProfileService = UpdateProfileService();

  // this controller keeps track of what the user is typing in th textField
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _addressController;

  FocusNode? _firstNameNode;
  FocusNode? _lastNameNode;
  FocusNode? _phoneNumberNode;
  FocusNode? _emailNode;
  FocusNode? _passwordNode;
  FocusNode? _addressNode;

  String? _firstName;
  String? _lastName;
  String? _email;
  String? _phoneNumber;
  String? _password;
  String _address = "";
  String? firstName = "";
  String? _itemImage = "";

  bool _loading = false;
  bool _passwordIsValid = false;
  bool _confirmPasswordIsValid = false;
  bool _emailIsValid = false;
   bool _isItemImage = false;

  var box =  Hive.box('userData');

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: box.get('firstName'));
    _lastNameController = TextEditingController(text: box.get('lastName'));
    _emailController = TextEditingController(text: box.get('email'));
    _phoneNumberController = TextEditingController(text: box.get('phoneNumber'));
    _addressController = TextEditingController(text: box.get('address'));
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


  uploadItemImage() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      // Open single file open
      final file = result.files.first;
      print("Image Name: ${file.name}");
      setState(() {
        _itemImage = file.name;
        _isItemImage = true;
      });
      return;
    }
  }


  /*
   * This method handles the onsubmit event annd validates users input. It triggers validation and sends data to the API
  */
  _onSubmit() async {
    setState(() {
      _loading = true;
    });
    print(" saves called");
    try {
      var response = await updateProfileService.updateProfile(firstName: _firstNameController.text, 
      lastName: _lastNameController.text, phoneNumber: _phoneNumberController.text,
       email: _emailController.text, address: _addressController.text);
       if(response == true) {
        //  var box = await Hive.openBox('userDetails');
        //  box.put('firstname', _firstName);
        //  print(response.toString());
         Navigator.of(context).pop();
       }
    } catch(err) {
      print("error saving details >>>" + err.toString());
    } finally {
      setState(() {
        _loading = false;
      });
    }

    
  }
  @override
  Widget build(BuildContext context) {
    var box = Hive.box('userData');
    return Scaffold(
      
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Column(
          children: [
             Row(
                children: [
                  BackIcon(
                    onPress: () {
                      Navigator.pop(context);
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 60.0),
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {},
                      customBorder: const CircleBorder(),
                      child: const Text(
                        'PROFILE MENU',
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
            Expanded(
              child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                       const Divider( thickness: 1.0,color: Color(0xff909090),),
                       SizedBox(
              child: Padding(
                  padding: const EdgeInsets.only(left:30.0, right: 30, bottom: 17),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                       _isItemImage == false
                      ? InkWell(
                          splashColor: Colors.black12.withAlpha(30),
                          child: Icon(Remix.account_circle_fill, size: 90,),
                            
                          
                          onTap: uploadItemImage,
                        )
                      : Text(
                          _itemImage!,
                          textScaleFactor: 1.5,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: secondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                       Text(
                         box.get('firstName'),
                        style:
                            TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                       Text( box.get('phoneNumber'),),
                      const SizedBox(
                        height: 8,
                      ),
                      Text( box.get('email'),),
                    ],
                  ),
              ),
                      ),
                      const Divider( thickness: 1.0,color: Color(0xff909090),),
                      const SizedBox(height: 20,),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InputField(
                                  key: const Key('First name'),
                                  textController: _firstNameController,
                                  node: _firstNameNode,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  obscureText: false,
                                  text: 'First name',
                                  hintText: 'First name',
                                  textHeight: 10.0,
                                  borderColor: appPrimaryColor.withOpacity(0.9),
                                  // suffixIcon: const Icon(
                                  //   Remix.user_line,
                                  //   size: 18.0,
                                  //   color: Color(0xFF909090),
                                  // ),
                                  validator: (value) {
                                    if (value!.trim().length > 2) {
                                      return null;
                                    }
                                    return "Enter a valid first  name";
                                  },
                                  onSaved: (value) {
                                    _firstName = value!.trim();
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 30.0),
                                InputField(
                                  key: const Key('Last name'),
                                  textController: _lastNameController,
                                  node: _firstNameNode,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  obscureText: false,
                                  text: 'Last name',
                                  hintText: 'Last name',
                                  textHeight: 10.0,
                                  borderColor: appPrimaryColor.withOpacity(0.9),
                                  // suffixIcon: const Icon(
                                  //   Remix.user_line,
                                  //   size: 18.0,
                                  //   color: Color(0xFF909090),
                                  // ),
                                  validator: (value) {
                                    if (value!.trim().length > 2) {
                                      return null;
                                    }
                                    return "Enter a valid last  name";
                                  },
                                  onSaved: (value) {
                                    _firstName = value!.trim();
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 30.0),
                                InputField(
                                  key: const Key('phoneNumber'),
                                  textController: _phoneNumberController,
                                  keyboardType: TextInputType.phone,
                                  node: _phoneNumberNode,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  obscureText: false,
                                  text: 'Phone Number',
                                  hintText: '+234-807-675-8970',
                                  textHeight: 10.0,
                                  borderColor: appPrimaryColor.withOpacity(0.9),
                                  // suffixIcon: const Icon(
                                  //   Remix.phone_line,
                                  //   size: 18.0,
                                  //   color: Color(0xFF909090),
                                  // ),
                                  validator: (value) {
                                    if (value!.trim().length == 11) {
                                      return null;
                                    }
                                    return "Enter a valid phone number";
                                  },
                                  onSaved: (value) {
                                    _phoneNumber = value!.trim();
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 30.0),
                                InputField(
                                  key: const Key('Company\'s email address'),
                                  textController: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  node: _emailNode,
                                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                                  obscureText: false,
                                  text: 'Email Address',
                                  hintText: '@gmail.com',
                                  textHeight: 10.0,
                                  borderColor: appPrimaryColor.withOpacity(0.9),
                                 
                                  validator: (value) {
                                    return _validateEmail();
                                  },
                                  onSaved: (value) {
                                    _email = value!.trim();
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 30.0),
                                
                                InputField(
                                  key: const Key('Home address'),
                                  textController: _addressController,
                                  node: _addressNode,
                                  maxLines: 1,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  obscureText: false,
                                  text: 'Home address',
                                  hintText: 'Address',
                                  textHeight: 10.0,
                                  borderColor: appPrimaryColor.withOpacity(0.9),
                                  onSaved: (value) {
                                    _address = value!.trim();
                                    return null;
                                  },
                                  
                                ),
                                
                                const SizedBox(height: 40.0),
                                Align(
                                    alignment: Alignment.center,
                                    child: Button(
                                        text: 'Save',
                                        //onPress:// _onSubmit,
                                        onPress: _onSubmit,
                                        color: appPrimaryColor,
                                        textColor: whiteColor,
                                        isLoading: _loading,
                                        width: 350.0)),
                                const SizedBox(height: 15.0),
                                
                                const SizedBox(height: 25.0),
                              ],
                            ),
                          ),
                        ),
                      
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class EditProfileContainer extends StatelessWidget {
   String? firstName ;
   EditProfileContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(left:30.0, right: 30, bottom: 17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 8, bottom: 12,),
              height: 80,
              width: 80,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('assets/images/image.png'))),
            ),
             Text(
              firstName?? "",
              style:
                  TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
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
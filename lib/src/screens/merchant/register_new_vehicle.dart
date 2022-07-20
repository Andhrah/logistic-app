// import 'package:another_flushbar/flushbar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:remixicon/remixicon.dart';
//
// import 'package:trakk/src/screens/auth/login.dart';
// import 'package:trakk/src/screens/auth/signup.dart';
// import 'package:trakk/src/screens/dispatch/checkout.dart';
// import 'package:trakk/src/screens/dispatch/pick_ride.dart';
// import 'package:trakk/src/screens/merchant/company_home.dart';
// import 'package:trakk/src/screens/merchant/list_of_vehicles.dart';
// import 'package:trakk/src/screens/merchant/vehicles.dart';
// import 'package:trakk/src/values/values.dart';
// import 'package:trakk/src/widgets/back_icon.dart';
// import 'package:trakk/src/widgets/button.dart';
// import 'package:trakk/src/widgets/cancel_button.dart';
// import 'package:trakk/src/widgets/input_field.dart';
//
// class RegisterNewVehicle extends StatefulWidget {
//   static String id = "registernewvehicle";
//
//   const RegisterNewVehicle({Key? key}) : super(key: key);
//
//   @override
//   State<RegisterNewVehicle> createState() => _RegisterNewVehicleState();
// }
//
// class _RegisterNewVehicleState extends State<RegisterNewVehicle> {
//   static String userType = "user";
//
//   bool _isButtonPress = false;
//
//   var weights = [
//     "Vehicle capacity",
//     "50kg",
//     "100",
//     "150",
//   ];
//   String _listOfWeights = "Vehicle capacity";
//
//   final _formKey = GlobalKey<FormState>();
//
//   late TextEditingController _vehicleNameController;
//   late TextEditingController _vehicleColorController;
//   late TextEditingController _emailController;
//   late TextEditingController _vehicleNumberController;
//   late TextEditingController _vehicleCapacityController;
//   late TextEditingController _passwordController;
//   late TextEditingController _confirmPasswordController;
//
//   FocusNode? _nameNode;
//   FocusNode? _lastNameNode;
//   FocusNode? _vehicleNumberNode;
//   FocusNode? _vehicleCapacityNode;
//   FocusNode? _emailNode;
//   FocusNode? _passwordNode;
//   FocusNode? _confirmPasswordNode;
//   FocusNode? _vehicleColorNode;
//
//   String? _name;
//   String? _lastName;
//   String? _email;
//   String? _vehicleNumber;
//   String? _vehicleCapacity;
//   String? _password;
//   String? _confirmPassword;
//   String? _vehicleColor;
//
//   bool _loading = false;
//   bool _passwordIsValid = false;
//   bool _confirmPasswordIsValid = false;
//   bool _hidePassword = true;
//   bool _autoValidate = false;
//   bool _emailIsValid = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _vehicleNameController = TextEditingController();
//     _vehicleColorController = TextEditingController();
//     _vehicleCapacityController = TextEditingController();
//     _emailController = TextEditingController();
//     _vehicleNumberController = TextEditingController();
//     _passwordController = TextEditingController();
//     _confirmPasswordController = TextEditingController();
//   }
//
//   _validateEmail() {
//     RegExp regex;
//     String pattern =
//         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
//     String email = _emailController.text;
//     if (email.trim().isEmpty) {
//       setState(() {
//         _emailIsValid = false;
//       });
//       return "Email address cannot be empty";
//     } else {
//       regex = RegExp(pattern);
//       setState(() {
//         _emailIsValid = regex.hasMatch(email);
//         print(_emailIsValid);
//       });
//       if (_emailIsValid == false) {
//         return "Enter a valid email address";
//       }
//     }
//   }
//
//   isConfirmPasswordValid() {
//     setState(() {
//       _confirmPasswordIsValid = _confirmPasswordController.text != null &&
//           _confirmPasswordController.text == _passwordController.text;
//       print(_confirmPasswordIsValid);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: whiteColor,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child:
//               Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             const SizedBox(
//               height: 20,
//             ),
//             Row(
//               children: [
//                 BackIcon(
//                   onPress: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//                 Container(
//                   margin: const EdgeInsets.only(left: 40.0),
//                   alignment: Alignment.center,
//                   child: const Text(
//                     'REGISTER NEW VEHICLE',
//                     textScaleFactor: 1.2,
//                     style: TextStyle(
//                       color: appPrimaryColor,
//                       fontWeight: FontWeight.bold,
//                       // decoration: TextDecoration.underline,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             const Padding(
//               padding: EdgeInsets.only(left: 30),
//               child: Text(
//                 'Vehicle data',
//                 textScaleFactor: 1.2,
//                 style: TextStyle(
//                   color: appPrimaryColor,
//                   fontWeight: FontWeight.bold,
//                   // decoration: TextDecoration.underline,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//
//             Container(
//                 height: 450,
//                 width: MediaQuery.of(context).size.width,
//                 margin: const EdgeInsets.symmetric(horizontal: 30.0),
//                 child: Form(
//                   key: _formKey,
//                   child: Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         InputField(
//                           key: const Key('name of vehicle'),
//                           textController: _vehicleNameController,
//                           node: _nameNode,
//                           autovalidateMode: AutovalidateMode.onUserInteraction,
//                           obscureText: false,
//                           text: 'Name of vehicle',
//                           hintText: 'name of vehicle',
//                           textHeight: 10.0,
//                           borderColor: appPrimaryColor.withOpacity(0.9),
//                           // suffixIcon: const Icon(
//                           //   Remix.user_line,
//                           //   size: 18.0,
//                           //   color: Color(0xFF909090),
//                           // ),
//                           // validator: (value) {
//                           //   if (value!.trim().length > 2) {
//                           //     return null;
//                           //   }
//                           //   return "Enter a valid first  name";
//                           // },
//                           onSaved: (value) {
//                             _name = value!.trim();
//                             return null;
//                           },
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         InputField(
//                           key: const Key('color of vehicle'),
//                           textController: _vehicleColorController,
//                           keyboardType: TextInputType.phone,
//                           node: _vehicleColorNode,
//                           autovalidateMode: AutovalidateMode.onUserInteraction,
//                           obscureText: false,
//                           text: 'Color of vehicle',
//                           hintText: 'Color of vehicle',
//                           textHeight: 5.0,
//                           borderColor: appPrimaryColor.withOpacity(0.9),
//                           onSaved: (value) {
//                             _vehicleColor = value!.trim();
//                             return null;
//                           },
//                         ),
//                         const SizedBox(height: 20.0),
//                         InputField(
//                           key: const Key('vehiclenumber'),
//                           textController: _vehicleNumberController,
//                           keyboardType: TextInputType.phone,
//                           node: _vehicleNumberNode,
//                           autovalidateMode: AutovalidateMode.onUserInteraction,
//                           obscureText: false,
//                           text: 'Vehicle number',
//                           hintText: 'Vehicle number',
//                           textHeight: 5.0,
//                           borderColor: appPrimaryColor.withOpacity(0.9),
//                           validator: (value) {
//                             if (value!.trim().length == 11) {
//                               return null;
//                             }
//                             return "Enter a valid phone number";
//                           },
//                           onSaved: (value) {
//                             _vehicleNumber = value!.trim();
//                             return null;
//                           },
//                         ),
//                         const SizedBox(height: 20.0),
//                         const SizedBox(height: 5.0),
//                         DecoratedBox(
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                   color: appPrimaryColor.withOpacity(0.9),
//                                   width: 0.3), //border of dropdown button
//                               borderRadius: BorderRadius.circular(
//                                   5.0), //border raiuds of dropdown button
//                             ),
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 10.0),
//                               child: DropdownButton<String>(
//                                 value: _listOfWeights,
//                                 icon: const Icon(Remix.arrow_down_s_line),
//                                 elevation: 16,
//                                 isExpanded: true,
//                                 style: TextStyle(
//                                   color: appPrimaryColor.withOpacity(0.8),
//                                   fontSize: 18.0,
//                                 ),
//                                 underline: Container(), //empty line
//                                 onChanged: (String? newValue) {
//                                   setState(() {
//                                     _listOfWeights = newValue!;
//                                   });
//                                 },
//                                 items: weights.map((String value) {
//                                   return DropdownMenuItem(
//                                     value: value,
//                                     child: Text(value),
//                                   );
//                                 }).toList(),
//                               ),
//                             )),
//
//                         const SizedBox(height: 20.0),
//
//                         const SizedBox(height: 5.0),
//                         //     _isButtonPress && _listOfWeights == "Vehicle capacity"
//                         //         ? const Text(
//                         //             "Select weight",
//                         //             textScaleFactor: 0.9,
//                         //             textAlign: TextAlign.center,
//                         //             style: TextStyle(
//                         //               color: Colors.red,
//                         //             ),
//                         //           )
//                         //         : Container(),
//                         //     const SizedBox(height: 30.0),
//                         //     const SizedBox(height: 40.0),
//                         Align(
//                           alignment: Alignment.center,
//                           child: Button(
//                               text: 'Register',
//                               //onPress:// _onSubmit,
//                               onPress: () => showDialog<String>(
//                                     // barrierDismissible: true,
//                                     context: context,
//                                     builder: (BuildContext context) =>
//                                         AlertDialog(
//                                       // title: const Text('AlertDialog Title'),
//                                       contentPadding:
//                                           const EdgeInsets.symmetric(
//                                               horizontal: 24.0, vertical: 10.0),
//                                       content: SizedBox(
//                                         height: 250.0,
//                                         child: Column(children: [
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.end,
//                                             children: [
//                                               InkWell(
//                                                   onTap: () {
//                                                     Navigator.of(context)
//                                                         .pushNamed(
//                                                             CompanyHome.id);
//                                                   },
//                                                   child: const CancelButton())
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             height: 20,
//                                           ),
//                                           Align(
//                                             alignment: Alignment.center,
//                                             child: Column(
//                                               children: [
//                                                 const Text(
//                                                   'Suzuki No. 889 has been added to vehicle lists',
//                                                   style: TextStyle(
//                                                       fontSize: 18,
//                                                       fontWeight:
//                                                           FontWeight.w400),
//                                                 ),
//                                                 const SizedBox(height: 30),
//                                                 Button(
//                                                     text: 'View all vehicles',
//                                                     onPress: () {
//                                                       Navigator.of(context)
//                                                           .pushNamed(
//                                                               ListOfVehicles
//                                                                   .id);
//                                                     },
//                                                     color: appPrimaryColor,
//                                                     textColor: whiteColor,
//                                                     isLoading: false,
//                                                     width: 300
//                                                     //MediaQuery.of(context).size.width/1.6,
//                                                     ),
//                                               ],
//                                             ),
//                                           ),
//                                         ]),
//                                       ),
//                                     ),
//                                   ),
//                               color: appPrimaryColor,
//                               textColor: whiteColor,
//                               isLoading: _loading,
//                               width: 300.0),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )),
//
//             const SizedBox(height: 15.0),
//             const SizedBox(height: 25.0),
//             //   ],
//             // ),
//           ]),
//         ),
//       ),
//     );
//   }
// }
//
// class EditProfileContainer extends StatelessWidget {
//   const EditProfileContainer({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       child: Padding(
//         padding: const EdgeInsets.only(left: 30.0, right: 30, bottom: 17),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               margin: EdgeInsets.only(
//                 top: 8,
//                 bottom: 12,
//               ),
//               height: 80,
//               width: 80,
//               decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                   image: DecorationImage(
//                       image: AssetImage('assets/images/image.png'))),
//             ),
//             const Text(
//               'Malik Johnson',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
//             ),
//             const Text('+234816559234'),
//             const SizedBox(
//               height: 8,
//             ),
//             Text('malhohn11@gmail.com'),
//           ],
//         ),
//       ),
//     );
//   }
// }

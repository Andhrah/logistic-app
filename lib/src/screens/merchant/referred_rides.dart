// import 'dart:ui';
//
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:google_place/google_place.dart';
// import 'package:trakk/src/values/values.dart';
//
// import '../../widgets/back_icon.dart';
// import '../profile/dispatch_history_screen/widgets/date_widget.dart';
//
// class ReferredRides extends StatefulWidget {
//   static const String id = 'referredrides';
//
//   const ReferredRides({Key? key}) : super(key: key);
//
//   @override
//   State<ReferredRides> createState() => _ReferredRidesState();
// }
//
// class _ReferredRidesState extends State<ReferredRides> {
//   final _formKey = GlobalKey<FormState>();
//
//   Color color = whiteColor;
//   bool _expanded1 = false;
//
//   late TextEditingController _pickUpController;
//   late TextEditingController _dropOffController;
//   late TextEditingController _itemController;
//   late TextEditingController _itemDescriptionController;
//   TextEditingController? _receiverNameController;
//   late TextEditingController _senderNameController;
//   late TextEditingController _receiverPhoneNumberController;
//   late TextEditingController _senderPhoneNumberController;
//   late TextEditingController _pickUpDateController;
//   late TextEditingController _dropOffDateController;
//
//   FocusNode? _pickUpNode;
//   FocusNode? _dropOffNode;
//   FocusNode? _receiverNameNode;
//   FocusNode? _senderNameNode;
//   FocusNode? _receiverphoneNumberNode;
//   FocusNode? _senderphoneNumberNode;
//   FocusNode? _itemNode;
//   FocusNode? _itemDescriptionNode;
//   FocusNode? _pickUpDateNode;
//   FocusNode? _dropOffDateNode;
//
//   String? _receiverName;
//   String? _receiverPhoneNumber;
//   String? _item;
//   String? _itemDescription;
//   String _itemImage = "";
//   String? _pickUpDate;
//   String? _dropOffDate;
//   dynamic _buttonText = "";
//
//   String startDate =
//       DateTime.now().subtract(const Duration(days: 1)).toIso8601String();
//   String endDate = DateTime.now().toIso8601String();
//   late GooglePlace googlePlace;
//   List<AutocompletePrediction> predictions = [];
//
//   //Timer? _debounce;
//
//   DetailsResult? _pickUp;
//   DetailsResult? _dropOff;
//
//   bool _isItemImage = false;
//
//   void autoCompleteSearch(String value) async {
//     var result = await googlePlace.autocomplete.get(value);
//     if (result != null && result.predictions != null && mounted) {
//       print(result.predictions!.first.description);
//       setState(() {
//         predictions = result.predictions!;
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     String apiKey = "AIzaSyBvxkb0Gv6kwpiplPtmeQZhG4_V-KvLZ1U";
//     googlePlace = GooglePlace(apiKey);
//
//     _pickUpController = TextEditingController();
//     _dropOffController = TextEditingController();
//     _itemController = TextEditingController();
//     _itemDescriptionController = TextEditingController();
//     _receiverNameController = TextEditingController();
//     _senderNameController = TextEditingController();
//     _receiverPhoneNumberController = TextEditingController();
//     _senderPhoneNumberController = TextEditingController();
//     _pickUpDateController = TextEditingController();
//     _dropOffDateController = TextEditingController();
//
//     _pickUpNode = FocusNode();
//     _dropOffNode = FocusNode();
//     _itemNode = FocusNode();
//     _itemDescriptionNode = FocusNode();
//     _pickUpDateNode = FocusNode();
//     _dropOffDateNode = FocusNode();
//     _receiverNameNode = FocusNode();
//     _senderNameNode = FocusNode();
//     _receiverphoneNumberNode = FocusNode();
//     _senderphoneNumberNode = FocusNode();
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     _pickUpNode!.dispose();
//     _dropOffNode!.dispose();
//   }
//
//   uploadItemImage() async {
//     final result = await FilePicker.platform.pickFiles();
//     if (result != null) {
//       // Open single file open
//       final file = result.files.first;
//       print("Image Name: ${file.name}");
//       setState(() {
//         _itemImage = file.name;
//         _isItemImage = true;
//       });
//       return;
//     }
//   }
//
//   _parseDate(value) {
//     var date = DateTime.parse(value);
//     var formattedDate = "${date.day}-${date.month}-${date.year}";
//     return formattedDate;
//
//     // print(formattedDate);
//   }
//
//   /*
//    * This method handles the onsubmit event annd validates users input. It triggers validation and sends data to the API
//   */
//   _onAddItemPress() async {
//     final FormState? form = _formKey.currentState;
//     if (form!.validate()) {
//       form.save();
//
//       // Navigator.of(context).pushNamed( NextOfKin.id,arguments: {
//       //   "pickUp": _pickUp,
//       //   "dropOff": _dropOff,
//       //   "receiverName": _receiverName,
//       //   "receiverPhoneNumber": _receiverPhoneNumber,
//       //   "item": _item,
//       //   "itemDescription": _itemDescription,
//       //   "pickUpDate": _pickUpDate,
//       //   "dropOffDate": _dropOffDate,
//       //   "itemImage": _itemImage,
//       // });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: whiteColor,
//         body: SafeArea(
//             child: Column(
//           children: [
//             Container(
//               height: 98,
//               child: Row(
//                 children: [
//                   BackIcon(
//                     onPress: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                   //SizedBox(width: MediaQuery.of(context).size.width*0.3,),
//                   Container(
//                     //padding: EdgeInsets.symmetric(horizontal: 30 ),
//                     //margin:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.2),
//                     padding: EdgeInsets.symmetric(
//                         horizontal: MediaQuery.of(context).size.width * 0.05),
//                     margin: EdgeInsets.symmetric(
//                         horizontal: MediaQuery.of(context).size.width * 0.06),
//                     alignment: Alignment.center,
//                     child: const Text(
//                       'REFERRED RIDES',
//                       textScaleFactor: 1.1,
//                       style: TextStyle(
//                         color: appPrimaryColor,
//                         fontWeight: FontWeight.bold,
//                         // decoration: TextDecoration.underline,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 30),
//                       child: DateDispatchHistory(
//                         startDate: startDate,
//                         endDate: endDate,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Container(
//                       margin: const EdgeInsets.only(left: 30, right: 30),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'Today\'s referred ride',
//                             textScaleFactor: 1.2,
//                             style: TextStyle(
//                               color: appPrimaryColor,
//                               fontWeight: FontWeight.bold,
//                               // decoration: TextDecoration.underline,
//                             ),
//                           ),
//                           Container(
//                             height: 100,
//                             decoration: const BoxDecoration(
//                                 color: Color(0xffEEEEEE),
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(4))),
//                             child: const Align(
//                               alignment: Alignment.centerLeft,
//                               child: Padding(
//                                 padding: EdgeInsets.all(16.0),
//                                 child: Text("None"),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.only(
//                           top: 10, bottom: 10, right: 30, left: 30),
//                       child: Text(
//                         'Previous referred',
//                         textAlign: TextAlign.start,
//                         style: TextStyle(
//                           fontSize: 18,
//                           color: appPrimaryColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       child: ListView.builder(
//                           physics: const ScrollPhysics(),
//                           shrinkWrap: true,
//                           scrollDirection: Axis.vertical,
//                           itemCount: 1,
//                           itemBuilder: (context, index) {
//                             return Padding(
//                               padding: const EdgeInsets.only(
//                                   top: 10, right: 30, left: 30),
//                               child: Column(
//                                 children: [
//                                   ExpansionPanelList(
//                                     elevation: 1,
//                                     animationDuration:
//                                         Duration(milliseconds: 200),
//                                     children: [
//                                       ExpansionPanel(
//                                         backgroundColor: color,
//                                         headerBuilder: (context, isExpanded) {
//                                           return ListTile(
//                                             title: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Row(
//                                                   // mainAxisAlignment:
//                                                   //     MainAxisAlignment.spaceBetween,
//                                                   children: const [
//                                                     Expanded(
//                                                       child: Text(
//                                                         'Delivery to Ikorodu',
//                                                         textAlign:
//                                                             TextAlign.start,
//                                                         style: TextStyle(
//                                                             color: Colors.black,
//                                                             fontSize: 18,
//
//                                                                     ),
//                                                       ),
//                                                     ),
//                                                     SizedBox(
//                                                       width: 30,
//                                                     ),
//                                                     Expanded(
//                                                       child: Text(
//                                                         '₦4000',
//                                                         style: TextStyle(
//                                                             color: Colors.black,
//                                                             fontSize: 18,
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .w600),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 SizedBox(
//                                                   height: 10,
//                                                 ),
//                                                 Text(
//                                                   '21/2/2022',
//                                                   style: TextStyle(
//                                                       color: grayColor,
//                                                       fontSize: 14,
//                                                       fontWeight:
//                                                           FontWeight.w400),
//                                                 ),
//                                               ],
//                                             ),
//                                           );
//                                         },
//                                         body: Column(
//                                           children: [
//                                             Divider(
//                                               thickness: 2,
//                                               color: appPrimaryColor,
//                                             ),
//                                             Padding(
//                                               padding: EdgeInsets.only(
//                                                   top: 10,
//                                                   left: 0,
//                                                   right: 8,
//                                                   bottom: 20),
//                                               child: Column(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.start,
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   Container(
//                                                       child: Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment.start,
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       Container(
//                                                         width: 50,
//                                                         //height: 100,
//                                                         //color: appPrimaryColor,
//                                                         child: Image.asset(
//                                                           "assets/images/order_highlighter2.png",
//                                                           height: 100.0,
//                                                         ),
//                                                       ),
//                                                       const SizedBox(
//                                                           width: 0.0),
//                                                       Column(
//                                                         children: [
//                                                           Text(
//                                                               'Pickup Location'),
//                                                           const SizedBox(
//                                                               height: 65.0),
//                                                           Text(
//                                                             'Delivery Location',
//                                                             // style: TextStyle(
//                                                             //     fontSize: 16,
//                                                             //     fontWeight:
//                                                             //         FontWeight
//                                                             //             .w500),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       SizedBox(
//                                                         width: 20,
//                                                       ),
//                                                       Column(
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .start,
//                                                         children: [
//                                                           Text(
//                                                               'Pickup Location'),
//                                                           const SizedBox(
//                                                               height: 65.0),
//                                                           Text(
//                                                             'Delivery ',
//                                                             // style: TextStyle(
//                                                             //     fontSize: 16,
//                                                             //     fontWeight:
//                                                             //         FontWeight
//                                                             //             .w500),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ],
//                                                   )),
//                                                   Container(
//                                                     child: Column(
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .start,
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .start,
//                                                       children: [
//                                                         Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .all(4.0),
//                                                           child: Row(
//                                                             mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .start,
//                                                             children: [
//                                                               Radio(
//                                                                 value: null,
//                                                                 groupValue:
//                                                                     null,
//                                                                 fillColor:
//                                                                     MaterialStateProperty
//                                                                         .all(
//                                                                             secondaryColor),
//
//                                                                 onChanged: null,
//
//                                                                 //mouseCursor: MouseCursor.uncontrolled,
//                                                               ),
//                                                               Text("Item"),
//                                                               SizedBox(
//                                                                 width: 95,
//                                                               ),
//                                                               Text(
//                                                                 'Black handbag',
//                                                                 style: TextStyle(
//                                                                     overflow:
//                                                                         TextOverflow
//                                                                             .ellipsis,
//                                                                     fontSize:
//                                                                         16,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .w500),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                         Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                       .only(
//                                                                   left: 4),
//                                                           child: Row(
//                                                             mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .start,
//                                                             //crossAxisAlignment: CrossAxisAlignment.start,
//                                                             children: [
//                                                               Radio(
//                                                                 value: null,
//                                                                 groupValue:
//                                                                     null,
//                                                                 fillColor:
//                                                                     MaterialStateProperty
//                                                                         .all(
//                                                                             secondaryColor),
//
//                                                                 onChanged: null,
//
//                                                                 //mouseCursor: MouseCursor.uncontrolled,
//                                                               ),
//                                                               Text("Rider"),
//                                                               // const SizedBox(
//                                                               //   width: 20,
//                                                               // ),
//                                                               SizedBox(
//                                                                 width: 95,
//                                                               ),
//                                                               Column(
//                                                                 crossAxisAlignment:
//                                                                     CrossAxisAlignment
//                                                                         .start,
//                                                                 children: const [
//                                                                   Text(
//                                                                     'Malik Johnson',
//                                                                     style: TextStyle(
//                                                                         fontSize:
//                                                                             16,
//                                                                         fontWeight:
//                                                                             FontWeight.w500),
//                                                                   ),
//                                                                   SizedBox(
//                                                                     height: 5,
//                                                                   ),
//                                                                   Text(
//                                                                     'Boxer 0098',
//                                                                     style: TextStyle(
//                                                                         fontSize:
//                                                                             16,
//                                                                         fontWeight:
//                                                                             FontWeight.w500),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Container(
//                                                     child: Column(
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .start,
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .start,
//                                                       children: [
//                                                         SizedBox(
//                                                           height: 30,
//                                                         ),
//                                                         Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                       .only(
//                                                                   left: 4),
//                                                           child: Row(
//                                                             mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .start,
//                                                             //crossAxisAlignment: CrossAxisAlignment.start,
//                                                             children: [
//                                                               Radio(
//                                                                 value: null,
//                                                                 groupValue:
//                                                                     null,
//                                                                 fillColor:
//                                                                     MaterialStateProperty
//                                                                         .all(
//                                                                             secondaryColor),
//
//                                                                 onChanged: null,
//
//                                                                 //mouseCursor: MouseCursor.uncontrolled,
//                                                               ),
//                                                               Text(
//                                                                   "Referred to"),
//                                                               // const SizedBox(
//                                                               //   width: 20,
//                                                               // ),
//                                                               SizedBox(
//                                                                 width: 65,
//                                                               ),
//                                                               Column(
//                                                                 crossAxisAlignment:
//                                                                     CrossAxisAlignment
//                                                                         .start,
//                                                                 children: const [
//                                                                   Text(
//                                                                     'Malik Johnson',
//                                                                     style: TextStyle(
//                                                                         fontSize:
//                                                                             16,
//                                                                         fontWeight:
//                                                                             FontWeight.w500),
//                                                                   ),
//                                                                   SizedBox(
//                                                                     height: 5,
//                                                                   ),
//                                                                   Text(
//                                                                     'Boxer 0098',
//                                                                     style: TextStyle(
//                                                                         fontSize:
//                                                                             16,
//                                                                         fontWeight:
//                                                                             FontWeight.w500),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         isExpanded: _expanded1,
//                                         canTapOnHeader: true,
//                                       ),
//                                     ],
//                                     dividerColor:
//                                         Color.fromARGB(255, 143, 141, 141),
//                                     expansionCallback:
//                                         (int panelIndex, bool isExpanded) {
//                                       setState(() {
//                                         isExpanded = !_expanded1;
//                                         !isExpanded ? color : grayColor;
//                                       });
//                                       _expanded1 = !_expanded1;
//                                       if (_expanded1 == true) {
//                                         setState(() {
//                                           color = whiteColor;
//                                         });
//                                       } else if (_expanded1 == false) {
//                                         setState(() {
//                                           color = Color.fromARGB(
//                                               255, 235, 235, 235);
//                                         });
//                                       }
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             );
//                           }),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         )));
//   }
// }

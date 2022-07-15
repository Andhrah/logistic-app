// import 'package:flutter/material.dart';
// import 'package:trakk/models/order/order.dart';
// import 'package:trakk/screens/dispatch/item_detail/item_details.dart';
// import 'package:trakk/utils/colors.dart';
// import 'package:trakk/widgets/button.dart';
// import 'package:trakk/widgets/header.dart';
//
// class DispatchSummary extends StatefulWidget {
//   static const String id = 'dispatchSummary';
//
//   const DispatchSummary({Key? key}) : super(key: key);
//
//   @override
//   _DispatchSummaryState createState() => _DispatchSummaryState();
// }
//
// class _DispatchSummaryState extends State<DispatchSummary> {
//   _onPressEdit() async {
//     Navigator.of(context).pushNamed(ItemDetails.id, arguments: {
//       "buttonText": "Save Changes",
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final arg = ModalRoute.of(context)!.settings.arguments as Map;
//     OrderModel orderModel = OrderModel.fromJson(arg["orderModel"]);
//     int riderId = arg["riderId"];
//
//     return Scaffold(
//         body: SingleChildScrollView(
//           child: SafeArea(
//               child: Column(
//                 children: [
//                   const SizedBox(height: 30.0),
//                   const Header(
//                     text: 'ITEM SUMMARY',
//                   ),
//
//                   Container(
//                     padding:
//                     const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
//                     child: Column(
//                       children: [
//                         SingleChildScrollView(
//                             scrollDirection: Axis.horizontal,
//                             child: Row(
//                               children: [
//                                 Card(
//                                   elevation: 0.0,
//                                   shape: RoundedRectangleBorder(
//                                     side: BorderSide(
//                                         color: appPrimaryColor.withOpacity(0.1),
//                                         width: 1),
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   child: Container(
//                                     margin: const EdgeInsets.symmetric(
//                                         horizontal: 10.0, vertical: 10.0),
//                                     width: MediaQuery.of(context).size.width / 1.5,
//                                     height: 120,
//                                     child: Row(children: [
//                                       Expanded(
//                                         child: Container(
//                                           margin: const EdgeInsets.only(right: 30.0),
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 10.0, vertical: 10.0),
//                                           child: Image.asset(
//                                             "assets/images/item_img.png",
//                                             height: 90.0,
//                                           ),
//                                           decoration: BoxDecoration(
//                                             color: Colors.grey.withOpacity(0.1),
//                                             borderRadius: const BorderRadius.all(
//                                                 Radius.circular(10)),
//                                           ),
//                                         ),
//                                       ),
//                                       Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           const SizedBox(height: 12.0),
//                                           const Text('Black handbag',
//                                               style: TextStyle(
//                                                   fontSize: 16.0,
//                                                   color: appPrimaryColor,
//                                                   fontWeight: FontWeight.w400)),
//                                           const SizedBox(height: 30.0),
//                                           const Text('40Kg',
//                                               style: TextStyle(
//                                                   fontSize: 16.0,
//                                                   color: appPrimaryColor,
//                                                   fontWeight: FontWeight.w400))
//                                         ],
//                                       )
//                                     ]),
//                                   ),
//                                 ),
//                                 Card(
//                                   elevation: 0.0,
//                                   shape: RoundedRectangleBorder(
//                                     side: BorderSide(
//                                         color: appPrimaryColor.withOpacity(0.1),
//                                         width: 1),
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   child: Container(
//                                     margin: const EdgeInsets.symmetric(
//                                         horizontal: 10.0, vertical: 10.0),
//                                     width: MediaQuery.of(context).size.width / 1.5,
//                                     height: 120,
//                                     child: Row(children: [
//                                       Expanded(
//                                         child: Container(
//                                           margin: const EdgeInsets.only(right: 30.0),
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 10.0, vertical: 10.0),
//                                           child: Image.asset(
//                                             "assets/images/item_img.png",
//                                             height: 90.0,
//                                           ),
//                                           decoration: BoxDecoration(
//                                             color: Colors.grey.withOpacity(0.1),
//                                             borderRadius: const BorderRadius.all(
//                                                 Radius.circular(10)),
//                                           ),
//                                         ),
//                                       ),
//                                       Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           const SizedBox(height: 12.0),
//                                           const Text('Black handbag',
//                                               style: TextStyle(
//                                                   fontSize: 16.0,
//                                                   color: appPrimaryColor,
//                                                   fontWeight: FontWeight.w400)),
//                                           const SizedBox(height: 30.0),
//                                           const Text('40Kg',
//                                               style: TextStyle(
//                                                   fontSize: 16.0,
//                                                   color: appPrimaryColor,
//                                                   fontWeight: FontWeight.w400))
//                                         ],
//                                       )
//                                     ]),
//                                   ),
//                                 ),
//                               ],
//                             )),
//
//                         // const SizedBox(height: 30.0),
//
//                         // const Align(
//                         //   alignment: Alignment.centerLeft,
//                         //   child: Text(
//                         //     '  Sender’s Info',
//                         //     style: TextStyle(
//                         //       fontSize: 15.0,
//                         //       color: appPrimaryColor,
//                         //       fontWeight: FontWeight.w700
//                         //     ),
//                         //   ),
//                         // ),
//
//                         // const SizedBox(height: 5.0),
//
//                         // Card(
//                         //   elevation: 0.0,
//                         //   shape: RoundedRectangleBorder(
//                         //     side: BorderSide(color: appPrimaryColor.withOpacity(0.1), width: 1),
//                         //     borderRadius: BorderRadius.circular(10),
//                         //   ),
//                         //   child: Container(
//                         //     padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
//                         //     // height: 110,
//                         //     child: Column(
//                         //       children: [
//                         //         Row(
//                         //           children: [
//                         //             Container(
//                         //               alignment: Alignment.centerLeft,
//                         //               width: MediaQuery.of(context).size.width/3,
//                         //               child:const Text(
//                         //                 'Name:',
//                         //                 style: TextStyle(
//                         //                   fontSize: 15.0,
//                         //                   color: appPrimaryColor,
//                         //                   fontWeight: FontWeight.w700
//                         //                 ),
//                         //               ),
//                         //             ),
//
//                         //             const Text(
//                         //               'Alexandra Collins',
//                         //               style: TextStyle(
//                         //                 fontSize: 15.0,
//                         //                 color: appPrimaryColor,
//                         //                 fontWeight: FontWeight.w400
//                         //               )
//                         //             )
//                         //           ],
//                         //         ),
//
//                         //         const SizedBox(height: 10.0),
//
//                         //         Row(
//                         //           children: [
//                         //             Container(
//                         //               alignment: Alignment.centerLeft,
//                         //               width: MediaQuery.of(context).size.width/3,
//                         //               child:const Text(
//                         //                 'Email Address:',
//                         //                 style: TextStyle(
//                         //                   fontSize: 14.0,
//                         //                   color: appPrimaryColor,
//                         //                   fontWeight: FontWeight.w700
//                         //                 ),
//                         //               ),
//                         //             ),
//
//                         //             const Text(
//                         //               'alexandra@zebrra.com',
//                         //               style: TextStyle(
//                         //                 fontSize: 14.0,
//                         //                 color: appPrimaryColor,
//                         //                 fontWeight: FontWeight.w400
//                         //               )
//                         //             )
//                         //           ],
//                         //         ),
//
//                         //         const SizedBox(height: 10.0),
//
//                         //         Row(
//                         //           children: [
//                         //             Container(
//                         //               alignment: Alignment.centerLeft,
//                         //               width: MediaQuery.of(context).size.width/3,
//                         //               child:const Text(
//                         //                 'Phone Number:',
//                         //                 style: TextStyle(
//                         //                   fontSize: 14.0,
//                         //                   color: appPrimaryColor,
//                         //                   fontWeight: FontWeight.w700
//                         //                 ),
//                         //               ),
//                         //             ),
//
//                         //             const Text(
//                         //               '+234-698-942-96',
//                         //               style: TextStyle(
//                         //                 fontSize: 14.0,
//                         //                 color: appPrimaryColor,
//                         //                 fontWeight: FontWeight.w400
//                         //               )
//                         //             )
//                         //           ],
//                         //         ),
//                         //       ],
//                         //     )
//                         //   ),
//                         // ),
//
//                         const SizedBox(height: 30.0),
//
//                         const Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             '  Receiver’s Info',
//                             style: TextStyle(
//                                 fontSize: 15.0,
//                                 color: appPrimaryColor,
//                                 fontWeight: FontWeight.w700),
//                           ),
//                         ),
//
//                         const SizedBox(height: 5.0),
//
//                         Card(
//                           elevation: 0.0,
//                           shape: RoundedRectangleBorder(
//                             side: BorderSide(
//                                 color: appPrimaryColor.withOpacity(0.1), width: 1),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 15.0, vertical: 15.0),
//                               // height: 110,
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Container(
//                                         alignment: Alignment.centerLeft,
//                                         width: MediaQuery.of(context).size.width / 3,
//                                         child: const Text(
//                                           'Name:',
//                                           style: TextStyle(
//                                               fontSize: 15.0,
//                                               color: appPrimaryColor,
//                                               fontWeight: FontWeight.w700),
//                                         ),
//                                       ),
//                                       const Text('Alexandra Collins',
//                                           style: TextStyle(
//                                               fontSize: 15.0,
//                                               color: appPrimaryColor,
//                                               fontWeight: FontWeight.w400))
//                                     ],
//                                   ),
//                                   const SizedBox(height: 10.0),
//                                   Row(
//                                     children: [
//                                       Container(
//                                         alignment: Alignment.centerLeft,
//                                         width: MediaQuery.of(context).size.width / 3,
//                                         child: const Text(
//                                           'Email Address:',
//                                           style: TextStyle(
//                                               fontSize: 14.0,
//                                               color: appPrimaryColor,
//                                               fontWeight: FontWeight.w700),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         child: const Text('alexandra@zebrra.com',
//                                             style: TextStyle(
//                                                 fontSize: 14.0,
//                                                 color: appPrimaryColor,
//                                                 fontWeight: FontWeight.w400)),
//                                       )
//                                     ],
//                                   ),
//                                   const SizedBox(height: 10.0),
//                                   Row(
//                                     children: [
//                                       Container(
//                                         alignment: Alignment.centerLeft,
//                                         width: MediaQuery.of(context).size.width / 3,
//                                         child: const Text(
//                                           'Phone Number:',
//                                           style: TextStyle(
//                                               fontSize: 14.0,
//                                               color: appPrimaryColor,
//                                               fontWeight: FontWeight.w700),
//                                         ),
//                                       ),
//                                       const Text('+234-698-942-96',
//                                           style: TextStyle(
//                                               fontSize: 14.0,
//                                               color: appPrimaryColor,
//                                               fontWeight: FontWeight.w400))
//                                     ],
//                                   ),
//                                 ],
//                               )),
//                         ),
//
//                         const SizedBox(height: 5.0),
//
//                         Card(
//                           elevation: 0.0,
//                           shape: RoundedRectangleBorder(
//                             side: BorderSide(
//                                 color: appPrimaryColor.withOpacity(0.1), width: 1),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 15.0, vertical: 15.0),
//                               // height: 110,
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Container(
//                                         alignment: Alignment.centerLeft,
//                                         width: MediaQuery.of(context).size.width / 3,
//                                         child: const Text(
//                                           'Pickup Date:',
//                                           style: TextStyle(
//                                               fontSize: 15.0,
//                                               color: appPrimaryColor,
//                                               fontWeight: FontWeight.w700),
//                                         ),
//                                       ),
//                                       const Text('24/3/2022',
//                                           style: TextStyle(
//                                               fontSize: 15.0,
//                                               color: appPrimaryColor,
//                                               fontWeight: FontWeight.w400))
//                                     ],
//                                   ),
//                                   const SizedBox(height: 10.0),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Container(
//                                         alignment: Alignment.centerLeft,
//                                         width: MediaQuery.of(context).size.width / 3,
//                                         child: const Text(
//                                           'Delivery Date:',
//                                           style: TextStyle(
//                                               fontSize: 14.0,
//                                               color: appPrimaryColor,
//                                               fontWeight: FontWeight.w700),
//                                         ),
//                                       ),
//                                       const Text('26/3/2022',
//                                           style: TextStyle(
//                                               fontSize: 14.0,
//                                               color: appPrimaryColor,
//                                               fontWeight: FontWeight.w400))
//                                     ],
//                                   ),
//                                 ],
//                               )),
//                         ),
//
//                         const SizedBox(height: 35.0),
//
//                         const Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             '  Rider’s Info',
//                             style: TextStyle(
//                                 fontSize: 15.0,
//                                 color: appPrimaryColor,
//                                 fontWeight: FontWeight.w700),
//                           ),
//                         ),
//
//                         const SizedBox(height: 5.0),
//
//                         Card(
//                           elevation: 0.0,
//                           shape: RoundedRectangleBorder(
//                             side: BorderSide(
//                                 color: appPrimaryColor.withOpacity(0.1), width: 1),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 15.0, vertical: 15.0),
//                               // height: 110,
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Container(
//                                         alignment: Alignment.centerLeft,
//                                         width: MediaQuery.of(context).size.width / 3,
//                                         child: const Text(
//                                           'Name:',
//                                           style: TextStyle(
//                                               fontSize: 15.0,
//                                               color: appPrimaryColor,
//                                               fontWeight: FontWeight.w700),
//                                         ),
//                                       ),
//                                       const Text('Alexandra Collins',
//                                           style: TextStyle(
//                                               fontSize: 15.0,
//                                               color: appPrimaryColor,
//                                               fontWeight: FontWeight.w400))
//                                     ],
//                                   ),
//                                   const SizedBox(height: 10.0),
//                                   Row(
//                                     children: [
//                                       Container(
//                                         alignment: Alignment.centerLeft,
//                                         width: MediaQuery.of(context).size.width / 3,
//                                         child: const Text(
//                                           'Email Address:',
//                                           style: TextStyle(
//                                               fontSize: 14.0,
//                                               color: appPrimaryColor,
//                                               fontWeight: FontWeight.w700),
//                                         ),
//                                       ),
//                                       const Expanded(
//                                         child: Text('alexandra@zebrra.com',
//                                             style: TextStyle(
//                                                 fontSize: 14.0,
//                                                 color: appPrimaryColor,
//                                                 fontWeight: FontWeight.w400)),
//                                       )
//                                     ],
//                                   ),
//                                   const SizedBox(height: 10.0),
//                                   Row(
//                                     children: [
//                                       Container(
//                                         alignment: Alignment.centerLeft,
//                                         width: MediaQuery.of(context).size.width / 3,
//                                         child: const Text(
//                                           'Phone Number:',
//                                           style: TextStyle(
//                                               fontSize: 14.0,
//                                               color: appPrimaryColor,
//                                               fontWeight: FontWeight.w700),
//                                         ),
//                                       ),
//                                       const Text('+234-698-942-96',
//                                           style: TextStyle(
//                                               fontSize: 14.0,
//                                               color: appPrimaryColor,
//                                               fontWeight: FontWeight.w400))
//                                     ],
//                                   ),
//                                 ],
//                               )),
//                         ),
//
//                         const SizedBox(height: 50.0),
//                         const Text(
//                           'Total Cost: ₦2000',
//                           style: TextStyle(
//                               fontSize: 20.0,
//                               color: appPrimaryColor,
//                               fontWeight: FontWeight.w700),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   const SizedBox(height: 10.0),
//                   Button(
//                     text: 'Edit Order',
//                     // onPress: () {
//                     //   Navigator.of(context).pushNamed(ItemDetails.id, arguments: {
//                     //     "buttonText": "Save Changes",
//                     //   });
//                     // },
//                     onPress: _onPressEdit,
//                     color: appPrimaryColor,
//                     textColor: whiteColor,
//                     isLoading: false,
//                     width: MediaQuery.of(context).size.width / 1.2,
//                   ),
//
//                   // const SizedBox(height: 10.0),
//                   // Button(
//                   //   text: 'Edit',
//                   //   onPress: () {
//                   //     Navigator.of(context).pushNamed(Checkout.id);
//                   //   },
//                   //   color: whiteColor,
//                   //   textColor: appPrimaryColor,
//                   //   isLoading: false,
//                   //   width: MediaQuery.of(context).size.width/1.2,
//                   // )
//                 ],
//               )),
//         ));
//   }
// }

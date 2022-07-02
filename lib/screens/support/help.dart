// import 'package:flutter/material.dart';
// import 'package:trakk/screens/auth/login.dart';
// import 'package:trakk/screens/dispatch/payment.dart';
// import 'package:trakk/screens/support/about_trakk.dart';
// import 'package:trakk/screens/support/account_data.dart';
// import 'package:trakk/screens/support/app_features.dart';
// import 'package:trakk/screens/support/payment_issues.dart';
// import 'package:trakk/screens/support/help_and_support.dart';
// import 'package:trakk/utils/colors.dart';
// import 'package:trakk/widgets/back_icon.dart';

// class HelpAndSupport extends StatelessWidget {
//   static const String id = 'help';

//   const HelpAndSupport({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: SafeArea(
//             child: Padding(
//           padding: const EdgeInsets.only(left: 0.0, right: 0.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 10.0),
//               Row(
//                 children: [
//                   BackIcon(
//                     onPress: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                   Container(
//                     margin: const EdgeInsets.only(left: 40.0),
//                     alignment: Alignment.center,
//                     child: const Text(
//                       'HELP & SUPPORT',
//                       textScaleFactor: 1.2,
//                       style: TextStyle(
//                         color: appPrimaryColor,
//                         fontWeight: FontWeight.bold,
//                         // decoration: TextDecoration.underline,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 0.0),
//               const Divider(thickness: 1.0, color: dividerColor,),
//               Padding(
//                 padding: const EdgeInsets.only(left: 35.0, right: 35.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Get support with',
//                       textScaleFactor: 1.2,
//                       style: TextStyle(
//                         color: appPrimaryColor,
//                         fontWeight: FontWeight.bold,
//                         // decoration: TextDecoration.underline,
//                       ),
//                     ),
//                     const SizedBox(height: 30.0),
//                     InkWell(
//                         onTap: () {
//                           Navigator.of(context).pushNamed(RideIssues.id);
//                         },
//                         child: const SupportContainer(
//                           title: 'Delivery',
//                         )),
//                     const SizedBox(
//                       height: 34,
//                     ),
//                     // InkWell(
//                     //     onTap: () {
//                     //       Navigator.of(context).pushNamed(PaymentIssues.id);
//                     //     },
//                     //     child: const SupportContainer(
//                     //       title: 'Payment',
//                     //     )),
//                     // const SizedBox(
//                     //   height: 34,
//                     // ),
//                     // InkWell(
//                     //   onTap: () {
//                     //     Navigator.of(context).pushNamed(AccountDataIssues.id);
//                     //   },
//                     //   child: const SupportContainer(
//                     //     title: 'Account and Data',
//                     //   ),
//                     // ),
//                     // const SizedBox(
//                     //   height: 34,
//                     // ),
//                     // InkWell(
//                     //   onTap:  () {
//                     //     Navigator.of(context).pushNamed(AppFeatures.id);
//                     //   },
//                     //   child: const SupportContainer(
//                     //     title: 'APP Features',
//                     //   ),
//                     // ),
//                     // const SizedBox(
//                     //   height: 34,
//                     // ),
//                     // InkWell(
//                     //   onTap: () {
//                     //     Navigator.of(context).pushNamed(AboutTrakk.id);
//                     //   },
//                     //   child: const SupportContainer(
//                     //     title: 'About Trakk',
//                     //   ),
//                     // ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         )),
//       ),
//     );
//   }
// }

// class SupportContainer extends StatelessWidget {
//   final String title;
//   const SupportContainer({
//     Key? key,
//     required this.title,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 43,
//       width: 344,
//       decoration: BoxDecoration(
//           color: const Color(0xffEEEEEE),
//           borderRadius: BorderRadius.circular(5.0)),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Center(
//             child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               title,
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
//             ),
//             const Icon(
//               Icons.arrow_forward_ios,
//               size: 17,
//             ),
//           ],
//         )),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:trakk/src/screens/merchant/merchant_rider_profile.dart';
// import 'package:trakk/src/values/values.dart';
// import 'package:trakk/src/widgets/button.dart';
//
// Widget build(BuildContext context) {
//   return ActiveContainer();
// }
//
// class ActiveContainer extends StatelessWidget {
//   const ActiveContainer({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 200,
//       decoration: const BoxDecoration(color: whiteColor, boxShadow: [
//         BoxShadow(
//           color: Color.fromARGB(255, 230, 230, 230),
//           spreadRadius: 1,
//           offset: Offset(2.0, 2.0), //(x,y)
//           blurRadius: 8.0,
//         ),
//       ]),
//       margin: EdgeInsets.only(left: 22, right: 22),
//       child: Padding(
//         padding: const EdgeInsets.all(22.0),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 SvgPicture.asset(
//                   'assets/images/cancel.svg',
//                   color: Colors.black,
//                 )
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Image.asset('assets/images/bike.png'),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: const [
//                     Text(
//                       'Suzuki',
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//                     ),
//                     Text(
//                       'Vehicle no. 887',
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//             Button(
//                 text: 'Assigned to Malik Johnson',
//                 onPress: () {
//                   Navigator.of(context).pushNamed(MerchantRiderProfile.id);
//                 },
//                 color: appPrimaryColor,
//                 width: 290,
//                 textColor: whiteColor,
//                 isLoading: false)
//           ],
//         ),
//       ),
//     );
//   }
// }

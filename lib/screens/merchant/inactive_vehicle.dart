import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/button.dart';

Widget build(BuildContext context) {
  return InactiveContainer();
}

class InactiveContainer extends StatelessWidget {
  const InactiveContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: const BoxDecoration(color: whiteColor, boxShadow: [
        BoxShadow(
          color: Color.fromARGB(255, 230, 230, 230),
          spreadRadius: 1,
          offset: Offset(2.0, 2.0), //(x,y)
          blurRadius: 8.0,
        ),
      ]),
      margin: EdgeInsets.only(left: 22, right: 22),
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(
                  'assets/images/cancel.svg',
                  color: Colors.black,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/bike.png', height: 100,width: 100,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    const Text(
                      'Suzuki',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const Text(
                      'Vehicle no. 887',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10,),
                    Button(
                text: 'Inactive ',
                onPress: () {},
                color: appPrimaryColor,
                width: 138,
                textColor: whiteColor,
                isLoading: false),
                  ],
                )
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}

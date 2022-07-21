import 'package:flutter/material.dart';
import 'package:trakk/src/values/values.dart';

class DefaultContainer extends StatelessWidget {
  final String? num;
  final String title;
  const DefaultContainer({
    Key? key, required this.title, this.num,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: const BoxDecoration(
        color: whiteColor,
        boxShadow: [
          BoxShadow(
    color: Color.fromARGB(255, 230, 230, 230),
    spreadRadius: 1,
    offset: Offset(1.8, 2.0), //(x,y)
    blurRadius: 5.0,
          ),
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:  [
            Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),

              
                Text(
                  
                  num?? "" ,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: secondaryColor),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
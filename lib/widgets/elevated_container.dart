import 'package:flutter/material.dart';

class ElevatedContainer extends StatelessWidget {
  const ElevatedContainer({Key? key, 
  this.onPress, 
  required this.radius, 
  required this.color,
  this.child,
  required this.height,
  required this.width}) : super(key: key);

  final VoidCallback? onPress;
  final Color color;
  final double radius;
  final Widget? child;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
       onTap: onPress,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(7.0),
        height: height,
        width: width,
        margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
        child: child,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
          boxShadow: const[
            BoxShadow(
              color: Color(0XFFBDBDBD),
              offset: Offset(0.0, 0.5), //(x,y)
              blurRadius: 1.8,
            ),
          ],
        ),
      )
    );
    
  }
}

import 'package:flutter/material.dart';

class ElispeImg extends StatelessWidget {
  const ElispeImg({Key? key, this.child,}) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        padding: const EdgeInsets.only(right: 30.0),
        width:  MediaQuery.of(context).size.width / 2,
        height: 150.0,
        decoration: const BoxDecoration(
          // color: Colors.purple,
          image: DecorationImage(
            image: AssetImage('assets/images/ellipse.png'),
            fit: BoxFit.fill,
            scale: 3.0,
          ),
        ),
        child: child,
      ),
    );
  }
}
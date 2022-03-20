import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  static const String id = 'home';

  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // throw UnimplementedError();
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 0.0, bottom: 50.0),
        decoration: BoxDecoration(
          
          //   AssetImage('assets/images/home.png'),
          //   fit: BoxFit.cover,
          // )
        ),
        child: const Text('HOME'),
      ),
    );
  }
}
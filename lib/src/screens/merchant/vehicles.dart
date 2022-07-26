import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:trakk/src/screens/merchant/add_rider_2/add_rider2.dart';
import 'package:trakk/src/screens/merchant/list_of_vehicles.dart';
import 'package:trakk/src/values/values.dart';

import '../../widgets/back_icon.dart';

class Vehicles extends StatefulWidget {
  static const String id = 'vehicles';

  const Vehicles({Key? key}) : super(key: key);

  @override
  State<Vehicles> createState() => _VehiclesState();
}

class _VehiclesState extends State<Vehicles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        body: SafeArea(
            child: Column(
          children: [
            const SizedBox(height: 10.0),
            Row(
              children: [
                BackIcon(
                  onPress: () {
                    Navigator.pop(context);
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(left: 40.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'VEHICLES',
                    textScaleFactor: 1.2,
                    style: TextStyle( fontFamily: 'HelveticaRoundedLTStd',
                      color: appPrimaryColor,
                      fontWeight: FontWeight.bold,
                      // decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(ListOfVehicles.id);
              },
              child: const DefaultContainer(
                title: 'View all vehicles',
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(AddRider2.id);
              },
              child: const DefaultContainer(
                title: 'Register new vehicle',
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(ListOfVehicles.id);
              },
              child: const DefaultContainer(
                title: 'Remove vehicle from list',
              ),
            ),
          ],
        )));
  }
}

class DefaultContainer extends StatelessWidget {
  final String title;
  const DefaultContainer({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: const BoxDecoration(color: whiteColor, boxShadow: [
        BoxShadow(
          color: Color.fromARGB(255, 230, 230, 230),
          spreadRadius: 1,
          offset: Offset(1.8, 2.0), //(x,y)
          blurRadius: 5.0,
        ),
      ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            const Icon(Icons.arrow_forward_ios, color: appPrimaryColor,),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:trakk/screens/wallet/fund_wallet.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/back_icon.dart';
import 'package:trakk/widgets/icon_container.dart';

class AllCards extends StatefulWidget {
  static const String  id = "allCards";

  const AllCards({Key? key}) : super(key: key);

  @override
  _AllCardsState createState() => _AllCardsState();
}

class _AllCardsState extends State<AllCards> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                      'PAYMENTS',
                      style: TextStyle(
                        color: appPrimaryColor,
                        fontSize: 20.0, 
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
      
              const Padding(padding: EdgeInsets.only(left: 40.0, right: 40),
              child: Text("Secure and manage all your cards connected to Trakk"),),

             //r Expanded(child: Divider(),),
              Container(height: 200,
                child: Column(children: [
                Text("Hello")
              ],))
      
              
              
            ]
          ),
        ),
      )
    );
  }
}

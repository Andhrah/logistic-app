import 'package:flutter/material.dart';
import 'package:trakk/src/screens/wallet/fund_wallet.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/widgets/back_icon.dart';
import 'package:trakk/src/widgets/icon_container.dart';

class Payments extends StatefulWidget {
  static const String  id = "payments";

  const Payments({Key? key}) : super(key: key);

  @override
  _PaymentsState createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
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
      
              
      
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 30.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Search',
                    labelStyle: const TextStyle(fontSize: 18.0, color: Color(0xFFCDCDCD)),
                    enabledBorder:  OutlineInputBorder(
                      borderSide: BorderSide(color: darkerPurple.withOpacity(0.3), width: 0.0),
                    ),
                    suffixIcon: const Icon(
                      Icons.search_rounded,
                      color: Color(0xFFCDCDCD),
                    ),
                  ),
                )
              ),
      
              Container(
                margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconContainer(
                          text: 'Electricity', 
                          imgUrl: 'assets/images/electricity.svg',
                          isText: false,
                          onPress: (){
                            Navigator.of(context).pushNamed(FundWalletScreen.id);
                          },
                        ),
      
                        IconContainer(
                          text: 'Television cable', 
                          imgUrl: 'assets/images/cable.svg',
                          isText: false,
                          onPress: (){},
                        ),
      
                        IconContainer(
                          text: 'Internet', 
                          imgUrl: 'assets/images/internet.svg',
                          isText: false,
                          onPress: (){},
                        ),
                      ],
                    ),
      
                    const SizedBox(height: 40.0),
      
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconContainer(
                          text: 'School Fees', 
                          imgUrl: 'assets/images/school.svg',
                          isText: false,
                          onPress: (){},
                        ),
      
                        IconContainer(
                          text: 'Sports & Game',
                          imgUrl: 'assets/images/game.svg',
                          isText: false,
                          onPress: (){},
                        ),
      
                        IconContainer(
                          text: 'Taxs & Levies',
                          imgUrl: 'assets/images/tax.svg',
                          isText: false,
                          onPress: (){},
                        ),
                      ],
                    ),
      
                    const SizedBox(height: 40.0),
      
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconContainer(
                          text: 'Airline Ticket', 
                          imgUrl:  'assets/images/airline.svg',
                          isText: false,
                          onPress: (){},
                        ),
      
                        IconContainer(
                          text: 'Tithes & Offering',
                          imgUrl: 'assets/images/tithes.svg',
                          isText: false,
                          onPress: (){},
                        ),
      
                        IconContainer(
                          text: 'Insurance',
                          imgUrl:  'assets/images/insurance01.svg',
                          isText: true,
                          onPress: (){},
                        ),
                      ],
                    ),
                    
                  ],
                )
              )
            ]
          ),
        ),
      )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/widgets/merchant_container.dart';

class CompanyHome extends StatefulWidget {
  static const String id = 'companyhome';
  const CompanyHome({Key? key}) : super(key: key);

  @override
  State<CompanyHome> createState() => _CompanyHomeState();
}

class _CompanyHomeState extends State<CompanyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body: SafeArea(
          child: ListView(children: [
        const SizedBox(height: 20.0),
        Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset('assets/images/Status bar.svg'),
                SvgPicture.asset('assets/images/alarm.svg'),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hello Glover,',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 30.0),
                      child: Button(
                          text: 'Admin',
                          onPress: () {},
                          color: green,
                          width: 110,
                          textColor: whiteColor,
                          isLoading: false),
                    )
                  ],
                ),
                const Text(
                  "Good evening",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 35,
        ),
        //const Expanded(child: Divider(),),
        Container(
          //height: 50,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                //spreadRadius: 5,
                blurRadius: 2.0,
                offset: const Offset(0.0, 1.0), 
              ),
            ],
          ),
          child: Expanded(
              child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                children: const [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: MerchantContainer(
                        color: green,
                        icon: 'assets/images/vehicle.svg',
                        title: 'Register new\n vehicle',
                      ),
                    ),
                  ),
                  //const SizedBox(width: 20,),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: MerchantContainer(
                        color: secondaryColor,
                        icon: 'assets/images/users.svg',
                        title: 'Register new\n Rider',
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: const [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: MerchantContainer(
                        color: secondaryColor,
                        icon: 'assets/images/pen.svg',
                        title: 'Edit Roder\'s\n details',
                      ),
                    ),
                  ),
                  //const SizedBox(width: 20,),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: MerchantContainer(
                        color: secondaryColor,
                        icon: 'assets/images/vehicle.svg',
                        title: 'View all\n vehicles',
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: const [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: MerchantContainer(
                        color: green,
                        icon: 'assets/images/mark.svg',
                        title: 'Today\'s\n successful\n delivery',
                        rides: '5',
                      ),
                    ),
                  ),
                  //const SizedBox(width: 20,),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: MerchantContainer(
                        color: green,
                        icon: 'assets/images/naira.svg',
                        title: 'Total number \n of referred\n Rides',
                        rides: '5',
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: const [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: MerchantContainer(
                        color: green,
                        icon: 'assets/images/naira.svg',
                        title: 'View my\n Riders',
                        rides: "(Riders)",
                      ),
                    ),
                  ),
                  //const SizedBox(width: 20,),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: MerchantContainer(
                        color: redColor,
                        icon: 'assets/images/cancel.svg',
                        title: 'Today\'s\n rejected\nrequest',
                        rides: '0',
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: const [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: MerchantContainer(
                        color: green,
                        icon: 'assets/images/vehicle.svg',
                        title: 'Request for a\n Rider',
                      ),
                    ),
                  ),
                  //const SizedBox(width: 20,),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: MerchantContainer(
                        color: green,
                        icon: 'assets/images/users.svg',
                        title: 'Deliver to my\n Customer',
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: const [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: MerchantContainer(
                        color: secondaryColor,
                        icon: 'assets/images/customers.svg',
                        title: 'My Customers',
                      ),
                    ),
                  ),
                  //const SizedBox(width: 20,),
                  Expanded(
                      child: SizedBox(
                    height: 160,
                    width: 160,
                  )),
                ],
              ),
            ],
          )),
        ),
      ])),
    );
  }
}

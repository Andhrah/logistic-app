import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/screens/riders/pick_up.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/button.dart';

class UserOrderScreen extends StatefulWidget {
  static const String id = 'userOrder';

  const UserOrderScreen({Key? key}) : super(key: key);

  @override
  _UserOrderScreenState createState() => _UserOrderScreenState();
}

class _UserOrderScreenState extends State<UserOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
            height: MediaQuery.of(context).size.height,
            child: Column(
            children: [
              const SizedBox(height: 10.0),
              const Text(
                'Your Dispatch',
                textScaleFactor: 1.9,
                style: TextStyle(
                  color: appPrimaryColor,
                  fontWeight: FontWeight.bold
                ),
              ),

              const SizedBox(height: 30.0),
              Expanded(
                child: ListView.builder(
                  itemCount: 1,
                  padding: const EdgeInsets.only(bottom: 120.0),
                  itemBuilder: (BuildContext context,int index){
                    return Card(
                      color: whiteColor,
                      // elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        // side: BorderSide(color: appPrimaryColor.withOpacity(0.1), width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: const EdgeInsets.only(bottom: 20.0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'ORDER ID:',
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                    color: appPrimaryColor.withOpacity(0.3),
                                    fontWeight: FontWeight.bold
                                  ),
                                ),

                                Text(
                                  '#234516',
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                    color: appPrimaryColor.withOpacity(0.3),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 15.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(width: 20.0),

                                Image.asset(
                                  'assets/images/order_highlighter2.png',
                                  height: 100,
                                  width: 13,
                                ),

                                const SizedBox(width: 20.0),
                                Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'PICK-UP ORDER',
                                        textScaleFactor: 0.9,
                                        style: TextStyle(
                                          color: appPrimaryColor.withOpacity(0.3),
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      const Text(
                                        '50b, Tapa street, yaba',
                                        textScaleFactor: 1.3,
                                        style: TextStyle(
                                          color: appPrimaryColor,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      
                                      const SizedBox(height: 20.0),
                                      Text(
                                        'DROP-OFF ORDER',
                                        textScaleFactor: 0.9,
                                        style: TextStyle(
                                          color: appPrimaryColor.withOpacity(0.3),
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      const Text(
                                        '1 Aminu street, mende maryland',
                                        textScaleFactor: 1.1,
                                        style: TextStyle(
                                          color: appPrimaryColor,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 30.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Icon(
                                      Remix.price_tag_3_fill,
                                      color: secondaryColor,
                                    ),
                                    Text(
                                      ' ₦1,500',
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                        color: secondaryColor,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ],
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Icon(
                                      Remix.time_fill,
                                      color: secondaryColor,
                                    ),
                                    Text(
                                      ' 12:05',
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                        color: secondaryColor,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ],
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Icon(
                                      Remix.pin_distance_fill,
                                     color: secondaryColor,
                                    ),
                                    Text(
                                      ' 29.7km',
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                        color: secondaryColor,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ],
                                ),
                              ]
                            ),

                            const SizedBox(height: 30.0),
                            Text(
                              'IMAGES:',
                              textScaleFactor: 0.9,
                              style: TextStyle(
                                color: appPrimaryColor.withOpacity(0.3),
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10.0),
                              height: 120.0,
                              child: ListView(
                                // This next line does the trick.
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(right: 30.0),
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                    child: Image.asset(
                                      "assets/images/item_img.png",
                                      height: 90.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.1),
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),

                                  Container(
                                    margin: const EdgeInsets.only(right: 30.0),
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                    child: Image.asset(
                                      "assets/images/item_img.png",
                                      height: 90.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.1),
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),

                                  Container(
                                    margin: const EdgeInsets.only(right: 30.0),
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                    child: Image.asset(
                                      "assets/images/item_img.png",
                                      height: 90.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.1),
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            const SizedBox(height: 30.0),
                            Align(
                              child: Button(
                                text: 'TRACK YOUR ORDER', 
                                onPress: () {
                                  Navigator.of(context).pushNamed(PickUpScreen.id);
                                  // Navigator.pop(context);
                                }, 
                                color: appPrimaryColor, 
                                textColor: whiteColor, 
                                isLoading: false,
                                width: MediaQuery.of(context).size.width/1.5,
                                // width: MediaQuery.of(context).size.width/6
                              ),
                            ),
                            const SizedBox(height: 20.0),
                          ],
                        ),
                      ),
                    );
                  }
                ),
              ),
              // const SizedBox(height: 140.0),
            ],
          ),
          ),
        ),
      ),
    );
  }
}

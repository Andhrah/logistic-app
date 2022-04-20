import 'package:flutter/material.dart';
import 'package:trakk/screens/dispatch/pick_ride.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/widgets/header.dart';
import 'package:trakk/widgets/input_field.dart';
import 'package:remixicon/remixicon.dart';

class ItemDetails extends StatefulWidget {
  static const String id = 'itemDetails';

  const ItemDetails({Key? key}) : super(key: key);

  @override
  _ItemDetailsState createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 30.0),
              const Header(
                text: 'CHOOSE A LOCATION',
              ),

              Container(
                height: 310.0,
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/map_img.png"),
                    fit: BoxFit.fill,
                  )
                ),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/map_pin.png",
                            height: 100.0,
                          ),

                          const SizedBox(width: 20.0),
                          Container(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            width: 280.0,
                            child: Column(
                              children: [
                                InputField(
                                  text: '',
                                  hintText: 'Item’s Location',
                                  textHeight: 0.0,
                                  borderColor: appPrimaryColor.withOpacity(0.5),
                                ),

                                InputField(
                                  text: '',
                                  hintText: 'Item’s Destination',
                                  textHeight: 0,
                                  borderColor: appPrimaryColor.withOpacity(0.5),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    InputField(
                      text: '',
                      hintText: 'Item',
                      textHeight: 0,
                      borderColor: appPrimaryColor.withOpacity(0.5),
                    ),

                    InputField(
                      text: '',
                      hintText: 'Item details',
                      textHeight: 0,
                      borderColor: appPrimaryColor.withOpacity(0.5),
                      area: null
                    ),
                  ]
                ),
              ),

              Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: appPrimaryColor.withOpacity(0.3), width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width/1.2,
                  height: 170,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        splashColor: Colors.black12.withAlpha(30),
                        child: const Icon(Remix.upload_2_line),
                        onTap: () {},
                      ),
                      const SizedBox(height: 26.0),
                      const Text(
                        'Upload item image',
                        style: TextStyle(
                          fontSize: 18.0, 
                          color: appPrimaryColor, 
                          fontWeight: FontWeight.w400
                        )
                      )
                    ]
                  ),
                ),
              ),

              const SizedBox(height: 30.0),

              Button(
                text: 'Proceed', 
                onPress: () {
                  Navigator.of(context).pushNamed(PickRide.id);
                }, 
                color: appPrimaryColor, 
                textColor: whiteColor, 
                isLoading: false,
                width: MediaQuery.of(context).size.width/1.2,
              )
            ],
          )
        ),
      )
    );
  }
}

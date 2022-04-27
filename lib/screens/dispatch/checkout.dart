import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:trakk/screens/dispatch/dispatch_summary.dart';
import 'package:trakk/screens/dispatch/pick_ride.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/widgets/header.dart';
import 'package:trakk/widgets/input_field.dart';
import 'package:remixicon/remixicon.dart';

class Checkout extends StatefulWidget {
  static const String id = 'checkout';

  const Checkout({Key? key}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 30.0),
              const Header(
                text: 'ADD INFO',
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Hi! Please fill in your details',
                        style: TextStyle(
                          fontSize: 15.0, 
                          color: appPrimaryColor, 
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    ),

                    const SizedBox(height: 30.0),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Sender’s Info',
                        style: TextStyle(
                          fontSize: 15.0, 
                          color: appPrimaryColor, 
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    ),

                    InputField(
                      obscureText: false,
                      text: '', 
                      textHeight: 0.0, 
                      borderColor: appPrimaryColor.withOpacity(0.3),
                      hintText: 'Email Address',
                      suffixIcon: Icon(
                        Remix.mail_line,
                        size: 20.0,
                        color: appPrimaryColor.withOpacity(0.2),
                      ),
                    ),

                    InputField(
                      obscureText: false,
                      text: '', 
                      textHeight: 0.0, 
                      borderColor: appPrimaryColor.withOpacity(0.3),
                      hintText: 'Name',
                      suffixIcon: Icon(
                        Remix.user_line,
                        size: 20.0,
                        color: appPrimaryColor.withOpacity(0.2),
                      ),
                    ),

                    InputField(
                      obscureText: false,
                      text: '', 
                      textHeight: 0.0, 
                      borderColor: appPrimaryColor.withOpacity(0.3),
                      hintText: 'Phone Number',
                      suffixIcon: Icon(
                        Remix.phone_line,
                        size: 20.0,
                        color: appPrimaryColor.withOpacity(0.2),
                      ),
                    ),

                    const SizedBox(height: 30.0),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Receiver’s Info',
                        style: TextStyle(
                          fontSize: 15.0, 
                          color: appPrimaryColor, 
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    ),

                    InputField(
                      obscureText: false,
                      text: '', 
                      textHeight: 0.0, 
                      borderColor: appPrimaryColor.withOpacity(0.3),
                      hintText: 'Email Address',
                      suffixIcon: Icon(
                        Remix.mail_line,
                        size: 20.0,
                        color: appPrimaryColor.withOpacity(0.2),
                      ),
                    ),

                    InputField(
                      obscureText: false,
                      text: '', 
                      textHeight: 0.0, 
                      borderColor: appPrimaryColor.withOpacity(0.3),
                      hintText: 'Name',
                      suffixIcon: Icon(
                        Remix.user_line,
                        size: 20.0,
                        color: appPrimaryColor.withOpacity(0.2),
                      ),
                    ),

                    InputField(
                      obscureText: false,
                      text: '', 
                      textHeight: 0.0, 
                      borderColor: appPrimaryColor.withOpacity(0.3),
                      hintText: 'Phone Number',
                      suffixIcon: Icon(
                        Remix.phone_line,
                        size: 20.0,
                        color: appPrimaryColor.withOpacity(0.2),
                      ),
                    ),

                    const SizedBox(height: 30.0),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Pickup Date',
                        style: TextStyle(
                          fontSize: 15.0, 
                          color: appPrimaryColor, 
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    ),

                    InputField(
                      obscureText: false,
                      text: '', 
                      textHeight: 0.0, 
                      borderColor: appPrimaryColor.withOpacity(0.3),
                      hintText: '24/3/2022',
                      suffixIcon: Icon(
                        Remix.calendar_line,
                        size: 20.0,
                        color: appPrimaryColor.withOpacity(0.2),
                      ),
                    ),

                    const SizedBox(height: 30.0),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Delivery Date',
                        style: TextStyle(
                          fontSize: 15.0, 
                          color: appPrimaryColor, 
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    ),

                    InputField(
                      obscureText: false,
                      text: '', 
                      textHeight: 0.0, 
                      borderColor: appPrimaryColor.withOpacity(0.3),
                      hintText: '26/3/2022',
                      suffixIcon: Icon(
                        Remix.calendar_line,
                        size: 20.0,
                        color: appPrimaryColor.withOpacity(0.2),
                      ),
                    ),

                    const SizedBox(height: 50.0),
                    const Text(
                      'Total Cost: ₦2000',
                      style: TextStyle(
                        fontSize: 20.0, 
                        color: appPrimaryColor, 
                        fontWeight: FontWeight.w700
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10.0),
              Button(
                text: 'Continue', 
                onPress: () {
                  Navigator.of(context).pushNamed(DispatchSummary.id);
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

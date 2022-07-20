import 'package:flutter/material.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/widgets/back_icon.dart';
import 'package:trakk/src/widgets/button.dart';

class PaymentIssues extends StatelessWidget {
  static const String id = 'paymentissue';

  const PaymentIssues({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(left: 0.0, right: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      'ABOUT TRAKK',
                      textScaleFactor: 1.2,
                      style: TextStyle(
                        color: appPrimaryColor,
                        fontWeight: FontWeight.bold,
                        // decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.only(left: 35.0, right: 35.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    const Text(
                      'Get support with Payment issues',
                      textScaleFactor: 1.2,
                      style: TextStyle(
                        color: appPrimaryColor,
                        fontWeight: FontWeight.bold,
                        // decoration: TextDecoration.underline,
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    const Text('What issue do you have with ride?',
                    style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w400),),

                  const SizedBox(height: 20.0),

                  TextField(
                    maxLines: 7,
                    keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0)
                    )
                  ),),

                    const SizedBox(height: 20),
                    Button(text: 'send', 
                    onPress: () {}, color: Colors.black, 
                    width: 300, textColor: Colors.white, isLoading: false)
                    
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}

class SupportContainer extends StatelessWidget {
  final String title;
  const SupportContainer({
    Key? key, required this.title,
  }) : super(key: key );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 43,
      width: 344,
      decoration: BoxDecoration(
          color: const Color(0xffEEEEEE),
          borderRadius: BorderRadius.circular(5.0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:  [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w400),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 17,
            ),
          ],
        )),
      ),
    );
  }
}

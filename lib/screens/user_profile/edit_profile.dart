import 'package:flutter/material.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/back_icon.dart';

class EditProfile extends StatelessWidget {
  static String id = "editprofile";

  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        backgroundColor: Colors.white,
        leading: BackIcon(
          onPress: () {
            Navigator.pop(context);
          },
        ),
        title: Container(
          // margin: const EdgeInsets.only(left: 0.0),
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {},
            customBorder: const CircleBorder(),
            child: const Text(
              'EDIT PROFILE',
              textScaleFactor: 1.0,
              style: TextStyle(
                color: appPrimaryColor,
                fontWeight: FontWeight.bold,
                // decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ),
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
          child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            EditProfileContainer(),
            Divider( thickness: 1.0,color: Color(0xff909090),)
          ],
        ),
      )),
    );
  }
}

class EditProfileContainer extends StatelessWidget {
  const EditProfileContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(left:30.0, right: 30, bottom: 17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 8, bottom: 12,),
              height: 80,
              width: 80,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('assets/images/image.png'))),
            ),
            const Text(
              'Malik Johnson',
              style:
                  TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            const Text('+234816559234'),
            const SizedBox(
              height: 8,
            ),
            Text('malhohn11@gmail.com'),
          ],
        ),
      ),
    );
  }
}

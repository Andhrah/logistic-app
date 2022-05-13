import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trakk/screens/user_profile/edit_profile.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/back_icon.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/widgets/profile_list.dart';

class UserMenu extends StatefulWidget {
  static const String id = "usermenu";
  const UserMenu({Key? key}) : super(key: key);

  @override
  State<UserMenu> createState() => _UserMenuState();
}

class _UserMenuState extends State<UserMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                  child: InkWell(
                    onTap: () {},
                    customBorder: const CircleBorder(),
                    child: const Text(
                      'PROFILE MENU',
                      textScaleFactor: 1.2,
                      style: TextStyle(
                        color: appPrimaryColor,
                        fontWeight: FontWeight.bold,
                        // decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              thickness: 1,
            ),
            const MenuContainer(),
            const Divider(
              thickness: 1,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(padding: EdgeInsets.only(left: 20),
              height: 87,
              decoration: const BoxDecoration(
                color: whiteColor,
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 2,
                    color: Color(0XFFBDBDBD),
                    offset: Offset(2.0, 4.0), //(x,y)
                    blurRadius: 10,
                  ),
                ],
              ),
              child: const Align(
                alignment: Alignment.center,
                child: ListTile(
                  title: Text(
                      'Share App with your Trakk\ncode and get ₦500 bonus in\nyour wallet', 
                      textAlign: TextAlign.justify,),
                  trailing: Icon(Icons.share),
                ),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            const ProfileList(
              svg: 'assets/images/wallet.svg',
              title: 'Wallet',
            ),
            const SizedBox(
              height: 18,
            ),
            const ProfileList(
              svg: 'assets/images/history.svg',
              title: 'Dispatch History',
            ),
            const SizedBox(
              height: 18,
            ),
            const ProfileList(
              svg: 'assets/images/settings.svg',
              title: 'Settings',
            ),
            const SizedBox(
              height: 18,
            ),
            const ProfileList(
              svg: 'assets/images/help.svg',
              title: 'Help and Support',
            ),
            const SizedBox(
              height: 18,
            ),
            const ProfileList(
              svg: 'assets/images/e-commerce.svg',
              title: 'E-commerce',
            ),
            const SizedBox(
              height: 18,
            ),
            const ProfileList(
              svg: 'assets/images/insurance.svg',
              title: 'Insurance',
            ),
            const SizedBox(
              height: 50,
            ),
            Container(padding: EdgeInsets.only(left: 30),
              height: 48,
              decoration: const BoxDecoration(
                color: whiteColor,
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 2,
                    color: Color(0XFFBDBDBD),
                    offset: Offset(2.0, 2.0), //(x,y)
                    blurRadius: 16,
                  ),
                ],
              ),
              child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/Logout.svg',
                        color: redColor,
                      ),
                      SizedBox(width: 22,),
                      const Text(
                        "Log out",
                        style: TextStyle(
                            color: redColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  )),
            ),
            const SizedBox(height: 45,),
            Align(alignment: Alignment.center,
            child: Button(text: 'Become a rider and earn',
             onPress: () {}, color: kTextColor, width: 344, 
             textColor: whiteColor, isLoading: false),),
             SizedBox(height: 30,),
          ]),
        ),
      ),
    );
  }
}



class MenuContainer extends StatelessWidget {
  const MenuContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 35.0, right: 35.0, top: 0, bottom: 0),
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: CircleAvatar(
                  child: Image(
                    image: AssetImage('assets/images/malik.png'),
                    height: 80,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Malik Johnson',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('+234816559234'),
                      SizedBox(
                        height: 8,
                      ),
                      Text('malhohn11@gmail.com'),
                    ],
                  ),
                  Button(
                      text: 'Edit profile',
                      onPress: () {
                        Navigator.of(context).pushNamed(EditProfile.id);
                      },
                      color: Colors.black,
                      width: 100.0,
                      textColor: whiteColor,
                      isLoading: false),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

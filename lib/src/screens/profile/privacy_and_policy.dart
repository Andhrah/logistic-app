import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:remixicon/remixicon.dart';

import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/widgets/back_icon.dart';
import '../../widgets/item_model.dart';

class PrivacyAndPolicy extends StatefulWidget {
  static String id = "privacyAndSecurity";

  const PrivacyAndPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyAndPolicy> createState() => _PrivacyAndPolicyState();
}

class _PrivacyAndPolicyState extends State<PrivacyAndPolicy> {
  bool status = false;

  static String userType = "user";

  final _formKey = GlobalKey<FormState>();

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  FocusNode? _firstNameNode;
  FocusNode? _lastNameNode;
  FocusNode? _phoneNumberNode;
  FocusNode? _emailNode;
  FocusNode? _passwordNode;
  FocusNode? _confirmPasswordNode;

  String? _firstName;
  String? _lastName;
  String? _email;
  String? _phoneNumber;
  String? _password;
  String? _confirmPassword;

  bool _isVisible = false;
  bool _isVisible1 = false;


  @override
  void initState() {
    super.initState();
  }

  List<ItemModel> itemData = <ItemModel>[
    ItemModel(
        headerItem: 'User Account Security',
        discription:
            "Android is a mobile operating system based on a modified version of the Linux kernel and other open source software, designed primarily for touchscreen mobile devices such as smartphones and tablets. ... Some well known derivatives include Android TV for televisions and Wear OS for wearables, both developed by Google.",
        colorsItem: Colors.green,
        img: 'assets/images/android_img.png'),
  ];

  String securityDescription =
      """In order to have continued access to use the Platform, you will have to register on the Platform and create an account with a unique user identity and password ("Account"). If you are using the Platform on a compatible mobile or tablet, you will have to install the application and then proceed with registration.
You will be responsible for maintaining the confidentiality of the Account information, and are fully responsible for all activities that occur under Your Account. You agree that you will 
   a) Immediately notify Trakk of any unauthorized use of Your Account information or any other breach of security, and
   b) Ensure that You exit from Your Account at the end of each session.
   TRAKK cannot and will not be liable for any loss or damage arising from your failure to comply with this provision.You may be held liable for losses incurred by TRAKK or any other User of or visitor to the Platform due to authorized or unauthorized use of Your Account as a result of your failure in keeping your Account information secure and confidential. 
Use of another User’s Account information for using the Platform is expressly prohibited.

""";
String privacyPolicy = """
All information provided by you is for the purpose of efficient delivery of services.

TRAKK shall not use your information for any other purpose other than that which was stated.

All information received by TRAKK shall be managed according to the Nigerian Data Protection Laws.

""";
  /*
   * This method handles the onsubmit event annd validates users input. It triggers validation and sends data to the API
  */

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
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
                  height: 98,
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.2),
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {},
                    customBorder: const CircleBorder(),
                    child: Text(
                      'PRIVACY & POLICY',
                      style: theme.textTheme.subtitle1!.copyWith(
                        fontWeight: kBoldWeight,
                        fontSize: 18,fontFamily: kDefaultFontFamilyHeading
                        // decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    InkWell(
                      onTap: (() {
                        setState(() {
                          _isVisible = true;
                        });
                      }),
                      child: privacyContainer(
                        isVisible: _isVisible,
                        leadIcon: Remix.account_pin_circle_line,
                        title: 'User Account Security',
                        description: securityDescription,
                        onPressed: () {
                          setState(() {
                            _isVisible = false;
                          });
                        },
                      ),
                    ),
                    InkWell(
                      onTap: (() {
                        setState(() {
                          _isVisible1 = true;
                        });
                      }),
                      child: privacyContainer(
                        isVisible: _isVisible1,
                        leadIcon: Remix.git_repository_private_line,
                        title: 'Privacy Policy',
                        description: privacyPolicy,
                        onPressed: () {
                          setState(() {
                            _isVisible1 = false;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class privacyContainer extends StatelessWidget {
  final IconData leadIcon;
  final String title;
  final String description;
  final Function onPressed;

  privacyContainer({
    Key? key,
    required bool isVisible,
    required this.leadIcon,
    required this.title,
    required this.description,
    required this.onPressed,
  })  : _isVisible = isVisible,
        super(key: key);

  bool _isVisible;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        color: Colors.black,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                leadIcon,
                color: secondaryColor,
              ),
              const Spacer(),
              Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: kDefaultFontFamily ),
              ),
              const Spacer(),
              _isVisible == true
                  ? IconButton(
                      onPressed: () {
                        onPressed();
                      },
                      icon: const Icon(
                        Remix.arrow_down_s_line,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(
                    Remix.arrow_right_s_line,
                      //size: 26,
                      color: Colors.white,
                    ),
            ],
          ),
          Visibility(
            visible: _isVisible,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ReadMoreText(
                description,
                trimLines: 19,
                colorClickableText: Colors.pink,
                trimMode: TrimMode.Line,
                trimCollapsedText: ' See all',
                trimExpandedText: ' Back',
                moreStyle: textStyle(),
                lessStyle: textStyle(),
                style: const TextStyle(
                    color: Colors.white, fontFamily: kDefaultFontFamilyBody),
              ),
            ),
          )
        ],
      ),
    );
  }

  TextStyle textStyle() {
    return const TextStyle(
      color: secondaryColor,
      fontSize: 16,
      fontWeight: FontWeight.w700,
      fontFamily: kDefaultFontFamily,
    );
  }
}

class divider extends StatelessWidget {
  const divider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 1.0,
      color: Color(0xff909090),
    );
  }
}

class SettingsRow extends StatelessWidget {
  final String title;
  final Widget statusIcon;
  final Widget icon;

  const SettingsRow({
    Key? key,
    required this.title,
    required this.statusIcon,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(
        children: [
          statusIcon,
          const SizedBox(
            width: 25,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ],
      ),
      icon,
    ]);
  }
}

var textStyle = const TextStyle(fontSize: 17, fontWeight: FontWeight.w600);

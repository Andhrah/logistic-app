import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:remixicon/remixicon.dart';

import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/widgets/back_icon.dart';
import '../../widgets/item_model.dart';

class Settings extends StatefulWidget {
  static String id = "privacyAndSecurity";

  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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

  bool _loading = false;
  bool _passwordIsValid = false;
  bool _confirmPasswordIsValid = false;
  bool _hidePassword = true;
  bool _autoValidate = false;
  bool _emailIsValid = false;

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

  String text =
      """In order to have continued access to use the Platform, you will have to register on the Platform and create an account with a unique user identity and password ("Account"). If you are using the Platform on a compatible mobile or tablet, you will have to install the application and then proceed with registration.
You will be responsible for maintaining the confidentiality of the Account information, and are fully responsible for all activities that occur under Your Account. You agree that you will 
   a)	immediately notify Trakk of any unauthorized use of Your Account information or any other breach of security, and
   b)	ensure that You exit from Your Account at the end of each session.
   TRAKK cannot and will not be liable for any loss or damage arising from your failure to comply with this provision.You may be held liable for losses incurred by TRAKK or any other User of or visitor to the Platform due to authorized or unauthorized use of Your Account as a result of your failure in keeping your Account information secure and confidential. 
Use of another User’s Account information for using the Platform is expressly prohibited.

""";
  /*
   * This method handles the onsubmit event annd validates users input. It triggers validation and sends data to the API
  */

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 2.0,
      //   backgroundColor: Colors.white,
      //   leading: BackIcon(
      //     onPress: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      //   title: Container(
      //     // margin: const EdgeInsets.only(left: 0.0),
      //     alignment: Alignment.center,
      //     child: InkWell(
      //       onTap: () {},
      //       customBorder: const CircleBorder(),
      //       child: const Text(
      //         'SETTINGS',
      //         textScaleFactor: 1.0,
      //         style: TextStyle(
      //           color: appPrimaryColor,
      //           fontWeight: FontWeight.bold,
      //           // decoration: TextDecoration.underline,
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
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
                        fontSize: 18,
                        // decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ExpandedText(text: "text"),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  height: MediaQuery.of(context).size.height * .5,
                  child: Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: itemData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return 
                        Container(
                          decoration: const BoxDecoration(
                              color: appPrimaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: ExpansionPanelList(
                            animationDuration: Duration(microseconds: 2000),
                            //dividerColor: Colors.red,
                            elevation: 0,
                            children: [
                              ExpansionPanel(
                                backgroundColor: grayColor,
                                body: Container(
                                  color: grayColor,
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      ReadMoreText(
                                        text,
                                        textAlign: TextAlign.start,
                                        //trimLength: 500,
                                        trimLines: 15,
                                        colorClickableText:
                                            Color.fromARGB(255, 30, 233, 91),
                                        trimMode: TrimMode.Line,
                                        trimCollapsedText: 'see all',
                                        trimExpandedText: 'back',
                                        lessStyle: textStyle,
                                        moreStyle: textStyle,
                                      ),
                                    ],
                                  ),
                                ),
                                headerBuilder:
                                    (BuildContext context, bool isExpanded) {
                                  return Container(
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                      children: const [
                                        Icon(
                                          Remix.account_pin_circle_line,
                                          color: appPrimaryColor,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                         "User Account Security",
                                          style: TextStyle(
                                            color: whiteColor,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                isExpanded: itemData[index].expanded,
                              )
                            ],
                            expansionCallback: (int index, bool status) {
                              setState(() {
                                itemData[index].expanded =
                                    !itemData[index].expanded;
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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
          SizedBox(
            width: 25,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ],
      ),
      icon,
    ]);
  }
}
  var textStyle = TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600);

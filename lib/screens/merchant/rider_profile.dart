import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trakk/models/merchant/get_riders_for_merchant_response.dart';
import 'package:trakk/utils/assets.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/back_icon.dart';

class RiderProfile extends StatefulWidget {
  static String id = "riderProfile";

  const RiderProfile({Key? key}) : super(key: key);

  @override
  State<RiderProfile> createState() => _RiderProfile();
}

class _RiderProfile extends State<RiderProfile> {
  static String userType = "user";

  final _formKey = GlobalKey<FormState>();

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _assignedvehicleController;

  FocusNode? _firstNameNode;
  FocusNode? _lastNameNode;
  FocusNode? _phoneNumberNode;
  FocusNode? _emailNode;
  FocusNode? _passwordNode;
  FocusNode? _confirmPasswordNode;
  FocusNode? _assignedvehicleNode;

  String? _firstName;
  String? _lastName;
  String? _email;
  String? _phoneNumber;
  String? _password;
  String? _confirmPassword;
  String? _assignedvehicle;

  bool _loading = false;
  bool _passwordIsValid = false;
  bool _confirmPasswordIsValid = false;
  bool _hidePassword = true;
  bool _autoValidate = false;
  bool _emailIsValid = false;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _assignedvehicleController = TextEditingController();
  }

  _validateEmail() {
    RegExp regex;
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    String email = _emailController.text;
    if (email.trim().isEmpty) {
      setState(() {
        _emailIsValid = false;
      });
      return "Email address cannot be empty";
    } else {
      regex = RegExp(pattern);
      setState(() {
        _emailIsValid = regex.hasMatch(email);
        print(_emailIsValid);
      });
      if (_emailIsValid == false) {
        return "Enter a valid email address";
      }
    }
  }

  isConfirmPasswordValid() {
    setState(() {
      _confirmPasswordIsValid = _confirmPasswordController.text != null &&
          _confirmPasswordController.text == _passwordController.text;
      print(_confirmPasswordIsValid);
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    var arg =
        (ModalRoute.of(context)!.settings.arguments) as Map<String, dynamic>;

    final model =
        GetRidersForMerchantPurpleAttributes.fromJson(arg['rider_datum']);

    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
          child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 0.0, right: 30, bottom: 17),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BackIcon(
                      onPress: () {
                        Navigator.pop(context);
                      },
                    ),
                    //Text('data'),
                    SizedBox(
                      width: mediaQuery.size.width * 0.08,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  model.userId?.data?.attributes?.avatar ?? '',
                              height: 80,
                              width: 80,
                              placeholder: (context, url) => Image.asset(
                                Assets.dummy_avatar,
                                height: 80,
                                width: 80,
                              ),
                              errorWidget: (context, url, err) => Image.asset(
                                Assets.dummy_avatar,
                                height: 80,
                                width: 80,
                              ),
                            ),
                            Text(
                              '${model.userId?.data?.attributes?.firstName ?? ''} ${model.userId?.data?.attributes?.lastName ?? ''}',
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    DefaultTabController(
                        length: 3,
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: TabBar(
                                        labelStyle: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                        indicatorPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 10),
                                        //indicatorColor: Colors.red,
                                        indicator: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            border: Border.all(),
                                            color: appPrimaryColor),
                                        labelPadding: EdgeInsets.only(left: 0),
                                        labelColor: whiteColor,
                                        unselectedLabelColor: appPrimaryColor,
                                        unselectedLabelStyle:
                                            TextStyle(fontSize: 16),
                                        tabs: const [
                                          Tab(text: 'Edit'),
                                          Tab(
                                            text: 'Suspend',
                                          ),
                                          Tab(
                                            text: 'Delete',
                                          ),
                                        ]),
                                  ),
                                ),
                                Container(
                                  //width: double.maxFinite,
                                  height: mediaQuery.size.height * 0.6,
                                  child: TabBarView(children: [
                                    SingleChildScrollView(
                                      //shrinkWrap: true,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          SizedBox(
                                            height: 25,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          detailsBox(),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          detailsBox(),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          detailsBox(),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          detailsBox(),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          detailsBox(),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          detailsBox(),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          detailsBox(),
                                          SizedBox(
                                            height: 0,
                                          ),
                                        ],
                                      ),
                                    ),
                                    ListView(
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 57,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 19, top: 23),
                                            child: Text(
                                              'Q/A',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          height: 1.0,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                    ListView(children: [
                                      Container(
                                        height: 57,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 19, top: 21),
                                          child: Text(
                                            'Library',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      Divider()
                                    ]),
                                  ]),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}

class detailsBox extends StatelessWidget {
  const detailsBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Activity',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 56,
          width: 344,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              color: Color.fromARGB(255, 210, 219, 235),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Text(
              'Malik',
              style: TextStyle(fontSize: 16, color: grayColor),
            ),
          ),
        ),
      ],
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
        padding: const EdgeInsets.only(left: 30.0, right: 30, bottom: 17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 8,
                bottom: 12,
              ),
              height: 80,
              width: 80,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('assets/images/image.png'))),
            ),
            const Text(
              'Malik Johnson',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
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

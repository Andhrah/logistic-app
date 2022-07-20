import 'package:flutter/material.dart';

import 'package:remixicon/remixicon.dart';

import 'package:trakk/provider/support/support.dart';
import 'package:trakk/services/support_service.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/back_icon.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/widgets/input_field.dart';

class HelpAndSupport extends StatefulWidget {
  static const String id = 'rideissue';

  const HelpAndSupport({Key? key}) : super(key: key);

  @override
  State<HelpAndSupport> createState() => _HelpAndSupportState();
}

class _HelpAndSupportState extends State<HelpAndSupport> {
  var complaints = [
    "Choose complaint",
    "Delivery issues",
    "Payment issues",
    "Account & data",
  ];

  final _formKey = GlobalKey<FormState>();

  String? _email;
  String _complaintType = "Choose complaint";

  late TextEditingController _emailController;
  late TextEditingController _messageController;

  FocusNode? _emailNode;

  bool _emailIsValid = false;

  bool _isButtonPress = false;
  bool _isLoading = false;

  SupportService supportService = SupportService();

  /*
   * This method handles the onsubmit event annd validates users input. It triggers validation and sends data to the API
  */
  _onSave() async {
    setState(() {
      _isButtonPress = true;
    });

    final FormState? form = _formKey.currentState;

    if (form!.validate() && _complaintType != "Choose complaint") {
      form.save();

      try {
        setState(() {
          _isLoading = true;
        });
        var response = await supportService.sendMessage(
            name: _complaintType,
            email: _emailController.text,
            message: _messageController.text);
        if (response == true) {
          Navigator.pop(context);
        }
        print(response.toString());
      } catch (e) {
        print("this is the error response " + e.toString());
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
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
      });
      if (_emailIsValid == false) {
        return "Enter a valid email address";
      }
    }
  }

  @override
  void initState() {
    super.initState();
    //_firstNameController = TextEditingController();
    //_lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _messageController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
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
                      'HELP & SUPPORT',
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
                  children: [
                    const Text(
                      'Get support with Ride issues',
                      textScaleFactor: 1.2,
                      style: TextStyle(
                        color: appPrimaryColor,
                        fontWeight: FontWeight.bold,
                        // decoration: TextDecoration.underline,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    // const Text(
                    //   'What issue do you have with ride?',
                    //   style:
                    //       TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    // ),
                    // const SizedBox(height: 20.0),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          InputField(
                            key: const Key('email'),
                            textController: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            node: _emailNode,
                            obscureText: false,
                            text: 'Email Address',
                            hintText: 'jane@email.com',
                            textHeight: 5.0,
                            borderColor: appPrimaryColor.withOpacity(0.9),
                            suffixIcon: const Icon(
                              Remix.mail_line,
                              size: 18.0,
                              color: Color(0xFF909090),
                            ),
                            validator: (value) {
                              return _validateEmail();
                            },
                            onSaved: (value) {
                              _email = value!.trim();
                              return null;
                            },
                          ),
                          _isButtonPress && _complaintType == "Choose complaint"
                              ? const Text(
                                  " Choose your complaint type",
                                  textScaleFactor: 0.9,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                )
                              : Container(),
                          const SizedBox(height: 30.0),
                          DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: appPrimaryColor.withOpacity(0.9),
                                    width: 0.3), //border of dropdown button
                                borderRadius: BorderRadius.circular(
                                    5.0), //border raiuds of dropdown button
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: DropdownButton<String>(
                                  value: _complaintType,
                                  icon: const Icon(Remix.arrow_down_s_line),
                                  elevation: 16,
                                  isExpanded: true,
                                  style: TextStyle(
                                    color: appPrimaryColor.withOpacity(0.8),
                                    fontSize: 18.0,
                                  ),
                                  underline: Container(),
                                  //empty line
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _complaintType = newValue!;
                                    });
                                  },
                                  items: complaints.map((String value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              )),
                          const SizedBox(height: 30.0),
                          TextField(
                            controller: _messageController,
                            maxLines: 7,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0))),
                          ),
                          const SizedBox(height: 50),
                          Button(
                              text: 'Send',
                              onPress: _onSave,
                              color: Colors.black,
                              width: mediaQuery.size.width * 1,
                              textColor: Colors.white,
                              isLoading: _isLoading)
                        ],
                      ),
                    ),
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
    Key? key,
    required this.title,
  }) : super(key: key);

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
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
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

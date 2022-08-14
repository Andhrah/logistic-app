import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/src/services/support_service.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/widgets/back_icon.dart';
import 'package:trakk/src/widgets/button.dart';
import 'package:trakk/src/widgets/input_field.dart';

import '../../utils/app_toast.dart';
import '../../values/enums.dart';

class SendMessage extends StatefulWidget {
  static const String id = 'sendMessage';

  const SendMessage({Key? key}) : super(key: key);

  @override
  State<SendMessage> createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  var complaints = [
    "Delivery issues",
    "Payment issues",
    "Account & data",
  ];

  final _formKey = GlobalKey<FormState>();

  String? _email;
  String? _complaintType;

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

    if (form!.validate() && _complaintType != null) {
      form.save();

      try {
        setState(() {
          _isLoading = true;
        });
        var response = await supportService.sendMessage(
            name: _complaintType ?? '',
            email: _emailController.text,
            message: _messageController.text);
        if (response == true) {
          Navigator.pop(context);
          appToast('Complaint sent successfully',
              appToastType: AppToastType.success);
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
    var theme = Theme.of(context);
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    BackIcon(
                      onPress: () {
                        Navigator.pop(context);
                      },
                    ),
                    Container(
                      //height: 60,
                      margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1, vertical: 27),
                      alignment: Alignment.center,
                      child: const Text(
                        'HELP & SUPPORT',
                        textScaleFactor: 1.2,
                        style: TextStyle(
                            color: appPrimaryColor,
                            fontWeight: kBoldWeight,
                            fontFamily: kDefaultFontFamilyHeading
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
                      const SizedBox(height: 30.0),
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
                            // const Text(
                            //   "Choose your complaint type",
                            //   textScaleFactor: 0.9,
                            //   textAlign: TextAlign.center,
                            //   style: TextStyle(
                            //     color: Colors.red,
                            //   ),
                            // ),
                            const SizedBox(height: 30.0),
                            DropdownButtonFormField<String>(
                              value: _complaintType,
                              icon: const Icon(Remix.arrow_down_s_line),
                              elevation: 16,
                              isExpanded: true,
                              hint: Text(
                                'Choose Complaint',
                                style: TextStyle(
                                  color: appPrimaryColor.withOpacity(0.5),
                                  fontSize: 14.0,
                                ),
                              ),
                              style: theme.textTheme.bodyText2!.copyWith(
                                color: appPrimaryColor.withOpacity(0.8),
                              ),
                              validator: (value) {
                                if (value == null || (value.isEmpty)) {
                                  return 'Choose your complaint type';
                                }

                                return null;
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 13.0, horizontal: 10.0),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: appPrimaryColor, width: 0.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: secondaryColor.withOpacity(0.8)),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: redColor.withOpacity(0.8)),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: appPrimaryColor.withOpacity(0.9),
                                      width: 0.0),
                                ),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: appPrimaryColor, width: 0.0),
                                ),
                                // labelText: labelText,
                                labelStyle: theme.textTheme.bodyText2!.copyWith(
                                    color: const Color(0xFF8C8C8C),
                                    fontWeight: kSemiBoldWeight),

                                hintStyle: theme.textTheme.bodyText2!
                                    .copyWith(color: const Color(0xFFBDBDBD)),
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _complaintType = newValue!;
                                });
                                _formKey.currentState!.validate();
                              },
                              items: complaints.map((String value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/bloc/app_settings_bloc.dart';
import 'package:trakk/bloc/validation_bloc.dart';
import 'package:trakk/models/app_settings.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/utils/enums.dart';
import 'package:trakk/utils/font.dart';
import 'package:trakk/widgets/input_field.dart';

typedef _OnInputCallback = Function(String senName, String senEmail,
    String senPhone, String recName, String recEmail, String recPhone);

class ItemDetailParticipantWidget extends StatefulWidget {
  final _OnInputCallback onInputCallback;

  const ItemDetailParticipantWidget(this.onInputCallback, {Key? key})
      : super(key: key);

  @override
  _ItemDetailParticipantWidgetState createState() =>
      _ItemDetailParticipantWidgetState();
}

class _ItemDetailParticipantWidgetState
    extends State<ItemDetailParticipantWidget> {
  ValidationBloc validationBloc = ValidationBloc();

  final TextEditingController _receiverNameController = TextEditingController();
  final TextEditingController _senderNameController = TextEditingController();
  final TextEditingController _receiverPhoneNumberController =
      TextEditingController();
  final TextEditingController _senderPhoneNumberController =
      TextEditingController();
  final TextEditingController _receiverEmailController =
      TextEditingController();
  final TextEditingController _senderEmailController = TextEditingController();

  final FocusNode _receiverNameNode = FocusNode();
  final FocusNode _senderNameNode = FocusNode();
  final FocusNode _receiverphoneNumberNode = FocusNode();
  final FocusNode _senderphoneNumberNode = FocusNode();
  final FocusNode _receiverEmailNode = FocusNode();
  final FocusNode _senderEmailNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _receiverNameController.dispose();
    _senderNameController.dispose();
    _receiverPhoneNumberController.dispose();
    _senderPhoneNumberController.dispose();
    _receiverEmailController.dispose();
    _senderEmailController.dispose();
    _receiverNameNode.dispose();
    _senderNameNode.dispose();
    _receiverphoneNumberNode.dispose();
    _senderphoneNumberNode.dispose();
    _receiverEmailNode.dispose();
    _senderEmailNode.dispose();
    validationBloc.dispose();
    super.dispose();
  }

  doCallback() async {
    String _senName = _senderNameController.text;
    String _senEmail = _senderEmailController.text;
    String _senPhone = _senderPhoneNumberController.text;

    //this is for when it's a customer or guest who's accessing this widget
    AppSettings appSettings = await appSettingsBloc.fetchAppSettings();
    if (appSettings.isLoggedIn &&
        appSettings.loginResponse != null &&
        _senName.isEmpty &&
        _senEmail.isEmpty &&
        _senPhone.isEmpty) {
      _senName = appSettings.loginResponse?.data?.user?.firstName ?? '';
      _senEmail = appSettings.loginResponse?.data?.user?.email ?? '';
      _senPhone = appSettings.loginResponse?.data?.user?.phoneNumber ?? '';
    }

    widget.onInputCallback(
        _senName,
        _senEmail,
        _senPhone,
        _receiverNameController.text,
        _receiverEmailController.text,
        _receiverPhoneNumberController.text);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Column(
      children: [
        FutureBuilder<UserType>(
            future: appSettingsBloc.getUserType,
            builder: (context, snapshot) {
              if (snapshot.hasData && (snapshot.data == UserType.guest)) {
                return Column(
                  children: [
                    Text(
                      'Sender’s Info',
                      style: theme.textTheme.bodyText2!.copyWith(
                        color: appPrimaryColor,
                        fontWeight: kBoldWeight,
                      ),
                    ),
                    InputField(
                      key: const Key('senderName'),
                      textController: _senderNameController,
                      node: _senderNameNode,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: false,
                      text: '',
                      hintText: 'Name',
                      textHeight: 0.0,
                      borderColor: appPrimaryColor.withOpacity(0.9),
                      suffixIcon: const Icon(
                        Remix.user_line,
                        size: 18.0,
                        color: Color(0xFF909090),
                      ),
                      validator: (value) {
                        if (value!.trim().length > 2) {
                          return null;
                        }
                        return "Enter a valid name";
                      },
                      onSaved: (value) {
                        doCallback();
                        return null;
                      },
                    ),

                    // const SizedBox(height: 30.0),
                    InputField(
                      key: const Key('senderEmail'),
                      textController: _senderEmailController,
                      node: _senderEmailNode,
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: false,
                      text: '',
                      hintText: 'Email',
                      textHeight: 0.0,
                      borderColor: appPrimaryColor.withOpacity(0.9),
                      suffixIcon: const Icon(
                        Remix.mail_line,
                        size: 18.0,
                        color: Color(0xFF909090),
                      ),
                      validator: validationBloc.emailValidator,
                      onSaved: (value) {
                        doCallback();
                        return null;
                      },
                    ),

                    InputField(
                      key: const Key('senderPhoneNumber'),
                      textController: _senderPhoneNumberController,
                      node: _senderphoneNumberNode,
                      keyboardType: TextInputType.phone,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: false,
                      text: '',
                      hintText: 'Phone number',
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      textHeight: 0.0,
                      borderColor: appPrimaryColor.withOpacity(0.9),
                      suffixIcon: const Icon(
                        Remix.phone_line,
                        size: 18.0,
                        color: Color(0xFF909090),
                      ),
                      validator: (value) {
                        if (value!.trim().length == 11) {
                          return null;
                        }
                        return "Enter a valid phone number";
                      },
                      onSaved: (value) {
                        doCallback();
                        return null;
                      },
                    ),

                    const SizedBox(height: 20.0),
                  ],
                );
              }
              return const SizedBox();
            }),
        Text(
          'Receiver’s Info',
          style: theme.textTheme.bodyText2!.copyWith(
            color: appPrimaryColor,
            fontWeight: kBoldWeight,
          ),
        ),
        InputField(
          key: const Key('receiverName'),
          textController: _receiverNameController,
          node: _receiverNameNode,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: false,
          text: '',
          hintText: 'Name',
          textHeight: 0.0,
          borderColor: appPrimaryColor.withOpacity(0.9),
          suffixIcon: const Icon(
            Remix.user_line,
            size: 18.0,
            color: Color(0xFF909090),
          ),
          validator: (value) {
            if (value!.trim().length > 2) {
              return null;
            }
            return "Enter a valid name";
          },
          onSaved: (value) {
            doCallback();
            return null;
          },
        ),
        InputField(
          key: const Key('receiverEmail'),
          textController: _receiverEmailController,
          node: _receiverEmailNode,
          keyboardType: TextInputType.emailAddress,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: false,
          text: '',
          hintText: 'Email',
          textHeight: 0.0,
          borderColor: appPrimaryColor.withOpacity(0.9),
          suffixIcon: const Icon(
            Remix.mail_line,
            size: 18.0,
            color: Color(0xFF909090),
          ),
          validator: validationBloc.emailValidator,
          onSaved: (value) {
            doCallback();
            return null;
          },
        ),
        InputField(
          key: const Key('receiverPhoneNumber'),
          textController: _receiverPhoneNumberController,
          node: _receiverphoneNumberNode,
          keyboardType: TextInputType.phone,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: false,
          text: '',
          hintText: 'Phone number',
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          textHeight: 0.0,
          borderColor: appPrimaryColor.withOpacity(0.9),
          suffixIcon: const Icon(
            Remix.phone_line,
            size: 18.0,
            color: Color(0xFF909090),
          ),
          validator: (value) {
            if (value!.trim().length == 11) {
              return null;
            }
            return "Enter a valid phone number";
          },
          onSaved: (value) {
            doCallback();
            return null;
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/bloc/app_settings_bloc.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/utils/enums.dart';
import 'package:trakk/widgets/input_field.dart';

typedef _OnInputCallback = Function(
    String senName, String senPhone, String recName, String recPhone);

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
  final TextEditingController _receiverNameController = TextEditingController();
  final TextEditingController _senderNameController = TextEditingController();
  final TextEditingController _receiverPhoneNumberController =
      TextEditingController();
  final TextEditingController _senderPhoneNumberController =
      TextEditingController();

  final FocusNode _receiverNameNode = FocusNode();
  final FocusNode _senderNameNode = FocusNode();
  final FocusNode _receiverphoneNumberNode = FocusNode();
  final FocusNode _senderphoneNumberNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _receiverNameController.dispose();
    _senderNameController.dispose();
    _receiverPhoneNumberController.dispose();
    _senderPhoneNumberController.dispose();
    _receiverNameNode.dispose();
    _senderNameNode.dispose();
    _receiverphoneNumberNode.dispose();
    _senderphoneNumberNode.dispose();
  }

  doCallback() => widget.onInputCallback(
      _senderNameController.text,
      _senderPhoneNumberController.text,
      _receiverNameController.text,
      _receiverPhoneNumberController.text);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<UserType>(
            future: appSettingsBloc.getUserType,
            builder: (context, snapshot) {
              if (snapshot.hasData && (snapshot.data == UserType.guest)) {
                return Column(
                  children: [
                    const Text(
                      'Sender’s Info',
                      textScaleFactor: 1.2,
                      style: TextStyle(
                        color: appPrimaryColor,
                        fontWeight: FontWeight.bold,
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
        const Text(
          'Receiver’s Info',
          textScaleFactor: 1.2,
          style: TextStyle(
            color: appPrimaryColor,
            fontWeight: FontWeight.bold,
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

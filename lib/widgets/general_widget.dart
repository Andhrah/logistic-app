import 'package:flutter/material.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/button.dart';

yesNoDialog(BuildContext context, Function() positiveCallback,
    Function() negativeCallback) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
// title: const Text('AlertDialog Title'),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 50.0, vertical: 50.0),
      content: SizedBox(
        height: 150.0,
        child: Column(children: [
          Button(
            text: 'Yes',
            onPress: () => positiveCallback(),
            color: appPrimaryColor,
            textColor: whiteColor,
            isLoading: false,
            width: MediaQuery.of(context).size.width / 1.6,
          ),
          const SizedBox(height: 30.0),
          Button(
            text: 'No',
            onPress: () => negativeCallback(),
            color: whiteColor,
            textColor: appPrimaryColor,
            isLoading: false,
            width: MediaQuery.of(context).size.width / 1.6,
          )
        ]),
      ),
    ),
  );
}

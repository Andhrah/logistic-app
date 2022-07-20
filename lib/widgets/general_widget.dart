import 'package:flutter/material.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/utils/helper_utils.dart';
import 'package:trakk/widgets/button.dart';

yesNoDialog(
  BuildContext context, {
  String message = '',
  Function()? positiveCallback,
  Function()? negativeCallback,
}) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
// title: const Text('AlertDialog Title'),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 50.0, vertical: 50.0),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        if (message.isNotEmpty)
          Center(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6!.copyWith(),
            ),
          ),
        if (message.isNotEmpty) 24.heightInPixel(),
        Row(
          children: [
            Expanded(
              child: Button(
                text: 'Yes',
                onPress: positiveCallback,
                color: appPrimaryColor,
                textColor: whiteColor,
                isLoading: false,
                width: MediaQuery.of(context).size.width / 1.6,
              ),
            ),
            12.widthInPixel(),
            Expanded(
              child: Button(
                text: 'No',
                onPress: negativeCallback,
                color: whiteColor,
                textColor: appPrimaryColor,
                isLoading: false,
                width: MediaQuery.of(context).size.width / 1.6,
              ),
            )
          ],
        ),
      ]),
    ),
  );
}

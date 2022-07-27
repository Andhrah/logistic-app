import 'package:flutter/material.dart';
import 'package:trakk/src/utils/helper_utils.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/widgets/button.dart';

yesNoDialog(
  BuildContext context, {
  String title = '',
  String message = '',
  Function()? positiveCallback,
  Function()? negativeCallback,
}) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: title.isEmpty
          ? null
          : Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: kBoldWeight),
            ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        // if (title.isNotEmpty)
        //   Center(
        //     child: Text(
        //       title,
        //       textAlign: TextAlign.center,
        //       style: Theme.of(context).textTheme.bodyText1!.copyWith(),
        //     ),
        //   ),
        // if (title.isNotEmpty) 24.heightInPixel(),
        if (message.isNotEmpty)
          Center(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle2!.copyWith(),
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
                width: MediaQuery.of(context).size.width,
                borderRadius: 8,
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
                width: MediaQuery.of(context).size.width,
                borderRadius: 8,
              ),
            )
          ],
        ),
      ]),
    ),
  );
}

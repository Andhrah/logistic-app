/*
*  Meritrade
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra Technologies]. All rights reserved.
    */

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:trakk/src/utils/app_toast.dart';
import 'package:trakk/src/values/colors.dart';
import 'package:trakk/src/values/font.dart';

typedef OnClickCallback(bool value);

class TermsAndConditionWidget extends StatefulWidget {
  final OnClickCallback onClickCallback;

  TermsAndConditionWidget(this.onClickCallback);

  @override
  State<StatefulWidget> createState() => TermsAndConditionWidgetState();
}

class TermsAndConditionWidgetState extends State<TermsAndConditionWidget> {
  bool _checkValue = false;
  late TapGestureRecognizer _onTapRecognizer;

  @override
  void initState() {
    super.initState();
    _onTapRecognizer = TapGestureRecognizer()..onTap = _handlePress;
  }

  @override
  void dispose() {
    _onTapRecognizer.dispose();
    super.dispose();
  }

  _handlePress() {
    runToast('Kindly check back');
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    MediaQueryData mediaQuery;
    mediaQuery = MediaQuery.of(context);

    var shortestSide = mediaQuery.size.shortestSide;
// Determine if we should use mobile layout or not. The

// number 600 here is a common breakpoint for a typical
// 7-inch tablet.

    final bool useMobileLayout = shortestSide < 600;

    return Row(
      children: <Widget>[
        Checkbox(
          value: _checkValue,
          activeColor: appPrimaryColor,
          hoverColor: whiteColor,
          focusColor: appPrimaryColor,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          overlayColor:
              MaterialStateProperty.all(appPrimaryColor.withOpacity(0.2)),
          fillColor: MaterialStateProperty.all(appPrimaryColor),
          checkColor: whiteColor,
          onChanged: (bool? value) {
            setState(() {
              _checkValue = value!;
            });

            widget.onClickCallback(_checkValue);
          },
        ),
        Flexible(
          child: RichText(
            text: TextSpan(
                text: 'I agree with the',
                style: theme.textTheme.bodyText1!
                    .copyWith(fontWeight: kRegularWeight),
                children: <TextSpan>[
                  TextSpan(
                    recognizer: _onTapRecognizer,
                    text: ' Terms & Privacy Policy',
                    style: theme.textTheme.bodyText1!.copyWith(
                        fontWeight: kSemiBoldWeight, color: appPrimaryColor),
                  ),
                ]),
          ),
        ),
      ],
    );
  }

  bool sendBack() {
    return _checkValue;
  }
}

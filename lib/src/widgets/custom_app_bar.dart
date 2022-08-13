import 'package:flutter/material.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/widgets/back_icon.dart';

class CustomAppBar extends StatelessWidget {
  final Widget? leading;
  final Widget? trailing;
  final Widget? title;
  final String? titleText;

  const CustomAppBar(
      {Key? key, this.leading, this.trailing, this.title, this.titleText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          leading ??
              BackIcon(
                onPress: () {
                  Navigator.pop(context);
                },
              ),
          title ??
              Text(
                titleText ?? '',
                style: theme.textTheme.subtitle2!.copyWith(
                  color: appPrimaryColor,
                  fontWeight: kBoldWeight,
                  // decoration: TextDecoration.underline,
                ),
              ),
          trailing ??
              leading ??
              AbsorbPointer(
                child: Opacity(
                  opacity: 0,
                  child: BackIcon(
                    onPress: () {},
                  ),
                ),
              ),
        ],
      ),
    );
  }
}

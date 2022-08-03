import 'package:flutter/material.dart';
import 'package:trakk/src/utils/helper_utils.dart';
import 'package:trakk/src/utils/singleton_data.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/widgets/button.dart';
import 'package:trakk/src/widgets/image_selector_modal.dart';
import 'package:trakk/src/widgets/searchable_list_modal.dart';

Future yesNoDialog(
  BuildContext context, {
  String title = '',
  String message = '',
  Function()? positiveCallback,
  Function()? negativeCallback,
}) async {
  return await showDialog<String>(
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

modalSearchableList(
    List<String> list, SearchableListCallback searchableListCallback,
    {BuildContext? context,
    bool isSearchable = false,
    String title = 'Select an item',
    BoxConstraints constraints = const BoxConstraints(maxHeight: 300)}) {
  showModalBottomSheet(
      context: context ??
          SingletonData.singletonData.navKey.currentState!.overlay!.context,
      isScrollControlled: true,
      constraints: constraints,
      builder: (context) {
        ThemeData theme = Theme.of(context);
        final bool isDark = theme.brightness == Brightness.dark;

        return SearchableListModal(
            list, searchableListCallback, isSearchable, title);
      },
      backgroundColor: Colors.transparent);
}

modalDialog(BuildContext context,
    {String title = '',
    Widget? child,
    required String positiveLabel,
    required Function() onPositiveCallback,
    required String negativeLabel,
    required Function() onNegativeCallback}) {
  var theme = Theme.of(context);
  MediaQueryData mediaQuery = MediaQuery.of(context);

  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
          margin: EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
          constraints: const BoxConstraints(maxWidth: 450),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 54),
          decoration: const BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50), topLeft: Radius.circular(50))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title.isNotEmpty) 24.heightInPixel(),
              if (title.isNotEmpty)
                Center(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headline6!.copyWith(),
                  ),
                ),
              if (title.isNotEmpty) 24.heightInPixel(),
              if (child != null) child,
              if (child != null) 24.heightInPixel(),
              Row(
                children: [
                  Expanded(
                    child: Button(
                        text: positiveLabel,
                        fontSize: 12,
                        onPress: () {
                          onPositiveCallback();
                        },
                        borderRadius: 12,
                        color: kTextColor,
                        width: double.infinity,
                        textColor: whiteColor,
                        isLoading: false),
                  ),
                  20.widthInPixel(),
                  Expanded(
                    child: Button(
                        text: negativeLabel,
                        fontSize: 12,
                        onPress: () {
                          onNegativeCallback();
                        },
                        borderRadius: 12,
                        color: redColor,
                        width: double.infinity,
                        textColor: whiteColor,
                        isLoading: false),
                  ),
                ],
              ),
            ],
          )));
}

modalImageSelector(ImageSelectorCallback callback, {BuildContext? context}) {
  showModalBottomSheet(
      context: context ??
          SingletonData.singletonData.navKey.currentState!.overlay!.context,
      isScrollControlled: true,
      builder: (context) {
        ThemeData theme = Theme.of(context);
        final bool isDark = theme.brightness == Brightness.dark;

        return ImageSelectorModal(callback);
      },
      backgroundColor: Colors.transparent);
}

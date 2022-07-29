/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'package:flutter/material.dart';
import 'package:trakk/src/bloc/validation_bloc.dart';
import 'package:trakk/src/utils/helper_utils.dart';
import 'package:trakk/src/values/values.dart';

typedef ImageSelectorCallback = Function(int index);

class ImageSelectorModal extends StatefulWidget {
  final ImageSelectorCallback selectorCallback;

  const ImageSelectorModal(this.selectorCallback, {Key? key}) : super(key: key);

  @override
  State<ImageSelectorModal> createState() => _ImageSelectorModalState();
}

class _ImageSelectorModalState extends State<ImageSelectorModal> {
  TextEditingController textEditingController = TextEditingController();

  final formValidator = ValidationBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    formValidator.dispose();
    super.dispose();
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

    return Padding(
      padding: EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
              color: isDark ? kDarkThemeBackgroundColor : kBackgroundColor,
              borderRadius: Radii.k20TopSymmetricRadius),
          child: Container(
            decoration: BoxDecoration(
                color: isDark ? kDarkThemeBackgroundColor : kBackgroundColor,
                borderRadius: Radii.k20TopSymmetricRadius),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SafeArea(
                  child: 10.heightInPixel(),
                ),
                Text(
                  'Select Image Source',
                  style: theme.textTheme.subtitle1!.copyWith(
                    fontWeight: kBoldWeight,
                  ),
                ),
                24.heightInPixel(),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: kDefaultLayoutPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          close(context);
                          widget.selectorCallback(0);
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                            children: [
                              Icon(
                                Icons.camera,
                                color: appPrimaryColor,
                                size: 54,
                              ),
                              8.heightInPixel(),
                              Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: Text(
                                    'Camera',
                                    style: theme.textTheme.subtitle2!.copyWith(
                                      fontWeight: kSemiBoldWeight,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      safeAreaWidth(context, 10).widthInPixel(),
                      GestureDetector(
                        onTap: () {
                          close(context);
                          widget.selectorCallback(1);
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                            children: [
                              Icon(
                                Icons.browse_gallery,
                                color: appPrimaryColor,
                                size: 54,
                              ),
                              8.heightInPixel(),
                              Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: Text(
                                    'Gallery',
                                    style: theme.textTheme.subtitle2!.copyWith(
                                      fontWeight: kSemiBoldWeight,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                24.heightInPixel()
              ],
            ),
          ),
        ),
      ),
    );
  }

  close(context) {
    Navigator.pop(context);
  }
}

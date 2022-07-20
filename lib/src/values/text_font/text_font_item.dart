/*  Trakk
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra Technologies]. All rights reserved.
*/

import 'package:flutter/material.dart';
import 'package:trakk/src/provider/settings_options/settings_options.dart';
import 'package:trakk/src/utils/options.dart';
import 'package:trakk/src/values/text_font/scales.dart';

class TextScaleFactorItem extends StatefulWidget {
  TextScaleFactorItem(this.options);

  final SettingOptions options;

  @override
  _TextScaleFactorItemState createState() => _TextScaleFactorItemState();
}

class _TextScaleFactorItemState extends State<TextScaleFactorItem> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final bool isDark = theme.brightness == Brightness.dark;

    var provider = SettingsProvider.settingsProvider(context);

    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Text size',
                style: theme.primaryTextTheme.subtitle1,
              ),
              Text(
                '${widget.options.textScaleFactor!.label}',
                style: theme.primaryTextTheme.bodyText2,
//                  Theme.of(context).primaryTextTheme.body1,
              ),
            ],
          ),
        ),
        PopupMenuButton<TrakkTextScaleValue>(
          padding: const EdgeInsetsDirectional.only(end: 16.0),
          icon: const Icon(Icons.arrow_drop_down),
          color: Colors.black,
          itemBuilder: (BuildContext context) {
            return kAllTrakkTextScaleValues
                .map<PopupMenuItem<TrakkTextScaleValue>>(
                    (TrakkTextScaleValue scaleValue) {
              return PopupMenuItem<TrakkTextScaleValue>(
                value: scaleValue,
                child: Text(
                  scaleValue.label,
                ),
              );
            }).toList();
          },
          onSelected: (TrakkTextScaleValue scaleValue) {
            setState(() {
              provider.handleOptionsChanged(
                widget.options.copyWith(textScaleFactor: scaleValue),
              );
            });
          },
        ),
      ],
    );
  }
}

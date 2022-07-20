/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'package:flutter/material.dart';
import 'package:trakk/bloc/app_settings_bloc.dart';
import 'package:trakk/models/app_settings.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/utils/options.dart';
import 'package:trakk/values/values.dart';

class ThemeItem extends StatefulWidget {
  const ThemeItem(
    this.options,
  );

  final SettingOptions options;

  @override
  _ThemeItemState createState() => _ThemeItemState();
}

class _ThemeItemState extends State<ThemeItem> {
  late String label;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
  }

  init() async {
    AppSettings appSettings = await appSettingsBloc.fetchAppSettings();

    setState(() {
      label =
          kAllTrakkThemeModeValues.elementAt(appSettings.themeModeIndex).label;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    final provider = TrakkApp.of(context);

    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Theme', style: theme.primaryTextTheme.subtitle1),
              Text(
                '$label',
                style: theme.primaryTextTheme.bodyText2,
              ),
            ],
          ),
        ),
        PopupMenuButton<TrakkThemeMode>(
          padding: const EdgeInsetsDirectional.only(end: 16.0),
          color: appPrimaryColor,
          icon: const Icon(Icons.arrow_drop_down),
          itemBuilder: (BuildContext context) {
            return kAllTrakkThemeModeValues.map<PopupMenuItem<TrakkThemeMode>>(
                (TrakkThemeMode trakkThemeMode) {
              return PopupMenuItem<TrakkThemeMode>(
                value: trakkThemeMode,
                child: Text(
                  trakkThemeMode.label,
                ),
              );
            }).toList();
          },
          onSelected: (TrakkThemeMode trakkThemeMode) {
            setState(() {
              label = trakkThemeMode.label;
              provider.handleOptionsChanged(
                widget.options.copyWith(trakkThemeMode: trakkThemeMode),
              );
              appSettingsBloc.setThemeMode(trakkThemeMode.index);
            });
          },
        ),
      ],
    );
  }
}

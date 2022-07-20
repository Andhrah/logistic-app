import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trakk/src/bloc/app_settings_bloc.dart';
import 'package:trakk/src/models/app_settings.dart';
import 'package:trakk/src/utils/options.dart';
import 'package:trakk/src/values/text_font/scales.dart';
import 'package:trakk/src/values/theme/themes.dart';

class SettingsProvider extends ChangeNotifier {
  SettingsProvider() {
    init();
  }

  static SettingsProvider settingsProvider(BuildContext context,
      {bool listen = false}) {
    return Provider.of<SettingsProvider>(context, listen: listen);
  }

  SettingOptions options = SettingOptions();

  init() async {
    AppSettings appSettings = await appSettingsBloc.fetchAppSettings();
    options = SettingOptions(
      theme: kLightTrakkTheme,
      darkTheme: kDarkTrakkTheme,
      trakkThemeMode:
          kAllTrakkThemeModeValues.elementAt(appSettings.themeModeIndex),
      textScaleFactor: kAllTrakkTextScaleValues[0],
      platform: defaultTargetPlatform,
    );
    notifyListeners();
  }

  handleOptionsChanged(SettingOptions newOptions) {
    options = newOptions;
    notifyListeners();
  }

  Widget applyTextScaleFactor(Widget child) {
    return Builder(
      builder: (BuildContext context) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
              textScaleFactor: options.textScaleFactor!.scale,
              alwaysUse24HourFormat: true),
          child: child,
        );
      },
    );
  }
}

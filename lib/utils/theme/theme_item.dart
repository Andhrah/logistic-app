// /*
// *
// *  Created by [Folarin Opeyemi].
// *  Copyright © 2022 [Zebrra]. All rights reserved.
//     */
//
// import 'package:expect/src/app.dart';
// import 'package:expect/src/bloc/app_settings_bloc.dart';
// import 'package:expect/src/model/app_settings.dart';
// import 'package:expect/src/utils/options.dart';
// import 'package:expect/src/values/theme/themes.dart';
// import 'package:expect/src/values/values.dart';
// import 'package:flutter/material.dart';
//
// class ThemeItem extends StatefulWidget {
//   const ThemeItem(
//     this.options,
//   );
//
//   final SettingOptions options;
//
//   @override
//   _ThemeItemState createState() => _ThemeItemState();
// }
//
// class _ThemeItemState extends State<ThemeItem> {
//   late String label;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       init();
//     });
//   }
//
//   init() async {
//     AppSettings appSettings = await appSettingsBloc.fetchAppSettings();
//
//     setState(() {
//       label = kAllGigXPadThemeModeValues
//           .elementAt(appSettings.themeModeIndex)
//           .label;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     ThemeData theme = Theme.of(context);
//     final bool isDark = theme.brightness == Brightness.dark;
//
//     final provider = GigXPadApp.of(context);
//
//     return Row(
//       children: <Widget>[
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text('Theme', style: theme.primaryTextTheme.subtitle1),
//               Text(
//                 '$label',
//                 style: theme.primaryTextTheme.bodyText2,
//               ),
//             ],
//           ),
//         ),
//         PopupMenuButton<GigXPadThemeMode>(
//           padding: const EdgeInsetsDirectional.only(end: 16.0),
//           color: AppColors.primaryElement,
//           icon: const Icon(Icons.arrow_drop_down),
//           itemBuilder: (BuildContext context) {
//             return kAllGigXPadThemeModeValues
//                 .map<PopupMenuItem<GigXPadThemeMode>>(
//                     (GigXPadThemeMode gigXPadThemeMode) {
//               return PopupMenuItem<GigXPadThemeMode>(
//                 value: gigXPadThemeMode,
//                 child: Text(
//                   gigXPadThemeMode.label,
//                 ),
//               );
//             }).toList();
//           },
//           onSelected: (GigXPadThemeMode gigXPadThemeMode) {
//             setState(() {
//               label = gigXPadThemeMode.label;
//               provider.handleOptionsChanged(
//                 widget.options.copyWith(gigXPadThemeMode: gigXPadThemeMode),
//               );
//               appSettingsBloc.setThemeMode(gigXPadThemeMode.index);
//             });
//           },
//         ),
//       ],
//     );
//   }
// }

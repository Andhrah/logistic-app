import 'package:flutter/material.dart';
import 'package:trakk/bloc/app_settings_bloc.dart';
import 'package:trakk/models/app_settings.dart';
import 'package:trakk/utils/assets.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/utils/font.dart';
import 'package:trakk/utils/helper_utils.dart';
import 'package:trakk/utils/padding.dart';
import 'package:trakk/utils/radii.dart';

class RiderTopPart extends StatefulWidget {
  const RiderTopPart({Key? key}) : super(key: key);

  @override
  _RiderTopPartState createState() => _RiderTopPartState();
}

class _RiderTopPartState extends State<RiderTopPart> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SafeArea(child: SizedBox(height: 12.0)),
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: kDefaultLayoutPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  ClipOval(
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: whiteColor, width: 1.5)),
                      child: Image.asset(
                        Assets.dummy_avatar,
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    'Active',
                    style: theme.textTheme.caption!
                        .copyWith(color: secondaryColor, height: 1.55),
                  ),
                ],
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  decoration: const BoxDecoration(
                      color: secondaryColor, borderRadius: Radii.k4pxRadius),
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    Assets.notification_icon_only,
                    width: 22,
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 34,
        ),
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: kDefaultLayoutPadding),
          child: StreamBuilder<AppSettings>(
              stream: appSettingsBloc.appSettings,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    'Hello ${snapshot.data?.loginResponse?.data?.user?.firstName ?? ''},',
                    style: theme.textTheme.headline5!.copyWith(
                        fontWeight: kSemiBoldWeight, color: whiteColor),
                  );
                }
                return const SizedBox();
              }),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: kDefaultLayoutPadding),
          child: Text(
            greetWithTime(),
            style: theme.textTheme.subtitle1!.copyWith(
              color: whiteColor,
            ),
          ),
        ),
      ],
    );
  }
}

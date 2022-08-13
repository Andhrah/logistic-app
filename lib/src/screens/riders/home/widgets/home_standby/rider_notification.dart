import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/src/services/base_network_call_handler.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/widgets/back_icon.dart';

class RiderNotification extends StatefulWidget {
  static String id = "notifications";

  const RiderNotification({Key? key}) : super(key: key);

  @override
  State<RiderNotification> createState() => _RiderNoticiationState();
}

class _RiderNoticiationState extends State<RiderNotification> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                BackIcon(
                  onPress: () {
                    Navigator.pop(context);
                  },
                ),
                Container(
                  //height: 60,
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 6,
                      vertical: 27),
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {},
                    customBorder: const CircleBorder(),
                    child: Text(
                      'NOTIFICATION',
                      style: theme.textTheme.subtitle1!.copyWith(
                          fontWeight: kBoldWeight,
                          fontSize: 18,
                          fontFamily: kDefaultFontFamilyHeading
                          // decoration: TextDecoration.underline,
                          ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    SvgPicture.asset(
                        "assets/images/rider/empty_notification.svg"),
                    Center(
                      child: Text(
                        "You don’t have any notification yet",
                        textScaleFactor: 1,
                        style: theme.textTheme.subtitle1!.copyWith(
                            fontWeight: kBoldWeight,
                            //fontSize: 18,
                            fontFamily: kDefaultFontFamily
                            // decoration: TextDecoration.underline,
                            ),
                      ),
                    ),
                    Container(
                      height: 220,
                    ),
                    suspendedRiderCard(context),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget suspendedRiderCard(BuildContext context) {
  var theme = Theme.of(context);

  return Container(
    constraints: const BoxConstraints(maxWidth: 344),
    margin: const EdgeInsets.symmetric(horizontal: kDefaultLayoutPadding),
    padding: EdgeInsets.symmetric(vertical: 12),
    decoration: const BoxDecoration(
        color: secondaryColor, borderRadius: Radii.k8pxRadius),
    child: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Remix.close_line,
                color: appPrimaryColor,
              ),
              SizedBox(height: 20),
              Text(
                'Dear Malik, your account has been temporarily suspended and you will not be able to receive order(s). Kindly contact your company for further assistance.',
                textScaleFactor: 1.2,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyText1!.copyWith(
                  fontWeight: kMediumWeight,
                  //fontSize: 18
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
